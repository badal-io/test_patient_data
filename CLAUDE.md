# Task

Generate LookML code for a looker project 'test_patient_data' that uses 'test_patient_data' model file. 
Please pay attention to how to build Explores and LookML Dashboards that is described in the end of the file.

# Database/Connection

This Looker project is connected to a database in BigQuery (GCP)

# Model file
The model file is already created with the connection defined.

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
    *add a few tiles: 2-3 single digit ones, 1 table and 1 bar chart
    * the last tile make a map tile that shows locations of all bike stations
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

# Defining Explores

## Prefered syntax

```
explore: explore_name {
    description: "Description I want"
    group_label: "Label to use as a heading in the Explore menu"
    label: "desired label"
    from: view_name #use from over view_name
    persist_for: "N (seconds | minutes | hours)"
    persist_with: datagroup_name

    join: view_name {
        # Desired join parameters (described on Join Parameters page)
        view_label: "desired label for the view"

        # JOIN PARAMETERS
        fields: [field_or_set, field_or_set, ...]
        foreign_key: dimension_name
        from: view_name
        outer_only: no | yes
        relationship: many_to_one | many_to_many | one_to_many | one_to_one 
        required_joins: [view_name, view_name, ...]
        sql_on: SQL ON clause ;;
        sql_table_name: table_name ;;
        type: left_outer | cross | full_outer | inner 

        # QUERY PARAMETERS
        required_access_grants: [access_grant_name, access_grant_name, ...]
        sql_where: SQL WHERE condition ;;
    }
}
```

### Example

```
explore: main_table {
  label: "Product and Category analysis"
  description: "This is the main_table explore that I have joined the category_table view to"
  view_label: "Field Picker title "
  group_label: "Test Explores"
  always_filter: {
    filters: [product_table.name: "A,B,C"]
  }
  join: category_table {
    sql_on: ${main_table.category_id} = ${category_table.id} ;;
    relationship: many_to_one
    type: left_outer
    fields: [category_table.name]
  }
  join: product_table {
    sql_on: ${main_table.product_id} = ${product_table.id} ;;
    type: left_outer
    relationship: many_to_one
  }
}
```
where `main_table`, `category_table` and `product_table` are views

## All parameters
```
explore: explore_name {
  extension: required
  extends: [explore_name,  explore_name, ...]
  fields: [field_or_set, field_or_set, ...]
  tags: ["string1", "string2", ...]

  # DISPLAY PARAMETERS
  description: "Description I want"
  group_label: "Label to use as a heading in the Explore menu"
  hidden: yes | no
  label: "desired label"
  query:  {
      # Desired query parameters (described on the query page)      }
  view_label: "Field picker heading I want for the Explore's fields"

  # FILTER PARAMETERS

  access_filter: {
    field: fully_scoped_field
    user_attribute: user_attribute_name
  }

  # Possibly more access_filter declarations

  always_filter: {
    filters: [field_name: "filter expression", field_name: "filter expression", ...]
  }
  case_sensitive: yes | no
  conditionally_filter: {
    filters: [field_name: "filter expression", field_name: "filter expression", ...]
    unless: [field_name, field_name, ...]
  }
  sql_always_having: SQL HAVING condition ;;
  sql_always_where: SQL WHERE condition ;;

  # JOIN PARAMETERS

  always_join: [view_name, view_name, ...]
  join: view_name {
    # Desired join parameters (described on Join Parameters page)
  }
  # Possibly more join declarations

  # QUERY PARAMETERS

  cancel_grouping_fields: [fully_scoped_field, fully_scoped_field, ...]
  from: view_name
  persist_for: "N (seconds | minutes | hours)"
  persist_with: datagroup_name
  required_access_grants: [access_grant_name, access_grant_name, ...]
  sql_table_name: table_name ;;
  sql_preamble: SQL STATEMENT  ;;
  symmetric_aggregates: yes | no
  view_name: view_name

  # AGGREGATE TABLE PARAMETERS

  aggregate_table: table_name {
    query:  {
      # Desired query parameters (described on the aggregate_table page)
    }
    materialization:  {
      # Desired materialization parameters (described on the aggregate_table page)
    }
  }
  # Possibly more aggregate_table declarations
}

## REFINEMENT PARAMETERS

explore: +explore_name {
  final: yes
}
```

## Defining dashboards

All LookML Dashboards parameters can be found here:
https://docs.cloud.google.com/looker/docs/reference/param-lookml-dashboard


### Example

```
- dashboard: dashboard_name
  preferred_viewer: dashboards | dashboards-next
  title: "chosen dashboard title"
  description: "chosen dashboard description"
  enable_viz_full_screen: true | false
  extends: name_of_dashboard_being_extended
  extension: required
  layout: tile | static | grid | newspaper
  rows:
    - elements: [element_name, element_name, ...]
      height: N
  tile_size: N
  width: N
  refresh: N (seconds | minutes | hours | days)
  auto_run: true | false

  # DASHBOARD FILTER PARAMETERS
  crossfilter_enabled: true | false
  filters_bar_collapsed: true | false
  filters_location_top: true | false
  filters:
  - name: filter_name
    title: "chosen filter title"
    type: field_filter | number_filter | date_filter | string_filter
    model: model_name
    explore: explore_name
    field: view_name.field_name
    default_value: Looker filter expression
    allow_multiple_values: true | false
    required: true | false
    ui_config:
      type: button_group | checkboxes | range_slider | tag_list | radio_buttons |
            button_toggles | dropdown_menu | slider | day_picker | day_range_picker |
            relative_timeframes | advanced
      display: inline | popover | overflow
      options:
        min: N
        max: N
      - value options
    listens_to_filters:
    - filter_name
      field: view_name.field_name

  # EMBEDDED DASHBOARD PARAMETERS
  embed_style:
    background_color: "css_color"
    show_title: true | false
    title_color: "css_color"
    show_filters_bar: true | false
    tile_background_color: "css_color"
    tile_text_color: "css_color"

  # ELEMENTS PARAMETERS
  elements:
  # One or more element declarations
```