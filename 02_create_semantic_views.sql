-- ============================================================================
-- Create Semantic Views for Manufacturing Intelligence
-- ============================================================================
-- Semantic views provide a business-friendly layer over raw data
-- These views will be used by Intelligence agents to understand context
-- ============================================================================

USE DATABASE MANUFACTURING_DEMO;
USE SCHEMA SEMANTIC;

-- Semantic View: Supply Chain Overview
-- Provides unified view of supply chain operations
CREATE OR REPLACE SEMANTIC VIEW supply_chain_overview AS
SELECT 
    supplier_id,
    supplier_name,
    part_number,
    part_description,
    order_date,
    delivery_date,
    DATEDIFF(day, order_date, delivery_date) AS delivery_days,
    quantity,
    unit_cost,
    quantity * unit_cost AS total_cost,
    status,
    risk_score,
    region,
    CASE 
        WHEN risk_score < 0.2 THEN 'Low Risk'
        WHEN risk_score < 0.4 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS risk_category,
    CASE 
        WHEN status = 'Delivered' AND delivery_date <= CURRENT_DATE() THEN 'On Time'
        WHEN status = 'Delivered' AND delivery_date > CURRENT_DATE() THEN 'Early'
        WHEN status = 'In Transit' THEN 'In Progress'
        ELSE 'Pending'
    END AS delivery_status
FROM MANUFACTURING_DEMO.DATA.supply_chain;

-- Semantic View: Production Performance
-- Provides insights into production efficiency and quality
CREATE OR REPLACE SEMANTIC VIEW production_performance AS
SELECT 
    production_line_id,
    machine_id,
    product_id,
    batch_number,
    start_time,
    end_time,
    DATEDIFF(minute, start_time, end_time) AS production_duration_minutes,
    quantity_produced,
    quality_score,
    energy_consumption,
    downtime_minutes,
    operator_id,
    -- Calculate efficiency metrics
    ROUND(quantity_produced / NULLIF(DATEDIFF(minute, start_time, end_time), 0) * 60, 2) AS units_per_hour,
    ROUND(energy_consumption / NULLIF(quantity_produced, 0), 4) AS energy_per_unit,
    ROUND(downtime_minutes / NULLIF(DATEDIFF(minute, start_time, end_time), 0) * 100, 2) AS downtime_percentage,
    CASE 
        WHEN quality_score >= 0.95 THEN 'Excellent'
        WHEN quality_score >= 0.90 THEN 'Good'
        WHEN quality_score >= 0.85 THEN 'Acceptable'
        ELSE 'Needs Improvement'
    END AS quality_rating
FROM MANUFACTURING_DEMO.DATA.production;

-- Semantic View: Inventory Status
-- Provides real-time inventory visibility
CREATE OR REPLACE SEMANTIC VIEW inventory_status AS
SELECT 
    warehouse_id,
    part_number,
    current_stock,
    reorder_level,
    reorder_quantity,
    current_stock - reorder_level AS stock_above_reorder,
    CASE 
        WHEN current_stock <= reorder_level THEN 'Reorder Needed'
        WHEN current_stock <= reorder_level * 1.5 THEN 'Low Stock'
        ELSE 'Adequate Stock'
    END AS stock_status,
    last_updated
FROM MANUFACTURING_DEMO.DATA.inventory;

-- Semantic View: Connected Products Analytics (Semi-structured)
-- Provides insights from connected vehicle/product data with JSON extraction
CREATE OR REPLACE SEMANTIC VIEW connected_products_analytics AS
SELECT 
    vehicle_id,
    product_id,
    telemetry_timestamp,
    -- Extract from semi-structured telemetry_data
    telemetry_data:sensors[0]:type::STRING AS primary_sensor_type,
    telemetry_data:sensors[0]:value::NUMBER AS primary_sensor_value,
    telemetry_data:diagnostics:engine_status::STRING AS engine_status,
    telemetry_data:diagnostics:battery_health::NUMBER AS battery_health,
    telemetry_data:diagnostics:error_codes::ARRAY AS error_codes,
    -- Extract from location_data
    location_data:latitude::NUMBER AS location_lat,
    location_data:longitude::NUMBER AS location_lon,
    location_data:address::STRING AS location_address,
    location_data:geofence::STRING AS geofence_region,
    location_data:speed::NUMBER AS current_speed,
    -- Extract from driver_info
    driver_info:driver_id::STRING AS driver_id,
    driver_info:name::STRING AS driver_name,
    driver_info:behavior_score::NUMBER AS driver_behavior_score,
    driver_info:fatigue_risk::STRING AS fatigue_risk,
    -- Extract from trip_metadata
    trip_metadata:trip_id::STRING AS trip_id,
    trip_metadata:route::STRING AS route,
    trip_metadata:distance_miles::NUMBER AS trip_distance_miles,
    trip_metadata:fuel_efficiency::NUMBER AS fuel_efficiency,
    -- Calculate alerts from sensor data
    CASE 
        WHEN telemetry_data:sensors[0]:type::STRING = 'temperature' AND telemetry_data:sensors[0]:value::NUMBER > 90 THEN 'High Temperature Alert'
        WHEN telemetry_data:sensors[0]:type::STRING = 'battery_level' AND telemetry_data:sensors[0]:value::NUMBER < 20 THEN 'Low Battery Alert'
        WHEN ARRAY_SIZE(telemetry_data:diagnostics:error_codes::ARRAY) > 0 THEN 'Error Codes Present'
        ELSE 'Normal'
    END AS alert_status,
    created_at
