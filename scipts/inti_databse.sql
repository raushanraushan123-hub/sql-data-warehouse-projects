-- Script Purpose:
-- This script creates a new database named 'DataWarehouse' after checking if it already exists.
-- If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
-- within the database: 'bronze', 'silver', and 'gold'.

-- WARNING:
-- Running this script will drop the entire 'DataWarehouse' database if it exists.
-- All data in the database will be permanently deleted. Proceed with caution
-- and ensure you have proper backups before running this script.

-- This script should typically be run while connected to a database other than 'DataWarehouse',
-- for example, the default 'postgres' database, as you cannot drop a database you are currently connected to.

-------------------------------------------------------------
-- Drop and Recreate the 'DataWarehouse' database
-------------------------------------------------------------

-- Terminate all active connections to the 'DataWarehouse' database (if it exists).
-- This is a crucial step in PostgreSQL before dropping a database that might have active users.
-- 'pg_terminate_backend' is a PostgreSQL function to end a backend process by PID.
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'DataWarehouse' AND pid <> pg_backend_pid();

-- Drop the 'DataWarehouse' database if it exists.
-- PostgreSQL uses 'DROP DATABASE IF EXISTS' for conditional dropping.
DROP DATABASE IF EXISTS "DataWarehouse";

-- Create the 'DataWarehouse' database.
CREATE DATABASE "DataWarehouse";

-------------------------------------------------------------
-- Connect to the New Database and Create Schemas
-------------------------------------------------------------

-- Connect to the newly created 'DataWarehouse' database.
-- '\c' is a psql meta-command used to connect to a different database within a psql session.
-- If running this script from a client application, you would typically establish a new connection
-- to 'DataWarehouse' after its creation.
\c "DataWarehouse";

-- Create Schemas within 'DataWarehouse'.
-- 'CREATE SCHEMA' syntax is standard SQL and works directly in PostgreSQL.
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
