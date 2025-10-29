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

## Explores 3-6:

Create single simple explores for each view

like
```
explore: view_name {}
```

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
