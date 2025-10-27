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
    * cache should be stored for 12 hours

# Project structure

* Create folders:
    * Views (for view files)
    * Explores (for explore lookml files)
    * LookML_Dashboards (for LookML dashboards)
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

## View 3

Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`

Name: bikeshare_trips


Table's ddl:
CREATE TABLE `bigquery-public-data.austin_bikeshare.bikeshare_trips`
(
  trip_id STRING OPTIONS(description="Numeric ID of bike trip"),
  subscriber_type STRING OPTIONS(description="Type of the Subscriber"),
  bike_id STRING OPTIONS(description="ID of bike used"),
  bike_type STRING OPTIONS(description="Type of bike used"),
  start_time TIMESTAMP OPTIONS(description="Start timestamp of trip"),
  start_station_id INT64 OPTIONS(description="Numeric reference for start station"),
  start_station_name STRING OPTIONS(description="Station name for start station"),
  end_station_id STRING OPTIONS(description="Numeric reference for end station"),
  end_station_name STRING OPTIONS(description="Station name for end station"),
  duration_minutes INT64 OPTIONS(description="Time of trip in minutes")
);

Dimensions:
trip_id,
  subscriber_type,
  bike_id STRING,
  bike_type STRING,
  start_station_id ,
  start_station_name ,
  end_station_id ,
  end_station_name

Dimension_groups (type time):

  start_time

Measures:
  duration_minutes

## View 4

Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations`

Name: bikeshare_stations


Table's ddl:
CREATE TABLE `bigquery-public-data.austin_bikeshare.bikeshare_stations`
(
  station_id INT64,
  name STRING,
  status STRING,
  location STRING,
  address STRING,
  alternate_name STRING,
  city_asset_number INT64,
  property_type STRING,
  number_of_docks INT64,
  power_type STRING,
  footprint_length INT64,
  footprint_width FLOAT64,
  notes STRING,
  council_district INT64,
  image STRING,
  modified_date TIMESTAMP
)
OPTIONS(
  description="Austin Bikeshare Stations table"
);

Dimensions:
  station_id INT64,
  name STRING,
  status STRING,
  address STRING,
  alternate_name STRING,
  city_asset_number INT64,
  property_type STRING,
  power_type STRING,
  notes STRING,
  council_district INT64,
  image STRING,

Dimensions (type location):
  location

Dimension_groups (type time):

  modified_date

Measures:
  number_of_docks INT64,
  footprint_length INT64,
  footprint_width FLOAT64,

## How to build views

* All dimensions and measures should have labels and descriptions
    * if description for a field is not provided then either put something simple there if it can be derived from the field name or leave it empty
* All measures should be defined first as hidden dimensions and then created as measures based on those dimensions
* Measure values can be NULLs so please make sure to convert NULLs to 0 for measures otherwise aggregation won't work
* All measures should have the following format: value_format: "#,##0.00"
* None of the tables have a primary key so I would like you to add it to each view and declare it as a primary key and make it hidden
* define both table names as constants in the manifest file and use those constants in 'sql_table_name' or 'derived_table'

## Specific requests

* for outpatient_charges_2013 view add a dimension that extracts a 4 digit code that is in the beggining field 'apc' and call it 'apc_code'

# Explores:
## Explore 1:
* name: Inpatient & Outpatient
* join logic: 
    select 
    a.*,
    b.*
    from `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013` a
    join `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013` b
    on a.provider_id=b.provider_id
* View 1:
    * inpatient_charges_2013
    * view label: Inpatient Chargers
* View 2:
    * outpatient_charges_2013
    * view label: Outpatient Chargers 

* Join type: left_outer
* relationship: many_to_one

## Explore 2:
* name: Bikeshare Info
* join logic: 
select
a.*,
b.*,
c.*

from `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips` a
left join `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations` b on a.start_station_id=b.station_id
left join `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations` c on cast(a.end_station_id as INTEGER)=c.station_id
* View 1:
    * bikeshare_trips
    * view label: Bikeshare Trips
