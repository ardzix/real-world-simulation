-- Seed data for World DB (run against world_db or rws_world_db)

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


