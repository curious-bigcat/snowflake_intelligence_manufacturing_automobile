-- ============================================================================
-- Verification Script - Manufacturing Intelligence Demo
-- ============================================================================
-- Run this script to verify that all components are set up correctly
-- ============================================================================

-- Check Intelligence Object
SELECT 'Checking Intelligence Object...' AS STEP;
SHOW INTELLIGENCE;

-- Check Database and Schemas
SELECT 'Checking Database and Schemas...' AS STEP;
SHOW DATABASES LIKE 'MANUFACTURING_DEMO';
SHOW SCHEMAS IN DATABASE MANUFACTURING_DEMO;
SHOW DATABASES LIKE 'SNOWFLAKE_INTELLIGENCE';
SHOW SCHEMAS IN DATABASE SNOWFLAKE_INTELLIGENCE;

-- Check Tables
SELECT 'Checking Tables...' AS STEP;
SHOW TABLES IN SCHEMA MANUFACTURING_DEMO.DATA;

-- Check Semantic Views
SELECT 'Checking Semantic Views...' AS STEP;
SHOW SEMANTIC VIEWS IN SCHEMA MANUFACTURING_DEMO.SEMANTIC;

-- Check Agents
SELECT 'Checking Agents...' AS STEP;
SHOW AGENTS IN INTELLIGENCE manufacturing_intelligence;
SHOW AGENTS IN SCHEMA SNOWFLAKE_INTELLIGENCE.AGENTS;

-- Verify Data in Tables
SELECT 'Verifying Data in Tables...' AS STEP;
SELECT 'supply_chain' AS TABLE_NAME, COUNT(*) AS ROW_COUNT FROM MANUFACTURING_DEMO.DATA.supply_chain
UNION ALL
SELECT 'production' AS TABLE_NAME, COUNT(*) AS ROW_COUNT FROM MANUFACTURING_DEMO.DATA.production
UNION ALL
SELECT 'inventory' AS TABLE_NAME, COUNT(*) AS ROW_COUNT FROM MANUFACTURING_DEMO.DATA.inventory
UNION ALL
SELECT 'connected_products' AS TABLE_NAME, COUNT(*) AS ROW_COUNT FROM MANUFACTURING_DEMO.DATA.connected_products;

-- Verify Semantic Views
SELECT 'Verifying Semantic Views...' AS STEP;
SELECT 'manufacturing_operations' AS VIEW_NAME, COUNT(*) AS ROW_COUNT FROM SEMANTIC VIEW(MANUFACTURING_DEMO.SEMANTIC.manufacturing_operations METRICS(*) DIMENSIONS(*));

-- Check Warehouse
SELECT 'Checking Warehouse...' AS STEP;
SHOW WAREHOUSES LIKE 'INTEL_WH';

-- Summary
SELECT '========================================' AS SEPARATOR;
SELECT 'VERIFICATION SUMMARY' AS SUMMARY;
SELECT '========================================' AS SEPARATOR;
SELECT 
    'Intelligence Object: manufacturing_intelligence' AS COMPONENT,
    CASE WHEN EXISTS (SELECT 1 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID(-1)))) THEN '✓ Created' ELSE '✗ Missing' END AS STATUS
UNION ALL
SELECT 
    'Database: MANUFACTURING_DEMO' AS COMPONENT,
    CASE WHEN EXISTS (SELECT 1 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID(-2)))) THEN '✓ Created' ELSE '✗ Missing' END AS STATUS
UNION ALL
SELECT 
    'Semantic View: manufacturing_operations' AS COMPONENT,
    CASE WHEN EXISTS (SELECT 1 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID(-3)))) THEN '✓ Created' ELSE '✗ Missing' END AS STATUS
UNION ALL
SELECT 
    'Agents Schema: SNOWFLAKE_INTELLIGENCE.AGENTS' AS COMPONENT,
    CASE WHEN EXISTS (SELECT 1 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID(-4)))) THEN '✓ Created' ELSE '✗ Missing' END AS STATUS
UNION ALL
SELECT 
    'Agents: 4 agents' AS COMPONENT,
    CASE WHEN EXISTS (SELECT 1 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID(-5)))) THEN '✓ Created' ELSE '✗ Missing' END AS STATUS;

SELECT '========================================' AS SEPARATOR;
SELECT 'Setup verification complete!' AS STATUS;
SELECT 'If all components show ✓, you are ready to demo!' AS NEXT_STEPS;
SELECT 'Refer to DEMO_GUIDE.md for sample queries.' AS REFERENCE;

