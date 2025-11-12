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
- **Location:** All agents are created in `SNOWFLAKE_INTELLIGENCE.AGENTS` schema
- **Syntax:** Uses `FROM SPECIFICATION` with YAML format
- **Tools:** Each agent has access to:
  - `Analyst1` (cortex_analyst_text_to_sql): Queries the unified semantic view
  - `Search1` (cortex_search): Searches the unified Cortex Search service
- **Configuration:** Tool resources configured per agent with appropriate filters

## Data Types in This Demo

- **Structured Data**: Traditional relational tables (supply_chain, production, inventory)
- **Semi-structured Data**: JSON/VARIANT columns (connected_products, iot_sensors, supplier_documents, product_configurations)
- **Unstructured Data**: Free-form text (maintenance_logs, quality_reports, supplier_communications, engineering_docs, incident_reports)

---

## Demo Structure

### Part 1: Supply Chain Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent`  
**Use Cases:** Supplier Risk, Inventory Management, Forecasting, Logistics

#### Structured Data Queries (Tables & Graphs)

1. **Which suppliers have high risk scores?**
   ```
   Show me suppliers with high risk scores and their details.
   ```

2. **What's our total spend by region?**
   ```
   Show me how much we spend with suppliers in each region. Make it a bar chart.
   ```

3. **Which parts need reordering?**
   ```
   Show me parts that need reordering with their current stock levels.
   ```

4. **How is our inventory distributed?**
   ```
   Show me a pie chart of parts by stock status - which ones need reorder, which are low, and which are adequate.
   ```

5. **What's the average delivery time by supplier?**
   ```
   Show me how long it takes each supplier to deliver on average.
   ```

6. **Which suppliers are delivering late?**
   ```
   Show me suppliers with delayed deliveries and their delivery status.
   ```

7. **What's our total cost by supplier?**
   ```
   Show me total spend for each supplier in a table.
   ```

8. **Show me risk vs spend relationship**
   ```
   Create a scatter plot showing supplier risk scores versus total spend, colored by region.
   ```

#### Semi-Structured Data Queries (JSON/VARIANT)

9. **What payment terms do our suppliers have?**
   ```
   Show me payment terms extracted from supplier documents.
   ```

10. **Which suppliers have ISO certifications?**
    ```
    Show me suppliers with ISO standards from their compliance documents.
    ```

11. **What's the total value of supplier documents?**
    ```
    Show me total document values by supplier and document type in a bar chart.
    ```

12. **What currencies are used in supplier contracts?**
    ```
    Show me currencies and payment terms from supplier documents.
    ```

#### Unstructured Data Queries (NLP Search)

13. **Are there any delivery delay discussions?**
    ```
    Search supplier communications for discussions about delivery delays.
    ```

14. **What quality issues have suppliers mentioned?**
    ```
    Find supplier communications about quality problems.
    ```

15. **What are suppliers saying about pricing?**
    ```
    Search supplier communications for pricing or contract discussions.
    ```

16. **Which suppliers have the most communications?**
    ```
    Show me which suppliers we communicate with most frequently.
    ```

#### Combined Data Type Queries

17. **Give me a complete supplier view**
    ```
    Show me supplier risk scores, their payment terms from documents, and any concerns from communications all together.
    ```

18. **Which high-risk suppliers have delivery issues?**
    ```
    Show me suppliers with high risk scores, check their delivery status, and search communications for any delay discussions.
    ```

---

### Part 2: Smart Production Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent`  
**Use Cases:** Shopfloor Visibility, Quality Management, Predictive Maintenance, Energy Optimization

#### Structured Data Queries (Tables & Graphs)

1. **Which production lines are most efficient?**
   ```
   Show me production efficiency by line with units produced and quality scores.
   ```

2. **How is production efficiency trending?**
   ```
   Show me a line chart of production efficiency over time by production line.
   ```

3. **What's the quality rating of our batches?**
   ```
   Show me production batches with their quality ratings - excellent, good, acceptable, or needs improvement.
   ```

4. **How are quality scores distributed?**
   ```
   Show me a histogram of quality scores across all batches.
   ```

5. **How much energy do we use per unit?**
   ```
   Show me energy consumption per unit produced by production line.
   ```

6. **Which lines are most energy efficient?**
   ```
   Show me a bar chart comparing energy efficiency across production lines.
   ```

