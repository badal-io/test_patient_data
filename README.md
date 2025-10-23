# Test Patient Data - Looker Project

## Overview
This Looker project provides a comprehensive analytical framework for exploring Medicare inpatient and outpatient charge data from 2013. The project enables analysis of healthcare provider charges, payments, and service volumes across different geographic regions and medical classifications.

## Source Data
The project is connected to a BigQuery database in Google Cloud Platform (GCP) and uses two primary data sources:

### Inpatient Charges 2013
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`
- **Description**: Contains Medicare inpatient prospective payment system (IPPS) provider summary data for fiscal year 2013
- **Key Fields**:
  - Provider information (ID, name, address, city, state, zipcode)
  - DRG (Diagnosis Related Group) definitions
  - Hospital referral region descriptions
  - Total discharges
  - Average covered charges, total payments, and Medicare payments

### Outpatient Charges 2013
- **Source Table**: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`
- **Description**: Contains Medicare outpatient prospective payment system provider summary data for fiscal year 2013
- **Key Fields**:
  - Provider information (ID, name, address, city, state, zipcode)
  - APC (Ambulatory Payment Classification) codes and descriptions
  - Hospital referral regions
  - Number of outpatient services
  - Average estimated submitted charges and total payments

## Project Structure

### Folders
- **Views**: Contains LookML view definitions for data sources
- **Explores**: Contains explore definitions that join views together
- **Dashboards**: Contains dashboard definitions for reporting
- **data_tests**: Contains data quality and validation tests

### Key Files
- **manifest.lkml**: Defines project-level constants for table names
- **test_patient_data.model.lkml**: Main model file with connection, includes, and datagroup definitions

## Semantic Layer Structure

### Views

#### inpatient_charges_2013.view.lkml
Provides dimensions and measures for inpatient Medicare data:
- **Dimensions**: Provider details, geographic information, DRG definitions, hospital referral regions
- **Measures**: Total discharges, average covered charges, average total payments, average Medicare payments, provider counts
- **Primary Key**: Composite key of provider_id and drg_definition

#### outpatient_charges_2013.view.lkml
Provides dimensions and measures for outpatient Medicare data:
- **Dimensions**: Provider details, geographic information, APC codes, hospital referral regions, extracted APC 4-digit code
- **Measures**: Total outpatient services, average estimated submitted charges, average total payments, provider counts
- **Primary Key**: Composite key of provider_id and apc
- **Special Feature**: `apc_code` dimension extracts the 4-digit code from the beginning of the APC field

### Explores

#### Inpatient & Outpatient
- **File**: Explores/inpatient_outpatient.explore.lkml
- **Base View**: inpatient_charges_2013 (labeled "Inpatient Charges")
- **Joined View**: outpatient_charges_2013 (labeled "Outpatient Charges")
- **Join Type**: Left outer join on provider_id
- **Relationship**: many_to_one (many inpatient records to one outpatient record per provider)
- **Use Case**: Enables combined analysis of inpatient and outpatient data at the provider level

### Data Refresh Strategy

#### Datagroup: week_end
- **Description**: Triggers every Monday at 9am Eastern Time
- **Logic**: SQL-based trigger that fires on Mondays at 9am ET
- **Cache Duration**: 12 hours
- **Purpose**: Ensures weekly data refresh while maintaining performance through caching

## Reports and Dashboards

### Provider Metrics Dashboard
- **File**: Dashboards/provider_metrics.dashboard.lookml
- **Components**:
  1. **Total Number of Providers**: Single value tile showing distinct count of providers
  2. **Outpatient Services by City and Hospital**: Column chart displaying outpatient service volumes segmented by city and hospital referral region
- **Filters**:
  - City (provider_city)
  - Hospital (hospital_referral_region)
  - Zipcode (provider_zipcode)
- **Use Cases**:
  - Monitor provider network size
  - Analyze service distribution across geographic regions
  - Identify high-volume service areas

## Data Quality Tests

### Test Files
- **File**: data_tests/patient_data_tests.lkml

### Test Definitions

#### 1. Inpatient Zipcode Not Null
- **Test Name**: `inpatient_zipcode_not_null`
- **Purpose**: Validates that the provider_zipcode field in inpatient_charges_2013 contains no NULL values
- **Assertion**: Count of records with NULL zipcode should equal 0
- **Impact**: Ensures geographic analysis integrity

#### 2. Outpatient Services Threshold by City
- **Test Name**: `outpatient_services_threshold_by_city`
- **Purpose**: Validates that outpatient_services measure exceeds 1000 for each city
- **Assertion**: Total outpatient services by city should be greater than 1000
- **Impact**: Identifies cities with insufficient service volume data

## Best Practices Implemented

### Naming Conventions
- View files use `.view.lkml` extension
- Explore files use `.explore.lkml` extension
- Dashboard files use `.dashboard.lookml` extension
- All files follow Looker naming standards (no spaces or special characters)

### LookML Standards
- All dimensions and measures include labels and descriptions
- Measures are based on hidden raw dimensions for consistency
- All measures use standardized value format: `#,##0.00`
- Primary keys defined and hidden in all views
- Table names defined as constants in manifest file for easy maintenance
- Proper use of backticks for BigQuery table references

### Performance Optimization
- Datagroup implementation for intelligent caching
- Primary keys defined for optimization
- Appropriate use of aggregate functions in measures

## Usage Guidelines

### Analyzing Provider Data
1. Use the "Inpatient & Outpatient" explore to analyze combined provider metrics
2. Filter by geographic dimensions (city, state, zipcode) for regional analysis
3. Compare inpatient vs outpatient metrics across providers
4. Use the Provider Metrics Dashboard for high-level monitoring

### Extending the Project
1. Add new views in the `Views` folder following the established pattern
2. Create new explores in the `Explores` folder
3. Define any new table constants in `manifest.lkml`
4. Add data tests to validate new data sources

## Technical Requirements
- Looker instance with BigQuery connection configured
- Connection name: `badal_internal_projects`
- Access to GCP project: `prj-s-dlp-dq-sandbox-0b3c`
- Access to dataset: `EK_test_data`

## Support and Maintenance
For questions or issues with this project, please contact your Looker administrator or data team.
