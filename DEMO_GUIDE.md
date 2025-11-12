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

1. **Supplier Performance Table**
   ```
   Create a table showing supplier performance metrics including total orders, average delivery time, total spend, and risk scores. Sort by risk score descending.
   ```

2. **Supplier Spend by Region (Bar Chart)**
   ```
   Create a bar chart showing total spend by supplier region. Use different colors for each region.
   ```

3. **Inventory Status Dashboard Table**
   ```
   Generate a comprehensive inventory status table showing part numbers, current stock levels, reorder levels, reorder quantities, stock status (Reorder Needed/Low Stock/Adequate), and warehouse locations.
   ```

4. **Inventory Stock Distribution (Pie Chart)**
   ```
   Create a pie chart showing the distribution of parts by stock status: Reorder Needed, Low Stock, and Adequate Stock.
   ```

5. **Supply Chain Risk Analysis Table**
   ```
   Create a detailed table of suppliers with high risk scores (above 0.4). Include supplier name, region, risk category, number of orders, total quantity ordered, and average unit cost.
   ```

6. **Supplier Risk vs Spend (Scatter Plot)**
   ```
   Create a scatter plot with risk score on x-axis and total spend on y-axis. Color code by region.
   ```

#### Semi-Structured Data Queries (JSON/VARIANT)

7. **Supplier Document Analysis Table**
   ```
   Extract data from supplier documents and show me a table with document ID, supplier ID, document type, document title, category, currency, payment terms, total value, and ISO standard compliance.
   ```

8. **Supplier Document Value Distribution (Bar Chart)**
   ```
   Create a bar chart showing total document value by supplier and document type.
   ```

#### Unstructured Data Queries (NLP Search)

9. **Supplier Communication Analysis**
   ```
   Search supplier communications for discussions about delivery delays or supply chain disruptions. Summarize the key issues and resolutions.
   ```

10. **Supplier Performance from Communications**
    ```
    Based on supplier communications, what are the main concerns or issues raised? Which suppliers have the most communication activity?
    ```

11. **Supplier Communication Summary Table**
    ```
    Generate a table from supplier communications showing supplier ID, communication date, type, subject, and key action items mentioned.
    ```

#### Combined Data Type Queries

12. **Cross-Type Supplier Analysis**
    ```
    Provide a comprehensive supplier analysis: Show supplier risk scores from structured data, extract payment terms from supplier documents, and search communications for any concerns. Create a unified table.
    ```

---

### Part 2: Smart Production Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent`  
**Use Cases:** Shopfloor Visibility, Quality Management, Predictive Maintenance, Energy Optimization

#### Structured Data Queries (Tables & Graphs)

1. **Production Efficiency by Line Table**
   ```
   Show me a table comparing production efficiency across all production lines. Include columns for production line ID, total units produced, average quality score, total downtime minutes, and efficiency percentage.
   ```

2. **Production Efficiency Trend (Line Chart)**
   ```
   Show me a line chart of production efficiency over time by production line. Include a trend line.
   ```

3. **Production Batch Quality Report Table**
   ```
   Show me a table of all production batches with their quality scores, quantity produced, production duration, energy consumption, and quality rating (Excellent/Good/Acceptable/Needs Improvement).
   ```

4. **Quality Scores Distribution (Histogram)**
   ```
   Generate a histogram showing the distribution of quality scores across all production batches.
   ```

5. **Energy Consumption Analysis Table**
   ```
   What is our energy consumption per unit produced? Show me a table with production line ID, total energy consumed, units produced, and energy per unit.
   ```

6. **Energy Efficiency Comparison (Bar Chart)**
   ```
   Create a bar chart comparing energy consumption per unit across different production lines.
   ```

#### Semi-Structured Data Queries (JSON/VARIANT)

7. **IoT Sensor Readings Table**
   ```
   Create a table from IoT sensor data showing sensor ID, machine ID, primary sensor name, sensor status, machine state, and timestamp. Filter for sensors with warnings or alerts.
   ```

8. **IoT Sensor Status by Machine (Stacked Bar Chart)**
   ```
   Generate a stacked bar chart showing sensor status distribution (normal/warning/alert) by machine ID.
   ```

