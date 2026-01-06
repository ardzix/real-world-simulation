# 📁 Project Structure

Dokumentasi struktur project Realworld Simulation MVP.

## Directory Layout

```
realworld_simulation/
├── proto/                      # Protocol Buffer definitions (gRPC contracts)
│   ├── common/
│   │   └── types.proto         # Shared types (IDs, Money, LocationRef, UIMessage)
│   ├── identity/
│   │   └── identity.proto      # Authentication & user management
│   ├── character/
│   │   └── character.proto     # Character state & actions
│   ├── world/
│   │   └── world.proto         # World, places, districts, travel
│   ├── contracts/
│   │   └── contracts.proto     # Contracts (paper & digital)
│   ├── ledger/
│   │   └── ledger.proto        # Double-entry accounting
│   └── feed/
│       └── feed.proto          # Event feed & notifications
│
├── services/                   # Microservices implementation
│   ├── gateway/                # Command Gateway (Go) - Entry point
│   │   ├── main.go
│   │   ├── handlers/
│   │   │   └── handler.go      # HTTP/WebSocket handlers
│   │   ├── parser/
│   │   │   └── parser.go       # CLI text parser
│   │   └── router/
│   │       └── router.go       # Command routing to services
│   │
│   ├── character/              # Character Service (Go)
│   │   ├── main.go
│   │   └── server/
│   │       └── server.go       # Character state machine & DB logic
│   │
│   ├── world/                  # World Service (Go)
│   │   ├── main.go
│   │   └── server/
│   │       └── server.go       # Places, districts, travel graph
│   │
│   ├── contracts/              # Contracts Service (Go)
│   │   ├── main.go
│   │   └── server/
│   │       └── server.go       # Contract lifecycle & signatures
│   │
│   ├── ledger/                 # Ledger Service (Rust)
│   │   ├── Cargo.toml
│   │   └── src/
│   │       ├── main.rs
│   │       └── ledger.rs       # Double-entry accounting logic
│   │
│   └── feed/                   # Event Feed Service (Go)
│       ├── main.go
│       └── server/
│           └── server.go       # Feed projection from events
│
├── migrations/                 # Database schemas (SQL)
│   ├── character_db.sql        # Character service schema
│   ├── world_db.sql            # World service schema
│   ├── contracts_db.sql        # Contracts service schema
│   ├── ledger_db.sql           # Ledger service schema
│   ├── feed_db.sql             # Feed service schema
│   └── seed_data.sql           # Initial seed data (demo world)
│
├── docker/                     # Dockerfiles
│   ├── Dockerfile.gateway
│   ├── Dockerfile.character
│   ├── Dockerfile.world
│   ├── Dockerfile.contracts
│   ├── Dockerfile.ledger
│   └── Dockerfile.feed
│
├── scripts/                    # Utility scripts
│   └── seed_all.sh             # Seed all databases
│
├── client/                     # Client implementations
│   ├── terminal/
│   │   └── main.go             # Terminal CLI client (Go)
│   └── web/
│       └── index.html          # Web browser client
│
├── docker-compose.yml          # Full stack orchestration
├── Makefile                    # Development helpers
├── go.mod                      # Go dependencies
├── .gitignore
├── README.md                   # Main documentation
├── QUICKSTART.md               # Quick start guide
├── PROJECT_STRUCTURE.md        # This file
└── white_paper.md              # Design philosophy & architecture

```

## Service Responsibilities

### 1. Command Gateway (Port 8080)
**Language**: Go  
**Purpose**: Single entry point, CLI parsing, command routing

**Key Features**:
- HTTP POST `/cmd/text` - Text command parsing
- HTTP POST `/cmd` - Structured command
- WebSocket `/ws` - Real-time streaming
- Routes commands to appropriate domain services via gRPC

**Dependencies**:
- All gRPC services (character, world, contracts, etc.)

---

### 2. Character Service (Port 50051)
**Language**: Go  
**Database**: character_db (Port 5432)  
**Purpose**: Character state machine & activity management

**Key Features**:
- Character creation & state management
- Activity validation (go, travel, work, eat, sleep)
- Needs tracking (energy, hunger, health)
- Scheduled actions (travel ETA, work duration)

**Events Published**:
- `character.location.changed`
- `character.activity.started/completed`
- `character.needs.updated`

---

