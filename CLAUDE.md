# Task

Generate LookML code for a looker project 'test_patient_data' that uses 'test_patient_data' model file.

# Database/Conection

This Looker project is connected to a database in BigQuery (GCP)

# Model file
The model file is already create with the connection defined.

* Add 'include` lines to include elements from all folders
* add a datagroup:
    * name: week_end
    * description: Triggers every Monday at 9am Eastern Time 
    * logic: sql statement that triggers on mondays at 9am ET

# Project structure

* Create folders:
    * Views (for view files)
    * Explores (for explore lookml files)
    * LookML Dashboards (for LookML dashboards)
    * data_tests (for data tests)
* Create a manifest file (to define constants)

# Views
## View 1

Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`

Name: inpatient_charges_2013


Table's ddl:
CREATE TABLE `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013`
(
  provider_id STRING,
  provider_name STRING,
  provider_street_address STRING,
  provider_city STRING,
  provider_state STRING,
  provider_zipcode STRING,
  drg_definition STRING,
  hospital_referral_region_description STRING,
  total_discharges INT64,
  average_covered_charges FLOAT64,
  average_total_payments FLOAT64,
  average_medicare_payments FLOAT64
);

Dimensions:
provider_id STRING,
  provider_name STRING,
  provider_street_address STRING,
  provider_city STRING,
  provider_state STRING,
  provider_zipcode STRING,
  drg_definition STRING,
  hospital_referral_region_description STRING,

Measures:
  total_discharges INT64,
  average_covered_charges FLOAT64,
  average_total_payments FLOAT64,
  average_medicare_payments FLOAT64


## View 2
Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`

Name: outpatient_charges_2013


Table's ddl:
CREATE TABLE `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013`
(
  provider_id STRING,
  provider_name STRING,
  provider_street_address STRING,
  provider_city STRING,
  provider_state STRING,
  provider_zipcode STRING,
  apc STRING,
  hospital_referral_region STRING,
  outpatient_services INT64,
  average_estimated_submitted_charges FLOAT64,
  average_total_payments FLOAT64
);

Dimensions:
  provider_id STRING,
  provider_name STRING,
  provider_street_address STRING,
  provider_city STRING,
  provider_state STRING,
  provider_zipcode STRING,
  apc STRING,
  hospital_referral_region STRING,

Measures:
  outpatient_services INT64,
  average_estimated_submitted_charges FLOAT64,
  average_total_payments FLOAT64

## How to build views

* All dimensions and measures should have labels and descriptions
    * if description for a field is not provided then either put something simple there if it can be derived from the field name or leave it empty
* All measures should be defined first as hidden dimensions and then created as measures based on those dimensions
* All measures should have the following format: value_format: "#,##0.00"
* None of the tables have a primary key so I would like you to add it to each view and declare it as a primary key and make it hidden
* define both table names as constants in the manifest file and use those constants in 'sql_table_name' or 'derived_table'

## Specific requests

* for outpatient_charges_2013 view add a dimension that extracts a 4 digit code that is in the beggining field 'apc' and call it 'apc_code'

# Explores:
Explore 1:
* name: Inpatient & Outpatient
* join logic: 
    select 
    a.*,
    b.*
    from `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013` a
    join `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013` b
    on a.provider_id=b.provider_id
* 

# Reporting
Build a lookML dashboard that has
    * single tile with number of providers (count of provider_id)
    * Column chart with: City (provider_city), Hospital (hospital_referral_region) and outpatient_services
    * filters: City, Hospital, Zipcode