* View 2:
    * bikeshare_stations
    * view label: Start Bike Stations
* View 3:
    * bikeshare_stations
    * view label: End Bike Stations

* Join type: left_outer
* relationship: many_to_one

# Reporting
## Dashboard 1
for Explore 1:
Build a lookML dashboard that has
    * single tile with number of providers (count of provider_id)
    * Column chart with: City (provider_city), Hospital (hospital_referral_region) and outpatient_services
    * filters: City, Hospital, Zipcode
## Dashboard 2
for Explore 2:
Build a lookML dashboard that has
    * 4 tiles with general information about the data
    * the 5th tile make a map tile that shows locations of all bike stations
    * filters:
        * Start station name (take it from the joined view for stations not from trip view)
        * End station name (take it from the joined view for stations not from trip view)
        * Subscriber Type
        * Bike Type

# Data tests
## for Explore 1:
* Create two data tests
    *  Check that provider zipcode field from inpatient_charges_2013 doesn't have any NULLs
    * check that measure outpatient_services from outpatient_charges_2013 is greater than 1000 by city

## for Explore 2:
* Create 2 data test:
    * to check that start_station_id and end_station_id in bikeshare_trip view are not NULLs

# Documentation
Generate a Readme.md file with the information about the project:
* source data
* structure of the semantic layer
* what reports are defined
* etc

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
}
```

## Data tests
You can create data tests in model files, view files, or in separate, dedicated data test files. When using a dedicated file to house your data tests, remember to include the data test file in any model file or view file where you want to run your data tests.

A data test cannot have the same name and explore_source as another data test in the same project. If you are using the same explore_source for multiple data tests in your project, be sure that the names of the data tests are all unique.

The test parameter has the following subparameters:
* explore_source: Defines the query to use in the data test.
* assert: Defines a Looker expression that is run on every row of the test query to verify the data. For use in data tests, fields in the Looker expression must be fully scoped, meaning they are specified using the view_name.field_name format

Example:
```
# This next data test checks to make sure that the 2017 revenue value is always $626,000. In this dataset, that is a known value that should never change.

test: historic_revenue_is_accurate {
  explore_source:  orders {
    column:  total_revenue {
      field:  orders.total_revenue 
    }
    filters: [orders.created_date:  "2017"]
  }
  assert:  revenue_is_expected_value {
    expression: ${orders.total_revenue} = 626000 ;;
  }
}

# This next data test checks to make sure that there are no null values in the data. This explore_source uses a sort to be sure that any nulls will be returned at the top of query. Sorting for nulls can vary, based on your dialect. The following test uses desc: yes as an example.
test: status_is_not_null {
  explore_source: orders {
    column: status {}
    sorts: [orders.status: desc]
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${orders.status}) ;;
  }
}
```

## Defining date dimensions
For date or timestamp type of dimension please use `dimension_group` with type `time`
Please follow this structure where `created` is just an example (please note that for `labal: "Created"` Looker will add `Date` automatically in the end as it's a dimension group)
```
dimension_group: created {
  type: time
  label: "Created"
  timeframes: [time, date, week, month, raw]
  sql: ${TABLE}.created_at ;;
}
 ```

 also add a formated date as dimension that is going to be a part of this dimension group. 
 like this:
 ```
 dimension: created_month_year {
    group_label: "Created Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${created_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }
 ```

## Defining geo dimensions that can be used in map chart
### type: location
type: location is used in conjunction with the sql_latitude and sql_longitude parameters to create coordinates that you want to plot on a Map or Static Map (Points) visualization 
```
view: view_name {
  dimension: field_name {
    type: location
    sql_latitude:${field_name_1} ;;
    sql_longitude:${field_name_2} ;;
  }
}
```

### type: zipcode
type: zipcode is used with zip code dimensions that you want to plot on a Static Map (Points) visualization (use a state or country field for Static Map (Regions)). Any dimension of type: zipcode is automatically given the map_layer_name of us_zipcode_tabulation_areas

```
dimension: zip {
  type: zipcode
  sql: ${TABLE}.zipcode ;;
}
```