### 3. World Service (Port 50052)
**Language**: Go  
**Database**: world_db (Port 5433)  
**Purpose**: World topology, places, districts, travel

**Key Features**:
- Place & district directory
- `go list` - nearby locations
- `travel list` - available districts
- Travel cost calculation (distance, time, risk)
- Resource node definitions

**Events Published**:
- `world.place.created/updated`
- `world.district.created/expanded`

---

### 4. Contracts Service (Port 50053)
**Language**: Go  
**Database**: contracts_db (Port 5434)  
**Purpose**: Contract lifecycle (paper & digital)

**Key Features**:
- Contract creation (paper requires physical presence, digital requires device)
- Signature collection
- Contract activation (when all parties signed)
- Obligation tracking
- Progress reporting

**Events Published**:
- `contract.created/signed/activated`
- `contract.progressed/completed/breached`

---

### 5. Ledger Service (Port 50054)
**Language**: Rust  
**Database**: ledger_db (Port 5435)  
**Purpose**: Double-entry accounting, financial integrity

**Key Features**:
- Account management
- Double-entry transactions (debit = credit)
- Transfer operations
- Tax application
- Payroll payouts (with mint authorization)
- Mint audit trail

**Events Published**:
- `ledger.transaction.posted`
- `ledger.tax.collected`
- `ledger.payroll.paid`
- `ledger.mint.executed` (audited)

**Invariants**:
- All transactions must balance
- Immutable ledger entries
- Mint only for authorized public payroll

---

### 6. Event Feed Service (Port 50056)
**Language**: Go  
**Database**: feed_db (Port 5436)  
**Purpose**: Event projection & notification delivery

**Key Features**:
- Consumes all domain events from Pulsar
- Creates player-specific feed messages
- Public channel feeds (news, announcements)
- Feed cursor tracking

**Events Consumed**: All domain events  
**Events Published**: None (projection service)

---

## Infrastructure Components

### PostgreSQL Databases (5x)
- **character_db** (5432) - Character state
- **world_db** (5433) - World topology
- **contracts_db** (5434) - Contracts
- **ledger_db** (5435) - Financial ledger
- **feed_db** (5436) - Event feed

Each service owns its database for autonomy.

### Apache Pulsar (Ports 6650, 8080)
Event streaming backbone. Topics:
- `persistent://game/char/character.events`
- `persistent://game/world/world.events`
- `persistent://game/contract/contract.events`
- `persistent://game/ledger/ledger.events`
- `persistent://game/feed/player.feed`

### Redis (Port 6379)
- Caching
- Rate limiting
- Session storage (future)

---

## Data Flow Example: "work start"

```
1. Player → Web Client → Gateway (:8080)
   POST /cmd/text {"text": "work start"}

2. Gateway parses command
   → Calls Character.SubmitAction(action=WORK_START)

3. Character Service:
   - Validates character is idle
   - Checks energy >= 20
   - Updates character.activity = "working"
   - Creates scheduled_action (work completion in 8 hours)
   - Publishes character.activity.started event → Pulsar

4. Feed Service (consumer):
   - Receives character.activity.started from Pulsar
   - Creates feed message for player
   - Stores in feed_db

5. Contract Service (consumer, optional):
   - Receives activity.started
   - Updates contract progress (if active employment contract)
   - Publishes contract.progressed → Pulsar

6. Ledger Service (consumer):
   - When activity.completed arrives
   - Calculates pay (hours * rate)
   - Posts payroll transaction
   - Publishes ledger.payroll.paid → Pulsar

7. Feed Service:
   - Receives payroll.paid
   - Notifies player: "You earned 50 IGC"
```

---

## Event Flow Architecture

```
┌──────────────┐
│   Services   │
│ (Producers)  │
└──────┬───────┘
       │ publish events
       ↓
┌──────────────┐
│    Pulsar    │ ← Event Stream (persistent, ordered)
│  Topic: char │
│  Topic: world│
│  Topic: ledger
└──────┬───────┘
       │ consume events
       ↓
┌──────────────┐
│   Services   │
│ (Consumers)  │ ← React to events, update projections
└──────────────┘
```

---

## Client Architecture

### Terminal Client (Go)
- Reads stdin
- Sends commands via HTTP POST to Gateway
- Displays formatted responses
- Command history

