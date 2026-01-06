-- Ledger Service Database Schema (Rust/SQLx compatible)

CREATE TABLE IF NOT EXISTS accounts (
    id VARCHAR(36) PRIMARY KEY,
    owner_id VARCHAR(36) NOT NULL,
    owner_type VARCHAR(20) NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    balance BIGINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_accounts_owner ON accounts(owner_id, owner_type);
CREATE INDEX idx_accounts_account_type ON accounts(account_type);

CREATE TABLE IF NOT EXISTS ledger_transactions (
    id VARCHAR(36) PRIMARY KEY,
    description TEXT NOT NULL,
    posted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    command_id VARCHAR(36)
);

CREATE INDEX idx_ledger_transactions_posted_at ON ledger_transactions(posted_at DESC);
CREATE INDEX idx_ledger_transactions_command_id ON ledger_transactions(command_id);

CREATE TABLE IF NOT EXISTS ledger_entries (
    id VARCHAR(36) PRIMARY KEY,
    transaction_id VARCHAR(36) NOT NULL REFERENCES ledger_transactions(id),
    account_id VARCHAR(36) NOT NULL REFERENCES accounts(id),
    entry_type VARCHAR(10) NOT NULL CHECK (entry_type IN ('debit', 'credit')),
    amount BIGINT NOT NULL CHECK (amount >= 0),
    balance_after BIGINT NOT NULL,
    posted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_ledger_entries_transaction_id ON ledger_entries(transaction_id);
CREATE INDEX idx_ledger_entries_account_id ON ledger_entries(account_id);
CREATE INDEX idx_ledger_entries_posted_at ON ledger_entries(posted_at DESC);

CREATE TABLE IF NOT EXISTS mint_audit (
    id VARCHAR(36) PRIMARY KEY,
    transaction_id VARCHAR(36) NOT NULL REFERENCES ledger_transactions(id),
    amount BIGINT NOT NULL,
    purpose TEXT NOT NULL,
    authorization_ref VARCHAR(255) NOT NULL,
    minted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_mint_audit_minted_at ON mint_audit(minted_at DESC);
CREATE INDEX idx_mint_audit_authorization_ref ON mint_audit(authorization_ref);

CREATE TABLE IF NOT EXISTS tax_rules (
    id VARCHAR(36) PRIMARY KEY,
    tax_type VARCHAR(50) NOT NULL,
    rate DECIMAL(5,4) NOT NULL,
    description TEXT,
    effective_from TIMESTAMPTZ NOT NULL,
    effective_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_tax_rules_tax_type ON tax_rules(tax_type);
CREATE INDEX idx_tax_rules_effective ON tax_rules(effective_from, effective_until);

CREATE TABLE IF NOT EXISTS processed_commands (
    command_id VARCHAR(36) PRIMARY KEY,
    command_type VARCHAR(50) NOT NULL,
    processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    result JSONB
);

