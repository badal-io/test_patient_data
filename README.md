# Test Patient Data - Looker Project

## Overview
This Looker project provides analytics and reporting capabilities for healthcare provider data and bikeshare system information. The project connects to BigQuery datasets and provides comprehensive views, explores, and dashboards for data analysis.

## Database Connection
- **Connection Name**: badal_internal_projects
- **Database Type**: Google BigQuery (GCP)
- **Project ID**: prj-s-dlp-dq-sandbox-0b3c
- **Dataset**: EK_test_data

## Project Structure

### Folders
- **Views/**: Contains all view files (.view.lkml) that define the data structure and calculations
- **Explores/**: Contains explore files (.explore.lkml) that define how views are joined together
- **LookML_Dashboards/**: Contains LookML dashboard files (.dashboard.lookml) for pre-built visualizations
- **data_tests/**: Contains data quality test files (.lkml)

### Key Files
- **manifest.lkml**: Defines project-level constants for table names
- **test_patient_data.model.lkml**: Main model file with connection, includes, and datagroup configuration

## Data Sources

### Healthcare Provider Data

#### 1. Inpatient Charges (2013)
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`
- **View Name**: inpatient_charges_2013
- **Description**: Contains inpatient hospital charge information including provider details, DRG definitions, discharges, and payment information

**Key Dimensions**:
- Provider information (ID, name, address, city, state, zipcode)
- DRG (Diagnosis Related Group) definition
- Hospital referral region

**Key Measures**:
- Total discharges
- Average covered charges
- Average total payments
- Average Medicare payments
- Count of providers

#### 2. Outpatient Charges (2013)
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`
- **View Name**: outpatient_charges_2013
- **Description**: Contains outpatient hospital charge information including provider details, APC codes, and payment information

**Key Dimensions**:
- Provider information (ID, name, address, city, state, zipcode)
- APC (Ambulatory Payment Classification)
- APC code (4-digit extracted code)
- Hospital referral region

**Key Measures**:
- Outpatient services count
- Average estimated submitted charges
- Average total payments
- Count of providers

### Bikeshare Data

#### 3. Bikeshare Trips
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`
- **View Name**: bikeshare_trips
- **Description**: Austin bikeshare trip information including trip details, bike information, and station data

**Key Dimensions**:
- Trip ID
- Subscriber type
- Bike ID and type
- Start and end station information
- Start time (with multiple timeframes: time, date, week, month, year)

**Key Measures**:
- Total duration in minutes
- Average duration in minutes
- Count of trips

#### 4. Bikeshare Stations
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations`
- **View Name**: bikeshare_stations
- **Description**: Austin bikeshare station information including location, capacity, and metadata

**Key Dimensions**:
- Station ID and name
- Status
- Location (geographic coordinates for mapping)
- Address and property type
- Council district
- Modified date (with multiple timeframes)

**Key Measures**:
- Total number of docks
- Average number of docks
- Footprint length and width
- Count of stations

## Semantic Layer Structure

### Explores

#### 1. Inpatient & Outpatient
- **Explore Name**: inpatient_outpatient
- **Base View**: inpatient_charges_2013
- **Joined View**: outpatient_charges_2013
- **Join Logic**: Left outer join on provider_id
- **Relationship**: many_to_one
- **Use Case**: Analyze both inpatient and outpatient charges by provider

#### 2. Bikeshare Info
- **Explore Name**: bikeshare_info
- **Base View**: bikeshare_trips
- **Joined Views**:
  - start_station (from bikeshare_stations) - Left outer join on start_station_id
  - end_station (from bikeshare_stations) - Left outer join on end_station_id (cast as INTEGER)
- **Relationship**: many_to_one for both joins
- **Use Case**: Analyze bikeshare trips with detailed station information for both start and end locations

### Datagroup
- **Name**: week_end
- **Description**: Triggers every Monday at 9am Eastern Time
- **Cache Duration**: 12 hours
- **Purpose**: Automatic cache invalidation and persistent derived table (PDT) rebuilding

## Dashboards

### 1. Provider Metrics Dashboard
- **Dashboard Name**: provider_metrics
- **Explore**: inpatient_outpatient
- **Purpose**: Monitor healthcare provider metrics and services

**Tiles**:
1. **Number of Providers**: Single value tile showing total count of providers
2. **Outpatient Services by City and Hospital**: Column chart displaying outpatient services grouped by city and hospital

**Filters**:
- City (provider_city)
- Hospital (hospital_referral_region_description)
- Zipcode (provider_zipcode)

### 2. Bikeshare Overview Dashboard
- **Dashboard Name**: bikeshare_overview
- **Explore**: bikeshare_info
- **Purpose**: Monitor bikeshare system usage and station information

**Tiles**:
1. **Total Trips**: Single value showing count of all trips
2. **Average Trip Duration**: Single value showing average trip duration in minutes
3. **Total Stations (Start)**: Single value showing count of start stations
4. **Total Docks Available**: Single value showing total dock capacity
5. **Bike Station Locations Map**: Geographic map showing all bike station locations

**Filters**:
- Start Station Name (from start_station view)
- End Station Name (from end_station view)
- Subscriber Type
- Bike Type

## Data Quality Tests

### Inpatient & Outpatient Tests
1. **inpatient_provider_zipcode_not_null**: Validates that provider zipcode field in inpatient_charges_2013 contains no NULL values
2. **outpatient_services_greater_than_1000_by_city**: Validates that outpatient services measure exceeds 1000 when grouped by city

### Bikeshare Tests
1. **bikeshare_start_station_id_not_null**: Validates that start_station_id in bikeshare_trips contains no NULL values
2. **bikeshare_end_station_id_not_null**: Validates that end_station_id in bikeshare_trips contains no NULL values

## Best Practices Implemented

1. **Constants for Table Names**: All table names are defined as constants in manifest.lkml for easy maintenance
2. **Primary Keys**: Each view has a defined primary key (may be composite) marked as hidden
3. **NULL Handling**: All measures use COALESCE to convert NULL values to 0 for proper aggregation
4. **Consistent Formatting**: All measures use value_format: "#,##0.00" for consistent display
5. **Hidden Raw Dimensions**: Measures are based on hidden dimensions to ensure proper NULL handling
6. **Labels and Descriptions**: All dimensions and measures include descriptive labels and descriptions
7. **Time Dimensions**: Date/timestamp fields use dimension_group with type: time for automatic timeframe generation
8. **Geographic Dimensions**: Location fields properly configured for map visualizations using type: location or type: zipcode

## Getting Started

1. Ensure you have access to the BigQuery connection "badal_internal_projects"
2. Navigate to the Explores section to begin ad-hoc analysis
3. Use the pre-built dashboards for quick insights
4. Run data tests regularly to ensure data quality

## Support and Maintenance

For questions or issues with this Looker project, please contact your Looker administrator or data team.
