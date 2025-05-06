#!/bin/bash

set -e  # Exit on any error

echo "Installing and starting PostgreSQL via Homebrew..."
brew install postgresql
brew services start postgresql

echo "Spinning up database..."
sleep 5

# Variables
DB_NAME="box_office_db"
DB_USER="postgres"
SCHEMA_FILE="db_schemas.sql"
DATA_FILE="test_data.sql"

# Function to check if a database exists
db_exists() {
  psql -U "$DB_USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'" | grep -q 1
}

# Step 1: Drop existing database if it exists
if db_exists; then
  echo "Database $DB_NAME already exists. Dropping it..."
  dropdb -U "$DB_USER" "$DB_NAME"
fi

# Step 2: Create database
echo "Creating database: $DB_NAME..."
createdb -U "$DB_USER" "$DB_NAME"

# Step 3: Load schema
if [[ -f "$SCHEMA_FILE" ]]; then
  echo "Loading schema from $SCHEMA_FILE..."
  psql -U "$DB_USER" -d "$DB_NAME" -f "$SCHEMA_FILE"
else
  echo "Schema file $SCHEMA_FILE not found! Aborting."
  exit 1
fi

# Step 4: Load test data
if [[ -f "$DATA_FILE" ]]; then
  echo "Loading test data from $DATA_FILE..."
  psql -U "$DB_USER" -d "$DB_NAME" -f "$DATA_FILE"
else
  echo "Data file $DATA_FILE not found! Aborting."
  exit 1
fi

echo "✅ Database setup complete!"

# Step 5: Python dependencies
if [[ -f python/requirements.txt ]]; then
  echo "Installing Python dependencies..."
  pip3 install -r python/requirements.txt
else
  echo "requirements.txt not found! Skipping Python setup."
fi