7. **Which machines have the most downtime?**
   ```
   Show me machines with high downtime and their production line.
   ```

8. **What's our average production duration?**
   ```
   Show me average production time per batch.
   ```

#### Semi-Structured Data Queries (JSON/VARIANT)

9. **Which machines have sensor alerts?**
    ```
    Show me machines with sensor warnings or alerts from IoT sensors.
    ```

10. **What's the status of our sensors?**
    ```
    Show me a stacked bar chart of sensor status - normal, warning, or alert - by machine.
    ```

11. **What state are our machines in?**
    ```
    Show me machine states from IoT sensors - which ones are running, idle, or have issues.
    ```

12. **Which sensors need attention?**
    ```
    Show me sensors with warnings or alerts, their machine ID, and sensor type.
    ```

#### Unstructured Data Queries (NLP Search)

13. **What maintenance issues do we have?**
    ```
    Search maintenance logs for bearing failures or replacements. What machines are affected?
    ```

14. **Which machines need frequent maintenance?**
    ```
    Find machines with recurring maintenance issues from the logs.
    ```

15. **What maintenance was done recently?**
    ```
    Show me a summary of recent maintenance activities - which machines, what was done, and what issues were found.
    ```

16. **What quality defects are we seeing?**
    ```
    Search quality reports for paint defects or surface finish issues. What caused them?
    ```

17. **What defects were found in batches?**
    ```
    Show me batches with defects - what was the defect, severity, and what corrective actions were taken.
    ```

18. **Are there quality trends we should worry about?**
    ```
    Search quality reports for trends in defect types over time.
    ```

#### Combined Data Type Queries

19. **Do sensor alerts affect quality?**
    ```
    Show me production batches that had IoT sensor alerts and their quality scores. Is there a correlation?
    ```

20. **What's the connection between production and quality reports?**
    ```
    Match production batches with quality reports. Show me batch number, quality score, and any defect descriptions.
    ```

21. **Do sensor alerts lead to maintenance?**
    ```
    Show me machines with IoT sensor warnings and what maintenance was performed. Create a timeline.
    ```

---

### Part 3: Connected Products Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent`  
**Use Cases:** Telematics, Predictive Maintenance, Fleet Management, EV Optimization

#### Structured Data Queries (Tables & Graphs)

1. **How many vehicles do we have connected?**
   ```
   Show me all connected vehicles with their product IDs and last update time.
   ```

2. **Where are our vehicles located?**
   ```
   Show me a pie chart of vehicles by geofence region.
   ```

#### Semi-Structured Data Queries (JSON/VARIANT)

3. **Which vehicles have sensor alerts?**
    ```
    Show me vehicles with sensor alerts - high temperature, low battery, or error codes.
    ```

4. **What are the sensor values?**
    ```
    Show me a box plot of sensor values by sensor type from connected vehicles.
    ```

5. **How is battery health changing?**
    ```
    Show me a line chart of battery health over time for each vehicle.
    ```

6. **What routes are vehicles taking?**
    ```
    Show me trip details - vehicle ID, route, distance, duration, fuel efficiency, and driver name.
    ```

7. **Which routes are most fuel efficient?**
    ```
    Show me a scatter plot of fuel efficiency versus distance for different routes.
    ```

8. **What are our product configurations?**
    ```
    Show me product configurations - model type, engine type, transmission, dimensions, and max speed.
    ```

9. **How many products by engine and transmission?**
    ```
    Show me a bar chart of products grouped by engine type and transmission.
    ```

10. **How are drivers performing?**
    ```
    Show me driver behavior scores, driving hours, and fatigue risk levels.
    ```

11. **What's the distribution of driver scores?**
    ```
    Show me a histogram of driver behavior scores.
    ```

12. **What's the average speed of our vehicles?**
    ```
    Show me average current speed by vehicle and location.
    ```

#### Unstructured Data Queries (NLP Search)

13. **What do engineering docs say about brakes?**
    ```
    Find engineering documents about brake system design or brake components.
    ```

14. **What design changes were made?**
    ```
    Find engineering documents describing design changes. Which products were affected?
    ```

15. **What maintenance was done on vehicles?**
    ```
    Search maintenance logs for specific vehicles. What maintenance was performed?
    ```

