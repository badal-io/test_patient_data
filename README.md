# Test Patient Data - Looker Project

## Overview
This Looker project (`test_patient_data`) provides a comprehensive semantic layer for analyzing healthcare provider performance metrics and bikeshare usage data. The project connects to BigQuery and combines inpatient charges, outpatient charges, and bikeshare data for in-depth business intelligence.

## Project Structure

### Database Connection
- **Connection**: `badal_internal_projects`
- **Database**: Google BigQuery (GCP)
- **Project**: `prj-s-dlp-dq-sandbox-0b3c`

### Folder Organization

```
test_patient_data/
├── Views/                      # Data view definitions
├── Explores/                   # Explore configurations
├── LookML_Dashboards/         # LookML dashboards
├── data_tests/                # Data quality tests
├── manifest.lkml              # Project constants
├── test_patient_data.model.lkml # Model file with includes and datagroup
└── README.md                  # This file
```

## Views

### 1. **inpatient_charges_2013**
Source table: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`

Provides inpatient hospital charge data including:
- **Dimensions**: Provider information (ID, name, address, city, state, zipcode), DRG definition, hospital referral region
- **Measures**: Total discharges, average covered charges, average total payments, average Medicare payments

### 2. **outpatient_charges_2013**
Source table: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`

Provides outpatient hospital charge data including:
- **Dimensions**: Provider information (ID, name, address, city, state, zipcode), APC (Ambulatory Payment Classification), APC code (4-digit extracted), hospital referral region
- **Measures**: Outpatient services count, average estimated submitted charges, average total payments

### 3. **bikeshare_trips**
Source table: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`

Provides bikeshare trip data including:
- **Dimensions**: Trip ID, subscriber type, bike ID, bike type, start/end station names and IDs
- **Dimension Groups**: Start time (with timeframes: time, date, week, month, raw)
- **Measures**: Duration in minutes, total duration, count of trips

### 4. **bikeshare_stations**
Source table: `bigquery-public-data.austin_bikeshare.bikeshare_stations`

Provides bikeshare station master data including:
- **Dimensions**: Station ID, name, status, address, alternate name, city asset number, property type, power type, notes, council district, image URL
- **Location**: Geographic coordinates for map visualization
- **Dimension Groups**: Modified date (with timeframes: time, date, week, month, raw)
- **Measures**: Number of docks, footprint length, footprint width

## Semantic Layer Configuration

### Datagroup: week_end
- **Description**: Triggers every Monday at 9am Eastern Time
- **Cache Duration**: 12 hours
- **Purpose**: Ensures data freshness weekly while maintaining performance through caching

### Table Constants (manifest.lkml)
The following constants are defined for easy reference and table name management:
- `inpatient_charges_table`: BigQuery table for inpatient charges
- `outpatient_charges_table`: BigQuery table for outpatient charges
- `bikeshare_trips_table`: BigQuery table for bikeshare trips
- `bikeshare_stations_table`: Austin bikeshare public data stations table

## Explores

### 1. **Inpatient & Outpatient**
Combines inpatient and outpatient charges data with a left outer join on provider_id.

**Join Logic**:
- Base view: `inpatient_charges_2013`
- Joined view: `outpatient_charges_2013`
- Relationship: Many-to-one

**Use Cases**:
- Compare inpatient vs. outpatient charges
- Analyze provider-specific charge patterns
- Benchmark hospital performance

### 2. **Bikeshare Info**
Combines bikeshare trips with station data using two separate joins for start and end stations.

**Join Logic**:
- Base view: `bikeshare_trips`
- Start stations join: `bikeshare_stations` (aliased as `bikeshare_stations_start`)
- End stations join: `bikeshare_stations` (aliased as `bikeshare_stations_end`)
- Join type: Left outer
- Relationship: Many-to-one

**Use Cases**:
- Analyze bikeshare usage patterns
- Identify popular stations
- Monitor subscriber types and bike preferences

## Dashboards

### 1. **Provider Metrics**
Business dashboard for explore: `Inpatient & Outpatient`

**Tiles**:
1. **Number of Providers** (Single Value)
   - Shows total count of unique providers

2. **Services by City and Hospital** (Column Chart)
   - Visualizes outpatient services across cities and hospital referral regions
   - Allows drill-down by city and hospital region

**Filters**:
- City (provider_city)
- Hospital (hospital_referral_region_description)
- Zipcode (provider_zipcode)

### 2. **Bikeshare Overview**
Business dashboard for explore: `Bikeshare Info`

**Tiles**:
1. **Total Trips** (Single Value) - Count of all trips
2. **Average Trip Duration** (Single Value) - Average duration in minutes
3. **Total Stations** (Single Value) - Count of unique stations
4. **Trips by Subscriber Type** (Single Value) - Trip count by subscriber segment
5. **Station Locations** (Map) - Geographic visualization of all bikeshare stations

**Filters**:
- Start Station Name
- End Station Name
- Subscriber Type
- Bike Type

## Data Tests

### Explore 1: Inpatient & Outpatient Tests

1. **inpatient_provider_zipcode_not_null**
   - Validates that all provider zipcodes in inpatient_charges_2013 are non-null
   - Prevents data quality issues in geographic filtering

2. **outpatient_services_by_city_gt_1000**
   - Ensures outpatient services count exceeds 1000 per city
   - Validates data completeness and accuracy

### Explore 2: Bikeshare Tests

1. **bikeshare_start_station_id_not_null**
   - Validates that all start station IDs are non-null
   - Ensures trip data integrity for joins

2. **bikeshare_end_station_id_not_null**
   - Validates that all end station IDs are non-null
   - Ensures complete trip routing information

## Key Design Decisions

### Primary Keys
- Composite keys added to all views for uniqueness
- Hidden from users but used internally for proper aggregation

### Measure Design
- All measures use hidden dimensions internally
- NULL values coerced to 0 to ensure proper aggregation
- Standard value format: `#,##0.00` for currency/decimal values

### Naming Conventions
- Follows Looker best practices
- File extensions: `.view.lkml`, `.explore.lkml`, `.dashboard.lookml`
- Descriptive labels and descriptions for all fields

### Time Dimensions
- `bikeshare_trips`: Start time with standard timeframes
- `bikeshare_stations`: Modified date with standard timeframes
- Enables time-based analysis and trend visualization

## CI/CD Pipeline

GitHub Actions workflow validates the project on every commit:
1. **LookML Validation**: Syntax and structure validation via Looker API
2. **SQL Validation**: Executes actual SQL against BigQuery database

See `.github/workflows/` for pipeline configuration details.

## Getting Started

1. **Install Looker CLI**: Ensure the Looker CLI is installed
2. **Push to Looker**: Use `lookml push` to deploy to your Looker instance
3. **Configure Secrets**: Add required GitHub secrets for CI/CD:
   - `LOOKER_BASE_URL`
   - `LOOKER_CLIENT_ID`
   - `LOOKER_CLIENT_SECRET`
   - `GCP_PROJECT_ID`
   - `GCP_CREDENTIALS` (JSON key)

## Support & Development

- All LookML files are version controlled in Git
- Follow branch-based development workflow
- Create feature branches for new dashboards/explores
- Run data tests before merging to production

## Documentation Standards

- All views, explores, and measures include descriptive labels and descriptions
- Dashboard documentation is embedded in dashboard definitions
- Field definitions follow a consistent format for clarity
