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
CREATE OR REPLACE SEMANTIC VIEW supply_chain_overview
TABLES (
  sc AS MANUFACTURING_DEMO.DATA.supply_chain PRIMARY KEY (supplier_id, part_number, order_date)
)
DIMENSIONS (
  sc.supplier_id AS sc.supplier_id,
  sc.supplier_name AS sc.supplier_name,
  sc.part_number AS sc.part_number,
  sc.part_description AS sc.part_description,
  sc.order_date AS sc.order_date,
  sc.delivery_date AS sc.delivery_date,
  sc.status AS sc.status,
  sc.region AS sc.region,
  sc.risk_category AS CASE 
    WHEN sc.risk_score < 0.2 THEN 'Low Risk'
    WHEN sc.risk_score < 0.4 THEN 'Medium Risk'
    ELSE 'High Risk'
  END,
  sc.delivery_status AS CASE 
    WHEN sc.status = 'Delivered' AND sc.delivery_date <= CURRENT_DATE() THEN 'On Time'
    WHEN sc.status = 'Delivered' AND sc.delivery_date > CURRENT_DATE() THEN 'Early'
    WHEN sc.status = 'In Transit' THEN 'In Progress'
    ELSE 'Pending'
  END
)
METRICS (
  sc.avg_delivery_days AS AVG(DATEDIFF(day, sc.order_date, sc.delivery_date)),
  sc.total_quantity AS SUM(sc.quantity),
  sc.avg_unit_cost AS AVG(sc.unit_cost),
  sc.total_cost AS SUM(sc.quantity * sc.unit_cost),
  sc.avg_risk_score AS AVG(sc.risk_score),
  sc.order_count AS COUNT(*)
);

-- Semantic View: Production Performance
-- Provides insights into production efficiency and quality
CREATE OR REPLACE SEMANTIC VIEW production_performance
TABLES (
  prod AS MANUFACTURING_DEMO.DATA.production PRIMARY KEY (production_line_id, machine_id, batch_number, start_time)
)
DIMENSIONS (
  prod.production_line_id AS prod.production_line_id,
  prod.machine_id AS prod.machine_id,
  prod.product_id AS prod.product_id,
  prod.batch_number AS prod.batch_number,
  prod.start_time AS prod.start_time,
  prod.end_time AS prod.end_time,
  prod.operator_id AS prod.operator_id,
  prod.quality_rating AS CASE 
    WHEN prod.quality_score >= 0.95 THEN 'Excellent'
    WHEN prod.quality_score >= 0.90 THEN 'Good'
    WHEN prod.quality_score >= 0.85 THEN 'Acceptable'
    ELSE 'Needs Improvement'
  END
)
METRICS (
  prod.avg_production_duration_minutes AS AVG(DATEDIFF(minute, prod.start_time, prod.end_time)),
  prod.total_quantity_produced AS SUM(prod.quantity_produced),
  prod.avg_quality_score AS AVG(prod.quality_score),
  prod.total_energy_consumption AS SUM(prod.energy_consumption),
  prod.total_downtime_minutes AS SUM(prod.downtime_minutes),
  prod.avg_units_per_hour AS AVG(ROUND(prod.quantity_produced / NULLIF(DATEDIFF(minute, prod.start_time, prod.end_time), 0) * 60, 2)),
  prod.avg_energy_per_unit AS AVG(ROUND(prod.energy_consumption / NULLIF(prod.quantity_produced, 0), 4)),
  prod.avg_downtime_percentage AS AVG(ROUND(prod.downtime_minutes / NULLIF(DATEDIFF(minute, prod.start_time, prod.end_time), 0) * 100, 2)),
  prod.batch_count AS COUNT(*)
);

-- Semantic View: Inventory Status
-- Provides real-time inventory visibility
CREATE OR REPLACE SEMANTIC VIEW inventory_status
TABLES (
  inv AS MANUFACTURING_DEMO.DATA.inventory PRIMARY KEY (warehouse_id, part_number)
)
DIMENSIONS (
  inv.warehouse_id AS inv.warehouse_id,
  inv.part_number AS inv.part_number,
  inv.stock_status AS CASE 
    WHEN inv.current_stock <= inv.reorder_level THEN 'Reorder Needed'
    WHEN inv.current_stock <= inv.reorder_level * 1.5 THEN 'Low Stock'
    ELSE 'Adequate Stock'
  END,
  inv.last_updated AS inv.last_updated
)
METRICS (
  inv.total_current_stock AS SUM(inv.current_stock),
  inv.avg_reorder_level AS AVG(inv.reorder_level),
  inv.total_reorder_quantity AS SUM(inv.reorder_quantity),
  inv.total_stock_above_reorder AS SUM(inv.current_stock - inv.reorder_level),
  inv.inventory_item_count AS COUNT(*)
);