FROM MANUFACTURING_DEMO.DATA.connected_products;

-- Semantic View: IoT Sensor Analytics (Semi-structured)
-- Provides insights from IoT sensor data with JSON extraction
CREATE OR REPLACE SEMANTIC VIEW iot_sensor_analytics AS
SELECT 
    sensor_id,
    machine_id,
    production_line_id,
    timestamp,
    -- Extract from sensor_readings array
    sensor_readings[0]:sensor_name::STRING AS primary_sensor_name,
    sensor_readings[0]:value::NUMBER AS primary_sensor_value,
    sensor_readings[0]:status::STRING AS primary_sensor_status,
    -- Extract from machine_state
    machine_state:state::STRING AS machine_state,
    machine_state:operating_mode::STRING AS operating_mode,
    machine_state:uptime_hours::NUMBER AS uptime_hours,
    ARRAY_SIZE(machine_state:alerts::ARRAY) AS alert_count,
    ARRAY_SIZE(machine_state:warnings::ARRAY) AS warning_count,
    -- Extract from calibration_data
    calibration_data:last_calibration::STRING AS last_calibration_date,
    calibration_data:calibration_due::STRING AS calibration_due_date,
    calibration_data:calibration_technician::STRING AS calibration_technician,
    -- Calculate status
    CASE 
        WHEN ARRAY_SIZE(machine_state:alerts::ARRAY) > 0 THEN 'Alert'
        WHEN ARRAY_SIZE(machine_state:warnings::ARRAY) > 0 THEN 'Warning'
        ELSE 'Normal'
    END AS overall_status,
    created_at
FROM MANUFACTURING_DEMO.DATA.iot_sensors;

-- Semantic View: Supplier Documents Overview (Semi-structured)
-- Provides insights from supplier document metadata
CREATE OR REPLACE SEMANTIC VIEW supplier_documents_overview AS
SELECT 
    document_id,
    supplier_id,
    document_type,
    document_date,
    -- Extract from metadata
    metadata:document_title::STRING AS document_title,
    metadata:category::STRING AS category,
    metadata:tags::ARRAY AS tags,
    -- Extract from extracted_data
    extracted_data:total_value::NUMBER AS document_value,
    extracted_data:currency::STRING AS currency,
    extracted_data:payment_terms::STRING AS payment_terms,
    -- Extract from compliance_info
    compliance_info:iso_certified::BOOLEAN AS iso_certified,
    compliance_info:iso_standard::STRING AS iso_standard,
    compliance_info:audit_score::NUMBER AS audit_score,
    compliance_info:certifications::ARRAY AS certifications,
    created_at
FROM MANUFACTURING_DEMO.DATA.supplier_documents;

-- Semantic View: Product Configurations Overview (Semi-structured)
-- Provides insights from product configuration data
CREATE OR REPLACE SEMANTIC VIEW product_configurations_overview AS
SELECT 
    product_id,
    version,
    configuration_date,
    -- Extract from config_data
    config_data:model::STRING AS model_type,
    config_data:engine_type::STRING AS engine_type,
    config_data:transmission::STRING AS transmission,
    config_data:features::ARRAY AS features,
    -- Extract from specifications
    specifications:dimensions:length_mm::NUMBER AS length_mm,
    specifications:dimensions:width_mm::NUMBER AS width_mm,
    specifications:weight_kg::NUMBER AS weight_kg,
    specifications:performance:max_speed_kmh::NUMBER AS max_speed_kmh,
    -- Extract from bill_of_materials
    bill_of_materials:total_components::NUMBER AS total_components,
    bill_of_materials:assembly_complexity::STRING AS assembly_complexity,
    created_at
FROM MANUFACTURING_DEMO.DATA.product_configurations;

