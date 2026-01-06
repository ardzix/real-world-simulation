-- Contracts Service Database Schema

CREATE TABLE IF NOT EXISTS contracts (
    id VARCHAR(36) PRIMARY KEY,
    contract_medium VARCHAR(20) NOT NULL CHECK (contract_medium IN ('paper', 'digital')),
    issuer_id VARCHAR(36) NOT NULL,
    issuer_type VARCHAR(20) NOT NULL,
    counterparty_id VARCHAR(36) NOT NULL,
    counterparty_type VARCHAR(20) NOT NULL,
    contract_type VARCHAR(50) NOT NULL,
    description TEXT,
    terms JSONB NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'draft',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    activated_at TIMESTAMP,
    completed_at TIMESTAMP
);

CREATE INDEX idx_contracts_issuer ON contracts(issuer_id, issuer_type);
CREATE INDEX idx_contracts_counterparty ON contracts(counterparty_id, counterparty_type);
CREATE INDEX idx_contracts_status ON contracts(status);
CREATE INDEX idx_contracts_created_at ON contracts(created_at DESC);

CREATE TABLE IF NOT EXISTS contract_signatures (
    id SERIAL PRIMARY KEY,
    contract_id VARCHAR(36) NOT NULL REFERENCES contracts(id),
    signer_id VARCHAR(36) NOT NULL,
    signer_type VARCHAR(20) NOT NULL,
    signed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_contract_signatures_contract_id ON contract_signatures(contract_id);

CREATE TABLE IF NOT EXISTS contract_obligations (
    id VARCHAR(36) PRIMARY KEY,
    contract_id VARCHAR(36) NOT NULL REFERENCES contracts(id),
    obligation_type VARCHAR(50) NOT NULL,
    description TEXT,
    requirements JSONB,
    deadline TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    completed_at TIMESTAMP
);

CREATE INDEX idx_contract_obligations_contract_id ON contract_obligations(contract_id);
CREATE INDEX idx_contract_obligations_status ON contract_obligations(status);

CREATE TABLE IF NOT EXISTS contract_progress (
    id VARCHAR(36) PRIMARY KEY,
    contract_id VARCHAR(36) NOT NULL REFERENCES contracts(id),
    progress_type VARCHAR(50) NOT NULL,
    progress_data JSONB NOT NULL,
    recorded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_contract_progress_contract_id ON contract_progress(contract_id);
CREATE INDEX idx_contract_progress_recorded_at ON contract_progress(recorded_at DESC);

CREATE TABLE IF NOT EXISTS processed_commands (
    command_id VARCHAR(36) PRIMARY KEY,
    contract_id VARCHAR(36),
    command_type VARCHAR(50) NOT NULL,
    processed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    result JSONB
);

