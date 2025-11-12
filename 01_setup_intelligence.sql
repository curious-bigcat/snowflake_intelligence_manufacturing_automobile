-- ============================================================================
-- Snowflake Intelligence Setup for Manufacturing Demo
-- ============================================================================
-- This script sets up the Snowflake Intelligence infrastructure
-- Run this script as ACCOUNTADMIN or a role with sufficient privileges
-- ============================================================================

-- Step 1: Create Intelligence Object
-- This creates the main Intelligence object in your account
CREATE INTELLIGENCE IF NOT EXISTS manufacturing_intelligence
  COMMENT = 'Snowflake Intelligence for Manufacturing & Automobiles Demo';

-- Step 2: Grant Usage Privileges
-- Grant usage to roles that will use Intelligence
GRANT USAGE ON INTELLIGENCE manufacturing_intelligence TO ROLE PUBLIC;

-- Step 3: Create Database and Schema for Demo Data
USE ROLE ACCOUNTADMIN;
CREATE DATABASE IF NOT EXISTS MANUFACTURING_DEMO;
CREATE SCHEMA IF NOT EXISTS MANUFACTURING_DEMO.DATA;
CREATE SCHEMA IF NOT EXISTS MANUFACTURING_DEMO.SEMANTIC;

-- Grant privileges
GRANT USAGE ON DATABASE MANUFACTURING_DEMO TO ROLE PUBLIC;
GRANT USAGE ON SCHEMA MANUFACTURING_DEMO.DATA TO ROLE PUBLIC;
GRANT USAGE ON SCHEMA MANUFACTURING_DEMO.SEMANTIC TO ROLE PUBLIC;

-- Step 4: Create Warehouse for Intelligence Operations
CREATE WAREHOUSE IF NOT EXISTS INTEL_WH
  WITH WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  COMMENT = 'Warehouse for Snowflake Intelligence operations';

GRANT USAGE ON WAREHOUSE INTEL_WH TO ROLE PUBLIC;

-- Step 5: Create Sample Manufacturing Tables (for demo purposes)
-- These represent typical manufacturing data sources covering:
-- STRUCTURED: Traditional relational tables
-- SEMI-STRUCTURED: JSON/VARIANT columns with nested data
-- UNSTRUCTURED: Text documents, logs, reports

-- ============================================================================
-- STRUCTURED DATA - Traditional relational tables
-- ============================================================================