-- Semantic View: Maintenance Logs Summary (Unstructured)
-- Provides searchable view of maintenance logs with key information extracted
CREATE OR REPLACE SEMANTIC VIEW maintenance_logs_summary AS
SELECT 
    log_id,
    machine_id,
    maintenance_date,
    technician_id,
    maintenance_type,
    -- Full text fields for semantic search
    log_entry,
    issues_found,
    actions_taken,
    recommendations,
    parts_used,
    -- Extract key information from text (for structured queries)
    CASE 
        WHEN UPPER(log_entry) LIKE '%REPLACE%' OR UPPER(actions_taken) LIKE '%REPLACE%' THEN 'Parts Replaced'
        WHEN UPPER(log_entry) LIKE '%CLEAN%' OR UPPER(actions_taken) LIKE '%CLEAN%' THEN 'Cleaning Performed'
        WHEN UPPER(log_entry) LIKE '%CALIBRAT%' OR UPPER(actions_taken) LIKE '%CALIBRAT%' THEN 'Calibration Performed'
        ELSE 'Other'
    END AS maintenance_category,
    created_at
FROM MANUFACTURING_DEMO.DATA.maintenance_logs;

-- Semantic View: Quality Reports Summary (Unstructured)
-- Provides searchable view of quality reports
CREATE OR REPLACE SEMANTIC VIEW quality_reports_summary AS
SELECT 
    report_id,
    batch_number,
    product_id,
    report_date,
    inspector_id,
    -- Full text fields for semantic search
    inspection_notes,
    defect_description,
    root_cause_analysis,
    corrective_actions,
    test_results,
    -- Extract quality status from text
    CASE 
        WHEN UPPER(inspection_notes) LIKE '%NO DEFECT%' OR UPPER(defect_description) = '' THEN 'No Defects'
        WHEN UPPER(defect_description) LIKE '%MINOR%' THEN 'Minor Defects'
        WHEN UPPER(defect_description) LIKE '%MAJOR%' OR UPPER(defect_description) LIKE '%CRITICAL%' THEN 'Major Defects'
        ELSE 'Defects Found'
    END AS quality_status,
    created_at
FROM MANUFACTURING_DEMO.DATA.quality_reports;

-- Semantic View: Supplier Communications Summary (Unstructured)
-- Provides searchable view of supplier communications
CREATE OR REPLACE SEMANTIC VIEW supplier_communications_summary AS
SELECT 
    communication_id,
    supplier_id,
    communication_date,
    communication_type,
    subject,
    -- Full text fields for semantic search
    content,
    summary,
    action_items,
    attachments_metadata,
    -- Extract communication category
    CASE 
        WHEN UPPER(subject) LIKE '%DELAY%' OR UPPER(content) LIKE '%DELAY%' THEN 'Delivery Delay'
        WHEN UPPER(subject) LIKE '%QUALITY%' OR UPPER(content) LIKE '%QUALITY%' THEN 'Quality Related'
        WHEN UPPER(subject) LIKE '%PRICING%' OR UPPER(content) LIKE '%PRICING%' OR UPPER(subject) LIKE '%CONTRACT%' THEN 'Pricing/Contract'
        WHEN UPPER(communication_type) = 'MEETING NOTES' THEN 'Meeting Notes'
        ELSE 'General'
    END AS communication_category,
    created_at
FROM MANUFACTURING_DEMO.DATA.supplier_communications;

-- Semantic View: Engineering Documentation Summary (Unstructured)
-- Provides searchable view of engineering documents
CREATE OR REPLACE SEMANTIC VIEW engineering_docs_summary AS
SELECT 
    doc_id,
    product_id,
    doc_type,
    doc_date,
    author,
    version,
    -- Full text fields for semantic search
    document_content,
    design_notes,
    test_procedures,
    change_history,
    created_at
FROM MANUFACTURING_DEMO.DATA.engineering_docs;

-- Semantic View: Incident Reports Summary (Unstructured)
-- Provides searchable view of incident reports
CREATE OR REPLACE SEMANTIC VIEW incident_reports_summary AS
SELECT 
    incident_id,
    incident_date,
    location,
    severity,
    status,
    -- Full text fields for semantic search
    incident_description,
    witness_statements,
    investigation_findings,
    preventive_measures,
    created_at
FROM MANUFACTURING_DEMO.DATA.incident_reports;

-- Grant SELECT on semantic views
GRANT SELECT ON ALL SEMANTIC VIEWS IN SCHEMA MANUFACTURING_DEMO.SEMANTIC TO ROLE PUBLIC;
GRANT SELECT ON FUTURE SEMANTIC VIEWS IN SCHEMA MANUFACTURING_DEMO.SEMANTIC TO ROLE PUBLIC;

SELECT 'Semantic views created successfully!' AS STATUS;

