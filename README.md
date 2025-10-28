# Test Patient Data - Looker Project

## Project Overview

The Test Patient Data project is a Looker semantic layer built on BigQuery that provides analytics and reporting capabilities for patient healthcare data and bikeshare trip information. This project enables organizations to analyze inpatient and outpatient charges, as well as track bikeshare usage patterns.

## Data Architecture

### Connection
- **Database**: Google BigQuery (GCP)
- **Project ID**: `badal_internal_projects`

### Database Structure

The project integrates data from two primary sources:

#### 1. Patient Healthcare Data
Located in: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data`

- **inpatient_charges_2013**: Contains inpatient hospital charges and metrics
  - Provider information (ID, name, location details)
  - DRG (Diagnosis Related Group) definitions
  - Hospital referral region descriptions
  - Metrics: Total discharges, average covered charges, total payments, Medicare payments

- **outpatient_charges_2013**: Contains outpatient service charges and metrics
  - Provider information (ID, name, location details)
  - APC (Ambulatory Payment Classification) codes
  - Hospital referral region
  - Metrics: Outpatient services count, estimated submitted charges, total payments

#### 2. Bikeshare Data
Located in: `bigquery-public-data.austin_bikeshare`

- **bikeshare_trips**: Individual trip records
  - Trip and bike IDs
  - Subscriber type and bike type information
  - Start and end station references
  - Trip start timestamp and duration

- **bikeshare_stations**: Station information and locations
  - Station identifiers and names
  - Geographic location (latitude/longitude)
  - Physical characteristics (number of docks, footprint dimensions)
  - Status and address information

## Semantic Layer Structure

### Views (4 total)

1. **inpatient_charges_2013.view.lkml**
   - Provides dimensions for provider and DRG details
   - Includes measures for discharges and payment metrics
   - Supports analysis of inpatient costs by provider and region

2. **outpatient_charges_2013.view.lkml**
   - Provides dimensions for provider and APC code details
   - Includes custom dimension: `apc_code` (4-digit code extracted from full APC)
   - Includes measures for outpatient services and charges
   - Enables analysis of outpatient services by provider and payment type

3. **bikeshare_trips.view.lkml**
   - Provides dimensions for trip, bike, and subscriber details
   - Includes time-based dimensions for trip start times
   - Includes measures for trip count and duration metrics
   - Enables analysis of bikeshare usage patterns

4. **bikeshare_stations.view.lkml**
   - Provides dimensions for station details and location data
   - Includes location dimension for geographic mapping
   - Includes measures for dock capacity and footprint metrics
   - Enables station-level analysis and mapping visualizations

### Explores (2 total)

#### 1. Inpatient & Outpatient Explore
- **Base View**: inpatient_charges_2013
- **Join**: outpatient_charges_2013
- **Join Type**: LEFT OUTER
- **Relationship**: many_to_one
- **Join Key**: provider_id
- **Purpose**: Analyze combined inpatient and outpatient charges by provider

#### 2. Bikeshare Info Explore
- **Base View**: bikeshare_trips
- **Joins**:
  - `start_stations` (bikeshare_stations) - LEFT OUTER, many_to_one
  - `end_stations` (bikeshare_stations) - LEFT OUTER, many_to_one
- **Join Keys**:
  - Start: bikeshare_trips.start_station_id = start_stations.station_id
  - End: CAST(bikeshare_trips.end_station_id AS INTEGER) = end_stations.station_id
- **Purpose**: Analyze bikeshare trips with origin and destination station details

## Reporting & Dashboards

### 1. Provider Metrics Dashboard
- **Explore**: Inpatient & Outpatient
- **Tiles**:
  1. **Number of Providers** (Single Value)
     - Counts unique providers
  2. **City, Hospital and Outpatient Services** (Column Chart)
     - Visualizes outpatient services by city and hospital referral region
- **Filters**:
  - Provider City
  - Hospital Referral Region
  - Provider Zipcode

### 2. Bikeshare Overview Dashboard
- **Explore**: Bikeshare Info
- **Tiles**:
  1. **Total Number of Trips** (Single Value)
  2. **Average Trip Duration** (Single Value)
  3. **Total Number of Stations** (Single Value)
  4. **Trips by End Station** (Treemap)
     - Hierarchical view of trip distribution by end station
  5. **Bike Type and Subscriber Type Report** (Table)
     - Shows trip count and total duration by bike and subscriber type
     - Theme: Contemporary with merged dimensions and headers
  6. **Trip Distribution by End Station** (Histogram)
     - Color: #e83461 (custom pink color)
  7. **Bike Stations Map** (Map Visualization)
     - Geographic plot of station locations with trip metrics
- **Filters**:
  - Start Station Name
  - End Station Name
  - Subscriber Type
  - Bike Type

## Data Governance

### Datagroup Configuration
- **Name**: week_end
- **Description**: Triggers every Monday at 9am Eastern Time
- **Trigger**: SQL-based trigger checking for Mondays at 9am ET
- **Cache Duration**: 12 hours
- **Purpose**: Ensures data freshness with controlled cache invalidation

### Data Tests

#### Patient Data Tests (patient_data_tests.lkml)
1. **provider_zipcode_not_null**
   - Validates that provider zipcode field contains no NULL values
   - Critical for accurate geographic analysis

2. **outpatient_services_greater_than_1000_by_city**
   - Validates that outpatient services exceed 1000 when aggregated by city
   - Ensures data quality and expected minimum thresholds

#### Bikeshare Data Tests (bikeshare_data_tests.lkml)
1. **start_station_id_not_null**
   - Validates that start_station_id field contains no NULL values
   - Critical for trip origin tracking

2. **end_station_id_not_null**
   - Validates that end_station_id field contains no NULL values
   - Critical for trip destination tracking

## Project Structure

```
test_patient_data/
├── manifest.lkml                    # Table name constants
├── test_patient_data.model.lkml     # Main model file with includes and datagroup
├── Views/
│   ├── inpatient_charges_2013.view.lkml
│   ├── outpatient_charges_2013.view.lkml
│   ├── bikeshare_trips.view.lkml
│   └── bikeshare_stations.view.lkml
├── Explores/
│   ├── inpatient_outpatient.explore.lkml
│   └── bikeshare_info.explore.lkml
├── LookML_Dashboards/
│   ├── provider_metrics.dashboard.lookml
│   └── bikeshare_overview.dashboard.lookml
├── data_tests/
│   ├── patient_data_tests.lkml
│   └── bikeshare_data_tests.lkml
└── README.md                        # This file
```

## Key Features

### Dimension & Measure Best Practices
- All dimensions and measures include descriptive labels and descriptions
- Measures are defined as hidden dimensions first, then exposed as measures
- NULL values are handled appropriately (converted to 0 for aggregations)
- All measure values use consistent formatting: `#,##0.00`
- Primary keys are defined for each view and marked as hidden
- Location dimensions support geographic mapping visualizations

### Naming Conventions
- Views named after source tables with descriptive suffixes
- Explores use clear, business-friendly names
- Dashboards follow naming convention: `{entity}_{metric_type}.dashboard.lookml`
- Data test files organized by subject area

## Usage & Recommendations

### For Analysts
- Use the **Provider Metrics Dashboard** for healthcare cost analysis and provider performance
- Use the **Bikeshare Overview Dashboard** for transportation usage patterns and station analysis
- Leverage filters for focused analysis on specific regions, providers, or time periods

### For Administrators
- Monitor data test results regularly to ensure data quality
- Review cache performance based on query patterns (12-hour cache with Monday 9am triggers)
- Update manifest.lkml if source table locations change

## Dependencies & Versions

- **Looker Version**: Compatible with Looker 7.0+
- **BigQuery**: Standard SQL dialect
- **LookML**: Standard LookML syntax

## Future Enhancements

Potential areas for expansion:
- Additional time-based dimensions for trend analysis
- More complex derived tables for advanced metrics
- Integration with additional healthcare datasets
- Enhanced geographic analysis with multi-layer mapping
