use anyhow::Result;
use sqlx::postgres::PgPoolOptions;
use std::env;
use tracing::{info, Level};
use tracing_subscriber;

mod ledger;

#[tokio::main]
async fn main() -> Result<()> {
    // Initialize tracing
    tracing_subscriber::fmt()
        .with_max_level(Level::INFO)
        .init();

    info!("Starting Ledger Service...");

    // Load environment variables
    dotenv::dotenv().ok();

    // Database connection
    let db_url = env::var("DATABASE_URL")
        .unwrap_or_else(|_| "postgres://postgres:postgres@localhost:5432/ledger_db".to_string());

    info!("Connecting to database...");
    let pool = PgPoolOptions::new()
        .max_connections(10)
        .connect(&db_url)
        .await?;

    info!("Database connected");

    // gRPC server setup
    let addr = env::var("BIND_ADDR")
        .unwrap_or_else(|_| "0.0.0.0:50054".to_string())
        .parse()?;

    let ledger_service = ledger::LedgerService::new(pool);

    info!("Ledger Service listening on {}", addr);

    // For now, just keep the service running
    // In full implementation, we'd register the gRPC service here
    tokio::signal::ctrl_c().await?;

    info!("Shutting down Ledger Service");
    Ok(())
}

