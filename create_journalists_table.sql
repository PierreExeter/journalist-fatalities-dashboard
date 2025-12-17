-- SQL CREATE TABLE statement for journalists dataset
-- Optimized for PostgreSQL 18
-- Database: unesco_db
-- Schema: journalists_schema
-- Table: killed_journalists

-- Set the search path to the journalists_schema
SET search_path TO journalists_schema, public;

-- Create the schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS journalists_schema;

-- Drop table if it exists to recreate with correct column order
DROP TABLE IF EXISTS journalists_schema.killed_journalists CASCADE;

CREATE TABLE journalists_schema.killed_journalists (
    -- Column order matches CSV exactly
    ID INTEGER PRIMARY KEY,
    "Title En" VARCHAR(255),
    Countries VARCHAR(10), -- Country code like 'SY'
    "Date" DATE,
    Nationality VARCHAR(100),
    Language VARCHAR(50),
    Gender VARCHAR(20),
    "Enquiry status" VARCHAR(255),
    Staff VARCHAR(50),
    Local VARCHAR(50),
    "Conflict Zone" BOOLEAN,
    Age INTEGER,
    Media VARCHAR(100),
    "Created At" TIMESTAMPTZ,
    "Updated At" TIMESTAMPTZ,
    "Date resolution" TEXT, -- Contains mixed formats: years (2024) and full timestamps
    UUID UUID,
    "Document Id" VARCHAR(100),
    "Published At" TIMESTAMPTZ,
    "Area coverage" TEXT,
    "Country Title EN" VARCHAR(255),
    "country_Regional Group" VARCHAR(100),
    Coordinates TEXT, -- Stored as text "35.0, 38.0"
    "Country UUID" UUID,
    "Enquiry status home" VARCHAR(100),
    calc_country VARCHAR(100),
    "Calc country code" VARCHAR(10),
    "Geo Shape" JSONB, -- PostgreSQL JSONB for efficient JSON storage and querying
    "Conflict zone calc" VARCHAR(100),
    "Enquiry status stat" VARCHAR(100),
    "Enquiry status min" VARCHAR(100)
);

-- Add indexes for frequently queried columns
CREATE INDEX IF NOT EXISTS idx_killed_journalists_uuid ON journalists_schema.killed_journalists(UUID);
CREATE INDEX IF NOT EXISTS idx_killed_journalists_countries ON journalists_schema.killed_journalists(Countries);
CREATE INDEX IF NOT EXISTS idx_killed_journalists_date ON journalists_schema.killed_journalists("Date");
CREATE INDEX IF NOT EXISTS idx_killed_journalists_enquiry_status ON journalists_schema.killed_journalists("Enquiry status");
CREATE INDEX IF NOT EXISTS idx_killed_journalists_conflict_zone ON journalists_schema.killed_journalists("Conflict Zone");

-- Add GIN index for efficient JSON queries on Geo Shape
CREATE INDEX IF NOT EXISTS idx_killed_journalists_geo_shape ON journalists_schema.killed_journalists USING GIN("Geo Shape");

-- Add comments for documentation
COMMENT ON TABLE journalists_schema.killed_journalists IS 'Dataset of killed journalists with comprehensive case information';
COMMENT ON COLUMN journalists_schema.killed_journalists.ID IS 'Primary identifier for each journalist record';
COMMENT ON COLUMN journalists_schema.killed_journalists."Title En" IS 'Journalist name in English';
COMMENT ON COLUMN journalists_schema.killed_journalists.Countries IS 'Country code (e.g., SY for Syria)';
COMMENT ON COLUMN journalists_schema.killed_journalists."Date" IS 'Date of incident';
COMMENT ON COLUMN journalists_schema.killed_journalists."Conflict Zone" IS 'Whether incident occurred in a conflict zone';
COMMENT ON COLUMN journalists_schema.killed_journalists."Geo Shape" IS 'GeoJSON polygon data for geographic boundaries';
COMMENT ON COLUMN journalists_schema.killed_journalists.UUID IS 'Unique identifier for the record';
COMMENT ON COLUMN journalists_schema.killed_journalists."Country UUID" IS 'UUID for the country';

-- Import command for CSV data
\copy journalists_schema.killed_journalists FROM 'data/fej001.csv' WITH (FORMAT csv, HEADER true, QUOTE '"', DELIMITER ',')
