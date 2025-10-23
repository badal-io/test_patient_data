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

# Reporting
Build a lookML dashboard that has
    * single tile with number of providers (count of provider_id)
    * Column chart with: City (provider_city), Hospital (hospital_referral_region) and outpatient_services
    * filters: City, Hospital, Zipcode

# Rules/Best Practices

## Naming convention for LookML elements

* Spaces and special characters: Filenames cannot include spaces or any of the following characters: / ? * : | " < > %
* File extensions: When creating LookML files with the Looker IDE, Looker will automatically add the .lkml extension to the end of the filename if you don't include the extension manually. For example, if you enter the filename flights_data_tests, Looker will name the file flights_data_tests.lkml

## File types:

* Model files with the file extension .model.lkml
* View files with the file extension .view.lkml 
* Project manifest files that are always named manifest.lkml
* Dashboard files with the file extension .dashboard.lookml
* Document files with the file extension .md
* Locale strings files with the file extension .strings.json
* Generic LookML files, which are used for the following types of files:
    * Explore files with the file extension .explore.lkml
    * Data test files with the file extension .lkml
    * Refinements files with the file extension .lkml
    * Any other files you're using to house LookML elements

## Defining a datagroup

Define a datagroup with the datagroup parameter, either in a model file or in its own LookML file. You can define multiple datagroups if you want different caching and persistent derived table (PDT) rebuild policies for different Explores or PDTs in your project.

The datagroup parameter can have the following subparameters:

* **label** — Specifies an optional label for the datagroup.
* **description** — Specifies an optional description for the datagroup that can be used to explain the datagroup's purpose and mechanism.
* **max_cache_age** — Specifies a string that defines a time period. When the age of a query's cache exceeds the time period, Looker invalidates the cache. The next time the query is issued, Looker sends the query to the database for fresh results.
The max_cache_age parameter specifies a string containing an integer followed by "seconds", "minutes", or "hours". This time period is the maximum time period for the cached results to be used by Explore queries that use the datagroup
* **sql_trigger** — Specifies a SQL query that returns one row with one column. If the value that is returned by the query is different from the query's prior results, then the datagroup goes into a triggered state.
* **interval_trigger** — Specifies a time schedule for triggering the datagroup, such as "24 hours".

At a minimum, a datagroup must have at least the max_cache_age parameter, the sql_trigger parameter, or the interval_trigger parameter.

A datagroup cannot have both sql_trigger and interval_trigger parameters. If you define a datagroup with both parameters, the datagroup will use the interval_trigger value and ignore the sql_trigger value, since the sql_trigger parameter requires Looker to use database resources when querying the database.

## Defining an explore

### Don't forget to use include
For the explore file `include` has to be used to inlude files or folders with the view files.
If there is a folder with all views it's better to include just it instead of all files. 

### relationships paratemeter
Relationships in LookML describe the cardinality between a base view and a joined view. This information is crucial for Looker’s query engine to generate efficient and correct SQL, especially for aggregations. The relationship parameter is a best practice to always include in a join.

Types of Relationships
* **many_to_one**: Many rows in the base view correspond to one row in the joined view. This is the most common relationship for joining a fact table to a dimension table. For example, many orders can be associated with one customer.
* **one_to_one**: Every row in the base view corresponds to exactly one row in the joined view.
* **one_to_many**: One row in the base view corresponds to many rows in the joined view. For example, a single order can have many order_items.
* **many_to_many**: Many rows in the base view correspond to many rows in the joined view. This is the most complex relationship.

## Use of variables from manifest file
For BigQuery connection:
When a table name defined as a constant in the manifest file then the constant should be put in `` when is used in a view file. 
For example:
* Manifeset constant:
'''
constant: table_name {
  value: "project_name.schema_name.table_name"
  export: override_required
}
'''
* View file:
```
view: view_name {
  sql_table_name: `@{table_name}` ;;
  ...
```
