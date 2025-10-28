# Test Patient Data - Looker Project

## Project Overview

This Looker project (`test_patient_data`) is a semantic layer built on top of healthcare and bikeshare data stored in Google BigQuery (GCP). The project provides analytics and reporting capabilities for inpatient/outpatient charges and bikeshare trip data.

## Project Structure

```
test_patient_data/
├── manifest.lkml                          # Project manifest with table constants
├── test_patient_data.model.lkml          # Main model file with includes and datagroup
├── Views/                                 # View definitions
│   ├── inpatient_charges_2013.view.lkml
│   ├── outpatient_charges_2013.view.lkml
│   ├── bikeshare_trips.view.lkml
│   └── bikeshare_stations.view.lkml
├── Explores/                              # Explore definitions
│   ├── inpatient_outpatient.explore.lkml
│   └── bikeshare_info.explore.lkml
├── LookML_Dashboards/                     # LookML Dashboard definitions
│   ├── inpatient_outpatient_dashboard.dashboard.lookml
│   └── bikeshare_dashboard.dashboard.lookml
├── data_tests/                            # Data validation tests
│   ├── inpatient_outpatient_tests.lkml
│   └── bikeshare_tests.lkml
└── README.md                              # This file
```

## Database Connection

- **Database**: Google BigQuery (GCP)
- **Connection**: `badal_internal_projects`

## Data Sources

### 1. Healthcare Data

#### Inpatient Charges 2013
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`
- **Description**: Contains inpatient hospital charge information from 2013
- **Key Fields**:
  - Provider Information: ID, name, address, city, state, zipcode
  - Clinical Information: DRG definition, hospital referral region
  - Financial Metrics: Total discharges, average covered charges, average total payments, average Medicare payments

#### Outpatient Charges 2013
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`
- **Description**: Contains outpatient hospital charge information from 2013
- **Key Fields**:
  - Provider Information: ID, name, address, city, state, zipcode
  - Clinical Information: APC (Ambulatory Payment Classification), hospital referral region
  - Financial Metrics: Outpatient services count, average estimated submitted charges, average total payments

### 2. Bikeshare Data

#### Bikeshare Trips
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`
- **Description**: Austin bikeshare trip records
- **Key Fields**:
  - Trip identification: Trip ID, bike ID
  - Trip Details: Subscriber type, bike type, start/end station info
  - Trip Metrics: Start time, duration in minutes

#### Bikeshare Stations
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations`
- **Description**: Austin bikeshare station information
- **Key Fields**:
  - Station identification: Station ID, name, alternate name
  - Location: Address, geographic coordinates (latitude/longitude)
  - Station Details: Status, property type, power type, council district
  - Capacity: Number of docks, footprint dimensions
  - Metadata: Modified date, notes, image URL

## Semantic Layer

### Views

#### 1. inpatient_charges_2013
Dimensions for provider information and clinical classification. Measures for discharge counts and payment averages.
- Hidden primary key: Composite of provider_id and drg_definition
- All measures include NULL handling (converted to 0) and standard currency formatting

#### 2. outpatient_charges_2013
Dimensions for provider information and clinical classification. Includes custom APC code extraction (first 4 digits).
- Hidden primary key: Composite of provider_id and apc
- All measures include NULL handling and standard currency formatting
- Special dimension: `apc_code` extracts 4-digit code from APC field

#### 3. bikeshare_trips
Dimensions for trip characteristics and participants. Time dimension for trip start times.
- Primary key: Trip ID
- Time dimension group: Start time (with timeframes: time, date, week, month, raw)
- Measures for trip duration and count

#### 4. bikeshare_stations
Dimensions for station characteristics and location. Location dimension for map visualizations.
- Primary key: Station ID
- Location type dimension for mapping capabilities
- Time dimension group: Modified date
- Measures for dock count, footprint dimensions

### Explores

#### 1. Inpatient & Outpatient
**Name**: "Inpatient & Outpatient"

Combines inpatient and outpatient charge data through provider ID.

**Join Logic**:
- Base View: inpatient_charges_2013
- Joined View: outpatient_charges_2013
- Join Type: LEFT OUTER
- Relationship: MANY_TO_ONE
- Join Condition: provider_id match

#### 2. Bikeshare Info
**Name**: "Bikeshare Info"

