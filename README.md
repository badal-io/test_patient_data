# Test Patient Data - Looker Project

## Overview

This Looker project provides a comprehensive semantic layer for analyzing healthcare and bikeshare data. It connects to BigQuery (GCP) and offers insights into inpatient charges, outpatient charges, and bikeshare trip information.

## Database & Connection

- **Database**: BigQuery (GCP)
- **Connection**: `badal_internal_projects`
- **Data Schema**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data`

## Project Structure

The project is organized into the following folders:

### Views (`/Views`)
Semantic layer definitions for four main data sources:

1. **inpatient_charges_2013.view.lkml**
   - Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`
   - Dimensions: Provider information (ID, name, address, city, state, zipcode), DRG definition, hospital referral region
   - Measures: Total discharges, average covered charges, average total payments, average Medicare payments
   - Features: Zipcode type dimension for mapping support

2. **outpatient_charges_2013.view.lkml**
   - Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`
   - Dimensions: Provider information, APC code (4-digit extraction), hospital referral region
   - Measures: Outpatient services, average estimated submitted charges, average total payments
   - Features: Derived APC code from APC field for easier analysis

3. **bikeshare_trips.view.lkml**
   - Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`
   - Dimensions: Trip ID, subscriber type, bike type, start/end station IDs (converted to INT64), station names, start time (with time group)
   - Measures: Trip duration in minutes, trip count
   - Features: Time dimension group with multiple timeframes (time, date, week, month, raw), formatted month/year dimension

4. **bikeshare_stations.view.lkml**
   - Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations`
   - Dimensions: Station ID, name, status, address, property type, power type, council district, location (with latitude/longitude)
   - Measures: Number of docks, footprint length, footprint width, station count
   - Features: Location dimension type for map visualization, time dimension group for modified date tracking

### Explores (`/Explores`)
Query interfaces that combine views with joins:

1. **patient_explores.explore.lkml**
   - **Inpatient & Outpatient**: Main explore joining inpatient and outpatient data on provider_id
     - Base view: inpatient_charges_2013
     - Joined view: outpatient_charges_2013 (left_outer join, many_to_one relationship)
   - **Inpatient Charges Explore**: Simple explore for inpatient_charges_2013 view
   - **Outpatient Charges Explore**: Simple explore for outpatient_charges_2013 view

2. **bikeshare_explores.explore.lkml**
   - **Bikeshare Info**: Main explore combining trips with start and end station information
     - Base view: bikeshare_trips
     - Joined views: bikeshare_stations (twice - for start and end stations)
     - Join types: left_outer joins with many_to_one relationships
   - **Bikeshare Trips Explore**: Simple explore for bikeshare_trips view
   - **Bikeshare Stations Explore**: Simple explore for bikeshare_stations view

### LookML Dashboards (`/LookML_Dashboards`)
Pre-built dashboards for visualization and analysis:

1. **patient_dashboard.dashboard.lookml**
   - Title: "Inpatient & Outpatient Report"
   - Tiles:
     - Total Number of Providers (single value)
     - Outpatient Services by City and Hospital (column chart)
     - Provider Details (table with provider info and metrics)
   - Filters: City, Hospital, Zipcode (all with multi-select support)
   - Purpose: Analyze provider distribution and service volumes

2. **bikeshare_dashboard.dashboard.lookml**
   - Title: "Bikeshare Information"
   - Tiles:
     - Total Trips (single value)
     - Average Trip Duration (single value)
     - Total Stations (single value)
     - Trips by Subscriber Type (bar chart)
     - Trip Details (table with trip information and duration)
     - Bikeshare Station Locations (map visualization)
   - Filters: Start Station Name, End Station Name, Subscriber Type, Bike Type (all with multi-select support)
   - Purpose: Monitor bike usage patterns and station distribution

## Caching & Performance

### Datagroups (`datagroups.lkml`)

- **daily_datagroup**
  - Description: Daily cache refresh with 24-hour expiration
  - Trigger: Interval-based (every 24 hours)
  - Cache Duration: 24 hours
  - Applied to: All explores in the project for consistent performance

All explores use the `daily_datagroup` caching policy via the `persist_with` parameter, ensuring query results are cached and refreshed daily to optimize performance.

## Data Quality Assurance

### Data Tests (`/data_tests`)

The project includes automated data quality checks to ensure data integrity:

1. **patient_data_tests.lkml**
   - **provider_zipcode_not_null**: Validates that all providers have zipcode values (no NULLs)
   - **outpatient_services_greater_than_1000_by_city**: Ensures outpatient services by city always exceed 1000

2. **bikeshare_data_tests.lkml**
   - **start_station_id_not_null**: Validates that all trips have a start station ID
   - **end_station_id_not_null**: Validates that all trips have an end station ID

These tests run during project validation and help catch data quality issues early.

## Configuration Files

### manifest.lkml
Contains constants for table references used across views:
- `inpatient_charges_2013_table`
- `outpatient_charges_2013_table`
- `bikeshare_trips_table`
- `bikeshare_stations_table`

Table constants are used in view definitions with the `@{table_name}` syntax.

### test_patient_data.model.lkml
Main model file that:
- Defines the BigQuery connection
- Includes all views, explores, dashboards, datagroups, and data tests
- Serves as the entry point for the semantic layer

## Key Features

### Data Quality
- Primary keys defined and hidden in all views
- NULL value handling with COALESCE in measures
- Data tests for critical fields

### Visualization Support
- Zipcode type for provider location mapping
- Location type with latitude/longitude for station mapping
- Time dimension groups with multiple timeframes

### Performance
- Daily caching policy across all explores
- Consistent cache management through shared datagroup
- Optimized measure aggregations

### Usability
- Clear labels and descriptions for all fields
- Multi-select filters on dashboards
- Intuitive explore names and view labels
- Organized folder structure for easy maintenance

## Using the Project

### Accessing Explores
- Navigate to the Explore section in Looker
- Available explores include:
  - Inpatient & Outpatient
  - Inpatient Charges
  - Outpatient Charges
  - Bikeshare Info
  - Bikeshare Trips
  - Bikeshare Stations

### Using Dashboards
- Access pre-built dashboards from the dashboard menu
- Apply filters to narrow down data
- Use cross-filtering to drill down into specific segments

### Running Data Tests
- Data tests are automatically run during project validation
- Failed tests indicate potential data quality issues
- Address data quality concerns before proceeding with analysis

## Maintenance Notes

### Adding New Views
1. Create view file in `/Views` folder
2. Add table constant to `manifest.lkml` if needed
3. Update model file include statement (already wildcarded)

### Creating New Explores
1. Create explore file in `/Explores` folder
2. Add `persist_with: daily_datagroup` to leverage caching
3. Update model file include statement (already wildcarded)

### Adding New Dashboards
1. Create dashboard file in `/LookML_Dashboards` folder
2. Use field_filter type for dashboard filters
3. Update model file include statement (already wildcarded)

## Contact & Support

For questions about this project or to request new features, please contact the analytics team.

---

**Last Updated**: October 2025
**Project Status**: Complete with all core components (Views, Explores, Dashboards, Caching, Data Tests)
