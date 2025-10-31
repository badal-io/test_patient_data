# Task

Generate LookML explores for a looker project 'test_patient_data' that uses 'test_patient_data' model file.

# Database/Connection

This Looker project is connected to a database in BigQuery (GCP)

# Model file
The model file is already created with the connection defined.

* Add 'include` lines to include elements from Explores folder.

# Project structure

* Create folders:
   * Explores (for explore lookml files)
        * in Explores folder please create 2 files:
            * bikeshare_explores for bikeshare related explores
            * patient_explores for inpatient and outpatient related explores

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

* Note: if dimensions are already converted to the same format on a view level then there is no need to convert them at join (explore) level. 

## Explores 3-6:

Create single simple explores for each view

```
explore: explore_name {
   label: "Explore Label"
   view_name: view_name
}
```

For example, for view `bikeshare_stations`
```
explore: bikeshare_stations_explore {
   label: "Bikeshare Stations"
   view_name: bikeshare_stations
}
```

# Defining an explore

## Don't forget to use include
For the explore file `include` has to be used to inlude files or folders with the view files.
If there is a folder with all views it's better to include just it instead of all files.

## relationships paratemeter
Relationships in LookML describe the cardinality between a base view and a joined view. This information is crucial for Looker’s query engine to generate efficient and correct SQL, especially for aggregations. The relationship parameter is a best practice to always include in a join.

Types of Relationships
* **many_to_one**: Many rows in the base view correspond to one row in the joined view. This is the most common relationship for joining a fact table to a dimension table. For example, many orders can be associated with one customer.
* **one_to_one**: Every row in the base view corresponds to exactly one row in the joined view.
* **one_to_many**: One row in the base view corresponds to many rows in the joined view. For example, a single order can have many order_items.
* **many_to_many**: Many rows in the base view correspond to many rows in the joined view. This is the most complex relationship.

## Explore paramaters

Structural Parameters

*extends* (for Explore)	Specifies Explore(s) that will be extended by this Explore
*extension* (for Explore)	Specifies that the Explore requires extension and cannot itself be exposed to users
*explore* (for model)	Exposes a view in the Explore menu
*fields* (for Explore)	Limits the fields available in an Explore from its base view and through the Explore's joins
*tags* (for Explore)	Specifies text that can be passed to other applications

Display Parameters

*description* (for Explore)	Adds a description for an Explore that appears to users in the UI
*group_label* (for Explore)	Creates a group label to use as a heading in the Explore menu
*hidden* (for Explore)	Hides an Explore from the Explore menu
*label* (for Explore)	Changes the way an Explore appears in the Explore menu
*query* (for Explore)	Creates a predefined query for users to select in an Explore's Quick Start menu.
*view_label* (for Explore)	Specifies how a group of fields from the Explore's base view will be labeled in the field picker

Filter Parameters

*access_filter*	Adds user-specific filters to an Explore
*always_filter*	Adds filters a user can change, but not remove, to an Explore
*case_sensitive* (for Explore)	Specifies whether filters are case-sensitive for an Explore
*conditionally_filter*	Adds filters to an Explore if a user does not add their own filter from a specific list
*sql_always_having*	Inserts conditions into the query's HAVING clause that a user cannot change or remove for this Explore
*sql_always_where*	Inserts conditions into the query's WHERE clause that a user cannot change or remove for this Explore

Join Parameters

*always_join*	Specifies which joins must always be applied to an Explore
*join*	Joins an additional view to an Explore. For more information about joins and their parameters, see the Join Parameters reference page.

Query Parameters

*cancel_grouping_fields*	Cancels the GROUP BY clause when certain fields are chosen in an Explore
*from* (for Explore)	Specifies the view on which an Explore will be based, and reference the fields of that view by the Explore's name
*persist_for* (for Explore)	Changes the cache settings for an Explore
*persist_with* (for Explore)	Specifies the datagroup to use for the Explore's caching policy
*required_access_grants* (for Explore)	Limits access to the Explore to only users whose user attribute values match the access grants
*sql_table_name* (for Explore)	Specifies the database table on which an Explore will be based
*symmetric_aggregates*	Specifies whether symmetric aggregates are enabled for an Explore
*view_name* (for Explore)	Specifies the view on which an Explore will be based, and references the fields of that view by the view's name

Aggregate Table Parameters

*aggregate_table*	Creates an aggregate table in order to use aggregate awareness for queries on the Explore. For information on the aggregate_table parameter, see the aggregate_table parameter page. For an overview of aggregate awareness, see the Aggregate awareness documentation page.
*query*	Defines the query for the aggregate table. For information on query and its subparameters, see the aggregate_table parameter page.
*materialization*	Defines the persistence strategy for the aggregate table. For information on materialization and its subparameters, see the aggregate_table parameter page.

Refinement Parameters

*explore: +explore_name*	Adds a plus sign (+) in front of an existing Explore name to add a refinement to the existing Explore. See the LookML refinements documentation page for more information and use cases.
*final*	Indicates that the current refinement is the final refinement allowed for the Explore. See the LookML refinements documentation page for more information and use cases.

```
## STRUCTURAL PARAMETERS

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

### from vs view_name vs label

Using from
You should use this option if you want to create multiple Explores from the same view and also want to reference fields differently for each Explore:
```
explore: customer {
  from: user
}
# Would appear in the Explore menu as 'Customer'
# Fields would appear like 'Customer Name'
# You would reference fields like ${customer.name}

explore: buyer {
  from: user
}
# Would appear in the Explore menu as 'Buyer'
# Fields would appear like 'Buyer Name'
# You would reference fields like ${buyer.name}
```

Using view_name
You should use this option if you want to create multiple Explores from the same view, and you want to reference fields the same way for each Explore:
```
explore: customer {
  view_name: user
}
# Would appear in the Explore menu as 'Customer'
# Fields would appear like 'User Name'
# You would reference fields like ${user.name}

explore: buyer {
  view_name: user
}
# Would appear in the Explore menu as 'Buyer'
# Fields would appear like 'User Name'
# You would reference fields like ${user.name}
```
Using label
You should use this option if you don't need to create multiple Explores from the same view, but want the Explore's name to appear differently in the Explore menu:
```
explore: user {
  label: "Customer"
}
# Would appear in the Explore menu as 'Customer'
# Fields would appear like 'User Name'
# You would reference fields like ${user.name}
```

from is rarely used with explore
It's not very common to use from to re-name an Explore. Although there are legitimate use cases, if you find yourself wanting to use this parameter, consider if you can simply rename the underlying view instead. It's much more common to rename joins using the join-level from parameter.

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
