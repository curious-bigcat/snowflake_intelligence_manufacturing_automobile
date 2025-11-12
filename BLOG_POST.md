---
title: "Building an AI-Powered Manufacturing Intelligence Demo with Snowflake Intelligence"
published: false
description: "Learn how to build a comprehensive manufacturing intelligence demo using Snowflake Intelligence, featuring structured, semi-structured, and unstructured data with AI agents"
tags: snowflake, ai, manufacturing, data-engineering, sql, machine-learning, analytics
cover_image: https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=1200
---

# Building an AI-Powered Manufacturing Intelligence Demo with Snowflake Intelligence

Manufacturing operations generate massive amounts of data across multiple formats—structured relational data, semi-structured JSON from IoT sensors, and unstructured text from maintenance logs and quality reports. Making sense of this data to drive intelligent decisions has traditionally required complex ETL pipelines, multiple tools, and significant engineering effort.

**Snowflake Intelligence** changes this paradigm by enabling you to build AI-powered applications directly on your data, without complex infrastructure. In this blog post, I'll walk you through building a comprehensive manufacturing intelligence demo that showcases Snowflake's capabilities with structured, semi-structured, and unstructured data.

## 🎯 What We're Building

We'll create a **vehicle manufacturing intelligence system** that:

- **Ingests multiple data types**: Structured supply chain data, semi-structured IoT sensor telemetry, and unstructured maintenance logs
- **Creates semantic views**: Business-friendly views that abstract away complex joins and relationships
- **Enables semantic search**: Full-text search across unstructured documents using Cortex Search
- **Deploys AI agents**: Specialized agents that answer natural language questions about manufacturing operations

## 🏗️ Architecture Overview

Our demo architecture consists of:

```
┌─────────────────────────────────────────────────────────────┐
│                    Snowflake Intelligence                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────┐      ┌──────────────────────────┐   │
│  │  Structured Data  │      │  Semi-Structured Data   │   │
│  │  - Supply Chain   │      │  - Connected Vehicles   │   │
│  │  - Production     │      │  - IoT Sensors         │   │
│  │  - Inventory     │      │  - Supplier Documents   │   │
│  └────────┬──────────┘      └──────────┬───────────────┘   │
│           │                            │                   │
│           └────────────┬───────────────┘                   │
│                        │                                   │
│           ┌────────────▼───────────────┐                   │
│           │  Unified Semantic View     │                   │
│           │  manufacturing_operations  │                   │
│           └────────────┬───────────────┘                   │
│                        │                                   │
│  ┌─────────────────────▼─────────────────────┐           │
│  │         Intelligence Agents                 │           │
│  │  - Supply Chain Agent                       │           │
│  │  - Production Agent                         │           │
│  │  - Connected Products Agent                 │           │
│  │  - Manufacturing Operations Agent            │           │
│  └─────────────────────┬───────────────────────┘           │
│                        │                                   │
│  ┌─────────────────────▼─────────────────────┐           │
│  │      Cortex Search Service                  │           │
│  │  manufacturing_documents_search             │           │
│  │  (Unstructured Data: Logs, Reports, Docs)  │           │
│  └─────────────────────────────────────────────┘           │
└─────────────────────────────────────────────────────────────┘
```

## 📊 Data Types in Our Demo

### Structured Data (3 Tables)

Traditional relational tables with fixed schemas:

- **`supply_chain`**: Supplier orders, delivery dates, risk scores, regions
- **`production`**: Production batches, quality scores, energy consumption, downtime
- **`inventory`**: Warehouse stock levels, reorder points, part numbers

### Semi-Structured Data (4 Tables)

JSON/VARIANT columns with nested data:

- **`connected_products`**: Vehicle telemetry with nested sensor arrays, diagnostics, location data, driver info, trip metadata
- **`iot_sensors`**: Manufacturing sensor readings with machine state, calibration data
- **`supplier_documents`**: Document metadata, extracted fields, compliance information
- **`product_configurations`**: Product specs, BOM structures, configuration options

### Unstructured Data (5 Tables)

Free-form text documents:

- **`maintenance_logs`**: Detailed maintenance notes, issues found, actions taken
- **`quality_reports`**: Inspection notes, defect descriptions, root cause analysis
- **`supplier_communications`**: Emails, meeting notes, contracts
- **`engineering_docs`**: Design specifications, test procedures, change history
- **`incident_reports`**: Incident descriptions, witness statements, investigation findings

