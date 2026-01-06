## Development Progress Log

Chronological log of work done on **Realworld Simulation**.

### 2026-01-06 — Initial MVP Project Setup
- **Project bootstrap**
  - Created base directory structure: `proto/`, `services/`, `migrations/`, `docker/`, `scripts/`, `client/`.
  - Added `go.mod` for the root Go module.
- **Proto definitions (gRPC contracts)**
  - `proto/common/types.proto` — ID types, `Money`, `LocationRef`, `OwnerRef`, `UIMessage`, `CommandMetadata`, `EventEnvelope`.
  - `proto/identity/identity.proto` — Auth & user/character linkage (MVP, service not yet implemented).
  - `proto/character/character.proto` — Character state, actions, events.
  - `proto/world/world.proto` — World topology (places, districts, travel).
  - `proto/contracts/contracts.proto` — Contracts (paper/digital), obligations, events.
  - `proto/ledger/ledger.proto` — Double-entry ledger, tax, payroll, mint events.
  - `proto/feed/feed.proto` — Player/public feed messages.

### 2026-01-06 — Core Services (Go & Rust)
- **Gateway Service (Go)**
  - Files: `services/gateway/main.go`, `handlers/handler.go`, `parser/parser.go`, `router/router.go`.
  - Features:
    - HTTP: `POST /cmd`, `POST /cmd/text`, `GET /health`.
    - WebSocket: `GET /ws` (terminal-style real-time).
    - Auth stub: `POST /auth/register`, `POST /auth/login` (mock responses).
    - CLI parser + aliases (`g`, `t`, `w`, `s`, `h` → `go`, `travel`, `work`, `status`, `help`).
    - Router stubs for core commands (`go`, `travel`, `work`, `status`, `eat`, `sleep`, `contract`).

- **Character Service (Go)**
  - Files: `services/character/main.go`, `services/character/server/server.go`.
  - Connects to Postgres (character DB) + Pulsar stub.
  - `Character` model and operations:
    - `GetCharacter`, `CreateCharacter`.
    - Update activity (`UpdateActivity`), needs (`UpdateNeeds`), location (`UpdateLocation`).
    - `ValidateAction` to check energy and state.

- **World Service (Go)**
  - Files: `services/world/main.go`, `services/world/server/server.go`.
  - Manages:
    - `District`, `Place`, `TravelEdge`.
  - Features:
    - `GetPlace`, `GetDistrict`, `ListNearbyPlaces`, `CreatePlace`, `CreateDistrict`, `CreateTravelEdge`.

- **Contracts Service (Go)**
  - Files: `services/contracts/main.go`, `services/contracts/server/server.go`.
  - Models: `Contract`, `ContractSignature`.
  - Features:
    - `CreateContract` (paper/digital) with JSON terms.
    - `SignContract` + auto-activation when all parties signed.
    - `GetContract`, `ListContracts`.

- **Ledger Service (Rust)**
  - Files: `services/ledger/src/main.rs`, `services/ledger/src/ledger.rs`, `Cargo.toml`.
  - Postgres via `sqlx`.
  - Features:
    - Create account.
    - Get account / balance.
    - Double-entry transaction posting (`post_transaction`).
    - Transfer between accounts (`transfer`).
    - Apply tax (`apply_tax`).
    - Mint currency (`mint_currency`) + audit in `mint_audit`.
  - Invariants:
    - Debit = Credit (otherwise `UnbalancedTransaction`).
    - Balance checks for credit (no negative balances except mint account).

- **Feed Service (Go)**
  - Files: `services/feed/main.go`, `services/feed/server/server.go`.
  - Table `feed_messages` + helpers `CreateFeedMessage`, `ListRecentMessages`, `ProcessDomainEvent`.

### 2026-01-06 — Database & Infrastructure
- **Migrations (schema)**
  - `migrations/character_db.sql` — tables `characters`, `character_activities`, `scheduled_actions`, `processed_commands`.
  - `migrations/world_db.sql` — `districts`, `places`, `travel_edges`, `resource_nodes`, `world_ruleset`.
  - `migrations/contracts_db.sql` — `contracts`, `contract_signatures`, `contract_obligations`, `contract_progress`, `processed_commands`.
  - `migrations/ledger_db.sql` — `accounts`, `ledger_transactions`, `ledger_entries`, `mint_audit`, `tax_rules`, `processed_commands`.
  - `migrations/feed_db.sql` — `feed_messages`, `public_feed_messages`, `player_feed_cursor`.

