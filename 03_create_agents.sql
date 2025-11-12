-- ============================================================================
-- Create Manufacturing Intelligence Agents
-- ============================================================================
-- These agents are specialized for different Manufacturing use cases
-- Using the unified semantic view and Cortex Search service
-- All agents are created in SNOWFLAKE_INTELLIGENCE.AGENTS schema
-- ============================================================================

-- Agent 1: Supply Chain Intelligence Agent
-- Handles queries about supply chain, inventory, suppliers, logistics
CREATE OR REPLACE AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent
  COMMENT = 'Supply Chain Intelligence Agent specializing in manufacturing and automotive supply chains'
  PROFILE = '{"display_name": "Supply Chain Agent", "avatar": "supply-chain-icon.png", "color": "blue"}'
  FROM SPECIFICATION
  $$
  models:
    orchestration: claude-4-sonnet

  orchestration:
    budget:
      seconds: 60
      tokens: 32000

  instructions:
    response: |
      You are a Supply Chain Intelligence Agent specializing in manufacturing and automotive supply chains.
      
      Your expertise includes:
      - Supplier risk assessment and management
      - Inventory optimization and visibility
      - Demand forecasting and planning
      - Transportation and logistics
      - Spend analytics
      - Sustainable sourcing
      
      When answering questions:
      1. Provide specific, data-driven insights
      2. Highlight risks and opportunities
      3. Suggest actionable recommendations
      4. Reference specific suppliers, parts, or metrics when relevant
      5. Consider both cost and risk factors in your analysis
      
      Always be concise but thorough in your responses.

    orchestration: |
      Use Analyst1 for supply chain data queries and analysis.
      Use Search1 for searching supplier documents and communications.

    system: |
      You are a Supply Chain Intelligence Agent with access to:
      - Supply chain data including supplier information, orders, deliveries, and risk scores
      - Inventory data showing stock levels, reorder points, and warehouse information
      - Production data that may impact supply chain planning
      - Supplier documents and communications

    sample_questions:
      - question: "What suppliers have high risk scores?"
        answer: "I'll analyze the supplier risk data from our supply chain database."
      - question: "Show me inventory levels for critical parts"
        answer: "I'll query the inventory data to show current stock levels and reorder status."
      - question: "Which suppliers have delivery delays?"
        answer: "I'll check the supply chain data for suppliers with delayed deliveries."

  tools:
    - tool_spec:
        type: "cortex_analyst_text_to_sql"
        name: "Analyst1"
        description: "Converts natural language to SQL queries for supply chain, inventory, and production data analysis"
    - tool_spec:
        type: "cortex_search"
        name: "Search1"
        description: "Searches supplier documents and communications for relevant information"

  tool_resources:
    Analyst1:
      semantic_view: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_operations"
    Search1:
      name: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search"
      max_results: "10"
      title_column: "document_text"
      id_column: "document_id"
  $$;

