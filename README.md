# 🏭 Snowflake Intelligence Demo - Vehicle Manufacturing

<div align="center">

![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![Intelligence](https://img.shields.io/badge/Snowflake_Intelligence-FF6B6B?style=for-the-badge&logo=snowflake&logoColor=white)
![Manufacturing](https://img.shields.io/badge/Manufacturing-4ECDC4?style=for-the-badge)
![Automotive](https://img.shields.io/badge/Automotive-FFE66D?style=for-the-badge)

**Comprehensive demonstration of Snowflake Intelligence capabilities for Vehicle Manufacturing**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)](https://www.snowflake.com)
[![Python](https://img.shields.io/badge/SQL-FFD43B?style=flat&logo=postgresql&logoColor=blue)](https://www.snowflake.com)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Quick Start Guide](#-quick-start-guide)
- [Data Types Supported](#-data-types-supported)
- [Intelligence Agents](#-intelligence-agents)
- [File Structure](#-file-structure)
- [Usage Examples](#-usage-examples)
- [Prerequisites](#-prerequisites)
- [Setup Instructions](#-setup-instructions)
- [Verification](#-verification)
- [Demo Guide](#-demo-guide)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

This repository contains a comprehensive **Snowflake Intelligence** demonstration specifically designed for **Vehicle Manufacturing** use cases. The demo showcases how Snowflake Intelligence can break down data silos, provide real-time visibility, and enable scalable AI adoption across manufacturing operations.

### What is Snowflake Intelligence?

**Snowflake Intelligence** is Snowflake's integrated AI platform that enables organizations to:
- 🤖 **Build AI Agents** - Create specialized AI agents that understand your business domain
- 📊 **Semantic Views** - Transform raw data into business-friendly semantic models
- 🔍 **Cortex Search** - Enable semantic search over unstructured text data
- 💬 **Natural Language Queries** - Ask questions in plain English, get intelligent answers

### Demo Scope

This demo demonstrates:
- ✅ **Structured Data** - Traditional relational tables (supply chain, production, inventory)
- ✅ **Semi-Structured Data** - JSON/VARIANT columns (connected vehicles, IoT sensors, product configurations)
- ✅ **Unstructured Data** - Free-form text (maintenance logs, quality reports, engineering docs)
- ✅ **Cross-Type Analysis** - Correlating data across all three data types
- ✅ **Natural Language Processing** - Semantic search and intelligent document analysis
- ✅ **Data Visualization** - Tables, charts, and graphs generated from queries

---

## ✨ Key Features

### 🏗️ Unified Architecture
- **Single Semantic View** - `manufacturing_operations` consolidates all structured and semi-structured data
- **Unified Cortex Search** - `manufacturing_documents_search` enables semantic search across all unstructured documents
- **Intelligent Agents** - Four specialized agents for different manufacturing domains

### 📊 Comprehensive Data Coverage
- **50+ Records per Table** - Realistic vehicle manufacturing data (Toyota Camry, Honda Accord, Ford F-150, Tesla Model 3, BMW 3 Series, etc.)
- **Real-World Scenarios** - Data reflects actual manufacturing operations and challenges
- **Multiple Data Formats** - Structured, semi-structured (JSON), and unstructured (text)

### 🤖 Specialized Intelligence Agents
- **Supply Chain Agent** - Supplier risk, inventory management, logistics
- **Production Agent** - Quality management, efficiency optimization, predictive maintenance
- **Connected Products Agent** - Telematics, fleet management, vehicle diagnostics
- **Operations Agent** - Cross-functional insights and strategic recommendations

### 🔍 Advanced Capabilities
- **Natural Language Queries** - Ask questions in plain English
- **Semantic Search** - Find relevant information across unstructured documents
- **Data Visualization** - Automatic generation of tables, charts, and graphs
- **Cross-Type Analysis** - Correlate data across structured, semi-structured, and unstructured sources


### Intelligence Agents Location

All agents are created in the **`SNOWFLAKE_INTELLIGENCE.AGENTS`** schema:

- `SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent`
- `SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent`
- `SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent`
- `SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent`

---

## 🚀 Quick Start Guide

### Prerequisites

- ✅ Snowflake account with Intelligence enabled
- ✅ Role with `ACCOUNTADMIN` or equivalent privileges
- ✅ `SNOWFLAKE.CORTEX_USER` database role granted
- ✅ Access to create databases, schemas, tables, and agents

### Step-by-Step Setup

#### Step 1: Setup Infrastructure
```sql
-- Run the setup script to create databases, schemas, tables, and warehouse
@01_setup_intelligence.sql
```

**What this does:**
- Creates databases: `MANUFACTURING_DEMO` and `SNOWFLAKE_INTELLIGENCE`
- Creates schemas: `DATA`, `SEMANTIC` (in MANUFACTURING_DEMO), and `AGENTS` (in SNOWFLAKE_INTELLIGENCE)
- Creates all required table structures: 
  - **Structured tables:** `supply_chain`, `production`, `inventory`
  - **Semi-structured tables:** `connected_products`, `iot_sensors`, `supplier_documents`, `product_configurations` (with VARIANT columns for JSON data)
  - **Unstructured tables:** `maintenance_logs`, `quality_reports`, `supplier_communications`, `engineering_docs`, `incident_reports` (with TEXT columns)
- Creates warehouse: `INTEL_WH` (X-SMALL, auto-suspend 60s)
- Inserts minimal sample data (3-5 records per table) for initial setup
- Grants USAGE privileges on databases, schemas, and warehouse to PUBLIC role
- Grants SELECT privileges on all tables to PUBLIC role

#### Step 2: Load Vehicle Manufacturing Data
```sql
-- Load comprehensive vehicle manufacturing data (50+ records per table)
@01b_insert_vehicle_data.sql
```

**What this does:**
- Inserts 50+ realistic vehicle manufacturing records per table
- **Structured data:** Supply chain orders (Bosch, Continental, Magna, ZF, etc.), production batches, inventory levels
- **Semi-structured data:** Connected vehicle telemetry (VEH-001 through VEH-050+), IoT sensor readings, supplier documents (contracts, invoices, certificates), product configurations (PROD-001, PROD-002, etc.)
- **Unstructured data:** Maintenance logs, quality reports, supplier communications (emails, meeting notes, contracts), engineering docs (design specs, test plans, change requests), incident reports
- Uses realistic vehicle data: Toyota Camry, Honda Accord, Ford F-150, Tesla Model 3, BMW 3 Series, etc.
- Includes realistic supplier names, VINs, locations, telemetry data, and manufacturing scenarios

#### Step 3: Create Semantic Views & Cortex Search
```sql
-- Create unified semantic view for structured/semi-structured data
@02_create_semantic_views.sql

-- Create unified Cortex Search service for unstructured data
@02a_create_cortex_search.sql
```

**What this does:**
- **Semantic View (`02_create_semantic_views.sql`):** Creates unified `manufacturing_operations` semantic view in `MANUFACTURING_DEMO.SEMANTIC` schema
  - Combines all structured and semi-structured tables with PRIMARY KEY and UNIQUE constraints
  - Defines relationships between tables (supply chain ↔ inventory, production ↔ quality reports, production ↔ maintenance logs, etc.)
  - Creates dimensions: supplier names, risk categories (Low/Medium/High), delivery status (On Time/Early/In Progress/Pending), quality ratings (Excellent/Good/Acceptable/Needs Improvement), stock status (Reorder Needed/Low Stock/Adequate), alert status, driver names, etc.
  - Creates metrics: averages (delivery days, quality scores, sensor values), totals (quantity, cost, energy consumption), counts (orders, batches, telemetry records)
  - Grants SELECT privilege on semantic view to PUBLIC role

- **Cortex Search (`02a_create_cortex_search.sql`):** Creates unified `manufacturing_documents_search` Cortex Search service in `MANUFACTURING_DEMO.SEMANTIC` schema
  - Enables change tracking on all unstructured tables (required for Cortex Search)
  - Creates warehouse: `CORTEX_SEARCH_WH` (X-SMALL, auto-suspend 60s)
  - Combines all unstructured text data using UNION ALL: maintenance logs, quality reports, supplier communications, engineering docs, incident reports
  - Uses composite PRIMARY KEY (document_type, document_id) with attributes for filtering
  - Configures embedding model: `snowflake-arctic-embed-l-v2.0`
  - Sets TARGET_LAG to 1 day for refresh frequency
  - Grants USAGE privilege on Cortex Search service to PUBLIC role

#### Step 4: Create Intelligence Agents
```sql
-- Create specialized Intelligence agents
@03_create_agents.sql
```

**What this does:**
- Creates 4 specialized Intelligence agents in `SNOWFLAKE_INTELLIGENCE.AGENTS` schema:
  - `supply_chain_agent` - Supplier risk, inventory, logistics
  - `production_agent` - Quality, efficiency, maintenance
  - `connected_products_agent` - Telematics, fleet management
  - `manufacturing_operations_agent` - Cross-functional insights
- Configures each agent with FROM SPECIFICATION syntax (YAML format)
- Sets up tools: `Analyst1` (cortex_analyst_text_to_sql) for semantic view queries, `Search1` (cortex_search) for unstructured data search
- Configures tool_resources: semantic_view and cortex_search service references
- Sets orchestration model: `claude-4-sonnet` with budget constraints
- Defines agent instructions, sample questions, and profiles
- Grants USAGE privileges on all agents to PUBLIC role

**You're all set!** After running these 4 steps, you can start using the Intelligence agents in Snowflake UI.

---

## 📊 Data Types Supported

### Structured Data
Traditional relational tables with fixed schemas:

| Table | Description | Records |
|-------|-------------|---------|
| `supply_chain` | Supplier orders, deliveries, risk scores | 50+ |
| `production` | Production batches, quality scores, efficiency metrics | 50+ |
| `inventory` | Stock levels, reorder points, warehouse locations | 50+ |

### Semi-Structured Data
JSON/VARIANT columns with nested data:

| Table | Description | Records |
|-------|-------------|---------|
| `connected_products` | Vehicle telemetry, sensor data, trip metadata | 50+ |
| `iot_sensors` | IoT sensor readings, machine states | 50+ |
| `supplier_documents` | Supplier contracts, invoices, compliance docs | 50+ |
| `product_configurations` | Vehicle configurations, specifications, BOMs | 50+ |

### Unstructured Data
Free-form text stored in TEXT columns:

| Table | Description | Records |
|-------|-------------|---------|
| `maintenance_logs` | Maintenance activities, issues, actions taken | 50+ |
| `quality_reports` | Quality inspections, defects, root cause analysis | 50+ |
| `supplier_communications` | Emails, meeting notes, supplier discussions | 50+ |
| `engineering_docs` | Engineering specifications, design notes, test procedures | 50+ |
| `incident_reports` | Safety incidents, equipment failures, investigations | 50+ |

---

## 🤖 Intelligence Agents

### 1. Supply Chain Agent
**Location:** `SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent`

**Capabilities:**
- Supplier risk assessment and management
- Inventory optimization and visibility
- Demand forecasting and planning
- Transportation and logistics analysis
- Spend analytics and cost optimization

**Example Queries:**
- "What suppliers have high risk scores? Show me the details and suggest mitigation strategies."
- "Create a bar chart showing total spend by supplier region."
- "Search supplier communications for discussions about delivery delays."

### 2. Production Agent
**Location:** `SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent`

**Capabilities:**
- Shopfloor visibility and real-time monitoring
- Production efficiency and throughput optimization
- Product yield and quality management
- Predictive maintenance recommendations
- Energy consumption and sustainability analysis

**Example Queries:**
- "Show me production efficiency by production line with a line chart showing trends."
- "Extract IoT sensor data and show which machines have alerts."
- "Search maintenance logs for recurring issues and create a summary table."

### 3. Connected Products Agent
**Location:** `SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent`

**Capabilities:**
- Telematics and sensor data analysis
- Predictive maintenance for vehicles/products
- Fleet management and optimization
- Driver behavior analysis
- Electric vehicle optimization

**Example Queries:**
- "Extract sensor data from connected vehicles and show vehicles with alerts in a table."
- "Create a line chart of battery health over time for all vehicles."
- "Find engineering documents related to brake system design."

### 4. Manufacturing Operations Agent
**Location:** `SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent`

**Capabilities:**
- End-to-end visibility across all operations
- Cross-functional analysis and optimization
- Strategic recommendations
- Correlation analysis across data types
- Comprehensive dashboard generation

**Example Queries:**
- "Provide a comprehensive analysis combining supplier risk, production quality, and vehicle performance with supporting charts."
- "Correlate production batch data with IoT sensor readings and quality reports."
- "Create a unified dashboard showing all manufacturing operations metrics."

---

## 📁 File Structure

```
KPMG_event/
│
├── 01_setup_intelligence.sql          # Infrastructure setup (Intelligence object, database, schemas, tables)
├── 01b_insert_vehicle_data.sql        # Vehicle manufacturing data insertion (50+ records per table)
├── 02_create_semantic_views.sql       # Unified semantic view creation with relationships
├── 02a_create_cortex_search.sql       # Unified Cortex Search service for unstructured data
├── 03_create_agents.sql               # Intelligence agents creation with tools and configurations
│
├── README.md                           # This file - comprehensive guide
├── DEMO_GUIDE.md                       # Detailed demo guide with sample queries
├── reference.MD                        # Manufacturing use cases reference
│
└── .gitignore                          # Git ignore file
```

### File Descriptions

| File | Purpose | Key Components |
|------|---------|----------------|
| `01_setup_intelligence.sql` | Infrastructure setup | Creates databases (`MANUFACTURING_DEMO`, `SNOWFLAKE_INTELLIGENCE`), schemas (`DATA`, `SEMANTIC`, `AGENTS`), all table structures (11 tables: 3 structured, 4 semi-structured, 5 unstructured), warehouse (`INTEL_WH`), inserts minimal sample data, grants privileges |
| `01b_insert_vehicle_data.sql` | Data population | Inserts 50+ realistic vehicle manufacturing records per table covering structured (supply chain orders, production batches, inventory), semi-structured (connected vehicle telemetry, IoT sensors, supplier documents, product configs), and unstructured data (maintenance logs, quality reports, communications, engineering docs, incident reports) |
| `02_create_semantic_views.sql` | Semantic layer | Creates unified `manufacturing_operations` semantic view in `MANUFACTURING_DEMO.SEMANTIC` with table relationships, business-friendly dimensions (risk categories, quality ratings, stock status, alert status, etc.), and aggregate metrics (averages, totals, counts) across all structured and semi-structured tables |
| `02a_create_cortex_search.sql` | Search service | Enables change tracking on unstructured tables, creates `CORTEX_SEARCH_WH` warehouse, creates unified `manufacturing_documents_search` Cortex Search service in `MANUFACTURING_DEMO.SEMANTIC` combining all unstructured text data (maintenance logs, quality reports, supplier communications, engineering docs, incident reports) with embedding model `snowflake-arctic-embed-l-v2.0` |
| `03_create_agents.sql` | AI agents | Creates 4 specialized Intelligence agents in `SNOWFLAKE_INTELLIGENCE.AGENTS` schema (`supply_chain_agent`, `production_agent`, `connected_products_agent`, `manufacturing_operations_agent`) using FROM SPECIFICATION with YAML format, configures tools (Analyst1 for semantic view, Search1 for Cortex Search), tool_resources, orchestration model `claude-4-sonnet`, instructions, and grants USAGE privileges |
| `DEMO_GUIDE.md` | Demo guide | Comprehensive guide with 50+ simple natural language sample queries organized by agent and data type |

---

## 💡 Usage Examples

### Using Agents in Snowflake UI

1. **Open Snowflake UI** → Navigate to **Intelligence Chat**

2. **Select an Agent:**
   - `SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent`
   - `SNOWFLAKE_INTELLIGENCE.AGENTS.production_agent`
   - `SNOWFLAKE_INTELLIGENCE.AGENTS.connected_products_agent`
   - `SNOWFLAKE_INTELLIGENCE.AGENTS.manufacturing_operations_agent`

3. **Ask Questions in Natural Language:**

   **Structured Data Query:**
   ```
   Create a table showing supplier performance metrics including total orders, 
   average delivery time, total spend, and risk scores. Sort by risk score descending.
   ```

   **Semi-Structured Data Query:**
   ```
   Extract and analyze sensor data from connected vehicles. Show me a table with 
   vehicle ID, sensor types, sensor values, thresholds, and alert status for 
   vehicles with sensor values exceeding thresholds.
   ```

   **Unstructured Data Query (NLP):**
   ```
   Search maintenance logs for any mentions of bearing failures or bearing 
   replacements. What machines are affected and what actions were taken?
   ```

   **Combined Data Type Query:**
   ```
   Correlate production batch data with IoT sensor readings and quality reports. 
   Show me which production batches had sensor alerts and how that affected 
   quality scores. Include charts showing the correlation.
   ```

### Example Outputs

- **Tables** - Structured data tables with sorting, filtering, and aggregation
- **Charts** - Bar charts, line charts, pie charts, histograms, scatter plots
- **NLP Results** - Relevant document excerpts with semantic search
- **Combined Analysis** - Cross-type correlations and insights

---

## 🔧 Prerequisites

### Required Privileges

- `ACCOUNTADMIN` role or equivalent
- `CREATE INTELLIGENCE` privilege
- `CREATE DATABASE` privilege
- `CREATE SCHEMA` privilege
- `CREATE TABLE` privilege
- `CREATE SEMANTIC VIEW` privilege
- `CREATE CORTEX SEARCH SERVICE` privilege
- `CREATE AGENT` privilege

### Required Database Roles

- `SNOWFLAKE.CORTEX_USER` - Required for Cortex Search and Intelligence features

### Grant Required Roles

```sql
-- Grant CORTEX_USER role to your role
GRANT DATABASE ROLE SNOWFLAKE.CORTEX_USER TO ROLE <your_role>;
```

---

## 📝 Setup Instructions

### Complete Setup Process

1. **Connect to Snowflake** using your preferred SQL client or Snowsight

2. **Run Setup Scripts in Order:**
   ```sql
   -- Step 1: Infrastructure
   @01_setup_intelligence.sql
   
   -- Step 2: Data
   @01b_insert_vehicle_data.sql
   
   -- Step 3: Semantic Layer & Search
   @02_create_semantic_views.sql
   @02a_create_cortex_search.sql
   
   -- Step 4: Agents
   @03_create_agents.sql
   ```

3. **Wait for Cortex Search Indexing:**
   - Cortex Search service indexing may take a few minutes
   - Check status: `DESCRIBE CORTEX SEARCH SERVICE MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search;`
   - Wait until `INDEXING_STATE` shows `RUNNING`

4. **Start Using Agents:**
   - Navigate to Intelligence Chat in Snowflake UI
   - Select an agent from `SNOWFLAKE_INTELLIGENCE.AGENTS` schema
   - Start asking questions in natural language!

---

## ✅ Verification

### Manual Verification Steps

After running all setup scripts, verify your setup with these commands:

1. **Check Database and Schemas:**
   ```sql
   SHOW DATABASES LIKE 'MANUFACTURING_DEMO';
   SHOW SCHEMAS IN DATABASE MANUFACTURING_DEMO;
   SHOW DATABASES LIKE 'SNOWFLAKE_INTELLIGENCE';
   SHOW SCHEMAS IN DATABASE SNOWFLAKE_INTELLIGENCE;
   ```

3. **Check Tables:**
   ```sql
   SHOW TABLES IN SCHEMA MANUFACTURING_DEMO.DATA;
   SELECT COUNT(*) FROM MANUFACTURING_DEMO.DATA.supply_chain;
   SELECT COUNT(*) FROM MANUFACTURING_DEMO.DATA.production;
   SELECT COUNT(*) FROM MANUFACTURING_DEMO.DATA.inventory;
   ```

4. **Check Semantic View:**
   ```sql
   SHOW SEMANTIC VIEWS IN SCHEMA MANUFACTURING_DEMO.SEMANTIC;
   ```

5. **Check Cortex Search Service:**
   ```sql
   DESCRIBE CORTEX SEARCH SERVICE MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search;
   -- Verify INDEXING_STATE shows 'RUNNING'
   ```

6. **Check Agents:**
   ```sql
   SHOW AGENTS IN SCHEMA SNOWFLAKE_INTELLIGENCE.AGENTS;
   ```

### Expected Results

- ✅ Database `MANUFACTURING_DEMO` with schemas `DATA` and `SEMANTIC`
- ✅ Database `SNOWFLAKE_INTELLIGENCE` with schema `AGENTS`
- ✅ All 11 tables created (3 structured, 4 semi-structured, 5 unstructured)
- ✅ All tables populated with 50+ records each (after running `01b_insert_vehicle_data.sql`)
- ✅ Semantic view `manufacturing_operations` created in `MANUFACTURING_DEMO.SEMANTIC` with relationships, dimensions, and metrics
- ✅ Cortex Search service `manufacturing_documents_search` created in `MANUFACTURING_DEMO.SEMANTIC` and indexed (`INDEXING_STATE = 'RUNNING'`)
- ✅ 4 agents created in `SNOWFLAKE_INTELLIGENCE.AGENTS` schema with proper tool configurations (Analyst1, Search1)

---

## 📖 Demo Guide

For comprehensive demo guidance, sample queries, and presentation tips, see **[DEMO_GUIDE.md](DEMO_GUIDE.md)**.

The demo guide includes:
- ✅ 50+ sample queries organized by agent
- ✅ Queries for structured, semi-structured, and unstructured data
- ✅ Examples generating tables, charts, and graphs
- ✅ NLP search examples
- ✅ Cross-type analysis queries
- ✅ Demo flow recommendations
- ✅ Troubleshooting guide

---

## 🐛 Troubleshooting

### Common Issues

#### Issue: Agents don't have enough context
**Solution:**
- Ensure semantic view is created: `SHOW SEMANTIC VIEWS IN SCHEMA MANUFACTURING_DEMO.SEMANTIC;`
- Ensure Cortex Search service is indexed: `DESCRIBE CORTEX SEARCH SERVICE manufacturing_documents_search;`
- Check agent tool_resources configuration in `03_create_agents.sql`
- Verify agents have USAGE privileges

#### Issue: Queries return generic responses
**Solution:**
- Make queries more specific to Vehicle Manufacturing domain
- Reference specific data elements (suppliers, parts, production lines, vehicle models)
- Ask for analysis rather than just data retrieval
- Specify if you want tables or charts

#### Issue: Performance is slow
**Solution:**
- Ensure warehouses are running: `SHOW WAREHOUSES;`
- Check Cortex Search service indexing state
- Verify semantic view is optimized
- Consider using smaller datasets for demo

#### Issue: Cortex Search not working
**Solution:**
- Verify `CORTEX_SEARCH_WH` warehouse exists and is running
- Check `INDEXING_STATE` of the service
- Ensure `SNOWFLAKE.CORTEX_USER` role is granted
- Wait for initial indexing to complete (may take several minutes)

---

## 🤝 Contributing

This is a demonstration repository. For questions or suggestions:

1. Review the code and documentation
2. Test the setup in your Snowflake environment
3. Provide feedback or suggestions

---

## 📄 License

This demonstration is provided as-is for educational and demonstration purposes.

---


![Snowflake](https://img.shields.io/badge/Powered_by-Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)

</div>