9. **Machine State Analysis**
   ```
   Extract machine state information from IoT sensors and create a table showing machine ID, current state, uptime, and any alerts.
   ```

#### Unstructured Data Queries (NLP Search)

10. **Maintenance Log Search**
    ```
    Search maintenance logs for any mentions of bearing failures or bearing replacements. What machines are affected and what actions were taken?
    ```

11. **Maintenance Pattern Recognition**
    ```
    Analyze maintenance logs to identify recurring issues or patterns. Which machines have the most frequent maintenance needs?
    ```

12. **Maintenance Summary Table**
    ```
    Create a table summarizing maintenance activities by extracting key information from maintenance logs. Include machine ID, maintenance date, maintenance type, issues found, and actions taken.
    ```

13. **Quality Issue Investigation**
    ```
    Find quality reports that mention paint defects or surface finish issues. What were the root causes and corrective actions?
    ```

14. **Quality Defect Analysis Table**
    ```
    Extract quality defect information from quality reports and create a table showing batch number, defect description, severity, root cause, and corrective actions.
    ```

15. **Quality Trend Analysis**
    ```
    Search quality reports for trends in defect types over time. Are there any emerging quality concerns?
    ```

#### Combined Data Type Queries

16. **Production + IoT Sensor Correlation**
    ```
    Correlate production batch data with IoT sensor readings. Show me which production batches had sensor alerts and how that affected quality scores. Create a table and a correlation chart.
    ```

17. **Production + Maintenance Correlation**
    ```
    Match production batch numbers with quality reports. Create a table showing batch number, quality score from production data, and defect descriptions from quality reports.
    ```

18. **IoT + Maintenance Correlation**
    ```
    Correlate IoT sensor alerts with maintenance logs. Which machines had sensor warnings and what maintenance was performed? Show me a timeline chart.
    ```

---

### Part 3: Connected Products Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent`  
**Use Cases:** Telematics, Predictive Maintenance, Fleet Management, EV Optimization

#### Structured Data Queries (Tables & Graphs)

1. **Connected Vehicle Summary Table**
   ```
   Create a table showing all connected vehicles with their product IDs, total telemetry records, and last update timestamp.
   ```

2. **Vehicle Usage Distribution (Pie Chart)**
   ```
   Create a pie chart showing the distribution of vehicles by geofence region.
   ```

#### Semi-Structured Data Queries (JSON/VARIANT)

3. **Connected Vehicle Sensor Analysis Table**
   ```
   Extract and analyze sensor data from connected vehicles. Show me a table with vehicle ID, sensor types, sensor values, thresholds, and alert status for vehicles with sensor values exceeding thresholds.
   ```

4. **Sensor Value Distribution (Box Plot)**
   ```
   Create a box plot showing the distribution of primary sensor values by sensor type from connected vehicles.
   ```

5. **Battery Health Trend (Line Chart)**
   ```
   Show me a line chart of battery health over time for all connected vehicles. Group by vehicle ID.
   ```

6. **Connected Vehicle Trip Analysis Table**
   ```
   Extract trip metadata from connected vehicles and create a table showing vehicle ID, trip ID, route, distance in miles, duration in minutes, fuel efficiency, number of stops, and driver name.
   ```

7. **Fuel Efficiency by Route (Scatter Plot)**
   ```
   Create a scatter plot showing fuel efficiency vs distance for different routes from connected vehicle trip data.
   ```

8. **Product Configuration Comparison Table**
   ```
   Extract product configuration details and create a comparison table showing product ID, model type, engine type, transmission, dimensions (length, width, weight), and max speed for all product versions.
   ```

9. **Product Configuration Distribution (Bar Chart)**
   ```
   Create a bar chart showing the count of products by engine type and transmission combination.
   ```

10. **Driver Behavior Analysis Table**
    ```
    Extract driver information from connected vehicles and create a table showing driver ID, driver name, behavior score, driving hours, and fatigue risk level.
    ```

