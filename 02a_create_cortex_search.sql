-- ============================================================================
-- Create Unified Cortex Search Service for Unstructured Data
-- ============================================================================
-- Single comprehensive Cortex Search service for all unstructured text data
-- Enables semantic search across maintenance logs, quality reports, communications, 
-- engineering docs, and incident reports in one unified search experience
-- ============================================================================

USE DATABASE MANUFACTURING_DEMO;
USE SCHEMA SEMANTIC;

-- Enable change tracking on unstructured data tables (required for Cortex Search)
ALTER TABLE MANUFACTURING_DEMO.DATA.maintenance_logs SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.quality_reports SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.supplier_communications SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.engineering_docs SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.incident_reports SET CHANGE_TRACKING = TRUE;

-- Create warehouse for Cortex Search service (if not exists)
CREATE WAREHOUSE IF NOT EXISTS CORTEX_SEARCH_WH
  WITH WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

-- ============================================================================
-- Unified Cortex Search Service: Manufacturing Documents
-- ============================================================================
-- Searches across all unstructured text data: maintenance logs, quality reports,
-- supplier communications, engineering documentation, and incident reports
CREATE OR REPLACE CORTEX SEARCH SERVICE manufacturing_documents_search
  ON document_text
  PRIMARY KEY (document_type, document_id)
  ATTRIBUTES document_type, document_id, source_table, related_id, related_type, document_date, author, category, severity, status
  WAREHOUSE = CORTEX_SEARCH_WH
  TARGET_LAG = '1 day'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
  AS (
    -- Maintenance Logs
    SELECT
        'MAINTENANCE_LOG' AS document_type,
        log_id AS document_id,
        'maintenance_logs' AS source_table,
        machine_id AS related_id,
        'MACHINE' AS related_type,
        maintenance_date AS document_date,
        technician_id AS author,
        maintenance_type AS category,
        NULL AS severity,
        NULL AS status,
        CONCAT_WS(' ',
            COALESCE('Maintenance Log: ' || log_id, ''),
            COALESCE('Machine: ' || machine_id, ''),
            COALESCE('Type: ' || maintenance_type, ''),
            COALESCE(log_entry, ''),
            COALESCE(issues_found, ''),
            COALESCE(actions_taken, ''),
            COALESCE(recommendations, ''),
            COALESCE(parts_used, '')
        ) AS document_text
    FROM MANUFACTURING_DEMO.DATA.maintenance_logs
    
    UNION ALL
    
    -- Quality Reports
    SELECT
        'QUALITY_REPORT' AS document_type,
        report_id AS document_id,
        'quality_reports' AS source_table,
        batch_number AS related_id,
        'BATCH' AS related_type,
        report_date AS document_date,
        inspector_id AS author,
        NULL AS category,
        NULL AS severity,
        NULL AS status,
        CONCAT_WS(' ',
            COALESCE('Quality Report: ' || report_id, ''),
            COALESCE('Batch: ' || batch_number, ''),
            COALESCE('Product: ' || product_id, ''),
            COALESCE(inspection_notes, ''),
            COALESCE(defect_description, ''),
            COALESCE(root_cause_analysis, ''),
            COALESCE(corrective_actions, ''),
            COALESCE(test_results, '')
        ) AS document_text
    FROM MANUFACTURING_DEMO.DATA.quality_reports
    
    UNION ALL
    
    -- Supplier Communications
    SELECT
        'SUPPLIER_COMMUNICATION' AS document_type,
        communication_id AS document_id,
        'supplier_communications' AS source_table,
        supplier_id AS related_id,
        'SUPPLIER' AS related_type,
        communication_date AS document_date,
        NULL AS author,
        communication_type AS category,
        NULL AS severity,
        NULL AS status,
        CONCAT_WS(' ',
            COALESCE('Subject: ' || subject, ''),
            COALESCE('Type: ' || communication_type, ''),
            COALESCE('Supplier: ' || supplier_id, ''),
            COALESCE(subject, ''),
            COALESCE(content, ''),
            COALESCE(summary, ''),
            COALESCE(action_items, '')
        ) AS document_text
    FROM MANUFACTURING_DEMO.DATA.supplier_communications
    
    UNION ALL
    
    -- Engineering Documentation
    SELECT
        'ENGINEERING_DOC' AS document_type,
        doc_id AS document_id,
        'engineering_docs' AS source_table,
        product_id AS related_id,
        'PRODUCT' AS related_type,
        doc_date AS document_date,
        author AS author,
        doc_type AS category,
        NULL AS severity,
        NULL AS status,
        CONCAT_WS(' ',
            COALESCE('Engineering Document: ' || doc_id, ''),
            COALESCE('Type: ' || doc_type, ''),
            COALESCE('Product: ' || product_id, ''),
            COALESCE('Version: ' || version, ''),
            COALESCE(document_content, ''),
            COALESCE(design_notes, ''),
            COALESCE(test_procedures, ''),
            COALESCE(change_history, '')
        ) AS document_text
    FROM MANUFACTURING_DEMO.DATA.engineering_docs
    
    UNION ALL
    
    -- Incident Reports
    SELECT
        'INCIDENT_REPORT' AS document_type,
        incident_id AS document_id,
        'incident_reports' AS source_table,
        location AS related_id,
        'LOCATION' AS related_type,
        incident_date AS document_date,
        NULL AS author,
        NULL AS category,
        severity AS severity,
        status AS status,
        CONCAT_WS(' ',
            COALESCE('Incident Report: ' || incident_id, ''),
            COALESCE('Location: ' || location, ''),
            COALESCE('Severity: ' || severity, ''),
            COALESCE('Status: ' || status, ''),
            COALESCE(incident_description, ''),
            COALESCE(witness_statements, ''),
            COALESCE(investigation_findings, ''),
            COALESCE(preventive_measures, '')
        ) AS document_text
    FROM MANUFACTURING_DEMO.DATA.incident_reports
);

-- Grant usage permissions
GRANT USAGE ON CORTEX SEARCH SERVICE manufacturing_documents_search TO ROLE PUBLIC;

SELECT 'Unified Cortex Search service created successfully!' AS STATUS;
