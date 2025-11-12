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

## Data Types Exploration Guide

This demo showcases three types of data:
- **Structured Data**: Traditional relational tables (supply_chain, production, inventory)
- **Semi-structured Data**: JSON/VARIANT columns (connected_products, iot_sensors, supplier_documents, product_configurations)
- **Unstructured Data**: Free-form text (maintenance_logs, quality_reports, supplier_communications, engineering_docs, incident_reports)

---

## Structured Data Exploration

### Overview
Structured data is stored in traditional relational tables with fixed schemas. Examples include supply chain orders, production batches, and inventory levels.

### Example Queries (Generate Tables)

#### 1. Supplier Performance Table
**Query:**
```
Create a table showing supplier performance metrics including total orders, average delivery time, total spend, and risk scores. Sort by risk score descending.
```

**Expected Output:** Table with columns: Supplier Name, Total Orders, Avg Delivery Days, Total Spend, Risk Score

#### 2. Production Efficiency by Line
**Query:**
```
Show me a table comparing production efficiency across all production lines. Include columns for production line ID, total units produced, average quality score, total downtime minutes, and efficiency percentage.
```

**Expected Output:** Table with production metrics by line

#### 3. Inventory Status Dashboard
**Query:**
```
Generate a comprehensive inventory status table showing part numbers, current stock levels, reorder levels, reorder quantities, stock status (Reorder Needed/Low Stock/Adequate), and warehouse locations.
```

**Expected Output:** Table with inventory details

#### 4. Supply Chain Risk Analysis Table
**Query:**
```
Create a detailed table of suppliers with high risk scores (above 0.4). Include supplier name, region, risk category, number of orders, total quantity ordered, and average unit cost.
```

**Expected Output:** Risk analysis table

#### 5. Production Batch Quality Report
**Query:**
```
Show me a table of all production batches with their quality scores, quantity produced, production duration, energy consumption, and quality rating (Excellent/Good/Acceptable/Needs Improvement).
```

**Expected Output:** Quality report table

### Example Queries (Generate Graphs/Charts)

#### 1. Supplier Spend by Region (Bar Chart)
**Query:**
```
Create a bar chart showing total spend by supplier region. Use different colors for each region.
```

**Expected Output:** Bar chart visualization

#### 2. Production Efficiency Trend (Line Chart)
**Query:**
```
Show me a line chart of production efficiency over time by production line. Include a trend line.
```

**Expected Output:** Time series line chart

#### 3. Inventory Stock Levels Distribution (Pie Chart)
**Query:**
```
Create a pie chart showing the distribution of parts by stock status: Reorder Needed, Low Stock, and Adequate Stock.
```

**Expected Output:** Pie chart

#### 4. Quality Scores Distribution (Histogram)
**Query:**
```
Generate a histogram showing the distribution of quality scores across all production batches.
```

**Expected Output:** Histogram chart

#### 5. Supplier Risk vs Spend (Scatter Plot)
**Query:**
```
Create a scatter plot with risk score on x-axis and total spend on y-axis. Color code by region.
```

**Expected Output:** Scatter plot

---

## Semi-Structured Data Exploration

### Overview
Semi-structured data is stored in VARIANT columns using JSON format. This includes connected vehicle telemetry, IoT sensor readings, supplier documents, and product configurations.

### Example Queries (JSON/VARIANT Extraction)

#### 1. Connected Vehicle Sensor Analysis
**Query:**
```
Extract and analyze sensor data from connected vehicles. Show me a table with vehicle ID, sensor types, sensor values, thresholds, and alert status for vehicles with sensor values exceeding thresholds.
```

**Expected Output:** Table with extracted JSON sensor data

#### 2. IoT Sensor Readings Table
**Query:**
```
Create a table from IoT sensor data showing sensor ID, machine ID, primary sensor name, sensor status, machine state, and timestamp. Filter for sensors with warnings or alerts.
```

**Expected Output:** Table with IoT sensor details

#### 3. Product Configuration Comparison
**Query:**
```
Extract product configuration details and create a comparison table showing product ID, model type, engine type, transmission, dimensions (length, width, weight), and max speed for all product versions.
```

**Expected Output:** Product configuration comparison table

#### 4. Supplier Document Analysis
**Query:**
```
Extract data from supplier documents and show me a table with document ID, supplier ID, document type, document title, category, currency, payment terms, total value, and ISO standard compliance.
```

**Expected Output:** Supplier document details table

#### 5. Connected Vehicle Trip Analysis
**Query:**
```
Extract trip metadata from connected vehicles and create a table showing vehicle ID, trip ID, route, distance in miles, duration in minutes, fuel efficiency, number of stops, and driver name.
```

**Expected Output:** Trip analysis table

### Example Queries (Generate Graphs from Semi-Structured Data)

#### 1. Sensor Value Distribution (Box Plot)
**Query:**
```
Create a box plot showing the distribution of primary sensor values by sensor type from connected vehicles.
```

**Expected Output:** Box plot chart

