# Test Patient Data - Looker Project

## Project Overview

This Looker project (`test_patient_data`) provides a semantic layer for analyzing healthcare provider charges and bikeshare trip data. The project is connected to BigQuery (GCP) and includes comprehensive views, explores, dashboards, and data tests.

## Data Source

### BigQuery Connection
- **Connection Name**: badal_internal_projects
- **Database**: GCP BigQuery

### Tables

#### Healthcare Data
1. **inpatient_charges_2013** (`prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`)
   - Contains inpatient hospital charge information
   - Fields: Provider details, DRG definitions, discharge counts, and payment information

2. **outpatient_charges_2013** (`prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`)
   - Contains outpatient hospital charge information
   - Fields: Provider details, APC codes, service counts, and payment information

#### Bikeshare Data
3. **bikeshare_trips** (`bigquery-public-data.austin_bikeshare.bikeshare_trips`)
   - Contains Austin bikeshare trip information
   - Fields: Trip details, bike information, start/end stations, and trip duration

4. **bikeshare_stations** (`bigquery-public-data.austin_bikeshare.bikeshare_stations`)
   - Contains Austin bikeshare station information
   - Fields: Station details, location, dock counts, and property information

## Project Structure

```
test_patient_data/
├── manifest.lkml                      # Project constants and datagroup definitions
├── test_patient_data.model.lkml       # Main model file with includes
├── Views/                             # View files
│   ├── inpatient_charges_2013.view.lkml
│   ├── outpatient_charges_2013.view.lkml
│   ├── bikeshare_trips.view.lkml
│   └── bikeshare_stations.view.lkml
├── Explores/                          # Explore files
│   ├── inpatient_outpatient.explore.lkml
│   └── bikeshare_info.explore.lkml
├── LookML_Dashboards/                 # Dashboard files
│   ├── inpatient_outpatient_dashboard.dashboard.lookml
│   └── bikeshare_dashboard.dashboard.lookml
├── data_tests/                        # Data quality tests
│   ├── inpatient_outpatient_tests.lkml
│   └── bikeshare_tests.lkml
└── README.md                          # This file
```

## Semantic Layer

### Views

#### inpatient_charges_2013
- **Type**: Dimension view
- **Dimensions**: Provider ID, name, address, city, state, zipcode, DRG definition, hospital referral region
- **Measures**: Total discharges, average covered charges, average total payments, average Medicare payments
- **Primary Key**: Composite ID (hidden)

#### outpatient_charges_2013
- **Type**: Dimension view
- **Dimensions**: Provider ID, name, address, city, state, zipcode, APC, APC code (extracted), hospital referral region
- **Measures**: Outpatient services, average estimated submitted charges, average total payments
- **Special Fields**: `apc_code` - extracted 4-digit code from the APC field
- **Primary Key**: Composite ID (hidden)

#### bikeshare_trips
- **Type**: Fact view
- **Dimensions**: Trip ID, subscriber type, bike ID, bike type, start/end station details
- **Dimension Groups**: Start time (time, date, week, month, raw)
- **Measures**: Duration minutes
- **Primary Key**: Trip ID (hidden)

#### bikeshare_stations
- **Type**: Dimension view
- **Dimensions**: Station ID, name, status, address, property type, power type, notes, council district, image
- **Location Dimension**: Geographic coordinates for mapping
- **Dimension Groups**: Modified date (time, date, week, month, raw)
- **Measures**: Number of docks, footprint length, footprint width
- **Primary Key**: Station ID (hidden)

### Explores

#### Inpatient & Outpatient
- **Base Table**: inpatient_charges_2013
- **Joined Table**: outpatient_charges_2013
- **Join Type**: LEFT OUTER
- **Join Condition**: Provider ID
- **Relationship**: Many-to-One
- **Cache Policy**: 12 hours (via `week_end` datagroup)
- **Use Case**: Analyze combined inpatient and outpatient charges by provider

#### Bikeshare Info
- **Base Table**: bikeshare_trips
- **Joined Tables**:
  - bikeshare_stations (for start stations)
  - bikeshare_stations (for end stations)
- **Join Type**: LEFT OUTER
- **Join Conditions**:
  - Start: bikeshare_trips.start_station_id = bikeshare_stations.station_id
  - End: bikeshare_trips.end_station_id = bikeshare_stations.station_id
- **Relationship**: Many-to-One
- **Cache Policy**: 12 hours (via `week_end` datagroup)
- **Use Case**: Analyze bikeshare trips with station details

## Dashboards

### Inpatient & Outpatient Dashboard
- **Explore**: Inpatient & Outpatient
- **Filters**:
  - City (from provider_city)
  - Hospital Referral Region
  - Zipcode
- **Tiles**:
  1. Number of Providers (single value)
  2. Outpatient Services by City and Hospital Region (column chart)

### Bikeshare Dashboard
- **Explore**: Bikeshare Info
- **Filters**:
  - Start Station Name (from joined stations view)
  - End Station Name (from joined stations view)
  - Subscriber Type
  - Bike Type
- **Tiles**:
  1. Total Trips (single value)
  2. Average Trip Duration (single value)
  3. Unique Bikes (single value)
  4. Trips by Date and Subscriber Type (bar chart)
  5. Trip Details (table)
  6. Bike Station Locations (map visualization)

## Data Quality Tests

### Inpatient & Outpatient Tests

1. **provider_zipcode_not_null**
   - Validates that provider zipcode field has no NULL values in inpatient_charges_2013

2. **outpatient_services_by_city_greater_than_1000**
   - Validates that outpatient_services measure is greater than 1000 when filtered by city

### Bikeshare Tests

1. **bikeshare_station_ids_not_null**
   - Validates that start_station_id and end_station_id are not NULL in bikeshare_trips

2. **end_station_id_not_null**
   - Validates that end_station_id is not NULL in bikeshare_trips

## Caching Policy

### Week End Datagroup
- **Trigger**: Every Monday at 9:00 AM Eastern Time
- **Cache Duration**: 12 hours
- **Applied To**: Both Inpatient & Outpatient and Bikeshare Info explores
- **Purpose**: Ensures data is refreshed weekly while maintaining query performance

## Key Features

- **Composite Primary Keys**: All views include hidden composite primary keys to ensure uniqueness
- **Null Handling**: All measures use COALESCE to convert NULLs to 0 for accurate aggregations
- **Number Formatting**: All measures use "#,##0.00" format for consistent currency/number display
- **Time Dimensions**: Time-based dimensions include multiple timeframes for flexible analysis
- **Location Data**: Bikeshare stations include geographic coordinates for map visualizations
- **Special Calculations**: APC code extraction from the full APC field for easier filtering and analysis

## Best Practices Implemented

- **Table Constants**: Table names defined as constants in manifest.lkml for easy maintenance
- **Include Statements**: Organized includes by folder for scalability
- **Relationship Definitions**: All joins include explicit relationship types for query optimization
- **Labels and Descriptions**: All fields include descriptive labels and descriptions
- **Data Tests**: Comprehensive data quality tests to catch data issues early
- **Cache Strategy**: Datagroup-based caching for improved performance

## Future Enhancements

- Add more views for additional datasets
- Create additional explores for cross-data analysis
- Expand dashboard functionality with more visualizations
- Add refinements for role-based access control
- Implement persistent derived tables (PDTs) for complex transformations
