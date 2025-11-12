-- ============================================================================
-- Create Cortex Search Services for Unstructured Data
-- ============================================================================
-- Cortex Search enables semantic search over unstructured text data
-- These services will be used by Intelligence agents for RAG and search
-- ============================================================================

USE DATABASE MANUFACTURING_DEMO;
USE SCHEMA SEMANTIC;

-- Enable change tracking on unstructured data tables (required for Cortex Search)
ALTER TABLE MANUFACTURING_DEMO.DATA.maintenance_logs SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.quality_reports SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.supplier_communications SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.engineering_docs SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.incident_reports SET CHANGE_TRACKING = TRUE;

-- Create warehouse for Cortex Search services (if not exists)
CREATE WAREHOUSE IF NOT EXISTS CORTEX_SEARCH_WH
  WITH WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

-- ============================================================================
-- Cortex Search Service: Maintenance Logs
-- ============================================================================
-- Searches maintenance log entries, issues found, actions taken, and recommendations
CREATE OR REPLACE CORTEX SEARCH SERVICE maintenance_logs_search
  ON log_entry
  PRIMARY KEY (log_id)
  ATTRIBUTES log_id, machine_id, maintenance_date, technician_id, maintenance_type
  WAREHOUSE = CORTEX_SEARCH_WH
  TARGET_LAG = '1 day'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
  AS (
    SELECT
        log_id,
        machine_id,
        maintenance_date,
        technician_id,
        maintenance_type,
        -- Combine all text fields for comprehensive search
        CONCAT_WS(' ',
            COALESCE(log_entry, ''),
            COALESCE(issues_found, ''),
            COALESCE(actions_taken, ''),
            COALESCE(recommendations, ''),
            COALESCE(parts_used, '')
        ) AS log_entry
    FROM MANUFACTURING_DEMO.DATA.maintenance_logs
);

-- ============================================================================
-- Cortex Search Service: Quality Reports
-- ============================================================================
-- Searches quality inspection notes, defect descriptions, root cause analysis, and corrective actions
CREATE OR REPLACE CORTEX SEARCH SERVICE quality_reports_search
  ON inspection_notes
  PRIMARY KEY (report_id)
  ATTRIBUTES report_id, batch_number, product_id, report_date, inspector_id
  WAREHOUSE = CORTEX_SEARCH_WH
  TARGET_LAG = '1 day'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
  AS (
    SELECT
        report_id,
        batch_number,
        product_id,
        report_date,
        inspector_id,
        -- Combine all text fields for comprehensive search
        CONCAT_WS(' ',
            COALESCE(inspection_notes, ''),
            COALESCE(defect_description, ''),
            COALESCE(root_cause_analysis, ''),
            COALESCE(corrective_actions, ''),
            COALESCE(test_results, '')
        ) AS inspection_notes
    FROM MANUFACTURING_DEMO.DATA.quality_reports
);

-- ============================================================================
-- Cortex Search Service: Supplier Communications
-- ============================================================================
-- Searches supplier communication content, summaries, and action items
CREATE OR REPLACE CORTEX SEARCH SERVICE supplier_communications_search
  ON content
  PRIMARY KEY (communication_id)
  ATTRIBUTES communication_id, supplier_id, communication_date, communication_type, subject
  WAREHOUSE = CORTEX_SEARCH_WH
  TARGET_LAG = '1 day'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
  AS (
    SELECT
        communication_id,
        supplier_id,
        communication_date,
        communication_type,
        subject,
        -- Combine all text fields for comprehensive search
        CONCAT_WS(' ',
            COALESCE(subject, ''),
            COALESCE(content, ''),
            COALESCE(summary, ''),
            COALESCE(action_items, '')
        ) AS content
    FROM MANUFACTURING_DEMO.DATA.supplier_communications
);

-- ============================================================================
-- Cortex Search Service: Engineering Documentation
-- ============================================================================
-- Searches engineering document content, design notes, test procedures, and change history
CREATE OR REPLACE CORTEX SEARCH SERVICE engineering_docs_search
  ON document_content
  PRIMARY KEY (doc_id)
  ATTRIBUTES doc_id, product_id, doc_type, doc_date, author, version
  WAREHOUSE = CORTEX_SEARCH_WH
  TARGET_LAG = '1 day'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
  AS (
    SELECT
        doc_id,
        product_id,
        doc_type,
        doc_date,
        author,
        version,
        -- Combine all text fields for comprehensive search
        CONCAT_WS(' ',
            COALESCE(doc_type, ''),
            COALESCE(document_content, ''),
            COALESCE(design_notes, ''),
            COALESCE(test_procedures, ''),
            COALESCE(change_history, '')
        ) AS document_content
    FROM MANUFACTURING_DEMO.DATA.engineering_docs
);

-- ============================================================================
-- Cortex Search Service: Incident Reports
-- ============================================================================
-- Searches incident descriptions, witness statements, investigation findings, and preventive measures
CREATE OR REPLACE CORTEX SEARCH SERVICE incident_reports_search
  ON incident_description
  PRIMARY KEY (incident_id)
  ATTRIBUTES incident_id, incident_date, location, severity, status
  WAREHOUSE = CORTEX_SEARCH_WH
  TARGET_LAG = '1 day'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
  AS (
    SELECT
        incident_id,
        incident_date,
        location,
        severity,
        status,
        -- Combine all text fields for comprehensive search
        CONCAT_WS(' ',
            COALESCE(incident_description, ''),
            COALESCE(witness_statements, ''),
            COALESCE(investigation_findings, ''),
            COALESCE(preventive_measures, '')
        ) AS incident_description
    FROM MANUFACTURING_DEMO.DATA.incident_reports
);

-- Grant usage permissions
GRANT USAGE ON CORTEX SEARCH SERVICE maintenance_logs_search TO ROLE PUBLIC;
GRANT USAGE ON CORTEX SEARCH SERVICE quality_reports_search TO ROLE PUBLIC;
GRANT USAGE ON CORTEX SEARCH SERVICE supplier_communications_search TO ROLE PUBLIC;
GRANT USAGE ON CORTEX SEARCH SERVICE engineering_docs_search TO ROLE PUBLIC;
GRANT USAGE ON CORTEX SEARCH SERVICE incident_reports_search TO ROLE PUBLIC;

SELECT 'Cortex Search services created successfully!' AS STATUS;