Combines bikeshare trips with station information for both start and end stations.

**Join Logic**:
- Base View: bikeshare_trips
- Joined Views:
  - bikeshare_stations (as Start Bike Stations) - joined on start_station_id
  - bikeshare_stations (as End Bike Stations) - joined on end_station_id
- Join Type: LEFT OUTER
- Relationship: MANY_TO_ONE

## Reports & Dashboards

### 1. Inpatient & Outpatient Charges Dashboard
**Location**: `/LookML_Dashboards/inpatient_outpatient_dashboard.dashboard.lookml`

**Purpose**: Overview of inpatient and outpatient healthcare charges across providers

**Components**:
- **Single Value Tile**: Number of Providers
  - Count of unique providers
- **Column Chart**: Outpatient Services by City & Hospital Region
  - X-axis: Provider City
  - Secondary Grouping: Hospital Referral Region
  - Y-axis: Outpatient Services count

**Filters**:
- City (provider_city)
- Hospital Referral Region (hospital_referral_region_description)
- Zipcode (provider_zipcode)

### 2. Bikeshare Information Dashboard
**Location**: `/LookML_Dashboards/bikeshare_dashboard.dashboard.lookml`

**Purpose**: Comprehensive view of bikeshare operations, usage patterns, and station locations

**Components**:
- **Single Value Tiles**:
  - Total Trips
  - Average Trip Duration (minutes)
  - Total Stations
- **Bar Chart**: Trips by Subscriber Type
- **Table**: Trips Detail
  - Columns: Bike ID, Bike Type, Start/End Station Names, Start Date, Trip Count, Average Duration
- **Map**: Bike Stations Map
  - Shows locations of all bikeshare stations with dock counts

**Filters**:
- Start Station Name
- End Station Name
- Subscriber Type
- Bike Type

## Data Validation

### Data Tests

#### Inpatient & Outpatient Tests (inpatient_outpatient_tests.lkml)

1. **inpatient_zipcode_not_null**
   - Validates that provider zipcode field has no NULL values
   - Explore: inpatient_charges_2013

2. **outpatient_services_greater_than_1000_by_city**
   - Validates that outpatient services count is greater than 1000 per city
   - Explore: inpatient_charges_2013
   - Allows NULL values (assumes missing data is valid)

#### Bikeshare Tests (bikeshare_tests.lkml)

1. **bikeshare_start_station_id_not_null**
   - Validates that start_station_id has no NULL values
   - Explore: bikeshare_trips

2. **bikeshare_end_station_id_not_null**
   - Validates that end_station_id has no NULL values
   - Explore: bikeshare_trips

## Caching Strategy

### Datagroup: week_end

- **Trigger**: Every Monday at 9am Eastern Time
- **Max Cache Age**: 12 hours
- **Use Case**: Ensures weekly data refresh for reports while leveraging cache within the week

This datagroup is applied to explores requiring fresh data on a weekly basis without excessive database load.

## Project Configuration

### Manifest Constants

Table names are defined as constants for easy maintenance and reference:

```
@{inpatient_charges_2013_table}    → prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013
@{outpatient_charges_2013_table}   → prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013
@{bikeshare_trips_table}           → prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips
@{bikeshare_stations_table}        → prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations
```

## Best Practices Implemented

1. **Naming Conventions**:
   - View files: `.view.lkml`
   - Explore files: `.explore.lkml`
   - Dashboard files: `.dashboard.lookml`
   - Data test files: `.lkml`
   - Manifest: `manifest.lkml`

2. **Dimension & Measure Design**:
   - All dimensions and measures include labels and descriptions
   - Measures defined first as hidden dimensions, then as measures
   - NULL handling: Measures convert NULLs to 0 for proper aggregation
   - Consistent value formatting: `#,##0.00` for financial metrics

3. **Primary Keys**:
   - All views include hidden primary keys
   - Composite keys used where single unique identifiers don't exist

4. **Relationships**:
   - Proper cardinality declarations (many_to_one)
   - Clear join conditions with fully qualified field references

5. **Documentation**:
   - Comprehensive labels and descriptions on all fields
   - View and explore labels for user-friendly interface

## File Naming Convention

- Spaces and special characters not allowed in filenames
- File extensions automatically managed by Looker IDE
- Consistent naming patterns across all LookML elements
