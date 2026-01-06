-- Event Feed Service Database Schema

CREATE TABLE IF NOT EXISTS feed_messages (
    id VARCHAR(36) PRIMARY KEY,
    player_id VARCHAR(36) NOT NULL,
    message_type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    severity VARCHAR(20) NOT NULL DEFAULT 'info',
    metadata JSONB,
    occurred_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_feed_messages_player_id ON feed_messages(player_id);
CREATE INDEX idx_feed_messages_occurred_at ON feed_messages(occurred_at DESC);
CREATE INDEX idx_feed_messages_severity ON feed_messages(severity);

CREATE TABLE IF NOT EXISTS public_feed_messages (
    id VARCHAR(36) PRIMARY KEY,
    channel_id VARCHAR(50) NOT NULL,
    message_type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    severity VARCHAR(20) NOT NULL DEFAULT 'info',
    metadata JSONB,
    occurred_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_public_feed_channel ON public_feed_messages(channel_id);
CREATE INDEX idx_public_feed_occurred_at ON public_feed_messages(occurred_at DESC);

CREATE TABLE IF NOT EXISTS player_feed_cursor (
    player_id VARCHAR(36) PRIMARY KEY,
    last_read_message_id VARCHAR(36),
    last_read_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

