-- Seed data for Ledger DB (run against ledger_db or rws_ledger_db)

-- Create system accounts
INSERT INTO accounts (id, owner_id, owner_type, account_type, balance)
VALUES 
    ('acc-govt-treasury', 'govt-alpha', 'government', 'treasury', 10000000),
    ('acc-govt-tax', 'govt-alpha', 'government', 'tax_collection', 0),
    ('acc-govt-payroll', 'govt-alpha', 'government', 'payroll', 5000000),
    ('acc-demo-player', 'demo-player-1', 'player', 'personal', 500),
    ('acc-demo-character', 'demo-character-1', 'character', 'personal', 125);

-- Create tax rules
INSERT INTO tax_rules (id, tax_type, rate, description, effective_from)
VALUES 
    ('tax-income', 'income', 0.1500, 'Standard income tax 15%', CURRENT_TIMESTAMP),
    ('tax-transaction', 'transaction', 0.0200, 'Transaction tax 2%', CURRENT_TIMESTAMP),
    ('tax-property', 'property', 0.0100, 'Property tax 1% annual', CURRENT_TIMESTAMP);


