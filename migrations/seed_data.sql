-- Seed data for World DB (run against world_db)

-- Create initial district
INSERT INTO districts (id, name, district_type, population, description)
VALUES 
    ('district-alpha', 'District Alpha', 'mixed', 5000, 'The starting district with basic facilities'),
    ('district-central', 'Central District', 'commercial', 15000, 'Main commercial hub with offices and markets');

-- Create places in District Alpha
INSERT INTO places (id, name, place_type, district_id, description, latitude, longitude)
VALUES 
    ('place-alpha-spawn', 'Alpha Spawn Point', 'spawn', 'district-alpha', 'Default starting location', 0.0, 0.0),
    ('place-alpha-jobcenter', 'District Alpha Job Center', 'job_center', 'district-alpha', 'Find employment here', 0.001, 0.001),
    ('place-alpha-shelter', 'Alpha Public Shelter', 'shelter', 'district-alpha', 'Free temporary housing', 0.002, 0.001),
    ('place-alpha-market', 'Alpha Market', 'market', 'district-alpha', 'Buy and sell goods', 0.003, 0.002),
    ('place-alpha-warehouse', 'Alpha Warehouse District', 'facility', 'district-alpha', 'Storage and logistics hub', 0.005, 0.003);

-- Create travel edges (connections between places)
INSERT INTO travel_edges (from_place_id, to_place_id, distance, base_risk)
VALUES 
    ('place-alpha-spawn', 'place-alpha-jobcenter', 50, 'low'),
    ('place-alpha-jobcenter', 'place-alpha-spawn', 50, 'low'),
    ('place-alpha-spawn', 'place-alpha-shelter', 120, 'low'),
    ('place-alpha-shelter', 'place-alpha-spawn', 120, 'low'),
    ('place-alpha-jobcenter', 'place-alpha-shelter', 80, 'low'),
    ('place-alpha-shelter', 'place-alpha-jobcenter', 80, 'low'),
    ('place-alpha-jobcenter', 'place-alpha-market', 150, 'low'),
    ('place-alpha-market', 'place-alpha-jobcenter', 150, 'low'),
    ('place-alpha-market', 'place-alpha-warehouse', 200, 'low'),
    ('place-alpha-warehouse', 'place-alpha-market', 200, 'low');

-- Create resource nodes
INSERT INTO resource_nodes (id, place_id, resource_type, total_reserve, remaining_reserve, extraction_rate)
VALUES 
    ('resource-alpha-iron', 'place-alpha-warehouse', 'iron_ore', 1000000, 1000000, 100),
    ('resource-alpha-copper', 'place-alpha-warehouse', 'copper_ore', 500000, 500000, 50);

-- Create world ruleset
INSERT INTO world_ruleset (id, version, seed, rules)
VALUES 
    ('ruleset-v1', 'v1.0.0', 'alpha-seed-001', '{"generation": "procedural", "difficulty": "normal"}');


-- Seed data for Ledger DB (run against ledger_db)

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


-- Seed data for Contracts DB (run against contracts_db)

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


-- Seed data for Character DB (run against character_db)

-- Create demo character
INSERT INTO characters (id, name, player_id, location_id, activity, energy, hunger, health)
VALUES 
    ('demo-character-1', 'Worker #1234', 'demo-player-1', 'place-alpha-spawn', 'idle', 75, 60, 100);