11. **Driver Behavior Score Distribution (Histogram)**
    ```
    Create a histogram showing the distribution of driver behavior scores across all connected vehicles.
    ```

#### Unstructured Data Queries (NLP Search)

12. **Engineering Documentation Search**
    ```
    Find engineering documents related to brake system design or brake component specifications. What are the key design parameters?
    ```

13. **Engineering Change History**
    ```
    Find engineering documents that describe design changes or modifications. What products were affected and why?
    ```

14. **Maintenance Correlation with Telemetry**
    ```
    Search maintenance logs for vehicles with specific VINs or product IDs. Correlate maintenance activities with telemetry alerts.
    ```

15. **Cross-Document Product Analysis**
    ```
    Search across all documents for mentions of specific vehicle models or product configurations. What issues or improvements are documented?
    ```

#### Combined Data Type Queries

16. **Telemetry + Maintenance Correlation**
    ```
    Correlate connected vehicle telemetry alerts with maintenance logs. Which vehicles had sensor alerts and what maintenance was performed? Show me a timeline chart.
    ```

17. **Product Config + Engineering Docs**
    ```
    Match product configurations with engineering documentation. Show me a table with product ID, configuration details, and related engineering document summaries.
    ```

18. **Comprehensive Vehicle Analysis**
    ```
    Provide a comprehensive analysis: Show connected vehicle telemetry data, extract product configuration details, search engineering docs for related specifications, and find any maintenance logs for those vehicles. Create a unified dashboard.
    ```

---

### Part 4: Cross-Functional Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent`  
**Use Cases:** End-to-end optimization, Strategic insights, Cross-functional analysis

#### Cross-Type Analysis Queries

1. **End-to-End Visibility Dashboard**
   ```
   Give me a comprehensive overview of our manufacturing operations. Show supplier risk scores, production quality metrics, inventory levels, connected vehicle performance, and any related maintenance or quality issues. Create tables and charts.
   ```

2. **Structured + Semi-Structured Analysis**
   ```
   Correlate production batch data with IoT sensor readings. Show me which production batches had sensor alerts and how that affected quality scores. Include charts showing the correlation.
   ```

3. **Structured + Unstructured Analysis**
   ```
   Match production batch numbers with quality reports. Create a table showing batch number, quality score from production data, and defect descriptions from quality reports. Add a trend chart.
   ```

4. **Semi-Structured + Unstructured Analysis**
   ```
   Correlate connected vehicle telemetry alerts with maintenance logs. Which vehicles had sensor alerts and what maintenance was performed? Show correlation charts.
   ```

5. **All Three Types Combined**
   ```
   Provide a comprehensive analysis: Show supplier risk scores, production quality for parts from those suppliers, connected vehicle performance for products using those parts, and any related maintenance or quality issues documented in reports. Create a unified dashboard with tables and visualizations.
   ```

6. **Strategic Recommendations Dashboard**
   ```
   Based on all available data, what are the top 3 strategic recommendations to improve our manufacturing operations? Include data from structured tables, semi-structured JSON, and unstructured documents. Present with supporting charts.
   ```

7. **Correlation Analysis Across All Data Types**
   ```
   Are there correlations between supplier performance, production quality, and product reliability? Analyze structured supplier data, production metrics, connected vehicle telemetry, and search quality reports and maintenance logs for patterns. Show correlation matrices and charts.
   ```

8. **Cost Optimization Analysis**
   ```
   Where are the biggest cost optimization opportunities across our supply chain, production, and product operations? Analyze structured cost data, extract cost information from supplier documents, and search communications for cost-related discussions. Create a comprehensive cost analysis table and charts.
   ```

9. **Sustainability Insights Dashboard**
   ```
   Analyze our energy consumption and supply chain practices. Extract energy data from production and IoT sensors, analyze supplier sustainability from documents, and search reports for sustainability initiatives. Create a sustainability dashboard with charts.
   ```

10. **Cross-Document Pattern Analysis**
    ```
    Search across all unstructured documents for mentions of "calibration" or "calibration issues". What types of documents mention this, what are the contexts, and how does this relate to production quality and IoT sensor data? Create a comprehensive analysis table.
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
