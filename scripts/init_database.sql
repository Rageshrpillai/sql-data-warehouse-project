
/*
=============================================================
Create Database and Schemas (PostgreSQL)
=============================================================
Script Purpose:
    This script drops and recreates a PostgreSQL database named
    'datawarehouse' if it already exists. After creating the
    database, it sets up three schemas commonly used in data
    engineering pipelines:
        - bronze  (raw data)
        - silver  (cleaned / transformed data)
        - gold    (analytics / business-ready data)

WARNING:
    Running this script will permanently delete the
    'datawarehouse' database if it exists.
    Ensure backups are taken before execution.

IMPORTANT:
    - PostgreSQL does NOT support USE or GO statements.
    - You must run the DROP/CREATE DATABASE commands while
      connected to a different database (usually 'postgres').
=============================================================
*/


-- Step 1: Drop and recreate the database
-- (Run this while connected to the 'postgres' database)


DROP DATABASE IF EXISTS datawarehouse;
CREATE DATABASE datawarehouse;

-- Step 2: Connect to the new database
-- (In psql)

-- \c datawarehouse

-- Step 3: Create schemas inside the database


CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
