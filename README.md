# Snowflake Intelligence Demo - Vehicle Manufacturing

## Quick Setup (3 Steps)

### Step 1: Setup Infrastructure
```sql
@01_setup_intelligence.sql
```
Creates database, tables, and Intelligence object.

### Step 2: Load Vehicle Manufacturing Data
```sql
@01b_insert_vehicle_data.sql
```
Loads 50+ records per table with realistic vehicle data (Camry, Accord, RAV4, F-150, Model 3, BMW 3 Series, etc.)

### Step 3: Create Semantic Views & Cortex Search Services
```sql
@02_create_semantic_views.sql
@02a_create_cortex_search.sql
```
Creates semantic views for structured/semi-structured data and Cortex Search services for unstructured data.

### Step 4: Create Intelligence Agents
```sql
@03_create_agents.sql
```
Creates 4 Intelligence agents with access to semantic views and Cortex Search.

## Verify Setup
```sql
@04_verify_setup.sql
```

## Using the Agents

1. Open Snowflake UI → Intelligence Chat
2. Select an agent:
   - `supply_chain_agent` - Supplier risk, inventory, logistics
   - `production_agent` - Quality, efficiency, maintenance
   - `connected_products_agent` - Telematics, fleet management
   - `manufacturing_operations_agent` - Cross-functional insights

3. Ask questions in natural language:
   - "What suppliers have high risk scores?"
   - "Show me production efficiency by assembly line"
   - "Are there any sensor alerts from connected vehicles?"
   - "Give me strategic recommendations for operations"

## Files

- `01_setup_intelligence.sql` - Infrastructure setup
- `01b_insert_vehicle_data.sql` - Vehicle manufacturing data (50+ records per table)
- `02_create_semantic_views.sql` - Semantic views for structured/semi-structured data with Cortex Search integration
- `02a_create_cortex_search.sql` - Cortex Search services for unstructured data (maintenance logs, quality reports, etc.)
- `03_create_agents.sql` - Intelligence agents
- `04_verify_setup.sql` - Setup verification
- `reference.MD` - Manufacturing use cases reference

## Data Types Supported

- **Structured Data**: Traditional relational tables (supply_chain, production, inventory)
- **Semi-structured Data**: JSON/VARIANT columns (connected_products, iot_sensors, supplier_documents, product_configurations)
- **Unstructured Data**: Free-form text with Cortex Search (maintenance_logs, quality_reports, supplier_communications, engineering_docs, incident_reports)

---

**Created for:** KPMG Manufacturing Event  
**Presenter:** Bharath Suresh, Senior Partner Solutions Engineer at Snowflake