-- Semantic View: Connected Products Analytics (Semi-structured)
-- Provides insights from connected vehicle/product data with JSON extraction
CREATE OR REPLACE SEMANTIC VIEW connected_products_analytics
TABLES (
  cp AS MANUFACTURING_DEMO.DATA.connected_products PRIMARY KEY (vehicle_id, telemetry_timestamp)
)
DIMENSIONS (
  cp.vehicle_id AS cp.vehicle_id,
  cp.product_id AS cp.product_id,
  cp.telemetry_timestamp AS cp.telemetry_timestamp,
  cp.primary_sensor_type AS cp.telemetry_data:sensors[0]:type::STRING,
  cp.engine_status AS cp.telemetry_data:diagnostics:engine_status::STRING,
  cp.location_address AS cp.location_data:address::STRING,
  cp.geofence_region AS cp.location_data:geofence::STRING,
  cp.driver_name AS cp.driver_info:name::STRING,
  cp.fatigue_risk AS cp.driver_info:fatigue_risk::STRING,
  cp.route AS cp.trip_metadata:route::STRING,
  cp.alert_status AS CASE 
    WHEN cp.telemetry_data:sensors[0]:type::STRING = 'temperature' AND cp.telemetry_data:sensors[0]:value::NUMBER > 90 THEN 'High Temperature Alert'
    WHEN cp.telemetry_data:sensors[0]:type::STRING = 'battery_level' AND cp.telemetry_data:sensors[0]:value::NUMBER < 20 THEN 'Low Battery Alert'
    WHEN ARRAY_SIZE(cp.telemetry_data:diagnostics:error_codes) > 0 THEN 'Error Codes Present'
    ELSE 'Normal'
  END,
  cp.created_at AS cp.created_at
)
METRICS (
  cp.avg_primary_sensor_value AS AVG(cp.telemetry_data:sensors[0]:value::NUMBER),
  cp.avg_battery_health AS AVG(cp.telemetry_data:diagnostics:battery_health::NUMBER),
  cp.avg_location_lat AS AVG(cp.location_data:latitude::NUMBER),
  cp.avg_location_lon AS AVG(cp.location_data:longitude::NUMBER),
  cp.avg_current_speed AS AVG(cp.location_data:speed::NUMBER),
  cp.avg_driver_behavior_score AS AVG(cp.driver_info:behavior_score::NUMBER),
  cp.total_trip_distance_miles AS SUM(cp.trip_metadata:distance_miles::NUMBER),
  cp.avg_fuel_efficiency AS AVG(cp.trip_metadata:fuel_efficiency::NUMBER),
  cp.telemetry_record_count AS COUNT(*)
);

-- Semantic View: IoT Sensor Analytics (Semi-structured)
-- Provides insights from IoT sensor data with JSON extraction
CREATE OR REPLACE SEMANTIC VIEW iot_sensor_analytics
TABLES (
  iot AS MANUFACTURING_DEMO.DATA.iot_sensors PRIMARY KEY (sensor_id, timestamp)
)
DIMENSIONS (
  iot.sensor_id AS iot.sensor_id,
  iot.machine_id AS iot.machine_id,
  iot.production_line_id AS iot.production_line_id,
  iot.timestamp AS iot.timestamp,
  iot.primary_sensor_name AS iot.sensor_readings[0]:sensor_name::STRING,
  iot.primary_sensor_status AS iot.sensor_readings[0]:status::STRING,
  iot.machine_state AS iot.machine_state:state::STRING,
  iot.operating_mode AS iot.machine_state:operating_mode::STRING,
  iot.calibration_technician AS iot.calibration_data:calibration_technician::STRING,
  iot.overall_status AS CASE 
    WHEN ARRAY_SIZE(iot.machine_state:alerts) > 0 THEN 'Alert'
    WHEN ARRAY_SIZE(iot.machine_state:warnings) > 0 THEN 'Warning'
    ELSE 'Normal'
  END,
  iot.created_at AS iot.created_at
)
METRICS (
  iot.avg_primary_sensor_value AS AVG(iot.sensor_readings[0]:value::NUMBER),
  iot.avg_uptime_hours AS AVG(iot.machine_state:uptime_hours::NUMBER),
  iot.total_alert_count AS SUM(ARRAY_SIZE(iot.machine_state:alerts)),
  iot.total_warning_count AS SUM(ARRAY_SIZE(iot.machine_state:warnings)),
  iot.sensor_reading_count AS COUNT(*)
);

