#!/bin/bash

## -- Postgres Install and Setup
brew install postgresql
# Variables
DB_NAME="box_office_db"
DB_USER="admin"
SCHEMA_FILE="db_schemas.sql"
DATA_FILE="test_data.sql"

# Function to check if a database exists
db_exists() {
  psql -U "$DB_USER" -tAc "SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'" | grep -q 1
}

# Drop and recreate database if it exists
if db_exists; then
  echo "Database $DB_NAME already exists. Dropping it..."
  dropdb -U "$DB_USER" "$DB_NAME"
fi

# Step 1: Create the database
echo "Creating database: $DB_NAME..."
createdb -U "$DB_USER" "$DB_NAME"

# Step 2: Load schema
echo "Loading schema from $SCHEMA_FILE..."
psql -U "$DB_USER" -d "$DB_NAME" -f "$SCHEMA_FILE"

# Step 3: Load test data
echo "Loading test data from $DATA_FILE..."
psql -U "$DB_USER" -d "$DB_NAME" -f "$DATA_FILE"

echo "Database ready!"

## ----- Programs setup
ROOT_DIR="$0"

# Python pre-reqs 
pip install -r ${ROOT_DIR}/requirements.txt

# C++ Pre-reqs
sudo apt install libpq-dev