## 🚀 Setup Guide

### Prerequisites

- Snowflake account with Intelligence enabled
- `ACCOUNTADMIN` role or equivalent privileges
- `SNOWFLAKE.CORTEX_USER` database role granted

### Step 1: Create Infrastructure

First, let's set up the databases, schemas, and tables:

```sql
-- Create databases and schemas
CREATE DATABASE IF NOT EXISTS MANUFACTURING_DEMO;
CREATE SCHEMA IF NOT EXISTS MANUFACTURING_DEMO.DATA;
CREATE SCHEMA IF NOT EXISTS MANUFACTURING_DEMO.SEMANTIC;

CREATE DATABASE IF NOT EXISTS SNOWFLAKE_INTELLIGENCE;
CREATE SCHEMA IF NOT EXISTS SNOWFLAKE_INTELLIGENCE.AGENTS;

-- Create warehouse
CREATE WAREHOUSE IF NOT EXISTS INTEL_WH
  WITH WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;
```

### Step 2: Create Tables

Let's create our tables. Here's an example of each data type:

**Structured Table Example:**
```sql
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
```

**Semi-Structured Table Example:**
```sql
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.connected_products (
    vehicle_id VARCHAR,
    product_id VARCHAR,
    telemetry_timestamp TIMESTAMP_NTZ,
    telemetry_data VARIANT,  -- JSON: sensors, diagnostics, error codes
    location_data VARIANT,   -- JSON: lat, lon, address, geofence
    driver_info VARIANT,     -- JSON: driver details, behavior metrics
    trip_metadata VARIANT,   -- JSON: route, distance, fuel efficiency
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
```

**Unstructured Table Example:**
```sql
CREATE OR REPLACE TABLE MANUFACTURING_DEMO.DATA.maintenance_logs (
    log_id VARCHAR,
    machine_id VARCHAR,
    maintenance_date DATE,
    technician_id VARCHAR,
    maintenance_type VARCHAR,
    log_entry TEXT,           -- Free-form text
    issues_found TEXT,
    actions_taken TEXT,
    recommendations TEXT,
    parts_used TEXT,
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
```

### Step 3: Insert Data

We'll insert realistic vehicle manufacturing data. Here's an example of inserting semi-structured data:

```sql
INSERT INTO MANUFACTURING_DEMO.DATA.connected_products 
SELECT 
    '1HGBH41JXMN109186' AS vehicle_id,
    'VEH-SEDAN-CAMRY-2024' AS product_id,
    '2024-01-15 08:30:00'::TIMESTAMP_NTZ AS telemetry_timestamp,
    PARSE_JSON('{
        "sensors": [
            {"type": "engine_temperature", "value": 88.5, "unit": "celsius", "threshold": 95},
            {"type": "oil_pressure", "value": 42.3, "unit": "psi", "threshold": 50}
        ],
        "diagnostics": {
            "engine_status": "normal",
            "battery_health": 94,
            "error_codes": []
        }
    }') AS telemetry_data,
    PARSE_JSON('{
        "latitude": 42.3314,
        "longitude": -83.0458,
        "address": "Detroit, MI",
        "geofence": "Michigan_Region",
        "speed": 45
    }') AS location_data,
    PARSE_JSON('{
        "driver_id": "DRV-JOHN-SMITH-001",
        "name": "John Smith",
        "behavior_score": 8.7,
        "fatigue_risk": "low"
    }') AS driver_info,
    PARSE_JSON('{
        "trip_id": "TRIP-2024-001-001",
        "route": "I-94 Eastbound",
        "distance_miles": 125.3,
        "fuel_efficiency": 32.5
    }') AS trip_metadata,
    CURRENT_TIMESTAMP() AS created_at;
```

### Step 4: Create Unified Semantic View

The semantic view combines all our tables with business-friendly dimensions and metrics:

