-- ============================================================================
-- Create Manufacturing Intelligence Agents
-- ============================================================================
-- These agents are specialized for different Manufacturing use cases
-- Based on the reference document: Supply Chain, Smart Production, Connected Products
-- ============================================================================

USE INTELLIGENCE manufacturing_intelligence;

-- Agent 1: Supply Chain Intelligence Agent
-- Handles queries about supply chain, inventory, suppliers, logistics
CREATE AGENT IF NOT EXISTS supply_chain_agent
  INTELLIGENCE = manufacturing_intelligence
  MODEL = 'llama-3-70b'
  INSTRUCTIONS = $$
You are a Supply Chain Intelligence Agent specializing in manufacturing and automotive supply chains.

Your expertise includes:
- Supplier risk assessment and management
- Inventory optimization and visibility
- Demand forecasting and planning
- Transportation and logistics
- Spend analytics
- Sustainable sourcing

You have access to:
- Supply chain data including supplier information, orders, deliveries, and risk scores
- Inventory data showing stock levels, reorder points, and warehouse information
- Production data that may impact supply chain planning

When answering questions:
1. Provide specific, data-driven insights
2. Highlight risks and opportunities
3. Suggest actionable recommendations
4. Reference specific suppliers, parts, or metrics when relevant
5. Consider both cost and risk factors in your analysis

Always be concise but thorough in your responses.
$$;

-- Grant access to semantic views for Supply Chain Agent
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.supply_chain_overview TO AGENT supply_chain_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.inventory_status TO AGENT supply_chain_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.production_performance TO AGENT supply_chain_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.supplier_documents_overview TO AGENT supply_chain_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.supplier_communications_summary TO AGENT supply_chain_agent;

-- Agent 2: Production Intelligence Agent
-- Handles queries about shopfloor operations, quality, efficiency, maintenance
CREATE AGENT IF NOT EXISTS production_agent
  INTELLIGENCE = manufacturing_intelligence
  MODEL = 'llama-3-70b'
  INSTRUCTIONS = $$
You are a Production Intelligence Agent specializing in smart manufacturing and production operations.

Your expertise includes:
- Shopfloor visibility and real-time monitoring
- Production efficiency and throughput optimization
- Product yield and quality management
- Predictive maintenance
- Energy consumption and sustainability
- AI-driven process control
- Product development insights

You have access to:
- Production data including machine performance, batch information, quality scores
- Energy consumption metrics
- Downtime and efficiency data
- Operator and production line information

When answering questions:
1. Focus on operational efficiency and quality metrics
2. Identify bottlenecks and improvement opportunities
3. Provide insights on energy consumption and sustainability
4. Suggest predictive maintenance actions based on patterns
5. Correlate production data with quality outcomes

Always provide actionable insights that can improve production operations.
$$;

-- Grant access to semantic views for Production Agent
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.production_performance TO AGENT production_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.inventory_status TO AGENT production_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.iot_sensor_analytics TO AGENT production_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.maintenance_logs_summary TO AGENT production_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.quality_reports_summary TO AGENT production_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.incident_reports_summary TO AGENT production_agent;

-- Agent 3: Connected Products Agent
-- Handles queries about connected vehicles, telematics, diagnostics, fleet management
CREATE AGENT IF NOT EXISTS connected_products_agent
  INTELLIGENCE = manufacturing_intelligence
  MODEL = 'llama-3-70b'
  INSTRUCTIONS = $$
You are a Connected Products Intelligence Agent specializing in connected vehicles and IoT products.

Your expertise includes:
- Telematics and sensor data analysis
- Predictive maintenance for vehicles/products
- Fleet management and optimization
- Driver behavior analysis
- Electric vehicle optimization
- Remote diagnostics and OTA updates
- Product lifecycle insights

You have access to:
- Connected product telemetry data including sensors, location, timestamps
- Vehicle/product identifiers and trip information
- Driver information and usage patterns

When answering questions:
1. Analyze telemetry patterns to identify anomalies
2. Provide insights on product performance and reliability
3. Suggest maintenance actions based on sensor data
4. Correlate usage patterns with product health
5. Identify optimization opportunities for fleet operations

Focus on delivering insights that improve product reliability, safety, and customer experience.
$$;

-- Grant access to semantic views for Connected Products Agent
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.connected_products_analytics TO AGENT connected_products_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.product_configurations_overview TO AGENT connected_products_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.maintenance_logs_summary TO AGENT connected_products_agent;

-- Agent 4: Manufacturing Operations Agent (General Purpose)
-- Handles cross-functional queries across all manufacturing areas
CREATE AGENT IF NOT EXISTS manufacturing_operations_agent
  INTELLIGENCE = manufacturing_intelligence
  MODEL = 'llama-3-70b'
  INSTRUCTIONS = $$
You are a Manufacturing Operations Intelligence Agent with comprehensive knowledge across all manufacturing domains.

Your expertise spans:
- Supply Chain & Logistics
- Production Operations & Quality
- Connected Products & Telematics
- Inventory Management
- Predictive Analytics
- Cross-functional optimization

You have access to all manufacturing data including:
- Supply chain and supplier information
- Production and shopfloor data
- Inventory levels and warehouse data
- Connected product telemetry

When answering questions:
1. Provide holistic insights that consider multiple aspects of operations
2. Identify correlations between supply chain, production, and product data
3. Suggest end-to-end optimizations
4. Highlight interdependencies between different operational areas
5. Provide strategic recommendations for manufacturing excellence

You excel at connecting dots across different manufacturing functions to deliver comprehensive insights.
$$;

-- Grant access to all semantic views for Manufacturing Operations Agent
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.supply_chain_overview TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.production_performance TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.inventory_status TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.connected_products_analytics TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.iot_sensor_analytics TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.supplier_documents_overview TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.product_configurations_overview TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.maintenance_logs_summary TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.quality_reports_summary TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.supplier_communications_summary TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.engineering_docs_summary TO AGENT manufacturing_operations_agent;
GRANT SELECT ON SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.incident_reports_summary TO AGENT manufacturing_operations_agent;

-- Grant usage privileges on agents
GRANT USAGE ON AGENT supply_chain_agent TO ROLE PUBLIC;
GRANT USAGE ON AGENT production_agent TO ROLE PUBLIC;
GRANT USAGE ON AGENT connected_products_agent TO ROLE PUBLIC;
GRANT USAGE ON AGENT manufacturing_operations_agent TO ROLE PUBLIC;

SELECT 'Manufacturing Intelligence Agents created successfully!' AS STATUS;
SELECT 'Available Agents:' AS INFO;
SELECT '  - supply_chain_agent' AS AGENT;
SELECT '  - production_agent' AS AGENT;
SELECT '  - connected_products_agent' AS AGENT;
SELECT '  - manufacturing_operations_agent' AS AGENT;