### Web Client (HTML + JavaScript)
- Browser-based terminal UI
- Sends commands via fetch() to Gateway
- Real-time connection status
- WebSocket support (future)

---

## Development Workflow

### 1. Local Development (No Docker)
```bash
# Start infrastructure only
docker-compose up postgres-character postgres-world pulsar redis -d

# Run services in separate terminals
cd services/gateway && go run main.go
cd services/character && go run main.go
# etc...
```

### 2. Full Docker Development
```bash
# Build & run everything
docker-compose up --build

# Or with make
make build
make up
```

### 3. Testing Flow
```bash
# Test individual command
make test-status

# Test via terminal client
cd client/terminal && go run main.go

# Test via web
open client/web/index.html
```

---

## Database Schema Overview

### character_db
```
characters
  ├─ id, name, player_id
  ├─ location_id (FK → places)
  ├─ activity (idle/working/traveling/sleeping)
  ├─ energy, hunger, health
  └─ timestamps

character_activities (history)
scheduled_actions (future tasks)
processed_commands (idempotency)
```

### world_db
```
districts
  ├─ id, name, district_type
  ├─ population
  └─ description

places
  ├─ id, name, place_type
  ├─ district_id (FK)
  ├─ coordinates
  └─ properties

travel_edges (graph)
  ├─ from_place_id → to_place_id
  ├─ distance, base_risk
```

### contracts_db
```
contracts
  ├─ id, contract_medium (paper/digital)
  ├─ issuer_id, counterparty_id
  ├─ contract_type, terms (JSON)
  ├─ status (draft/active/completed)

contract_signatures
contract_obligations
contract_progress
```

### ledger_db
```
accounts
  ├─ id, owner_id, owner_type
  ├─ account_type
  ├─ balance

ledger_transactions
ledger_entries (debit/credit)
  ├─ transaction_id (FK)
  ├─ account_id (FK)
  ├─ entry_type, amount
  ├─ balance_after

mint_audit (transparency)
tax_rules
```

### feed_db
```
feed_messages
  ├─ id, player_id
  ├─ message_type, title, content
  ├─ severity
  ├─ occurred_at

public_feed_messages (channel-based)
player_feed_cursor (read tracking)
```

---

## Technology Stack

### Languages
- **Go**: Gateway, Character, World, Contracts, Feed (hot path, concurrency)
- **Rust**: Ledger (correctness, determinism, financial integrity)

### Databases
- **PostgreSQL 15**: All persistent state (one per service)

### Messaging
- **Apache Pulsar**: Event streaming backbone

### Caching
- **Redis**: Rate limiting, caching

### Protocols
- **gRPC**: Inter-service communication
- **HTTP/REST**: Client → Gateway
- **WebSocket**: Real-time streaming (future)

---

## Key Design Patterns

1. **Command → State Change → Event**
   - All actions flow through this pipeline
   - Command validation before state mutation
   - Events published for downstream consumption

2. **Event Sourcing (Partial)**
   - Ledger is append-only
   - All services publish domain events
   - Events can reconstruct state

3. **Microservice per Database**
   - Each service owns its data
   - No shared database
   - Communication via events & gRPC

4. **Idempotency**
   - Command IDs for deduplication
   - Processed command tracking
   - Safe retry

5. **Scheduled Actions**
   - Long-running actions (travel, work, sleep)
   - Stored as future tasks
   - Worker picks up when due

---

## Next Phase: What's Missing

### MVP Complete ✅
- Core services implemented
- Database schemas ready
- Docker orchestration working
- Command parsing & routing
- Basic demo world seeded

### Phase 2 TODO
- [ ] Actual Pulsar integration (currently mocked)
- [ ] Scheduled action workers (Celery/cron)
- [ ] Inventory Service
- [ ] Logistics Service (vehicles, shipments)
- [ ] Production & Extraction Service
- [ ] NPC Schedule Service
- [ ] Full gRPC proto code generation
- [ ] Authentication (JWT)

### Phase 3 TODO
- [ ] NPC Mind Service (LLM planning)
- [ ] WorldGen Service (procedural generation)
- [ ] Web client with modern UI
- [ ] Discord/Telegram adapters
- [ ] Graph projection service
- [ ] Monitoring & observability

---

Untuk informasi lebih lanjut, lihat [README.md](README.md) dan [white_paper.md](white_paper.md).