```sql
CREATE OR REPLACE SEMANTIC VIEW MANUFACTURING_DEMO.SEMANTIC.manufacturing_operations
TABLES (
  -- Structured Data Tables
  sc AS MANUFACTURING_DEMO.DATA.supply_chain 
    PRIMARY KEY (supplier_id, part_number, order_date),
  prod AS MANUFACTURING_DEMO.DATA.production 
    PRIMARY KEY (production_line_id, machine_id, batch_number, start_time),
  inv AS MANUFACTURING_DEMO.DATA.inventory 
    PRIMARY KEY (warehouse_id, part_number) UNIQUE (part_number),
  
  -- Semi-structured Data Tables
  cp AS MANUFACTURING_DEMO.DATA.connected_products 
    PRIMARY KEY (vehicle_id, telemetry_timestamp),
  iot AS MANUFACTURING_DEMO.DATA.iot_sensors 
    PRIMARY KEY (sensor_id, timestamp),
  -- ... more tables
)
RELATIONSHIPS (
  sc_inventory AS sc(part_number) REFERENCES inv(part_number),
  prod_quality_reports AS prod(batch_number) REFERENCES qr(batch_number),
  prod_maintenance AS prod(machine_id) REFERENCES ml(machine_id)
)
DIMENSIONS (
  -- Supply Chain Dimensions
  sc.supplier_id AS sc.supplier_id,
  sc.supplier_name AS sc.supplier_name,
  sc.risk_category AS CASE 
    WHEN sc.risk_score < 0.2 THEN 'Low Risk'
    WHEN sc.risk_score < 0.4 THEN 'Medium Risk'
    ELSE 'High Risk'
  END,
  
  -- Production Dimensions
  prod.quality_rating AS CASE 
    WHEN prod.quality_score >= 0.95 THEN 'Excellent'
    WHEN prod.quality_score >= 0.90 THEN 'Good'
    WHEN prod.quality_score >= 0.85 THEN 'Acceptable'
    ELSE 'Needs Improvement'
  END,
  
  -- Connected Products Dimensions (from JSON)
  cp.engine_status AS cp.telemetry_data:diagnostics:engine_status::STRING,
  cp.driver_name AS cp.driver_info:name::STRING,
  cp.alert_status AS CASE 
    WHEN cp.telemetry_data:sensors[0]:type::STRING = 'temperature' 
         AND cp.telemetry_data:sensors[0]:value::NUMBER > 90 
    THEN 'High Temperature Alert'
    ELSE 'Normal'
  END
)
METRICS (
  sc.avg_delivery_days AS AVG(DATEDIFF(day, sc.order_date, sc.delivery_date)),
  sc.total_cost AS SUM(sc.quantity * sc.unit_cost),
  prod.avg_quality_score AS AVG(prod.quality_score),
  prod.total_quantity_produced AS SUM(prod.quantity_produced),
  cp.avg_battery_health AS AVG(cp.telemetry_data:diagnostics:battery_health::NUMBER),
  cp.total_trip_distance_miles AS SUM(cp.trip_metadata:distance_miles::NUMBER)
);
```

**Key Benefits:**
- ✅ Business-friendly dimensions (risk categories, quality ratings) instead of raw scores
- ✅ Automatic relationships enable cross-table queries
- ✅ Aggregate metrics pre-calculated for performance
- ✅ JSON extraction handled transparently

### Step 5: Create Cortex Search Service

For unstructured data, we create a unified Cortex Search service:

```sql
-- Enable change tracking (required for Cortex Search)
ALTER TABLE MANUFACTURING_DEMO.DATA.maintenance_logs SET CHANGE_TRACKING = TRUE;
ALTER TABLE MANUFACTURING_DEMO.DATA.quality_reports SET CHANGE_TRACKING = TRUE;
-- ... enable for all unstructured tables

-- Create unified Cortex Search service
CREATE OR REPLACE CORTEX SEARCH SERVICE 
  MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search
  ON document_text
  PRIMARY KEY (document_type, document_id)
  ATTRIBUTES document_type, document_id, source_table, related_id, 
             document_date, author, category, severity, status
  WAREHOUSE = CORTEX_SEARCH_WH
  TARGET_LAG = '1 day'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
  AS (
    -- Maintenance Logs
    SELECT
        'MAINTENANCE_LOG' AS document_type,
        log_id AS document_id,
        'maintenance_logs' AS source_table,
        machine_id AS related_id,
        maintenance_date AS document_date,
        technician_id AS author,
        maintenance_type AS category,
        CONCAT_WS(' ',
            'Maintenance Log: ' || log_id,
            'Machine: ' || machine_id,
            log_entry,
            issues_found,
            actions_taken,
            recommendations
        ) AS document_text
    FROM MANUFACTURING_DEMO.DATA.maintenance_logs
    
    UNION ALL
    
    -- Quality Reports
    SELECT
        'QUALITY_REPORT' AS document_type,
        report_id AS document_id,
        'quality_reports' AS source_table,
        batch_number AS related_id,
        report_date AS document_date,
        inspector_id AS author,
        CONCAT_WS(' ',
            'Quality Report: ' || report_id,
            'Batch: ' || batch_number,
            inspection_notes,
            defect_description,
            root_cause_analysis,
            corrective_actions
        ) AS document_text
    FROM MANUFACTURING_DEMO.DATA.quality_reports
    
    -- ... more UNION ALL clauses for other unstructured tables
);
```

