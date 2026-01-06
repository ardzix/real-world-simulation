.PHONY: help up down restart logs clean seed test

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up: ## Start all services
	docker-compose up -d
	@echo "Waiting for services to be ready..."
	@sleep 10
	@echo "Services are up! Run 'make seed' to populate databases."

down: ## Stop all services
	docker-compose down

restart: ## Restart all services
	docker-compose restart

logs: ## Show logs from all services
	docker-compose logs -f

logs-gateway: ## Show logs from gateway
	docker-compose logs -f gateway

logs-character: ## Show logs from character service
	docker-compose logs -f character

logs-world: ## Show logs from world service
	docker-compose logs -f world

clean: ## Stop and remove all containers, networks, and volumes
	docker-compose down -v
	@echo "All data removed. Run 'make up' and 'make seed' to start fresh."

seed: ## Seed all databases with initial data
	@chmod +x scripts/seed_all.sh
	@./scripts/seed_all.sh

db-character: ## Connect to character database
	docker exec -it character_db psql -U postgres -d character_db

db-world: ## Connect to world database
	docker exec -it world_db psql -U postgres -d world_db

db-contracts: ## Connect to contracts database
	docker exec -it contracts_db psql -U postgres -d contracts_db

db-ledger: ## Connect to ledger database
	docker exec -it ledger_db psql -U postgres -d ledger_db

db-feed: ## Connect to feed database
	docker exec -it feed_db psql -U postgres -d feed_db

test-status: ## Test status command
	curl -X POST http://localhost:8080/cmd/text \
		-H "Content-Type: application/json" \
		-d '{"text": "status"}'

test-go-list: ## Test go list command
	curl -X POST http://localhost:8080/cmd/text \
		-H "Content-Type: application/json" \
		-d '{"text": "go list"}'

test-travel-list: ## Test travel list command
	curl -X POST http://localhost:8080/cmd/text \
		-H "Content-Type: application/json" \
		-d '{"text": "travel list"}'

test-work: ## Test work start command
	curl -X POST http://localhost:8080/cmd/text \
		-H "Content-Type: application/json" \
		-d '{"text": "work start"}'

test-contracts: ## Test contract list command
	curl -X POST http://localhost:8080/cmd/text \
		-H "Content-Type: application/json" \
		-d '{"text": "contract list"}'

test-help: ## Test help command
	curl -X POST http://localhost:8080/cmd/text \
		-H "Content-Type: application/json" \
		-d '{"text": "help"}'

build: ## Build all services
	docker-compose build

ps: ## Show running containers
	docker-compose ps

dev-gateway: ## Run gateway locally (requires Go)
	cd services/gateway && go run main.go

dev-character: ## Run character service locally (requires Go)
	cd services/character && go run main.go

dev-world: ## Run world service locally (requires Go)
	cd services/world && go run main.go

dev-contracts: ## Run contracts service locally (requires Go)
	cd services/contracts && go run main.go

dev-ledger: ## Run ledger service locally (requires Rust)
	cd services/ledger && cargo run

dev-feed: ## Run feed service locally (requires Go)
	cd services/feed && go run main.go