#### 2. Battery Health Trend (Line Chart)
**Query:**
```
Show me a line chart of battery health over time for all connected vehicles. Group by vehicle ID.
```

**Expected Output:** Time series line chart

#### 3. Product Configuration Distribution (Bar Chart)
**Query:**
```
Create a bar chart showing the count of products by engine type and transmission combination.
```

**Expected Output:** Grouped bar chart

#### 4. IoT Sensor Status by Machine (Stacked Bar Chart)
**Query:**
```
Generate a stacked bar chart showing sensor status distribution (normal/warning/alert) by machine ID.
```

**Expected Output:** Stacked bar chart

#### 5. Fuel Efficiency by Route (Scatter Plot)
**Query:**
```
Create a scatter plot showing fuel efficiency vs distance for different routes from connected vehicle trip data.
```

**Expected Output:** Scatter plot

---

## Unstructured Data Exploration (NLP Questions)

### Overview
Unstructured data consists of free-form text stored in TEXT columns. Cortex Search enables semantic search over this data using natural language queries.

### Example NLP Queries

#### 1. Maintenance Log Search
**Query:**
```
Search maintenance logs for any mentions of bearing failures or bearing replacements. What machines are affected and what actions were taken?
```

**Expected Output:** Relevant maintenance log entries with context

#### 2. Quality Issue Investigation
**Query:**
```
Find quality reports that mention paint defects or surface finish issues. What were the root causes and corrective actions?
```

**Expected Output:** Quality report excerpts with analysis

#### 3. Supplier Communication Analysis
**Query:**
```
Search supplier communications for discussions about delivery delays or supply chain disruptions. Summarize the key issues and resolutions.
```

**Expected Output:** Communication summaries

#### 4. Engineering Documentation Search
**Query:**
```
Find engineering documents related to brake system design or brake component specifications. What are the key design parameters?
```

**Expected Output:** Engineering document excerpts

#### 5. Incident Report Analysis
**Query:**
```
Search incident reports for safety incidents or equipment failures. What were the common causes and preventive measures recommended?
```

**Expected Output:** Incident analysis

#### 6. Maintenance Pattern Recognition
**Query:**
```
Analyze maintenance logs to identify recurring issues or patterns. Which machines have the most frequent maintenance needs?
```

**Expected Output:** Pattern analysis

#### 7. Quality Trend Analysis
**Query:**
```
Search quality reports for trends in defect types over time. Are there any emerging quality concerns?
```

**Expected Output:** Trend analysis

#### 8. Supplier Performance from Communications
**Query:**
```
Based on supplier communications, what are the main concerns or issues raised? Which suppliers have the most communication activity?
```

**Expected Output:** Supplier communication insights

#### 9. Engineering Change History
**Query:**
```
Find engineering documents that describe design changes or modifications. What products were affected and why?
```

**Expected Output:** Change history summary

#### 10. Cross-Document Analysis
**Query:**
```
Search across all documents for mentions of "calibration" or "calibration issues". What types of documents mention this and what are the contexts?
```

**Expected Output:** Cross-document analysis

### Example Queries (Generate Tables from Unstructured Data)

#### 1. Maintenance Summary Table
**Query:**
```
Create a table summarizing maintenance activities by extracting key information from maintenance logs. Include machine ID, maintenance date, maintenance type, issues found, and actions taken.
```

**Expected Output:** Maintenance summary table

#### 2. Quality Defect Analysis Table
**Query:**
```
Extract quality defect information from quality reports and create a table showing batch number, defect description, severity, root cause, and corrective actions.
```

**Expected Output:** Quality defect table

#### 3. Supplier Communication Summary Table
**Query:**
```
Generate a table from supplier communications showing supplier ID, communication date, type, subject, and key action items mentioned.
```

**Expected Output:** Communication summary table

---

## Combined Data Type Queries

### Cross-Type Analysis Examples

#### 1. Structured + Semi-Structured
**Query:**
```
Correlate production batch data with IoT sensor readings. Show me which production batches had sensor alerts and how that affected quality scores.
```

**Expected Output:** Combined analysis table/graph

#### 2. Structured + Unstructured
**Query:**
```
Match production batch numbers with quality reports. Create a table showing batch number, quality score from production data, and defect descriptions from quality reports.
```

**Expected Output:** Combined data table

#### 3. Semi-Structured + Unstructured
**Query:**
```
Correlate connected vehicle telemetry alerts with maintenance logs. Which vehicles had sensor alerts and what maintenance was performed?
```

**Expected Output:** Correlation analysis

#### 4. All Three Types Combined
**Query:**
```
Provide a comprehensive analysis: Show supplier risk scores, production quality for parts from those suppliers, connected vehicle performance for products using those parts, and any related maintenance or quality issues documented in reports.
```

**Expected Output:** Comprehensive cross-type analysis

---

## Demo Structure

### Part 1: Supply Chain Intelligence
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent`  
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
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent`  
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
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent`  
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
**Agent:** `SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent`  
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