**Key Features:**
- 🔍 **Hybrid search**: Combines vector (semantic) and keyword search
- 📊 **Unified interface**: Search across all document types in one query
- ⚡ **Low latency**: Optimized for real-time search
- 🔄 **Auto-refresh**: Updates automatically as source data changes

### Step 6: Create Intelligence Agents

Now for the exciting part—creating AI agents that can answer natural language questions:

```sql
CREATE OR REPLACE AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.supply_chain_agent
  COMMENT = 'Supply Chain Intelligence Agent'
  PROFILE = '{"display_name": "Supply Chain Agent", "color": "blue"}'
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
      You are a Supply Chain Intelligence Agent specializing in manufacturing.
      Provide specific, data-driven insights about suppliers, inventory, and logistics.
      Highlight risks and opportunities with actionable recommendations.

    orchestration: |
      Use Analyst1 for supply chain data queries.
      Use Search1 for searching supplier documents and communications.

  tools:
    - tool_spec:
        type: "cortex_analyst_text_to_sql"
        name: "Analyst1"
        description: "Converts natural language to SQL queries"
    - tool_spec:
        type: "cortex_search"
        name: "Search1"
        description: "Searches supplier documents and communications"

  tool_resources:
    Analyst1:
      semantic_view: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_operations"
    Search1:
      name: "MANUFACTURING_DEMO.SEMANTIC.manufacturing_documents_search"
      max_results: "10"
      title_column: "document_text"
      id_column: "document_id"
  $$;
```

We create four specialized agents:
1. **Supply Chain Agent**: Supplier risk, inventory, logistics
2. **Production Agent**: Quality, efficiency, maintenance, IoT sensors
3. **Connected Products Agent**: Telematics, fleet management, vehicle diagnostics
4. **Manufacturing Operations Agent**: Cross-functional insights

## 💬 Using the Agents

Once deployed, you can ask natural language questions:

### Supply Chain Queries

**Question:** "Which suppliers have high risk scores?"

**Agent Response:** 
> "I found 3 suppliers with high risk scores (>0.4):
> - SUP004 (ZF Friedrichshafen): Risk score 0.20, 8-Speed Transmission
> - SUP005 (Aisin Seiki): Risk score 0.22, CVT Transmission
> - SUP017 (Benteler Automotive): Risk score 0.22, Chassis Frame Assembly
> 
> Recommendations:
> - Diversify suppliers for critical components
> - Increase monitoring frequency for high-risk suppliers
> - Consider backup suppliers for SUP004 and SUP005"

### Production Queries

**Question:** "Show me production efficiency by assembly line"

**Agent Response:**
> "Production efficiency metrics by assembly line:
> 
> | Line | Avg Units/Hour | Avg Quality Score | Total Batches |
> |------|----------------|-------------------|---------------|
> | ASSY-LINE-01 | 15.2 | 0.96 | 10 |
> | ASSY-LINE-02 | 12.1 | 0.95 | 10 |
> | ASSY-LINE-04 | 11.8 | 0.97 | 10 |
> 
> Insights:
> - ASSY-LINE-01 has highest throughput but quality could improve
> - ASSY-LINE-04 (EV line) has best quality but lower throughput
> - Consider cross-training operators to balance efficiency"

### Connected Products Queries

**Question:** "Are there any vehicles with sensor alerts?"