-- Semantic View: Supplier Documents Overview (Semi-structured)
-- Provides insights from supplier document metadata
CREATE OR REPLACE SEMANTIC VIEW supplier_documents_overview
TABLES (
  sd AS MANUFACTURING_DEMO.DATA.supplier_documents PRIMARY KEY (document_id)
)
DIMENSIONS (
  sd.document_id AS sd.document_id,
  sd.supplier_id AS sd.supplier_id,
  sd.document_type AS sd.document_type,
  sd.document_date AS sd.document_date,
  sd.document_title AS sd.metadata:document_title::STRING,
  sd.category AS sd.metadata:category::STRING,
  sd.currency AS sd.extracted_data:currency::STRING,
  sd.payment_terms AS sd.extracted_data:payment_terms::STRING,
  sd.iso_standard AS sd.compliance_info:iso_standard::STRING,
  sd.created_at AS sd.created_at
)
METRICS (
  sd.total_document_value AS SUM(sd.extracted_data:total_value::NUMBER),
  sd.avg_audit_score AS AVG(sd.compliance_info:audit_score::NUMBER),
  sd.document_count AS COUNT(*)
);

-- Semantic View: Product Configurations Overview (Semi-structured)
-- Provides insights from product configuration data
CREATE OR REPLACE SEMANTIC VIEW product_configurations_overview
TABLES (
  pc AS MANUFACTURING_DEMO.DATA.product_configurations PRIMARY KEY (product_id, version)
)
DIMENSIONS (
  pc.product_id AS pc.product_id,
  pc.version AS pc.version,
  pc.configuration_date AS pc.configuration_date,
  pc.model_type AS pc.config_data:model::STRING,
  pc.engine_type AS pc.config_data:engine_type::STRING,
  pc.transmission AS pc.config_data:transmission::STRING,
  pc.assembly_complexity AS pc.bill_of_materials:assembly_complexity::STRING,
  pc.created_at AS pc.created_at
)
METRICS (
  pc.avg_length_mm AS AVG(pc.specifications:dimensions:length_mm::NUMBER),
  pc.avg_width_mm AS AVG(pc.specifications:dimensions:width_mm::NUMBER),
  pc.avg_weight_kg AS AVG(pc.specifications:weight_kg::NUMBER),
  pc.avg_max_speed_kmh AS AVG(pc.specifications:performance:max_speed_kmh::NUMBER),
  pc.avg_total_components AS AVG(pc.bill_of_materials:total_components::NUMBER),
  pc.configuration_count AS COUNT(*)
);

-- Semantic View: Maintenance Logs Summary (Unstructured)
-- Provides searchable view of maintenance logs with key information extracted
CREATE OR REPLACE SEMANTIC VIEW maintenance_logs_summary
TABLES (
  ml AS MANUFACTURING_DEMO.DATA.maintenance_logs PRIMARY KEY (log_id)
)
DIMENSIONS (
  ml.log_id AS ml.log_id,
  ml.machine_id AS ml.machine_id,
  ml.maintenance_date AS ml.maintenance_date,
  ml.technician_id AS ml.technician_id,
  ml.maintenance_type AS ml.maintenance_type,
  ml.maintenance_category AS CASE 
    WHEN UPPER(ml.log_entry) LIKE '%REPLACE%' OR UPPER(ml.actions_taken) LIKE '%REPLACE%' THEN 'Parts Replaced'
    WHEN UPPER(ml.log_entry) LIKE '%CLEAN%' OR UPPER(ml.actions_taken) LIKE '%CLEAN%' THEN 'Cleaning Performed'
    WHEN UPPER(ml.log_entry) LIKE '%CALIBRAT%' OR UPPER(ml.actions_taken) LIKE '%CALIBRAT%' THEN 'Calibration Performed'
    ELSE 'Other'
  END,
  ml.created_at AS ml.created_at
)
METRICS (
  ml.maintenance_log_count AS COUNT(*)
);

