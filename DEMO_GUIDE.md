# Snowflake Intelligence Demo Guide - Vehicle Manufacturing

## Overview
This demo showcases Snowflake Intelligence capabilities for Vehicle Manufacturing, addressing key challenges such as data silos, real-time visibility, and scalable AI adoption.

## Architecture

### Unified Semantic View
- **Name:** `manufacturing_operations`
- **Purpose:** Single semantic view consolidating all structured and semi-structured data
- **Tables Included:**
  - Structured: `supply_chain`, `production`, `inventory`
  - Semi-structured: `connected_products`, `iot_sensors`, `supplier_documents`, `product_configurations`
  - Unstructured: `maintenance_logs`, `quality_reports`, `supplier_communications`, `engineering_docs`, `incident_reports`
- **Features:** Relationships defined between tables, dimensions and metrics for business-friendly querying

### Unified Cortex Search Service
- **Name:** `manufacturing_documents_search`
- **Purpose:** Single search service for all unstructured text data
- **Data Sources:** Combines text from maintenance logs, quality reports, supplier communications, engineering docs, and incident reports
- **Features:** Hybrid (vector + keyword) search with semantic reranking

### Intelligence Agents
- **Syntax:** Uses `FROM SPECIFICATION` with YAML format
- **Tools:** Each agent has access to:
  - `Analyst1` (cortex_analyst_text_to_sql): Queries the unified semantic view
  - `Search1` (cortex_search): Searches the unified Cortex Search service
- **Configuration:** Tool resources configured per agent with appropriate filters

## Demo Structure

### Part 1: Supply Chain Intelligence
**Agent:** `supply_chain_agent`  
**Use Cases:** Supplier Risk, Inventory Management, Forecasting, Logistics

#### Sample Queries:

1. **Supplier Risk Assessment**
   ```
   What suppliers have high risk scores? Show me the details and suggest mitigation strategies.
   ```

2. **Inventory Visibility**
   ```
   Which parts need reordering? Show me current stock levels and reorder status.
   ```

3. **Supply Chain Optimization**
   ```
   Analyze our supply chain performance. What are the key bottlenecks and how can we optimize delivery times?
   ```

4. **Spend Analytics**
   ```
   What is our total spend by supplier and region? Which areas have the highest costs?
   ```

5. **Demand Forecasting**
   ```
   Based on production data, what parts will we need in the next month? Consider current inventory levels.
   ```

---

### Part 2: Smart Production Intelligence
**Agent:** `production_agent`  
**Use Cases:** Shopfloor Visibility, Quality Management, Predictive Maintenance, Energy Optimization

#### Sample Queries:

1. **Production Efficiency**
   ```
   Show me the production efficiency by production line. Which lines are performing best and which need improvement?
   ```

2. **Quality Analysis**
   ```
   Analyze product quality scores across batches. Are there any quality trends or issues I should be aware of?
   ```

3. **Energy Consumption**
   ```
   What is our energy consumption per unit produced? Which production lines are most energy efficient?
   ```

4. **Predictive Maintenance**
   ```
   Based on production data, which machines have high downtime? What maintenance actions would you recommend?
   ```

5. **Yield Optimization**
   ```
   Compare production yields across different batches and operators. What factors contribute to higher yields?
   ```

---

### Part 3: Connected Products Intelligence
**Agent:** `connected_products_agent`  
**Use Cases:** Telematics, Predictive Maintenance, Fleet Management, EV Optimization

#### Sample Queries:

1. **Telemetry Analysis**
   ```
   Analyze sensor data from our connected vehicles. Are there any anomalies or alerts I should be concerned about?
   ```

2. **Predictive Maintenance**
   ```
   Based on telemetry data, which vehicles need maintenance attention? What patterns indicate potential failures?
   ```

3. **Fleet Management**
   ```
   Show me insights about our vehicle fleet. How are vehicles being used and what optimization opportunities exist?
   ```

4. **Electric Vehicle Optimization**
   ```
   Analyze battery levels and energy consumption patterns for our electric vehicles. How can we optimize charging and usage?
   ```

5. **Product Reliability**
   ```
   What insights can you provide about product reliability based on connected vehicle data? Are there any recurring issues?
   ```

---

### Part 4: Cross-Functional Intelligence
**Agent:** `manufacturing_operations_agent`  
**Use Cases:** End-to-end optimization, Strategic insights, Cross-functional analysis

#### Sample Queries:

1. **End-to-End Visibility**
   ```
   Give me a comprehensive overview of our manufacturing operations. How are supply chain, production, and product performance connected?
   ```

2. **Strategic Recommendations**
   ```
   Based on all available data, what are the top 3 strategic recommendations to improve our manufacturing operations?
   ```

3. **Correlation Analysis**
   ```
   Are there correlations between supplier performance, production quality, and product reliability? What insights can you provide?
   ```

4. **Cost Optimization**
   ```
   Where are the biggest cost optimization opportunities across our supply chain, production, and product operations?
   ```

5. **Sustainability Insights**
   ```
   Analyze our energy consumption and supply chain practices. What sustainability improvements can we make?
   ```

---

## Demo Flow Recommendations

### Option 1: Use Case Driven (Recommended for Business Audience)
1. **Start with a Business Challenge** (from reference.MD)
   - "We have data silos across our enterprise..."
   - "We need real-time visibility into our supply chain..."
   - "We want to scale AI across our manufacturing teams..."