16. **What issues are documented for our products?**
    ```
    Search all documents for mentions of vehicle models or product configurations. What issues or improvements are documented?
    ```

#### Combined Data Type Queries

17. **Do vehicle alerts lead to maintenance?**
    ```
    Show me vehicles with telemetry alerts and what maintenance was performed. Create a timeline.
    ```

18. **What's the connection between product configs and engineering docs?**
    ```
    Match product configurations with engineering documentation. Show me product details and related engineering specs.
    ```

19. **Give me a complete vehicle view**
    ```
    Show me vehicle telemetry data, product configurations, related engineering docs, and any maintenance logs all together.
    ```

---

### Part 4: Cross-Functional Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent`  
**Use Cases:** End-to-end optimization, Strategic insights, Cross-functional analysis

#### Cross-Type Analysis Queries

1. **Give me a complete operations overview**
   ```
   Show me everything - supplier risks, production quality, inventory levels, vehicle performance, and any issues from reports. Create tables and charts.
   ```

2. **Do sensor alerts affect production quality?**
   ```
   Show me production batches with IoT sensor alerts and their quality scores. Is there a connection?
   ```

3. **What do quality reports say about our batches?**
   ```
   Match production batches with quality reports. Show me batch number, quality score, and defect descriptions.
   ```

4. **Do vehicle alerts lead to maintenance?**
   ```
   Show me vehicles with telemetry alerts and what maintenance was performed. Create charts showing the correlation.
   ```

5. **How does everything connect?**
   ```
   Show me supplier risks, production quality for their parts, vehicle performance using those parts, and any related issues from reports. Create a unified dashboard.
   ```

6. **What should we focus on?**
   ```
   Based on all our data, what are the top 3 things we should improve? Use data from tables, JSON, and documents. Show supporting charts.
   ```

7. **Are supplier, production, and vehicle quality related?**
   ```
   Is there a connection between supplier performance, production quality, and vehicle reliability? Analyze supplier data, production metrics, vehicle telemetry, and search reports for patterns.
   ```

8. **Where can we save money?**
   ```
   Where are the biggest cost savings opportunities? Look at supply chain costs, production costs, and search documents for cost discussions.
   ```

9. **How sustainable are we?**
   ```
   Analyze our energy use and supply chain practices. Look at production energy, sensor data, supplier documents, and search reports for sustainability info.
   ```

