#!/bin/bash

echo "Seeding all databases with initial data..."

# Wait for databases to be ready
sleep 5

# Seed World DB
echo "Seeding World DB..."
docker exec -i world_db psql -U postgres -d world_db < migrations/seed_data.sql

# Seed Ledger DB
echo "Seeding Ledger DB..."
docker exec -i ledger_db psql -U postgres -d ledger_db < migrations/seed_data.sql

# Seed Contracts DB
echo "Seeding Contracts DB..."
docker exec -i contracts_db psql -U postgres -d contracts_db < migrations/seed_data.sql

# Seed Character DB
echo "Seeding Character DB..."
docker exec -i character_db psql -U postgres -d character_db < migrations/seed_data.sql

echo "Seeding complete!"