**Agent Response:**
> "Found 2 vehicles with alerts:
> 
> 1. **Vehicle 1HGBH41JXMN109187** (Toyota Camry)
>    - Alert: High Temperature (92.1°C, threshold: 95°C)
>    - Location: Chicago, IL
>    - Recommendation: Schedule maintenance check
> 
> 2. **Vehicle 1HGBH41JXMN109192** (Toyota RAV4)
>    - Alert: Low Tire Pressure (34 PSI, threshold: 28 PSI)
>    - Location: Dallas, TX
>    - Recommendation: Check tire pressure, inspect for leaks
> 
> Both vehicles are still within safe operating ranges but should be monitored."

### Cross-Functional Queries

**Question:** "What's the correlation between supplier risk and production quality?"

**Agent Response:**
> "Analysis of supplier risk vs production quality:
> 
> **Key Findings:**
> - Suppliers with risk scores <0.15: Average quality score 0.97
> - Suppliers with risk scores 0.15-0.20: Average quality score 0.95
> - Suppliers with risk scores >0.20: Average quality score 0.93
> 
> **Correlation:** Moderate negative correlation (-0.42)
> 
> **Recommendations:**
> 1. Prioritize low-risk suppliers for critical components
> 2. Implement additional quality checks for high-risk suppliers
> 3. Review supplier qualification process for new suppliers"

## 🔍 Searching Unstructured Data

The Cortex Search service enables semantic search across all documents:

**Question:** "Find maintenance logs about bearing replacement"

**Search Results:**
> 1. **LOG-003** - Machine C (Predictive Maintenance)
>    - Issue: Bearing wear detected in main drive assembly
>    - Action: Replaced main drive bearing assembly (Part #BRG-45678)
>    - Date: 2024-01-15
> 
> 2. **LOG-001** - Machine A (Preventive Maintenance)
>    - Issue: Minor wear detected on belt drive system
>    - Action: Adjusted belt tension, scheduled bearing replacement
>    - Date: 2024-01-10

The search understands semantic meaning, not just keywords!

## 📈 Key Benefits

### 1. **Unified Data Access**
- Single semantic view abstracts away complex joins
- Agents can query across all data types seamlessly
- Relationships automatically handled

### 2. **Natural Language Interface**
- No SQL knowledge required for end users
- Agents understand business context
- Responses include actionable insights

### 3. **Real-Time Intelligence**
- Semantic views update automatically
- Cortex Search refreshes daily
- Agents always use latest data

### 4. **Cost-Effective**
- No separate vector database needed
- No complex ETL pipelines
- Pay only for compute used

## 🎓 Learning Resources

- [Snowflake Intelligence Documentation](https://docs.snowflake.com/en/user-guide/intelligence-overview)
- [Semantic Views Guide](https://docs.snowflake.com/en/user-guide/semantic-views)
- [Cortex Search Documentation](https://docs.snowflake.com/en/user-guide/cortex-search)
- [Intelligence Agents Guide](https://docs.snowflake.com/en/user-guide/agents)

## 🚀 Next Steps

1. **Extend the Demo**: Add more data sources, create additional agents
2. **Customize Agents**: Fine-tune instructions for your specific use cases
3. **Integrate**: Connect agents to your applications via REST API
4. **Scale**: Add more warehouses, optimize semantic views for performance

## 📝 Complete Code Repository

All code for this demo is available on GitHub:
[GitHub Repository](https://github.com/your-repo/snowflake-intelligence-manufacturing)

The repository includes:
- Complete SQL setup scripts
- Sample data generation scripts
- Detailed README with setup instructions
- Demo guide with example queries

## 💡 Conclusion

Snowflake Intelligence enables you to build sophisticated AI applications directly on your data, without the complexity of managing separate vector databases, embedding pipelines, or LLM infrastructure. The unified approach—semantic views for structured/semi-structured data and Cortex Search for unstructured data—provides a powerful foundation for intelligent applications.

Whether you're building manufacturing intelligence, customer support systems, or financial analytics, Snowflake Intelligence provides the tools you need to make your data truly intelligent.

**Have questions or want to share your own Snowflake Intelligence projects?** Leave a comment below or reach out on [Twitter](https://twitter.com/yourhandle)!

---

**Tags:** #snowflake #ai #manufacturing #data-engineering #sql #machine-learning #analytics

**Author Bio:** [Your name and bio here]