10. **What do documents say about calibration?**
    ```
    Search all documents for calibration mentions. How does this relate to production quality and sensor data?
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
   - Demonstrate queries across structured, semi-structured, and unstructured data

3. **Demonstrate Value**
   - Use specific queries relevant to Vehicle Manufacturing use cases
   - Show how agents understand context and provide actionable insights
   - Show tables and graphs generated from different data types

### Option 2: Agent Capability Driven (Recommended for Technical Audience)
1. **Supply Chain Agent** - Show structured supplier data, semi-structured supplier documents, unstructured communications
2. **Production Agent** - Show structured production data, semi-structured IoT sensors, unstructured maintenance/quality logs
3. **Connected Products Agent** - Show semi-structured telemetry, structured summaries, unstructured engineering docs
4. **Operations Agent** - Show cross-functional intelligence combining all data types

### Option 3: Data Type Driven (Recommended for Data Engineers)
1. **Structured Data** - Show tables and charts from relational data
2. **Semi-Structured Data** - Show JSON extraction and analysis
3. **Unstructured Data** - Show NLP search capabilities
4. **Combined Analysis** - Show cross-type correlations and insights

### Option 4: Customer Story Driven (Recommended for Executive Audience)
Reference the customer case studies from reference.MD:

1. **Siemens Story**
   - Query: "How can we reduce supply chain risk and improve efficiency?"
   - Show how Intelligence provides self-service analytics across all data types

2. **Honeywell Story**
   - Query: "Give me visibility into inventory across all sites, every level, every hour"
   - Show real-time visibility capabilities with structured data

3. **ABB Story**
   - Query: "How can we optimize inventory and pricing across our global operations?"
   - Show data-driven optimization using structured and semi-structured data

4. **Penske Logistics Story**
   - Query: "Analyze our fleet performance and provide actionable insights for safety and retention"
   - Show AI-powered insights from semi-structured telemetry and unstructured reports

---

## Key Talking Points

### 1. Breaking Down Data Silos
- **Challenge:** Data scattered across systems (SAP, Oracle, SCADA, PLMs) in different formats
- **Solution:** Intelligence agents provide unified access to structured, semi-structured, and unstructured data through natural language
- **Demo:** Ask cross-functional questions that require data from multiple sources and formats

### 2. Real-Time Visibility
- **Challenge:** Need real-time visibility across inventory, demand, logistics, shopfloor
- **Solution:** Semantic views provide real-time access to operational data (structured and semi-structured)
- **Demo:** Query current inventory status, production performance, connected vehicle alerts

### 3. Unstructured Data Intelligence
- **Challenge:** Valuable insights locked in documents, logs, and reports
- **Solution:** Cortex Search enables semantic search over unstructured text
- **Demo:** Search maintenance logs, quality reports, and engineering docs using natural language

### 4. Scaling AI Across Teams
- **Challenge:** Difficulties scaling AI across various teams
- **Solution:** Intelligence agents democratize AI - no coding required
- **Demo:** Show how business users can ask questions in natural language across all data types

### 5. Data-Driven Optimization
- **Challenge:** Need to optimize supply chain, production, and product operations
- **Solution:** Intelligence agents provide actionable insights and recommendations from all data types
- **Demo:** Ask for optimization recommendations and show data-driven suggestions with supporting charts

---

## Advanced Demo Scenarios

### Scenario 1: Supply Chain Disruption
**Setup:** Mention a supplier delay or quality issue  
**Query:** "A key supplier has delayed delivery. What's the impact on our production schedule and inventory? Search supplier communications for related discussions. What alternatives do we have?"

### Scenario 2: Quality Issue Investigation
**Setup:** Mention a quality problem in production  
**Query:** "We're seeing quality issues in recent batches. Analyze production data, check IoT sensor readings during those batches, and search quality reports for defect descriptions. Identify root causes and suggest corrective actions."

### Scenario 3: Connected Vehicle Alert
**Setup:** Show telemetry alerts  
**Query:** "We're getting high temperature alerts from connected vehicles. Analyze the telemetry data, extract product configurations for affected vehicles, and search maintenance logs and engineering docs for related issues. Determine if this is widespread or isolated."

### Scenario 4: Strategic Planning
**Setup:** Discuss business planning needs  
**Query:** "We're planning for next quarter. Based on current operations, what should we focus on? Analyze structured data (supply chain, production, inventory), extract insights from supplier documents and product configurations, and search reports for historical patterns. Provide strategic recommendations with supporting data visualizations."

---

## Tips for Successful Demo

1. **Prepare Context:** Before each query, briefly explain the business context
2. **Show Process:** Walk through how the agent understands the question and accesses data
3. **Highlight Data Types:** Point out when queries access structured, semi-structured, or unstructured data
4. **Show Visualizations:** Emphasize tables and charts generated from different data types
5. **Highlight Insights:** Emphasize actionable recommendations, not just data retrieval
6. **Connect to Reference:** Link back to use cases from reference.MD
7. **Show Natural Language:** Demonstrate that queries don't need to be perfectly structured
8. **Iterate:** Show how follow-up questions refine insights
9. **Compare:** If possible, show how this compares to traditional BI/reporting approaches
10. **Cross-Type Analysis:** Demonstrate queries that combine multiple data types

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
- Specify if you want tables or charts
- Verify that agents have access to both Analyst1 (semantic view) and Search1 (Cortex Search) tools

### If performance is slow:
- Ensure warehouse is running (especially CORTEX_SEARCH_WH for Cortex Search service)
- Check that the unified semantic view is optimized
- Verify Cortex Search service is fully indexed (check INDEXING_STATE)
- Consider using smaller datasets for demo

---

## Next Steps After Demo

1. **Customize for Specific Customer:**
   - Add their actual data sources (structured, semi-structured, unstructured)
   - Create domain-specific semantic views
   - Tailor agent instructions to their use cases

2. **Expand Capabilities:**
   - Add more tables to the unified semantic view (e.g., customer data, financial data)
   - Add more unstructured data sources to the unified Cortex Search service
   - Create specialized agents for specific roles with custom tool configurations
   - Integrate with external tools via APIs

3. **Production Deployment:**
   - Set up proper security and governance
   - Train users on effective querying across all data types
   - Monitor usage and optimize performance
