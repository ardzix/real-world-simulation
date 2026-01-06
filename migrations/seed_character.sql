-- Seed data for Character DB (run against character_db or rws_character_db)

-- Create demo character
INSERT INTO characters (id, name, player_id, location_id, activity, energy, hunger, health)
VALUES 
    ('demo-character-1', 'Worker #1234', 'demo-player-1', 'place-alpha-spawn', 'idle', 75, 60, 100);


