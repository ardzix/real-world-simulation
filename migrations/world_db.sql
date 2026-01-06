-- World Service Database Schema

CREATE TABLE IF NOT EXISTS districts (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    district_type VARCHAR(50) NOT NULL,
    population INTEGER NOT NULL DEFAULT 0,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_districts_name ON districts(name);

CREATE TABLE IF NOT EXISTS places (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    place_type VARCHAR(50) NOT NULL,
    district_id VARCHAR(36) NOT NULL REFERENCES districts(id),
    description TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    properties JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_places_district_id ON places(district_id);
CREATE INDEX idx_places_place_type ON places(place_type);
CREATE INDEX idx_places_name ON places(name);

CREATE TABLE IF NOT EXISTS travel_edges (
    id SERIAL PRIMARY KEY,
    from_place_id VARCHAR(36) NOT NULL REFERENCES places(id),
    to_place_id VARCHAR(36) NOT NULL REFERENCES places(id),
    distance INTEGER NOT NULL,
    base_risk VARCHAR(20) NOT NULL DEFAULT 'low',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_travel_edges_from_place ON travel_edges(from_place_id);
CREATE INDEX idx_travel_edges_to_place ON travel_edges(to_place_id);

CREATE TABLE IF NOT EXISTS resource_nodes (
    id VARCHAR(36) PRIMARY KEY,
    place_id VARCHAR(36) NOT NULL REFERENCES places(id),
    resource_type VARCHAR(50) NOT NULL,
    total_reserve BIGINT NOT NULL,
    remaining_reserve BIGINT NOT NULL,
    extraction_rate INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_resource_nodes_place_id ON resource_nodes(place_id);
CREATE INDEX idx_resource_nodes_resource_type ON resource_nodes(resource_type);

CREATE TABLE IF NOT EXISTS world_ruleset (
    id VARCHAR(36) PRIMARY KEY,
    version VARCHAR(50) NOT NULL UNIQUE,
    seed VARCHAR(255),
    rules JSONB NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

