-- ============================================================
-- Building 59 Project Foundation
-- ============================================================

-- ------------------------------------------------------------
-- Schemas
-- ------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS building59_dev.bronze
COMMENT 'Raw and source-preserving data for the Building 59 project';

CREATE SCHEMA IF NOT EXISTS building59_dev.silver
COMMENT 'Cleaned, standardized, validated, and reusable domain data for the Building 59 project';

CREATE SCHEMA IF NOT EXISTS building59_dev.gold
COMMENT 'Business-ready analytical data products for the Building 59 project';

CREATE SCHEMA IF NOT EXISTS building59_dev.operations
COMMENT 'Operational and supporting project objects for the Building 59 project';


-- ------------------------------------------------------------
-- Verify schemas
-- ------------------------------------------------------------

SHOW SCHEMAS IN building59_dev;


-- ------------------------------------------------------------
-- Managed project volume
-- ------------------------------------------------------------

CREATE VOLUME IF NOT EXISTS
building59_dev.operations.project_files
COMMENT 'Managed project files for the Building 59 data engineering project';


-- ------------------------------------------------------------
-- External source-data volume
-- ------------------------------------------------------------

-- First inspect the actual external-location URL:
DESCRIBE EXTERNAL LOCATION el_building59_landing;

-- Replace the LOCATION below with the verified URL plus:
-- /building59_source

CREATE EXTERNAL VOLUME IF NOT EXISTS
building59_dev.bronze.source_data
LOCATION '<verified-el_building59_landing-url>/building59_source'
COMMENT 'Building 59 source files stored in the ADLS landing area';


-- ------------------------------------------------------------
-- Verify volumes
-- ------------------------------------------------------------

SHOW VOLUMES IN building59_dev.bronze;
SHOW VOLUMES IN building59_dev.operations;


-- ------------------------------------------------------------
-- Catalog and schema access validation
-- ------------------------------------------------------------

USE CATALOG building59_dev;
SELECT current_catalog();

USE SCHEMA bronze;
SELECT current_schema();


-- ------------------------------------------------------------
-- Temporary table-access validation
-- ------------------------------------------------------------

CREATE TABLE building59_dev.bronze.foundation_access_test (
    test_id INT,
    test_message STRING
);

INSERT INTO building59_dev.bronze.foundation_access_test
VALUES (
    1,
    'Building 59 project foundation validated'
);

SELECT *
FROM building59_dev.bronze.foundation_access_test;


-- ------------------------------------------------------------
-- Cleanup temporary validation table
-- ------------------------------------------------------------

DROP TABLE IF EXISTS
building59_dev.bronze.foundation_access_test;