# Go Ad Service

This is a simple ad serving service implemented in Go. It provides two RESTful APIs: one for creating ads and another for listing active ads based on certain conditions.

## Requirements

- Go 1.16 or later
- PostgreSQL database

## Setup

1. Clone the repository:

```bash
git clone https://github.com/i-am-harveyt/go-ad-service.git
cd go-ad-service
```

2. Set up the PostgreSQL database:

```bash
# Create a new database
CREATE DATABASE ad_service;

# Connect to the database
\c ad_service

# Create the `ads` table
CREATE TABLE ads (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    start_at TIMESTAMP NOT NULL,
    end_at TIMESTAMP NOT NULL,
    age_start SMALLINT,
    age_end SMALLINT,
    gender TEXT[],
    country TEXT[],
    platform TEXT[]
);

# Create indexes
CREATE INDEX idx_ads_start_at ON ads (start_at);
CREATE INDEX idx_ads_end_at ON ads (end_at);
Set the DATABASE_URL environment variable:
bash
```

3. Run

```bash
export DATABASE_URL="postgres://go:go@localhost/go?sslmode=disable"
go run main.go
```

The server will start running on `http://localhost:3000`.
