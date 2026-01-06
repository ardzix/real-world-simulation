use anyhow::Result;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use sqlx::{PgPool, Postgres, Transaction};
use thiserror::Error;
use uuid::Uuid;

#[derive(Error, Debug)]
pub enum LedgerError {
    #[error("Account not found: {0}")]
    AccountNotFound(String),
    
    #[error("Insufficient balance: required {required}, available {available}")]
    InsufficientBalance { required: i64, available: i64 },
    
    #[error("Transaction entries must balance")]
    UnbalancedTransaction,
    
    #[error("Database error: {0}")]
    DatabaseError(#[from] sqlx::Error),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Account {
    pub id: String,
    pub owner_id: String,
    pub owner_type: String,
    pub account_type: String,
    pub balance: i64,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LedgerTransaction {
    pub id: String,
    pub description: String,
    pub posted_at: DateTime<Utc>,
    pub command_id: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LedgerEntry {
    pub id: String,
    pub transaction_id: String,
    pub account_id: String,
    pub entry_type: String, // "debit" or "credit"
    pub amount: i64,
    pub balance_after: i64,
    pub posted_at: DateTime<Utc>,
}

pub struct LedgerService {
    pool: PgPool,
}

impl LedgerService {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }

    /// Create a new account
    pub async fn create_account(
        &self,
        owner_id: String,
        owner_type: String,
        account_type: String,
    ) -> Result<Account> {
        let account = Account {
            id: Uuid::new_v4().to_string(),
            owner_id,
            owner_type,
            account_type,
            balance: 0,
            created_at: Utc::now(),
            updated_at: Utc::now(),
        };

        sqlx::query!(
            r#"
            INSERT INTO accounts (id, owner_id, owner_type, account_type, balance, created_at, updated_at)
            VALUES ($1, $2, $3, $4, $5, $6, $7)
            "#,
            account.id,
            account.owner_id,
            account.owner_type,
            account.account_type,
            account.balance,
            account.created_at,
            account.updated_at,
        )
        .execute(&self.pool)
        .await?;

        Ok(account)
    }

    /// Get account by ID
    pub async fn get_account(&self, account_id: &str) -> Result<Account, LedgerError> {
        let account = sqlx::query_as!(
            Account,
            r#"
            SELECT id, owner_id, owner_type, account_type, balance, created_at, updated_at
            FROM accounts
            WHERE id = $1
            "#,
            account_id
        )
        .fetch_optional(&self.pool)
        .await?
        .ok_or_else(|| LedgerError::AccountNotFound(account_id.to_string()))?;

        Ok(account)
    }

    /// Get account balance
    pub async fn get_balance(&self, account_id: &str) -> Result<i64, LedgerError> {
        let account = self.get_account(account_id).await?;
        Ok(account.balance)
    }

    /// Post a double-entry transaction
    pub async fn post_transaction(
        &self,
        description: String,
        entries: Vec<(String, String, i64)>, // (account_id, entry_type, amount)
        command_id: Option<String>,
    ) -> Result<String, LedgerError> {
        // Validate entries balance
        let mut total_debit = 0i64;
        let mut total_credit = 0i64;

        for (_, entry_type, amount) in &entries {
            match entry_type.as_str() {
                "debit" => total_debit += amount,
                "credit" => total_credit += amount,
                _ => {}
            }
        }

        if total_debit != total_credit {
            return Err(LedgerError::UnbalancedTransaction);
        }

        // Start transaction
        let mut tx = self.pool.begin().await?;

        let transaction_id = Uuid::new_v4().to_string();
        let posted_at = Utc::now();

        // Insert transaction record
        sqlx::query!(
            r#"
            INSERT INTO ledger_transactions (id, description, posted_at, command_id)
            VALUES ($1, $2, $3, $4)
            "#,
            transaction_id,
            description,
            posted_at,
            command_id,
        )
        .execute(&mut *tx)
        .await?;

        // Post entries
        for (account_id, entry_type, amount) in entries {
            self.post_entry(&mut tx, &transaction_id, &account_id, &entry_type, amount, posted_at)
                .await?;
        }

        tx.commit().await?;

        Ok(transaction_id)
    }

    /// Post a single ledger entry and update account balance
    async fn post_entry(
        &self,
        tx: &mut Transaction<'_, Postgres>,
        transaction_id: &str,
        account_id: &str,
        entry_type: &str,
        amount: i64,
        posted_at: DateTime<Utc>,
    ) -> Result<(), LedgerError> {
        // Get current balance
        let current_balance: i64 = sqlx::query_scalar!(
            r#"SELECT balance FROM accounts WHERE id = $1 FOR UPDATE"#,
            account_id
        )
        .fetch_one(&mut **tx)
        .await
        .map_err(|_| LedgerError::AccountNotFound(account_id.to_string()))?;

        // Calculate new balance
        let new_balance = match entry_type {
            "debit" => current_balance + amount,
            "credit" => {
                if current_balance < amount {
                    return Err(LedgerError::InsufficientBalance {
                        required: amount,
                        available: current_balance,
                    });
                }
                current_balance - amount
            }
            _ => current_balance,
        };

        // Update account balance
        sqlx::query!(
            r#"UPDATE accounts SET balance = $1, updated_at = $2 WHERE id = $3"#,
            new_balance,
            Utc::now(),
            account_id
        )
        .execute(&mut **tx)
        .await?;

        // Insert entry
        let entry_id = Uuid::new_v4().to_string();
        sqlx::query!(
            r#"
            INSERT INTO ledger_entries (id, transaction_id, account_id, entry_type, amount, balance_after, posted_at)
            VALUES ($1, $2, $3, $4, $5, $6, $7)
            "#,
            entry_id,
            transaction_id,
            account_id,
            entry_type,
            amount,
            new_balance,
            posted_at,
        )
        .execute(&mut **tx)
        .await?;

        Ok(())
    }

    /// Transfer money between two accounts
    pub async fn transfer(
        &self,
        from_account: &str,
        to_account: &str,
        amount: i64,
        reason: String,
        command_id: Option<String>,
    ) -> Result<String, LedgerError> {
        let entries = vec![
            (to_account.to_string(), "debit".to_string(), amount),
            (from_account.to_string(), "credit".to_string(), amount),
        ];

        self.post_transaction(reason, entries, command_id).await
    }

    /// Apply tax (deduct from account and credit to tax account)
    pub async fn apply_tax(
        &self,
        from_account: &str,
        tax_account: &str,
        tax_amount: i64,
        tax_type: String,
        command_id: Option<String>,
    ) -> Result<String, LedgerError> {
        let entries = vec![
            (tax_account.to_string(), "debit".to_string(), tax_amount),
            (from_account.to_string(), "credit".to_string(), tax_amount),
        ];

        let description = format!("{} tax applied", tax_type);
        self.post_transaction(description, entries, command_id).await
    }

    /// Mint new currency (only for authorized public payroll)
    pub async fn mint_currency(
        &self,
        to_account: &str,
        amount: i64,
        purpose: String,
        authorization_ref: String,
    ) -> Result<String, LedgerError> {
        // Create mint account if not exists (special system account)
        let mint_account_id = "SYSTEM-MINT";

        // For mint operations, we allow negative balance on the mint account
        let mut tx = self.pool.begin().await?;

        let transaction_id = Uuid::new_v4().to_string();
        let posted_at = Utc::now();

        // Insert transaction
        sqlx::query!(
            r#"
            INSERT INTO ledger_transactions (id, description, posted_at, command_id)
            VALUES ($1, $2, $3, $4)
            "#,
            transaction_id,
            format!("MINT: {} ({})", purpose, authorization_ref),
            posted_at,
            Some(authorization_ref.clone()),
        )
        .execute(&mut *tx)
        .await?;

        // Post to destination account (debit = increase balance)
        self.post_entry(&mut tx, &transaction_id, to_account, "debit", amount, posted_at)
            .await?;

        // Record mint in audit log
        sqlx::query!(
            r#"
            INSERT INTO mint_audit (id, transaction_id, amount, purpose, authorization_ref, minted_at)
            VALUES ($1, $2, $3, $4, $5, $6)
            "#,
            Uuid::new_v4().to_string(),
            transaction_id,
            amount,
            purpose,
            authorization_ref,
            posted_at,
        )
        .execute(&mut *tx)
        .await?;

        tx.commit().await?;

        Ok(transaction_id)
    }
}

