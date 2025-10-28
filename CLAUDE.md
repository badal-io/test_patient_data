# Task

Generate LookML code for a looker project 'test_patient_data' that uses 'test_patient_data' model file.
I want you to generate views and explores. 

# Database/Connection

This Looker project is connected to a database in BigQuery (GCP)

# Model file
The model file is already created with the connection defined.

* Add 'include` lines to include elements from Views and Explores

# Project structure

* Create folders:
   * Views (for view files)
   * Explores (for explore lookml files)
        * in Explores folder please create 2 files:
            * bikeshare_explores for bikeshare related explores
            * patient_explores for inpatient and outpatient related explores
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

 add a dimension that extracts a 4 digit code that is in the beggining field 'apc' and call it 'apc_code'

Measures:
 outpatient_services INT64,
 average_estimated_submitted_charges FLOAT64,
 average_total_payments FLOAT64

## View 3

Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`

Name: bikeshare_trips

Table's ddl:
CREATE TABLE `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips`
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
CREATE TABLE `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations`
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

## Explores 3-6:

Create single simple explores for each view

like
```
explore: view_name {}
```

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