-- Semantic View: Quality Reports Summary (Unstructured)
-- Provides searchable view of quality reports
CREATE OR REPLACE SEMANTIC VIEW quality_reports_summary
TABLES (
  qr AS MANUFACTURING_DEMO.DATA.quality_reports PRIMARY KEY (report_id)
)
DIMENSIONS (
  qr.report_id AS qr.report_id,
  qr.batch_number AS qr.batch_number,
  qr.product_id AS qr.product_id,
  qr.report_date AS qr.report_date,
  qr.inspector_id AS qr.inspector_id,
  qr.quality_status AS CASE 
    WHEN UPPER(qr.inspection_notes) LIKE '%NO DEFECT%' OR UPPER(qr.defect_description) = '' THEN 'No Defects'
    WHEN UPPER(qr.defect_description) LIKE '%MINOR%' THEN 'Minor Defects'
    WHEN UPPER(qr.defect_description) LIKE '%MAJOR%' OR UPPER(qr.defect_description) LIKE '%CRITICAL%' THEN 'Major Defects'
    ELSE 'Defects Found'
  END,
  qr.created_at AS qr.created_at
)
METRICS (
  qr.quality_report_count AS COUNT(*)
);

-- Semantic View: Supplier Communications Summary (Unstructured)
-- Provides searchable view of supplier communications
CREATE OR REPLACE SEMANTIC VIEW supplier_communications_summary
TABLES (
  scm AS MANUFACTURING_DEMO.DATA.supplier_communications PRIMARY KEY (communication_id)
)
DIMENSIONS (
  scm.communication_id AS scm.communication_id,
  scm.supplier_id AS scm.supplier_id,
  scm.communication_date AS scm.communication_date,
  scm.communication_type AS scm.communication_type,
  scm.subject AS scm.subject,
  scm.communication_category AS CASE 
    WHEN UPPER(scm.subject) LIKE '%DELAY%' OR UPPER(scm.content) LIKE '%DELAY%' THEN 'Delivery Delay'
    WHEN UPPER(scm.subject) LIKE '%QUALITY%' OR UPPER(scm.content) LIKE '%QUALITY%' THEN 'Quality Related'
    WHEN UPPER(scm.subject) LIKE '%PRICING%' OR UPPER(scm.content) LIKE '%PRICING%' OR UPPER(scm.subject) LIKE '%CONTRACT%' THEN 'Pricing/Contract'
    WHEN UPPER(scm.communication_type) = 'MEETING NOTES' THEN 'Meeting Notes'
    ELSE 'General'
  END,
  scm.created_at AS scm.created_at
)
METRICS (
  scm.communication_count AS COUNT(*)
);

-- Semantic View: Engineering Documentation Summary (Unstructured)
-- Provides searchable view of engineering documents
CREATE OR REPLACE SEMANTIC VIEW engineering_docs_summary
TABLES (
  ed AS MANUFACTURING_DEMO.DATA.engineering_docs PRIMARY KEY (doc_id)
)
DIMENSIONS (
  ed.doc_id AS ed.doc_id,
  ed.product_id AS ed.product_id,
  ed.doc_type AS ed.doc_type,
  ed.doc_date AS ed.doc_date,
  ed.author AS ed.author,
  ed.version AS ed.version,
  ed.created_at AS ed.created_at
)
METRICS (
  ed.document_count AS COUNT(*)
);

-- Semantic View: Incident Reports Summary (Unstructured)
-- Provides searchable view of incident reports
CREATE OR REPLACE SEMANTIC VIEW incident_reports_summary
TABLES (
  ir AS MANUFACTURING_DEMO.DATA.incident_reports PRIMARY KEY (incident_id)
)
DIMENSIONS (
  ir.incident_id AS ir.incident_id,
  ir.incident_date AS ir.incident_date,
  ir.location AS ir.location,
  ir.severity AS ir.severity,
  ir.status AS ir.status,
  ir.created_at AS ir.created_at
)
METRICS (
  ir.incident_count AS COUNT(*)
);

-- Grant SELECT on semantic views
GRANT SELECT ON ALL SEMANTIC VIEWS IN SCHEMA MANUFACTURING_DEMO.SEMANTIC TO ROLE PUBLIC;
GRANT SELECT ON FUTURE SEMANTIC VIEWS IN SCHEMA MANUFACTURING_DEMO.SEMANTIC TO ROLE PUBLIC;

SELECT 'Semantic views created successfully!' AS STATUS;