-- Agent 2: Production Intelligence Agent
-- Handles queries about shopfloor operations, quality, efficiency, maintenance
CREATE OR REPLACE AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent
  COMMENT = 'Production Intelligence Agent specializing in smart manufacturing and production operations'
  PROFILE = '{"display_name": "Production Agent", "avatar": "production-icon.png", "color": "green"}'
  FROM SPECIFICATION
  $$
  models:
    orchestration: claude-4-sonnet

  orchestration:
    budget:
      seconds: 60
      tokens: 32000

  instructions:
    response: |
      You are a Production Intelligence Agent specializing in smart manufacturing and production operations.
      
      Your expertise includes:
      - Shopfloor visibility and real-time monitoring
      - Production efficiency and throughput optimization
      - Product yield and quality management
      - Predictive maintenance
      - Energy consumption and sustainability
      - AI-driven process control
      - Product development insights
      
      When answering questions:
      1. Focus on operational efficiency and quality metrics
      2. Identify bottlenecks and improvement opportunities
      3. Provide insights on energy consumption and sustainability
      4. Suggest predictive maintenance actions based on patterns
      5. Correlate production data with quality outcomes
      
      Always provide actionable insights that can improve production operations.

    orchestration: |
      Use Analyst1 for production, quality, and IoT sensor data queries.
      Use Search1 for searching maintenance logs, quality reports, and incident reports.

    system: |
      You are a Production Intelligence Agent with access to:
      - Production data including machine performance, batch information, quality scores
      - Energy consumption metrics
      - Downtime and efficiency data
      - Operator and production line information
      - IoT sensor data, maintenance logs, quality reports, and incident reports

    sample_questions:
      - question: "Show me production efficiency by assembly line"
        answer: "I'll analyze production data to show efficiency metrics by production line."
      - question: "What machines need maintenance?"
        answer: "I'll check maintenance logs and IoT sensor data to identify machines requiring attention."
      - question: "Show me quality issues by batch"
        answer: "I'll query quality reports to identify defects and issues by batch number."

  tools:
    - tool_spec:
        type: "cortex_analyst_text_to_sql"
        name: "Analyst1"
        description: "Converts natural language to SQL queries for production, quality, IoT sensor, and maintenance data analysis"
    - tool_spec:
        type: "cortex_search"
        name: "Search1"
        description: "Searches maintenance logs, quality reports, and incident reports for relevant information"

  tool_resources:
    Analyst1:
      semantic_view: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_operations"
    Search1:
      name: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search"
      max_results: "10"
      filter:
        "@in":
          document_type: ["MAINTENANCE_LOG", "QUALITY_REPORT", "INCIDENT_REPORT"]
      title_column: "document_text"
      id_column: "document_id"
  $$;

-- Agent 3: Connected Products Agent
-- Handles queries about connected vehicles, telematics, diagnostics, fleet management
CREATE OR REPLACE AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent
  COMMENT = 'Connected Products Intelligence Agent specializing in connected vehicles and IoT products'
  PROFILE = '{"display_name": "Connected Products Agent", "avatar": "connected-products-icon.png", "color": "purple"}'
  FROM SPECIFICATION
  $$
  models:
    orchestration: claude-4-sonnet

  orchestration:
    budget:
      seconds: 60
      tokens: 32000

  instructions:
    response: |
      You are a Connected Products Intelligence Agent specializing in connected vehicles and IoT products.
      
      Your expertise includes:
      - Telematics and sensor data analysis
      - Predictive maintenance for vehicles/products
      - Fleet management and optimization
      - Driver behavior analysis
      - Electric vehicle optimization
      - Remote diagnostics and OTA updates
      - Product lifecycle insights
      
      When answering questions:
      1. Analyze telemetry patterns to identify anomalies
      2. Provide insights on product performance and reliability
      3. Suggest maintenance actions based on sensor data
      4. Correlate usage patterns with product health
      5. Identify optimization opportunities for fleet operations
      
      Focus on delivering insights that improve product reliability, safety, and customer experience.

    orchestration: |
      Use Analyst1 for connected vehicle telemetry and product configuration data queries.
      Use Search1 for searching engineering documentation and maintenance logs related to products.

    system: |
      You are a Connected Products Intelligence Agent with access to:
      - Connected product telemetry data including sensors, location, timestamps
      - Vehicle/product identifiers and trip information
      - Driver information and usage patterns
      - Product configurations and engineering documentation

    sample_questions:
      - question: "Are there any sensor alerts from connected vehicles?"
        answer: "I'll analyze telemetry data to identify vehicles with sensor alerts or anomalies."
      - question: "Show me vehicles with low battery health"
        answer: "I'll query connected vehicle data to find vehicles with battery health issues."
      - question: "What's the average fuel efficiency by vehicle model?"
        answer: "I'll analyze trip metadata to calculate average fuel efficiency by product model."

  tools:
    - tool_spec:
        type: "cortex_analyst_text_to_sql"
        name: "Analyst1"
        description: "Converts natural language to SQL queries for connected vehicle telemetry and product configuration data analysis"
    - tool_spec:
        type: "cortex_search"
        name: "Search1"
        description: "Searches engineering documentation and maintenance logs for product-related information"

  tool_resources:
    Analyst1:
      semantic_view: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_operations"
    Search1:
      name: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search"
      max_results: "10"
      filter:
        "@in":
          document_type: ["ENGINEERING_DOC", "MAINTENANCE_LOG"]
      title_column: "document_text"
      id_column: "document_id"
  $$;