2. **Show the Solution**
   - Demonstrate how Intelligence agents provide natural language access to data
   - Show cross-functional insights that break down silos

3. **Demonstrate Value**
   - Use specific queries relevant to Vehicle Manufacturing use cases
   - Show how agents understand context and provide actionable insights

### Option 2: Agent Capability Driven (Recommended for Technical Audience)
1. **Supply Chain Agent** - Show supplier risk, inventory, logistics
2. **Production Agent** - Show quality, efficiency, maintenance
3. **Connected Products Agent** - Show telematics, fleet management
4. **Operations Agent** - Show cross-functional intelligence

### Option 3: Customer Story Driven (Recommended for Executive Audience)
Reference the customer case studies from reference.MD:

1. **Siemens Story**
   - Query: "How can we reduce supply chain risk and improve efficiency?"
   - Show how Intelligence provides self-service analytics

2. **Honeywell Story**
   - Query: "Give me visibility into inventory across all sites, every level, every hour"
   - Show real-time visibility capabilities

3. **ABB Story**
   - Query: "How can we optimize inventory and pricing across our global operations?"
   - Show data-driven optimization

4. **Penske Logistics Story**
   - Query: "Analyze our fleet performance and provide actionable insights for safety and retention"
   - Show AI-powered insights

---

## Key Talking Points

### 1. Breaking Down Data Silos
- **Challenge:** Data scattered across systems (SAP, Oracle, SCADA, PLMs)
- **Solution:** Intelligence agents provide unified access to all data through natural language
- **Demo:** Ask cross-functional questions that require data from multiple sources

### 2. Real-Time Visibility
- **Challenge:** Need real-time visibility across inventory, demand, logistics, shopfloor
- **Solution:** Semantic views provide real-time access to operational data
- **Demo:** Query current inventory status, production performance, connected vehicle alerts

### 3. Scaling AI Across Teams
- **Challenge:** Difficulties scaling AI across various teams
- **Solution:** Intelligence agents democratize AI - no coding required
- **Demo:** Show how business users can ask questions in natural language

### 4. Data-Driven Optimization
- **Challenge:** Need to optimize supply chain, production, and product operations
- **Solution:** Intelligence agents provide actionable insights and recommendations
- **Demo:** Ask for optimization recommendations and show data-driven suggestions

---

## Advanced Demo Scenarios

### Scenario 1: Supply Chain Disruption
**Setup:** Mention a supplier delay or quality issue  
**Query:** "A key supplier has delayed delivery. What's the impact on our production schedule and inventory? What alternatives do we have?"

### Scenario 2: Quality Issue Investigation
**Setup:** Mention a quality problem in production  
**Query:** "We're seeing quality issues in recent batches. Analyze production data and identify root causes. What corrective actions should we take?"

### Scenario 3: Connected Vehicle Alert
**Setup:** Show telemetry alerts  
**Query:** "We're getting high temperature alerts from connected vehicles. Analyze the data and determine if this is a widespread issue or isolated incidents."

### Scenario 4: Strategic Planning
**Setup:** Discuss business planning needs  
**Query:** "We're planning for next quarter. Based on current operations, what should we focus on? Consider supply chain, production capacity, and product performance."

---

## Tips for Successful Demo

1. **Prepare Context:** Before each query, briefly explain the business context
2. **Show Process:** Walk through how the agent understands the question and accesses data
3. **Highlight Insights:** Emphasize actionable recommendations, not just data retrieval
4. **Connect to Reference:** Link back to use cases from reference.MD
5. **Show Natural Language:** Demonstrate that queries don't need to be perfectly structured
6. **Iterate:** Show how follow-up questions refine insights
7. **Compare:** If possible, show how this compares to traditional BI/reporting approaches

---

## Troubleshooting

### If agents don't have enough context:
- Ensure the unified semantic view (`manufacturing_operations`) is created and populated
- Ensure the unified Cortex Search service (`manufacturing_documents_search`) is created and indexed
- Check that agents have proper tool_resources configured (semantic_view and cortex_search service)
- Verify that the Intelligence object is properly configured
- Check that agents have USAGE privileges on the semantic view and Cortex Search service

### If queries return generic responses:
- Make queries more specific to Vehicle Manufacturing domain
- Reference specific data elements (suppliers, parts, production lines, vehicle models)
- Ask for analysis rather than just data retrieval
- Verify that agents have access to both Analyst1 (semantic view) and Search1 (Cortex Search) tools

### If performance is slow:
- Ensure warehouse is running (especially CORTEX_SEARCH_WH for Cortex Search service)
- Check that the unified semantic view is optimized
- Verify Cortex Search service is fully indexed (check INDEXING_STATE)
- Consider using smaller datasets for demo

---

## Next Steps After Demo

1. **Customize for Specific Customer:**
   - Add their actual data sources
   - Create domain-specific semantic views
   - Tailor agent instructions to their use cases

2. **Expand Capabilities:**
   - Add more tables to the unified semantic view (e.g., customer data, financial data)
   - Add more unstructured data sources to the unified Cortex Search service
   - Create specialized agents for specific roles with custom tool configurations
   - Integrate with external tools via APIs

3. **Production Deployment:**
   - Set up proper security and governance
   - Train users on effective querying
   - Monitor usage and optimize performance