-- Supply Chain Data (Structured)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.supply_chain (
    supplier_id VARCHAR,
    supplier_name VARCHAR,
    part_number VARCHAR,
    part_description VARCHAR,
    order_date DATE,
    delivery_date DATE,
    quantity NUMBER,
    unit_cost NUMBER(10,2),
    status VARCHAR,
    risk_score NUMBER(3,2),
    region VARCHAR,
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Production/Shopfloor Data (Structured)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.production (
    production_line_id VARCHAR,
    machine_id VARCHAR,
    product_id VARCHAR,
    batch_number VARCHAR,
    start_time TIMESTAMP_NTZ,
    end_time TIMESTAMP_NTZ,
    quantity_produced NUMBER,
    quality_score NUMBER(3,2),
    energy_consumption NUMBER(10,2),
    downtime_minutes NUMBER,
    operator_id VARCHAR,
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Inventory Data (Structured)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.inventory (
    warehouse_id VARCHAR,
    part_number VARCHAR,
    current_stock NUMBER,
    reorder_level NUMBER,
    reorder_quantity NUMBER,
    last_updated TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- ============================================================================
-- SEMI-STRUCTURED DATA - JSON/VARIANT columns
-- ============================================================================

-- Connected Vehicle/Product Telemetry (Semi-structured JSON)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.connected_products (
    vehicle_id VARCHAR,
    product_id VARCHAR,
    telemetry_timestamp TIMESTAMP_NTZ,
    -- Semi-structured: JSON telemetry data
    telemetry_data VARIANT,  -- Contains nested JSON with sensors, diagnostics, etc.
    location_data VARIANT,   -- Contains lat, lon, address, geofence info
    driver_info VARIANT,     -- Contains driver details, behavior metrics
    trip_metadata VARIANT,   -- Contains trip details, route, duration
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- IoT Sensor Data (Semi-structured)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.iot_sensors (
    sensor_id VARCHAR,
    machine_id VARCHAR,
    production_line_id VARCHAR,
    timestamp TIMESTAMP_NTZ,
    -- Semi-structured: Sensor readings as JSON
    sensor_readings VARIANT,  -- Array of sensor values with types, units, thresholds
    machine_state VARIANT,    -- Current state, alerts, warnings
    calibration_data VARIANT, -- Calibration history, offsets, adjustments
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Supplier Documents Metadata (Semi-structured)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.supplier_documents (
    document_id VARCHAR,
    supplier_id VARCHAR,
    document_type VARCHAR,
    document_date DATE,
    -- Semi-structured: Document metadata and extracted fields
    metadata VARIANT,         -- Document properties, tags, categories
    extracted_data VARIANT,   -- Extracted fields from documents (prices, terms, etc.)
    compliance_info VARIANT,  -- Compliance status, certifications, audits
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Product Configuration (Semi-structured)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.product_configurations (
    product_id VARCHAR,
    version VARCHAR,
    configuration_date DATE,
    -- Semi-structured: Product configuration as JSON
    config_data VARIANT,      -- Nested configuration options, features, settings
    specifications VARIANT,   -- Technical specs, dimensions, materials
    bill_of_materials VARIANT, -- BOM structure with nested components
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- ============================================================================
-- UNSTRUCTURED DATA - Text documents, logs, reports
-- ============================================================================

-- Maintenance Logs (Unstructured text)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.maintenance_logs (
    log_id VARCHAR,
    machine_id VARCHAR,
    maintenance_date DATE,
    technician_id VARCHAR,
    maintenance_type VARCHAR,
    -- Unstructured: Free-form text logs
    log_entry TEXT,           -- Detailed maintenance notes, observations
    issues_found TEXT,        -- Description of issues discovered
    actions_taken TEXT,       -- Actions performed during maintenance
    recommendations TEXT,     -- Recommendations for future maintenance
    parts_used TEXT,          -- Parts replaced or used (free text)
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Quality Reports (Unstructured text)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.quality_reports (
    report_id VARCHAR,
    batch_number VARCHAR,
    product_id VARCHAR,
    report_date DATE,
    inspector_id VARCHAR,
    -- Unstructured: Quality inspection reports
    inspection_notes TEXT,     -- Detailed inspection observations
    defect_description TEXT,   -- Description of any defects found
    root_cause_analysis TEXT,  -- Analysis of quality issues
    corrective_actions TEXT,   -- Actions taken to address issues
    test_results TEXT,         -- Test results and observations
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Supplier Communications (Unstructured text)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.supplier_communications (
    communication_id VARCHAR,
    supplier_id VARCHAR,
    communication_date DATE,
    communication_type VARCHAR, -- Email, Meeting Notes, Contract, etc.
    subject VARCHAR,
    -- Unstructured: Communication content
    content TEXT,              -- Full text of emails, meeting notes, etc.
    summary TEXT,              -- Summary or key points
    action_items TEXT,         -- Action items extracted from communication
    attachments_metadata TEXT, -- Description of attachments
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Engineering Documentation (Unstructured text)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.engineering_docs (
    doc_id VARCHAR,
    product_id VARCHAR,
    doc_type VARCHAR,          -- Design Spec, Test Plan, Change Request, etc.
    doc_date DATE,
    author VARCHAR,
    version VARCHAR,
    -- Unstructured: Engineering documentation
    document_content TEXT,     -- Full text of engineering documents
    design_notes TEXT,         -- Design considerations and notes
    test_procedures TEXT,      -- Testing procedures and results
    change_history TEXT,       -- Change log and history
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Incident Reports (Unstructured text)
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.incident_reports (
    incident_id VARCHAR,
    incident_date DATE,
    location VARCHAR,
    severity VARCHAR,
    status VARCHAR,
    -- Unstructured: Incident descriptions
    incident_description TEXT, -- Detailed description of the incident
    witness_statements TEXT,   -- Witness accounts and statements
    investigation_findings TEXT, -- Investigation results and findings
    preventive_measures TEXT,  -- Measures taken to prevent recurrence
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- ============================================================================
-- INSERT SAMPLE DATA
-- ============================================================================
-- NOTE: Detailed vehicle manufacturing data with 50+ records per table
-- is provided in file: 01b_insert_vehicle_data.sql
-- Run that file after this setup script completes
-- 
-- For now, inserting minimal data to allow setup to complete:

INSERT INTO MANUFACTURING_DEMO.DATA.production VALUES
('LINE-01', 'MACHINE-A', 'PROD-001', 'BATCH-2024-001', '2024-01-15 08:00:00', '2024-01-15 16:00:00', 500, 0.95, 1250.50, 30, 'OP-001', CURRENT_TIMESTAMP()),
('LINE-02', 'MACHINE-B', 'PROD-002', 'BATCH-2024-002', '2024-01-15 08:00:00', '2024-01-15 16:00:00', 750, 0.98, 1850.25, 15, 'OP-002', CURRENT_TIMESTAMP()),
('LINE-01', 'MACHINE-A', 'PROD-001', 'BATCH-2024-003', '2024-01-16 08:00:00', '2024-01-16 16:00:00', 520, 0.97, 1280.00, 20, 'OP-001', CURRENT_TIMESTAMP()),
('LINE-03', 'MACHINE-C', 'PROD-003', 'BATCH-2024-004', '2024-01-17 08:00:00', '2024-01-17 16:00:00', 600, 0.96, 1450.75, 25, 'OP-003', CURRENT_TIMESTAMP()),
('LINE-02', 'MACHINE-B', 'PROD-002', 'BATCH-2024-005', '2024-01-18 08:00:00', '2024-01-18 16:00:00', 780, 0.99, 1920.50, 10, 'OP-002', CURRENT_TIMESTAMP());

INSERT INTO MANUFACTURING_DEMO.DATA.inventory VALUES
('WH-001', 'PART-12345', 5000, 1000, 2000, CURRENT_TIMESTAMP()),
('WH-002', 'PART-67890', 2500, 500, 1000, CURRENT_TIMESTAMP()),
('WH-001', 'PART-11111', 8000, 2000, 3000, CURRENT_TIMESTAMP()),
('WH-003', 'PART-22222', 1200, 300, 500, CURRENT_TIMESTAMP()),
('WH-002', 'PART-33333', 3500, 800, 1500, CURRENT_TIMESTAMP());

-- SEMI-STRUCTURED DATA - JSON/VARIANT columns
-- Note: PARSE_JSON cannot be used directly in VALUES clause, so we use SELECT FROM VALUES pattern
-- Using individual INSERT SELECT statements for each row
INSERT INTO MANUFACTURING_DEMO.DATA.connected_products 
SELECT 'VEH-001' AS vehicle_id, 'PROD-001' AS product_id, '2024-01-15 10:30:00'::TIMESTAMP_NTZ AS telemetry_timestamp,
    PARSE_JSON('{"sensors": [{"type": "temperature", "value": 85.5, "unit": "celsius", "threshold": 90}, {"type": "pressure", "value": 45.2, "unit": "psi", "threshold": 50}, {"type": "vibration", "value": 2.3, "unit": "g", "threshold": 5.0}], "diagnostics": {"engine_status": "normal", "battery_health": 92, "error_codes": []}}') AS telemetry_data,
    PARSE_JSON('{"latitude": 37.7749, "longitude": -122.4194, "address": "San Francisco, CA", "geofence": "North_Region", "speed": 65, "heading": 180}') AS location_data,
    PARSE_JSON('{"driver_id": "DRV-001", "name": "John Smith", "license_number": "CA123456", "behavior_score": 8.5, "driving_hours_today": 6.5, "fatigue_risk": "low"}') AS driver_info,
    PARSE_JSON('{"trip_id": "TRIP-001", "route": "Highway 101", "distance_miles": 245.5, "duration_minutes": 225, "fuel_efficiency": 28.5, "stops": 2}') AS trip_metadata,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.connected_products 
SELECT 'VEH-002' AS vehicle_id, 'PROD-002' AS product_id, '2024-01-15 11:00:00'::TIMESTAMP_NTZ AS telemetry_timestamp,
    PARSE_JSON('{"sensors": [{"type": "battery_level", "value": 78.5, "unit": "percent", "threshold": 20}, {"type": "charging_status", "value": "not_charging", "unit": "status"}, {"type": "range_estimate", "value": 245, "unit": "miles"}], "diagnostics": {"battery_health": 88, "charging_port_status": "ok", "error_codes": []}}') AS telemetry_data,
    PARSE_JSON('{"latitude": 40.7128, "longitude": -74.0060, "address": "New York, NY", "geofence": "East_Region", "speed": 0, "heading": 0}') AS location_data,
    PARSE_JSON('{"driver_id": "DRV-002", "name": "Sarah Johnson", "license_number": "NY789012", "behavior_score": 9.2, "driving_hours_today": 4.0, "fatigue_risk": "low"}') AS driver_info,
    PARSE_JSON('{"trip_id": "TRIP-002", "route": "City Streets", "distance_miles": 12.3, "duration_minutes": 45, "fuel_efficiency": 0, "stops": 5}') AS trip_metadata,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.connected_products 
SELECT 'VEH-003' AS vehicle_id, 'PROD-001' AS product_id, '2024-01-15 14:20:00'::TIMESTAMP_NTZ AS telemetry_timestamp,
    PARSE_JSON('{"sensors": [{"type": "temperature", "value": 92.3, "unit": "celsius", "threshold": 90}, {"type": "pressure", "value": 48.5, "unit": "psi", "threshold": 50}, {"type": "vibration", "value": 4.8, "unit": "g", "threshold": 5.0}], "diagnostics": {"engine_status": "warning", "battery_health": 85, "error_codes": ["TEMP_HIGH", "VIBRATION_ELEVATED"]}}') AS telemetry_data,
    PARSE_JSON('{"latitude": 34.0522, "longitude": -118.2437, "address": "Los Angeles, CA", "geofence": "West_Region", "speed": 72, "heading": 270}') AS location_data,
    PARSE_JSON('{"driver_id": "DRV-003", "name": "Mike Davis", "license_number": "CA456789", "behavior_score": 7.8, "driving_hours_today": 8.5, "fatigue_risk": "medium"}') AS driver_info,
    PARSE_JSON('{"trip_id": "TRIP-003", "route": "Interstate 5", "distance_miles": 380.2, "duration_minutes": 320, "fuel_efficiency": 26.2, "stops": 1}') AS trip_metadata,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.iot_sensors
SELECT 'SENSOR-001' AS sensor_id, 'MACHINE-A' AS machine_id, 'LINE-01' AS production_line_id, '2024-01-15 10:00:00'::TIMESTAMP_NTZ AS timestamp,
    PARSE_JSON('[{"sensor_name": "temperature_probe_1", "value": 75.5, "unit": "celsius", "status": "normal", "threshold_min": 60, "threshold_max": 90}, {"sensor_name": "pressure_gauge_1", "value": 45.2, "unit": "psi", "status": "normal", "threshold_min": 30, "threshold_max": 60}, {"sensor_name": "vibration_sensor", "value": 1.8, "unit": "g", "status": "normal", "threshold_max": 5.0}]') AS sensor_readings,
    PARSE_JSON('{"state": "running", "operating_mode": "production", "alerts": [], "warnings": [], "uptime_hours": 1245.5}') AS machine_state,
    PARSE_JSON('{"last_calibration": "2024-01-01", "calibration_due": "2024-04-01", "offset_temperature": 0.2, "offset_pressure": 0.0, "calibration_technician": "TECH-001"}') AS calibration_data,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.iot_sensors
SELECT 'SENSOR-002' AS sensor_id, 'MACHINE-B' AS machine_id, 'LINE-02' AS production_line_id, '2024-01-15 10:00:00'::TIMESTAMP_NTZ AS timestamp,
    PARSE_JSON('[{"sensor_name": "temperature_probe_1", "value": 82.3, "unit": "celsius", "status": "normal", "threshold_min": 60, "threshold_max": 90}, {"sensor_name": "flow_rate", "value": 125.5, "unit": "liters/min", "status": "normal", "threshold_min": 100, "threshold_max": 150}]') AS sensor_readings,
    PARSE_JSON('{"state": "running", "operating_mode": "production", "alerts": [], "warnings": ["flow_rate_approaching_max"], "uptime_hours": 892.3}') AS machine_state,
    PARSE_JSON('{"last_calibration": "2023-12-15", "calibration_due": "2024-03-15", "offset_temperature": 0.5, "offset_flow": 0.0, "calibration_technician": "TECH-002"}') AS calibration_data,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.iot_sensors
SELECT 'SENSOR-003' AS sensor_id, 'MACHINE-C' AS machine_id, 'LINE-03' AS production_line_id, '2024-01-15 10:00:00'::TIMESTAMP_NTZ AS timestamp,
    PARSE_JSON('[{"sensor_name": "temperature_probe_1", "value": 88.7, "unit": "celsius", "status": "warning", "threshold_min": 60, "threshold_max": 90}, {"sensor_name": "pressure_gauge_1", "value": 58.2, "unit": "psi", "status": "warning", "threshold_min": 30, "threshold_max": 60}]') AS sensor_readings,
    PARSE_JSON('{"state": "running", "operating_mode": "production", "alerts": ["temperature_high"], "warnings": ["pressure_approaching_max"], "uptime_hours": 2103.7}') AS machine_state,
    PARSE_JSON('{"last_calibration": "2023-11-20", "calibration_due": "2024-02-20", "offset_temperature": 0.3, "offset_pressure": 0.1, "calibration_technician": "TECH-001"}') AS calibration_data,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.supplier_documents
SELECT 'DOC-001' AS document_id, 'SUP001' AS supplier_id, 'Contract' AS document_type, '2024-01-10'::DATE AS document_date,
    PARSE_JSON('{"document_title": "Supply Agreement 2024", "pages": 15, "language": "English", "format": "PDF", "file_size_mb": 2.5, "tags": ["contract", "supply", "2024"], "category": "Legal"}') AS metadata,
    PARSE_JSON('{"total_value": 250000, "currency": "USD", "payment_terms": "Net 30", "delivery_terms": "FOB", "warranty_period_months": 12, "penalty_clauses": true}') AS extracted_data,
    PARSE_JSON('{"iso_certified": true, "iso_standard": "ISO 9001:2015", "environmental_compliance": "ISO 14001", "last_audit_date": "2023-12-15", "audit_score": 95, "certifications": ["ISO 9001", "ISO 14001", "IATF 16949"]}') AS compliance_info,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.supplier_documents
SELECT 'DOC-002' AS document_id, 'SUP002' AS supplier_id, 'Quality Certificate' AS document_type, '2024-01-05'::DATE AS document_date,
    PARSE_JSON('{"document_title": "Quality Assurance Certificate Q4 2023", "pages": 3, "language": "English", "format": "PDF", "file_size_mb": 0.8, "tags": ["quality", "certificate", "Q4-2023"], "category": "Quality"}') AS metadata,
    PARSE_JSON('{"defect_rate": 0.02, "purity_level": 99.8, "test_date": "2023-12-20", "test_standard": "ASTM D1234", "batch_numbers": ["BATCH-2023-Q4-001", "BATCH-2023-Q4-002"]}') AS extracted_data,
    PARSE_JSON('{"iso_certified": true, "iso_standard": "ISO 9001:2015", "environmental_compliance": "ISO 14001", "last_audit_date": "2023-11-10", "audit_score": 92, "certifications": ["ISO 9001", "ISO 14001"]}') AS compliance_info,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.supplier_documents
SELECT 'DOC-003' AS document_id, 'SUP003' AS supplier_id, 'Invoice' AS document_type, '2024-01-28'::DATE AS document_date,
    PARSE_JSON('{"document_title": "Invoice INV-2024-00128", "pages": 2, "language": "English", "format": "PDF", "file_size_mb": 0.5, "tags": ["invoice", "payment", "2024"], "category": "Financial"}') AS metadata,
    PARSE_JSON('{"invoice_number": "INV-2024-00128", "invoice_date": "2024-01-28", "due_date": "2024-02-27", "total_amount": 191500, "currency": "USD", "line_items": [{"part": "PART-11111", "quantity": 2000, "unit_price": 95.75}]}') AS extracted_data,
    PARSE_JSON('{"iso_certified": true, "iso_standard": "ISO 9001:2015", "environmental_compliance": null, "last_audit_date": "2023-10-05", "audit_score": 88, "certifications": ["ISO 9001"]}') AS compliance_info,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.product_configurations
SELECT 'PROD-001' AS product_id, 'V2.1' AS version, '2024-01-01'::DATE AS configuration_date,
    PARSE_JSON('{"model": "Premium", "engine_type": "V6 Turbo", "transmission": "8-Speed Automatic", "drivetrain": "AWD", "features": ["Adaptive Cruise Control", "Lane Keep Assist", "Blind Spot Monitoring", "360 Camera"], "options": {"interior": "Leather", "color": "Metallic Blue", "wheels": "20-inch Alloy"}}') AS config_data,
    PARSE_JSON('{"dimensions": {"length_mm": 4850, "width_mm": 1920, "height_mm": 1680, "wheelbase_mm": 2850}, "weight_kg": 1850, "materials": {"body": "Aluminum", "frame": "Steel", "interior": "Leather/Synthetic"}, "performance": {"max_speed_kmh": 250, "acceleration_0_100": 5.8, "fuel_tank_liters": 70}}') AS specifications,
    PARSE_JSON('{"components": [{"part_id": "PART-12345", "name": "Engine Block", "quantity": 1, "supplier": "SUP001"}, {"part_id": "PART-67890", "name": "Transmission Gear", "quantity": 1, "supplier": "SUP002"}, {"part_id": "PART-11111", "name": "Brake System", "quantity": 4, "supplier": "SUP003"}], "total_components": 1250, "assembly_complexity": "High"}') AS bill_of_materials,
    CURRENT_TIMESTAMP() AS created_at;

INSERT INTO MANUFACTURING_DEMO.DATA.product_configurations
SELECT 'PROD-002' AS product_id, 'V1.5' AS version, '2024-01-01'::DATE AS configuration_date,
    PARSE_JSON('{"model": "Electric", "battery_type": "Lithium-Ion", "battery_capacity_kwh": 85, "charging": {"type": "CCS", "max_power_kw": 150, "fast_charge_support": true}, "features": ["Regenerative Braking", "One-Pedal Driving", "Over-the-Air Updates", "Smart Charging"], "options": {"interior": "Vegan Leather", "color": "Pearl White", "wheels": "19-inch Aero"}}') AS config_data,
    PARSE_JSON('{"dimensions": {"length_mm": 4750, "width_mm": 1890, "height_mm": 1620, "wheelbase_mm": 2900}, "weight_kg": 2100, "materials": {"body": "Aluminum", "frame": "Aluminum", "interior": "Recycled Materials"}, "performance": {"max_speed_kmh": 200, "acceleration_0_100": 4.5, "range_km": 450, "charging_time_minutes": 30}}') AS specifications,
    PARSE_JSON('{"components": [{"part_id": "PART-22222", "name": "Battery Pack", "quantity": 1, "supplier": "SUP004"}, {"part_id": "PART-33333", "name": "ECU Module", "quantity": 2, "supplier": "SUP005"}], "total_components": 980, "assembly_complexity": "Medium"}') AS bill_of_materials,
    CURRENT_TIMESTAMP() AS created_at;

-- UNSTRUCTURED DATA - Free-form text documents
INSERT INTO MANUFACTURING_DEMO.DATA.maintenance_logs VALUES
('LOG-001', 'MACHINE-A', '2024-01-10', 'TECH-001', 'Preventive',
 'Performed scheduled preventive maintenance on Machine A. Inspected all moving parts, lubricated bearings, and checked hydraulic system. Machine was running smoothly with no immediate issues detected. Replaced air filter as part of routine maintenance.',
 'Minor wear detected on belt drive system. Belt tension slightly below optimal but still within acceptable range. Hydraulic fluid level was at minimum threshold.',
 'Replaced air filter (Part #AF-12345). Lubricated all bearing points with high-temperature grease. Adjusted belt tension to optimal setting. Topped off hydraulic fluid to recommended level.',
 'Monitor belt wear over next 30 days. Schedule belt replacement during next maintenance cycle if wear continues. Check hydraulic system for potential leaks.',
 'Air Filter AF-12345 (1 unit), High-Temp Grease (500ml), Hydraulic Fluid (2 liters)',
 CURRENT_TIMESTAMP()),
('LOG-002', 'MACHINE-B', '2024-01-12', 'TECH-002', 'Corrective',
 'Emergency maintenance call due to unexpected shutdown. Machine B stopped production at 14:30. Initial investigation revealed overheating in the main motor assembly. Temperature readings showed 95°C, exceeding normal operating range of 60-80°C.',
 'Root cause identified as blocked cooling vents. Accumulated dust and debris prevented proper airflow, causing motor to overheat. Thermal protection system activated correctly, preventing damage.',
 'Cleaned all cooling vents and air intake filters. Replaced clogged filter. Performed deep cleaning of motor housing. Verified cooling fan operation. Reset thermal protection system.',
 'Implement more frequent filter replacement schedule. Add weekly visual inspection of cooling vents. Consider upgrading to higher-capacity cooling system if issue recurs.',
 'Air Filter AF-67890 (2 units), Cooling Fan Motor CF-001 (1 unit - replaced as precaution), Cleaning Supplies',
 CURRENT_TIMESTAMP()),
('LOG-003', 'MACHINE-C', '2024-01-15', 'TECH-001', 'Predictive',
 'Predictive maintenance based on vibration analysis data. Vibration sensors indicated increasing trend in bearing vibration levels over past 2 weeks. Current readings approaching threshold levels.',
 'Bearing wear detected in main drive assembly. Vibration amplitude increased from 1.5g to 4.8g over monitoring period. No immediate failure risk, but replacement recommended before next production run.',
 'Replaced main drive bearing assembly (Part #BRG-45678). Performed alignment check on drive system. Recalibrated vibration sensors. Conducted test run to verify normal operation.',
 'Continue monitoring vibration levels post-replacement. Document baseline readings for future comparison. Review bearing supplier quality if premature wear continues.',
 'Main Drive Bearing BRG-45678 (1 unit), Bearing Grease (1kg), Alignment Tools',
 CURRENT_TIMESTAMP());

INSERT INTO MANUFACTURING_DEMO.DATA.quality_reports VALUES
('QR-001', 'BATCH-2024-001', 'PROD-001', '2024-01-15', 'INS-001',
 'Comprehensive quality inspection conducted on Batch 2024-001. Visual inspection revealed excellent surface finish and consistent dimensions across all units sampled. All critical dimensions measured within specification limits. Paint quality and color consistency met premium standards.',
 'No defects detected during inspection. All sampled units passed dimensional checks, surface quality assessment, and functional testing.',
 'Production process parameters were well-controlled during this batch. Operator training and adherence to procedures contributed to high quality output. No process deviations noted.',
 'Continue current production parameters. This batch serves as quality benchmark for future production runs.',
 'Dimensional measurements: Length 4850±2mm (all units passed), Width 1920±2mm (all units passed), Height 1680±2mm (all units passed). Surface roughness: Ra 0.8μm (within spec). Paint thickness: 80-85μm (within spec). Functional tests: All systems operational.',
 CURRENT_TIMESTAMP()),
('QR-002', 'BATCH-2024-002', 'PROD-002', '2024-01-15', 'INS-002',
 'Quality inspection of electric vehicle batch. Battery pack integration verified. Charging system functionality tested. All electrical systems checked for proper operation. Software version confirmed and OTA update capability verified.',
 'Minor cosmetic issue detected on 2 units: slight paint imperfection on door panel. Issue does not affect functionality but noted for process improvement.',
 'Paint application process may need adjustment for door panel area. Investigation shows potential issue with spray gun angle or pressure settings during application.',
 'Adjust paint application parameters for door panels. Re-inspect affected units after correction. Update standard operating procedures.',
 'Battery capacity test: 85.2 kWh average (spec: 85±1 kWh). Charging test: 0-80% in 28 minutes (spec: <30 min). Electrical system: All circuits tested, no faults. Software: Version 1.5.2 confirmed, OTA functional.',
 CURRENT_TIMESTAMP()),
('QR-003', 'BATCH-2024-003', 'PROD-001', '2024-01-16', 'INS-001',
 'Routine quality inspection revealed quality score of 0.97, slightly below target of 0.98. Investigation focused on assembly consistency and component fit.',
 'Minor alignment issues detected in 3 units: front bumper alignment slightly off-center. Gap measurements showed 2mm deviation from specification in some areas.',
 'Root cause analysis indicates fixture wear in assembly station. Fixture positioning pins showing signs of wear, causing slight misalignment during assembly process.',
 'Replace worn fixture components. Recalibrate assembly station. Implement daily fixture inspection routine. Re-work affected units to correct alignment.',
 'Dimensional checks: 97% within spec (target: 99%). Alignment checks: 94% perfect alignment (target: 98%). Component fit: All critical fits verified. Functional tests: All passed.',
 CURRENT_TIMESTAMP());

INSERT INTO MANUFACTURING_DEMO.DATA.supplier_communications VALUES
('COMM-001', 'SUP001', '2024-01-12', 'Email', 'Delivery Schedule Update - Q1 2024',
 'Dear Procurement Team, We wanted to inform you about a slight adjustment to our Q1 2024 delivery schedule. Due to increased demand from multiple customers, we are experiencing a 2-week delay on Engine Block orders (PART-12345). We anticipate this to be temporary and expect to return to normal lead times by mid-February. We have allocated your current order and will prioritize it, but delivery will shift from February 1st to February 15th. We apologize for any inconvenience and are working to minimize impact. Please let us know if this affects your production schedule and we can discuss alternatives.',
 'Supplier SUP001 notified of 2-week delivery delay for PART-12345. Delay due to increased demand. Delivery shifted from Feb 1 to Feb 15. Supplier offering to discuss alternatives.',
 '1. Assess impact on production schedule. 2. Review alternative suppliers for PART-12345. 3. Communicate delay to production planning team. 4. Schedule call with supplier to discuss mitigation.',
 'Attached: Updated delivery schedule PDF, Alternative delivery options document',
 CURRENT_TIMESTAMP()),
('COMM-002', 'SUP002', '2024-01-08', 'Meeting Notes', 'Quality Improvement Initiative Discussion',
 'Meeting with Precision Parts Ltd quality team to discuss recent quality improvements. They have implemented new quality control measures including automated inspection systems and enhanced testing protocols. Discussion covered their ISO 9001:2015 recertification process and upcoming audit schedule. They shared their quality metrics showing 0.02% defect rate, which is excellent. We discussed potential collaboration on joint quality initiatives and supplier development programs. Action items identified for both parties.',
 'Meeting with SUP002 quality team. Discussed quality improvements, ISO recertification, and collaboration opportunities. Their defect rate is 0.02%.',
 '1. Review SUP002 quality metrics and compare to other suppliers. 2. Evaluate joint quality initiative proposals. 3. Schedule follow-up meeting to discuss supplier development program. 4. Update supplier scorecard with latest quality data.',
 'Attached: Quality metrics report, ISO certificate copy, Joint initiative proposal',
 CURRENT_TIMESTAMP()),
('COMM-003', 'SUP003', '2024-01-20', 'Contract', 'New Pricing Agreement 2024',
 'We are pleased to present our new pricing structure for 2024. Based on our long-term partnership and volume commitments, we are offering a 5% reduction on Brake System components (PART-11111) for orders exceeding 10,000 units annually. This pricing is effective immediately and applies to all orders placed from January 2024 onwards. We have also improved our payment terms to Net 45 for qualified customers. Please review the attached contract amendment and let us know if you have any questions.',
 'SUP003 offering 5% price reduction on PART-11111 for annual volumes >10,000 units. Improved payment terms to Net 45. Effective immediately.',
 '1. Review contract amendment terms. 2. Calculate annual volume to confirm eligibility. 3. Compare new pricing with current costs. 4. Legal review of contract terms. 5. Respond to supplier with decision.',
 'Attached: Contract amendment document, New pricing schedule, Payment terms document',
 CURRENT_TIMESTAMP());

INSERT INTO MANUFACTURING_DEMO.DATA.engineering_docs VALUES
('ENG-001', 'PROD-001', 'Design Specification', '2023-12-01', 'ENG-001', 'V2.1',
 'This document specifies the design requirements for PROD-001 Version 2.1, Premium Model. The vehicle is designed to meet premium segment expectations with focus on performance, comfort, and advanced technology features. Key design objectives include: achieving 0-100 km/h acceleration in under 6 seconds, maintaining fuel efficiency above 8.5 L/100km, and providing premium interior experience with advanced driver assistance systems. The design incorporates a V6 turbocharged engine, 8-speed automatic transmission, and all-wheel drive system. Safety features include adaptive cruise control, lane keep assist, blind spot monitoring, and 360-degree camera system. The vehicle architecture supports over-the-air software updates for future feature enhancements.',
 'Design considerations include weight optimization through aluminum body construction while maintaining structural integrity. Aerodynamic efficiency was prioritized in exterior design, achieving drag coefficient of 0.28. Interior design focuses on premium materials and ergonomic layout. Climate control system designed for optimal comfort in various weather conditions. Sound insulation and vibration damping materials selected to provide quiet cabin experience.',
 'Testing procedures include: 1) Performance testing on test track for acceleration, braking, and handling. 2) Fuel economy testing per WLTP standards. 3) Safety testing including crash tests per Euro NCAP standards. 4) Durability testing including 200,000 km endurance test. 5) Climate testing in extreme temperatures (-40°C to +50°C). 6) Quality and reliability testing including component life testing.',
 'Version 2.1 changes: Updated infotainment system to latest generation. Enhanced driver assistance algorithms. Improved fuel efficiency through engine calibration updates. Added wireless charging pad. Updated interior trim options.',
 CURRENT_TIMESTAMP()),
('ENG-002', 'PROD-002', 'Test Plan', '2023-11-15', 'ENG-002', 'V1.0',
 'Comprehensive test plan for PROD-002 Electric Vehicle. Testing covers battery system, charging infrastructure compatibility, electric motor performance, regenerative braking system, and software functionality. Battery testing includes capacity verification, charging speed testing, thermal management validation, and cycle life testing. Motor testing covers power output, efficiency mapping, and thermal performance. Charging compatibility testing includes CCS standard compliance, fast charging capability, and home charging scenarios. Software testing covers over-the-air update functionality, infotainment system, and driver assistance features.',
 'Design considerations for electric vehicle include battery placement for optimal weight distribution and crash safety. Thermal management system designed to maintain battery temperature within optimal range. Regenerative braking system calibrated for maximum energy recovery while maintaining smooth driving experience.',
 'Test procedures: 1) Battery capacity test: Verify 85 kWh capacity with <1% variance. 2) Charging test: Achieve 0-80% charge in <30 minutes using 150kW charger. 3) Range test: Verify 450 km range under WLTP conditions. 4) Performance test: 0-100 km/h in <5 seconds. 5) Regenerative braking: Verify energy recovery efficiency >85%. 6) Software OTA: Test update delivery and installation. 7) Thermal management: Verify operation in -20°C to +45°C range.',
 'Test plan version 1.0 - Initial release. Future updates will include additional test scenarios based on field data and customer feedback.',
 CURRENT_TIMESTAMP()),
('ENG-003', 'PROD-001', 'Change Request', '2024-01-05', 'ENG-003', 'CR-2024-001',
 'Change request to update PROD-001 infotainment system software to address customer feedback regarding user interface responsiveness. Current software version 2.0 has received feedback about slower response times when switching between applications. Proposed change includes software update to version 2.1 with optimized code and improved memory management. Change also includes addition of wireless Apple CarPlay and Android Auto support, which was frequently requested feature. Implementation requires no hardware changes, only software update. Testing plan includes regression testing of all infotainment features and validation of new wireless connectivity features.',
 'Design considerations: Software optimization must not impact other vehicle systems. Memory management improvements should reduce system load. Wireless connectivity requires Bluetooth and WiFi hardware which is already present in current design.',
 'Testing procedures: 1) User interface responsiveness testing with timing measurements. 2) Wireless CarPlay/Android Auto connectivity testing. 3) Regression testing of all existing infotainment features. 4) Memory usage monitoring during extended operation. 5) Compatibility testing with various mobile devices.',
 'Change approved for implementation in production starting January 2024. Software update will be delivered via over-the-air update for existing vehicles and included in new production.',
 CURRENT_TIMESTAMP());

INSERT INTO MANUFACTURING_DEMO.DATA.incident_reports VALUES
('INC-001', '2024-01-08', 'Production Line 2', 'Medium', 'Resolved',
 'Incident occurred during shift change at Production Line 2. A quality inspector noticed that several units from Batch 2024-002 had misaligned front bumpers. Investigation revealed that the assembly fixture had shifted slightly, causing misalignment in 12 units produced during the 2-hour period before detection. The issue was identified during routine quality inspection, and production was immediately halted to prevent further affected units.',
 'Witness statements from operators indicate that the fixture positioning appeared normal during operation. Quality inspector noticed the misalignment during visual inspection. Production supervisor confirmed that fixture calibration was last performed 3 weeks ago, which is within normal schedule.',
 'Investigation found that fixture positioning pins had worn down slightly, causing gradual misalignment over time. The wear was not immediately visible during routine visual checks. Root cause analysis determined that fixture maintenance schedule needs to be more frequent, and visual inspection alone is insufficient for detecting gradual wear.',
 'Immediate actions: Replaced worn fixture pins, recalibrated assembly station, reworked all 12 affected units. Preventive measures: Implemented weekly fixture inspection routine with measurement verification, added fixture wear monitoring to preventive maintenance schedule, updated training for operators on fixture condition recognition.',
 CURRENT_TIMESTAMP()),
('INC-002', '2024-01-12', 'Warehouse 1', 'Low', 'Resolved',
 'Minor safety incident in Warehouse 1 during inventory count. A forklift operator accidentally bumped into a storage rack while maneuvering in narrow aisle. No injuries occurred, but minor damage to rack and some stored parts were dislodged. Incident occurred during busy period with multiple forklifts operating simultaneously.',
 'Forklift operator stated that another forklift was blocking the aisle, requiring tight maneuver. Warehouse supervisor confirmed that aisle was narrower than recommended due to temporary storage of additional pallets. No other witnesses directly observed the incident.',
 'Investigation found that aisle width was reduced below safety standards due to temporary storage overflow. Forklift operator followed proper procedures but space constraints made maneuver difficult. Root cause: Inadequate space planning during high-volume period.',
 'Immediate actions: Relocated temporary storage to restore proper aisle width, inspected and repaired damaged rack, verified all dislodged parts for damage. Preventive measures: Implemented maximum aisle occupancy policy, added visual markers for minimum aisle width, scheduled regular space utilization reviews.',
 CURRENT_TIMESTAMP()),
('INC-003', '2024-01-14', 'Quality Lab', 'Low', 'Under Investigation',
 'Quality testing equipment malfunction during routine batch testing. Automated testing station for electrical systems failed to complete test sequence for Batch 2024-004. Error message indicated communication failure between test controller and measurement instruments. Manual testing was performed as backup to complete quality verification, causing 4-hour delay in batch release.',
 'Quality technician reported that equipment had been functioning normally earlier in the day. Error occurred suddenly during test sequence. Equipment manufacturer support was contacted and remote diagnostics performed.',
 'Preliminary investigation suggests possible firmware issue or communication cable problem. Equipment manufacturer is conducting further diagnostics. Manual testing confirmed that all units passed quality requirements, so no quality impact.',
 'Immediate actions: Switched to manual testing backup procedure, contacted equipment manufacturer support, documented incident for tracking. Preventive measures: Schedule equipment firmware update review, add communication cable inspection to maintenance checklist, evaluate backup testing capacity.',
 CURRENT_TIMESTAMP());

COMMIT;

-- Step 6: Grant SELECT on tables
GRANT SELECT ON ALL TABLES IN SCHEMA MANUFACTURING_DEMO.DATA TO ROLE PUBLIC;
GRANT SELECT ON FUTURE TABLES IN SCHEMA MANUFACTURING_DEMO.DATA TO ROLE PUBLIC;

SELECT 'Setup completed successfully! You can now proceed to create semantic views and agents.' AS STATUS;

