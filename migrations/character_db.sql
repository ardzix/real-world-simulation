-- Character Service Database Schema

CREATE TABLE IF NOT EXISTS characters (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    player_id VARCHAR(36) NOT NULL,
    location_id VARCHAR(36) NOT NULL,
    activity VARCHAR(50) NOT NULL DEFAULT 'idle',
    energy INTEGER NOT NULL DEFAULT 100 CHECK (energy >= 0 AND energy <= 100),
    hunger INTEGER NOT NULL DEFAULT 100 CHECK (hunger >= 0 AND hunger <= 100),
    health INTEGER NOT NULL DEFAULT 100 CHECK (health >= 0 AND health <= 100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_characters_player_id ON characters(player_id);
CREATE INDEX idx_characters_location_id ON characters(location_id);

CREATE TABLE IF NOT EXISTS character_activities (
    id VARCHAR(36) PRIMARY KEY,
    character_id VARCHAR(36) NOT NULL REFERENCES characters(id),
    activity_type VARCHAR(50) NOT NULL,
    started_at TIMESTAMP NOT NULL,
    estimated_end TIMESTAMP,
    completed_at TIMESTAMP,
    successful BOOLEAN,
    details JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_character_activities_character_id ON character_activities(character_id);
CREATE INDEX idx_character_activities_started_at ON character_activities(started_at DESC);

CREATE TABLE IF NOT EXISTS scheduled_actions (
    id VARCHAR(36) PRIMARY KEY,
    character_id VARCHAR(36) NOT NULL REFERENCES characters(id),
    action_type VARCHAR(50) NOT NULL,
    due_time TIMESTAMP NOT NULL,
    payload JSONB,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    executed_at TIMESTAMP
);

CREATE INDEX idx_scheduled_actions_due_time ON scheduled_actions(due_time);
CREATE INDEX idx_scheduled_actions_status ON scheduled_actions(status);

CREATE TABLE IF NOT EXISTS processed_commands (
    command_id VARCHAR(36) PRIMARY KEY,
    character_id VARCHAR(36) NOT NULL,
    command_type VARCHAR(50) NOT NULL,
    processed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    result JSONB
);

CREATE INDEX idx_processed_commands_character_id ON processed_commands(character_id);