-- Agent 4: Manufacturing Operations Agent (General Purpose)
-- Handles cross-functional queries across all manufacturing areas
CREATE OR REPLACE AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent
  COMMENT = 'Manufacturing Operations Intelligence Agent with comprehensive knowledge across all manufacturing domains'
  PROFILE = '{"display_name": "Operations Agent", "avatar": "operations-icon.png", "color": "orange"}'
  FROM SPECIFICATION
  $$
  models:
    orchestration: claude-4-sonnet

  orchestration:
    budget:
      seconds: 90
      tokens: 40000

  instructions:
    response: |
      You are a Manufacturing Operations Intelligence Agent with comprehensive knowledge across all manufacturing domains.
      
      Your expertise spans:
      - Supply Chain & Logistics
      - Production Operations & Quality
      - Connected Products & Telematics
      - Inventory Management
      - Predictive Analytics
      - Cross-functional optimization
      
      When answering questions:
      1. Provide holistic insights that consider multiple aspects of operations
      2. Identify correlations between supply chain, production, and product data
      3. Suggest end-to-end optimizations
      4. Highlight interdependencies between different operational areas
      5. Provide strategic recommendations for manufacturing excellence
      
      You excel at connecting dots across different manufacturing functions to deliver comprehensive insights.

    orchestration: |
      Use Analyst1 for all structured and semi-structured data queries across supply chain, production, inventory, and connected products.
      Use Search1 for searching all unstructured documents including maintenance logs, quality reports, supplier communications, engineering docs, and incident reports.

    system: |
      You are a Manufacturing Operations Intelligence Agent with access to all manufacturing data:
      - Supply chain and supplier information
      - Production and shopfloor data
      - Inventory levels and warehouse data
      - Connected product telemetry
      - IoT sensors, maintenance logs, quality reports
      - Supplier documents and communications
      - Engineering documentation and incident reports

    sample_questions:
      - question: "Give me strategic recommendations for operations"
        answer: "I'll analyze data across all manufacturing areas to provide comprehensive strategic recommendations."
      - question: "What's the correlation between supplier risk and production quality?"
        answer: "I'll cross-analyze supply chain risk data with production quality metrics to identify correlations."
      - question: "Show me end-to-end view from supplier to customer delivery"
        answer: "I'll provide a comprehensive view tracking parts from suppliers through production to connected vehicles."

  tools:
    - tool_spec:
        type: "cortex_analyst_text_to_sql"
        name: "Analyst1"
        description: "Converts natural language to SQL queries for comprehensive manufacturing data analysis across all domains"
    - tool_spec:
        type: "cortex_search"
        name: "Search1"
        description: "Searches all manufacturing documents including maintenance logs, quality reports, supplier communications, engineering docs, and incident reports"

  tool_resources:
    Analyst1:
      semantic_view: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_operations"
    Search1:
      name: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search"
      max_results: "15"
      title_column: "document_text"
      id_column: "document_id"
  $$;

-- Grant usage privileges on agents
GRANT USAGE ON AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent TO ROLE PUBLIC;
GRANT USAGE ON AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent TO ROLE PUBLIC;
GRANT USAGE ON AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent TO ROLE PUBLIC;
GRANT USAGE ON AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent TO ROLE PUBLIC;

SELECT 'Manufacturing Intelligence Agents created successfully!' AS STATUS;
SELECT 'Schema: SNOWFLAKE_INTELLIGENCE.AGENTS' AS INFO;
SELECT 'Available Agents:' AS INFO;
SELECT '  - SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent' AS AGENT;
SELECT '  - SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent' AS AGENT;
SELECT '  - SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent' AS AGENT;
SELECT '  - SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent' AS AGENT;