- **Seed data (final refactor)**
  - `migrations/seed_world.sql` — districts + places + edges + resources + ruleset.
  - `migrations/seed_ledger.sql` — system accounts + tax rules.
  - `migrations/seed_contracts.sql` — demo employment & delivery contracts + signatures.
  - `migrations/seed_character.sql` — demo character (`demo-character-1`).
  - Previously, a single `seed_data.sql` was applied to all DBs and caused relation errors; this was refactored into per-DB seed files, and the migration script was updated accordingly.

- **Docker infrastructure (initial, for reference)**
  - `docker-compose.yml` — Postgres per service, Pulsar, Redis, all services (Go/Rust).
  - Dockerfiles for: gateway, character, world, contracts, ledger, feed.
  - Note: user opted **not** to use Docker locally; this remains mainly for deployment/reference.

- **Helper & tooling**
  - `Makefile` — targets `up`, `down`, `seed`, `logs`, `dev-*`, etc.
  - `README.md` — main documentation.
  - `QUICKSTART.md` — 5-minute guide.
  - `PROJECT_STRUCTURE.md` — structure & architecture explanation.
  - `IMPLEMENTATION_REPORT.md` — MVP implementation report.

### 2026-01-06 — Local Dev (No Docker) & Integration with VPS
- **.env & remote configuration**
  - Root `.env` is used to point to DB/Pulsar/Redis on the VPS:
    - `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`.
    - `CHARACTER_DB_NAME`, `WORLD_DB_NAME`, `CONTRACTS_DB_NAME`, `LEDGER_DB_NAME`, `FEED_DB_NAME` (e.g. `rws_character_db`, etc.).
    - `PULSAR_URL`, etc.

- **Run scripts (Go & Rust services)**
  - `scripts/run_character.sh`
  - `scripts/run_world.sh`
  - `scripts/run_contracts.sh`
  - `scripts/run_feed.sh`
  - `scripts/run_gateway.sh`
  - `scripts/run_ledger.sh`
  - All scripts updated to:
    - Auto-load `.env` from the project root.
    - Use correct fallbacks: `*_DB_HOST` → `DB_HOST` → `localhost`, and same for ports.
    - Ledger: if `DATABASE_URL` is not set, build it from `DB_*` and `LEDGER_DB_NAME`.

- **Migration script (single entrypoint)**
  - `scripts/migrate_local.sh` updated to:
    - Load `.env`.
    - Derive `PGHOST/PGPORT/PGUSER` from `DB_HOST/DB_PORT/DB_USER`.
    - Use `CHARACTER_DB_NAME`, `WORLD_DB_NAME`, etc. for `psql -d`.
    - Set `PGPASSWORD` from `DB_PASSWORD` for non-interactive runs.
    - Execute:
      - Schema migrations for all DBs.
      - Per-DB seeding: `seed_world.sql`, `seed_ledger.sql`, `seed_contracts.sql`, `seed_character.sql`.

### 2026-01-06 — Client Applications
- **Terminal client (Go)**
  - File: `client/terminal/main.go`.
  - Features:
    - Read user input (CLI).
    - Send `POST /cmd/text` to the Gateway.
    - Render responses with colors + pretty-printed JSON.
    - Simple command history.

- **Web client (HTML/JS)**
  - File: `client/web/index.html`.
  - Features:
    - Terminal-style UI in the browser.
    - Connection status (health endpoint).
    - Command history (up/down arrows).
    - Timestamped output.

---

### TODO / Next Steps (High-Level)
- Wire gRPC for each service (using existing proto definitions).
- Integrate Pulsar properly (publishers/consumers) for Character, World, Contracts, Ledger, Feed.
- Add Inventory & Logistics services.
- Add real auth (JWT) and Identity service.
- Add workers for scheduled actions (travel/work/sleep).

