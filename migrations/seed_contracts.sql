-- Seed data for Contracts DB (run against contracts_db or rws_contracts_db)

-- Create sample employment contract
INSERT INTO contracts (id, contract_medium, issuer_id, issuer_type, counterparty_id, counterparty_type, contract_type, description, terms, status, created_at, activated_at)
VALUES 
    (
        'contract-demo-001',
        'paper',
        'govt-alpha',
        'government',
        'demo-character-1',
        'character',
        'employment',
        'Sanitation Worker - District Alpha',
        '{"role": "sanitation_worker", "salary_per_day": 50, "duration_days": 30, "shift_hours": 8}',
        'active',
        CURRENT_TIMESTAMP - INTERVAL '5 days',
        CURRENT_TIMESTAMP - INTERVAL '5 days'
    );

-- Add signatures for the active contract
INSERT INTO contract_signatures (contract_id, signer_id, signer_type, signed_at)
VALUES 
    ('contract-demo-001', 'govt-alpha', 'government', CURRENT_TIMESTAMP - INTERVAL '5 days'),
    ('contract-demo-001', 'demo-character-1', 'character', CURRENT_TIMESTAMP - INTERVAL '5 days');

-- Create pending contract (unsigned)
INSERT INTO contracts (id, contract_medium, issuer_id, issuer_type, counterparty_id, counterparty_type, contract_type, description, terms, status)
VALUES 
    (
        'contract-demo-002',
        'paper',
        'company-logistics-01',
        'company',
        'demo-character-1',
        'character',
        'delivery',
        'Delivery Contract - Alpha Warehouse to Central Market',
        '{"cargo_type": "iron_ore", "quantity": 500, "payment": 100, "deadline_hours": 24}',
        'pending_signature'
    );

INSERT INTO contract_signatures (contract_id, signer_id, signer_type)
VALUES 
    ('contract-demo-002', 'company-logistics-01', 'company');


