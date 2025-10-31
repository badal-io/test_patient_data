# Test Patient Data - Looker Project

## Project Overview

The `test_patient_data` Looker project is a comprehensive semantic layer built on top of BigQuery data sources. It provides analytics and insights for healthcare and bikeshare data through LookML views, explores, dashboards, and data quality tests.

## Table of Contents

1. [Source Data](#source-data)
2. [Project Structure](#project-structure)
3. [Semantic Layer](#semantic-layer)
4. [Explores](#explores)
5. [Dashboards](#dashboards)
6. [Caching Strategy](#caching-strategy)
7. [Data Quality Tests](#data-quality-tests)
8. [Configuration](#configuration)

---

## Source Data

### Data Connection
- **Connection**: `badal_internal_projects`
- **Database**: BigQuery (GCP)
- **Project**: `prj-s-dlp-dq-sandbox-0b3c`
- **Schema**: `EK_test_data`

### Data Sources

#### Healthcare Data

1. **inpatient_charges_2013**
   - Table: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`
   - Description: Inpatient hospital charges data for 2013
   - Key Fields:
     - Provider Information: `provider_id`, `provider_name`, `provider_street_address`, `provider_city`, `provider_state`, `provider_zipcode`
     - Clinical: `drg_definition` (Diagnosis-Related Group)
     - Regional: `hospital_referral_region_description`
     - Metrics: `total_discharges`, `average_covered_charges`, `average_total_payments`, `average_medicare_payments`

2. **outpatient_charges_2013**
   - Table: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`
   - Description: Outpatient hospital charges data for 2013
   - Key Fields:
     - Provider Information: `provider_id`, `provider_name`, `provider_street_address`, `provider_city`, `provider_state`, `provider_zipcode`
     - Clinical: `apc` (Ambulatory Payment Classification) with extracted `apc_code`
     - Regional: `hospital_referral_region`
     - Metrics: `outpatient_services`, `average_estimated_submitted_charges`, `average_total_payments`

#### Bikeshare Data

3. **bikeshare_trips**
   - Table: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`
   - Description: Individual bike trip records
   - Key Fields:
     - Trip ID: `trip_id`
     - User Info: `subscriber_type`
     - Bike Info: `bike_id`, `bike_type`
     - Station Info: `start_station_id`, `start_station_name`, `end_station_id`, `end_station_name`
     - Temporal: `start_time` (timestamp), `duration_minutes`

4. **bikeshare_stations**
   - Table: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations`
   - Description: Bike station master data
   - Key Fields:
     - Station Info: `station_id`, `name`, `alternate_name`, `status`
     - Location: `location` (geographic coordinates), `address`, `city_asset_number`
     - Infrastructure: `property_type`, `power_type`, `number_of_docks`, `footprint_length`, `footprint_width`
     - Administrative: `council_district`, `notes`, `image`
     - Temporal: `modified_date` (timestamp)

---

## Project Structure

```
test_patient_data/
├── README.md                           # Project documentation (this file)
├── CLAUDE.md                           # Project task instructions
├── manifest.lkml                       # Project constants
├── datagroups.lkml                     # Caching policies
├── test_patient_data.model.lkml        # Main model file with includes
├── Views/                              # Semantic layer views
│   ├── inpatient_charges_2013.view.lkml
│   ├── outpatient_charges_2013.view.lkml
│   ├── bikeshare_trips.view.lkml
│   └── bikeshare_stations.view.lkml
├── Explores/                           # Explores for data analysis
│   ├── patient_explores.explore.lkml
│   └── bikeshare_explores.explore.lkml
├── LookML_Dashboards/                  # Business dashboards
│   ├── patient_analytics.dashboard.lookml
│   └── bikeshare_analysis.dashboard.lookml
├── data_tests/                         # Data quality tests
│   ├── patient_data_tests.lkml
│   └── bikeshare_data_tests.lkml
└── tasks/                              # Project task files (reference)
    ├── task_1_views.md
    ├── task_2_explores.md
    ├── task_3_reporting.md
    ├── task_4_caching.md
    ├── task_5_datatests.md
    ├── task_6_documentation.md
    └── task_execution_tracker.md
```

---

## Semantic Layer

### Views

The semantic layer consists of four main views, each representing a data entity with dimensions and measures.

#### 1. inpatient_charges_2013
- **Description**: Inpatient hospital charges with provider and clinical information
- **Primary Key**: Composite key (provider_id + drg_definition)
- **Dimensions**:
  - Provider: `provider_id`, `provider_name`, `provider_street_address`, `provider_city`, `provider_state`, `provider_zipcode` (type: zipcode)
  - Clinical: `drg_definition`
  - Regional: `hospital_referral_region_description`
- **Measures**:
  - `total_discharges` (sum)
  - `average_covered_charges` (average)
  - `average_total_payments` (average)
  - `average_medicare_payments` (average)

#### 2. outpatient_charges_2013
- **Description**: Outpatient hospital charges with provider and service information
- **Primary Key**: Composite key (provider_id + apc)
- **Dimensions**:
  - Provider: `provider_id`, `provider_name`, `provider_street_address`, `provider_city`, `provider_state`, `provider_zipcode` (type: zipcode)
  - Clinical: `apc`, `apc_code` (extracted 4-digit code from apc field)
  - Regional: `hospital_referral_region`
- **Measures**:
  - `outpatient_services` (sum)
  - `average_estimated_submitted_charges` (average)
  - `average_total_payments` (average)

#### 3. bikeshare_trips
- **Description**: Individual bike trip records with station and duration information
- **Primary Key**: `trip_id`
- **Dimensions**:
  - Trip: `trip_id`, `subscriber_type`, `bike_id`, `bike_type`
  - Stations: `start_station_id` (type: integer), `start_station_name`, `end_station_id` (type: integer), `end_station_name`
  - Temporal: `start_time` (time dimension group with timeframes: time, date, week, month, raw)
- **Measures**:
  - `duration_minutes` (sum)
  - `average_duration_minutes` (average)
  - `count` (record count)

#### 4. bikeshare_stations
- **Description**: Bike station master data with location and infrastructure information
- **Primary Key**: `station_id` (integer)
- **Dimensions**:
  - Station: `station_id`, `name`, `status`, `address`, `alternate_name`
  - Location: `location` (type: location with latitude/longitude)
  - Infrastructure: `property_type`, `power_type`, `council_district`, `city_asset_number`, `notes`, `image`
  - Temporal: `modified_date` (time dimension group)
- **Measures**:
  - `number_of_docks` (sum)
  - `footprint_length` (sum)
  - `footprint_width` (average)
  - `count` (record count)

### View Configuration Features

- **Primary Keys**: All views include hidden primary keys to uniquely identify records
- **Derived Measures**: All measures are defined as hidden dimensions first, then created as measures
- **NULL Handling**: Measures use COALESCE to convert NULLs to 0 for proper aggregation
- **Value Formatting**: All measures formatted with `#,##0.00` format
- **Time Dimensions**: Timestamp fields use dimension_group with proper timeframes and Month+Year formatted dimensions
- **Type Casting**: Station IDs cast to INT64 in BigQuery for consistency
- **Zipcode Support**: Provider zipcodes use type: zipcode for map visualizations

---

## Explores

The project includes 6 explores for data analysis, grouped into two categories:

### Patient Healthcare Explores

1. **inpatient_outpatient** (Combined)
   - Base View: `inpatient_charges_2013`
   - Joined View: `outpatient_charges_2013`
   - Join Type: LEFT OUTER
   - Relationship: Many-to-One (many outpatient records per provider)
   - Join Condition: `provider_id = provider_id`
   - Purpose: Analyze inpatient and outpatient charges together by provider

2. **inpatient_charges_2013_explore** (Simple)
   - View: `inpatient_charges_2013`
   - Purpose: Detailed exploration of inpatient charges data

3. **outpatient_charges_2013_explore** (Simple)
   - View: `outpatient_charges_2013`
   - Purpose: Detailed exploration of outpatient charges data

### Bikeshare Explores

4. **bikeshare_info** (Combined)
   - Base View: `bikeshare_trips`
   - Joined Views:
     - `bikeshare_stations_start` (aliased from bikeshare_stations)
     - `bikeshare_stations_end` (aliased from bikeshare_stations)
   - Join Type: LEFT OUTER
   - Relationship: Many-to-One
   - Join Conditions:
     - Start: `start_station_id = station_id`
     - End: `CAST(end_station_id AS INT64) = station_id`
   - Purpose: Analyze trips with start and end station details

5. **bikeshare_trips_explore** (Simple)
   - View: `bikeshare_trips`
   - Purpose: Detailed exploration of bike trip records

6. **bikeshare_stations_explore** (Simple)
   - View: `bikeshare_stations`
   - Purpose: Detailed exploration of station master data and locations

### Explore Configuration

- **Caching**: All explores use the `daily_datagroup` for consistent caching behavior
- **Labels & Descriptions**: All explores include user-friendly labels and descriptions
- **Relationships**: Proper many-to-one relationships for efficient aggregations

---

## Dashboards

### 1. Patient Analytics

**Dashboard**: `patient_analytics.dashboard.lookml`

Comprehensive analysis of inpatient and outpatient charges by provider.

**Tiles**:
- **Total Providers** (Single Value)
  - Metric: Count of unique providers
  - Used to quickly see the number of providers in the dataset

- **Outpatient Services by City and Hospital** (Column Chart)
  - Dimensions: Provider City, Hospital Referral Region (pivot)
  - Measure: Outpatient Services
  - Insight: Compare outpatient services across different cities and hospital regions

**Filters**:
- **City** (tag list): Filter by provider city
- **Hospital Referral Region** (tag list): Filter by hospital referral region
- **Zipcode** (tag list): Filter by provider zipcode

---

### 2. Bikeshare Analysis

**Dashboard**: `bikeshare_analysis.dashboard.lookml`

Comprehensive analysis of bikeshare trips with station locations.

**Tiles**:
- **Total Trips** (Single Value)
  - Metric: Count of all bike trips
  - Quick KPI showing total trip volume

- **Average Trip Duration (Minutes)** (Single Value)
  - Metric: Average duration in minutes
  - Shows typical trip length

- **Bike Type Distribution** (Single Value)
  - Dimension: Bike Type count
  - Shows how many trips per bike type

- **Trips by Subscriber Type** (Bar Chart)
  - Dimension: Subscriber Type
  - Measure: Trip Count
  - Insight: Compare subscriber types and their trip patterns

- **Trip Details Table** (Table)
  - Columns: Subscriber Type, Bike Type, Start Station, End Station, Trip Count
  - Purpose: Explore detailed trip information and common route patterns

- **Bike Station Locations** (Map)
  - Geographic visualization showing all bikeshare station locations
  - Uses the location dimension with latitude/longitude coordinates
  - Sized by station count/activity

**Filters**:
- **Start Station Name** (tag list): Filter by start station (from joined bikeshare_stations view)
- **End Station Name** (tag list): Filter by end station (from joined bikeshare_stations view)
- **Subscriber Type** (button group): Filter by user type
- **Bike Type** (button group): Filter by bike type

---

## Caching Strategy

### Datagroup Configuration

**Datagroup**: `daily_datagroup`

- **File**: `datagroups.lkml`
- **Cache Duration**: 24 hours
- **Trigger Type**: SQL-based
- **Trigger Query**: `SELECT CURRENT_DATE()`
- **Behavior**:
  - Cache is invalidated and refreshed daily
  - Rebuilds on the calendar day change (UTC midnight)
  - All explores use this datagroup via `persist_with: daily_datagroup`

### Benefits

- Consistent caching policy across all explores
- Reduces database load through query result caching
- Data freshness balanced with performance
- Automatic refresh ensures analysts see recent data daily

---

## Data Quality Tests

### Healthcare Data Tests

**File**: `data_tests/patient_data_tests.lkml`

1. **inpatient_provider_zipcode_not_null**
   - Explore: `inpatient_outpatient`
   - Test: Verifies no NULL values in `provider_zipcode` field
   - Purpose: Ensure provider location data is complete
   - Frequency: Runs on every Looker data test execution

2. **outpatient_services_greater_than_1000_by_city**
   - Explore: `inpatient_outpatient`
   - Test: Validates `outpatient_services` measure > 1000 for all rows
   - Purpose: Validate business logic - services should meet minimum threshold
   - Groups by: Provider City
   - Frequency: Runs on every Looker data test execution

### Bikeshare Data Tests

**File**: `data_tests/bikeshare_data_tests.lkml`

1. **bikeshare_start_station_id_not_null**
   - Explore: `bikeshare_info`
   - Test: Verifies no NULL values in `start_station_id` field
   - Purpose: Ensure all trips have valid start station references
   - Frequency: Runs on every Looker data test execution

2. **bikeshare_end_station_id_not_null**
   - Explore: `bikeshare_info`
   - Test: Verifies no NULL values in `end_station_id` field
   - Purpose: Ensure all trips have valid end station references
   - Frequency: Runs on every Looker data test execution

### Running Data Tests

Data tests can be executed through:
- Looker IDE's "Run Tests" feature
- Scheduled job runs
- CI/CD pipeline integrations

---

## Configuration

### Constants (manifest.lkml)

The project uses constants for all table references, allowing centralized management:

```
constant: inpatient_charges_2013_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013"
  export: override_required
}

constant: outpatient_charges_2013_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013"
  export: override_required
}

constant: bikeshare_trips_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips"
  export: override_required
}

constant: bikeshare_stations_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations"
  export: override_required
}
```

### Model File Includes

The main model file `test_patient_data.model.lkml` includes:

1. `datagroups.lkml` - Caching policies
2. `Views/*.view.lkml` - All view definitions
3. `Explores/*.explore.lkml` - All explore definitions
4. `LookML_Dashboards/*.dashboard.lookml` - All dashboards
5. `data_tests/*.lkml` - All data tests

---

## Best Practices Implemented

### View Layer
- ✓ Composite primary keys for multi-dimensional data
- ✓ Hidden dimensions for measure calculations
- ✓ NULL-safe measure aggregations using COALESCE
- ✓ Consistent value formatting (#,##0.00)
- ✓ Proper type casting for dimension consistency
- ✓ Specialized dimension types (zipcode, location, time)

### Explore Layer
- ✓ Clear labels and descriptions
- ✓ Proper join relationships (many-to-one)
- ✓ Consistent caching via datagroups
- ✓ Distinction between combined and simple explores

### Reporting Layer
- ✓ Dashboard descriptions for user context
- ✓ Multiple filter types for flexibility
- ✓ Mix of KPI and detailed visualization tiles
- ✓ Geographic visualization with map tiles

### Data Quality
- ✓ Comprehensive test coverage for critical fields
- ✓ Both NULL and threshold validation tests
- ✓ Tests based on business requirements

### Project Organization
- ✓ Modular file structure
- ✓ Centralized constants management
- ✓ Consistent naming conventions
- ✓ Clear documentation

---

## Getting Started

### Accessing the Project

1. Open Looker and navigate to the `test_patient_data` model
2. Select an Explore to begin analyzing data
3. Use the dashboards for pre-built insights

### Customization

To modify or extend the project:

1. **Add new fields**: Edit corresponding `.view.lkml` files
2. **Create new explores**: Add to `.explore.lkml` files
3. **Build new dashboards**: Create `.dashboard.lookml` files
4. **Add data tests**: Expand `.lkml` files in `data_tests` folder

---

## Support & Maintenance

- For data issues, check the relevant data test results
- For performance issues, review the caching configuration in `datagroups.lkml`
- For additions, follow the established patterns in existing files
- Update this README when significant changes are made to the project

---

**Project Created**: October 2024
**Last Updated**: October 31, 2024
