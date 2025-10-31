# Task

Generate LookML dashboards for a looker project 'test_patient_data' that uses 'test_patient_data' model file.

Do a comprehensive research on building LookML dashboards taking into account this document and the information that you can find yourself.

# Database/Connection

This Looker project is connected to a database in BigQuery (GCP)

# Model file
The model file is already created with the connection defined.

* Add 'include` lines to include elements from LookML_Dashboards folder.

A common practice is to include all LookML dashboards in a model by using a wildcard:
`include: "*.dashboard.lookml"`

or, if your LookML dashboards appear within a folder in the IDE, use the path to their location
`include: "/path/*.dashboard.lookml"`


# Project structure

* Create folders:
   * LookML_Dashboards (for LookML dashboards)

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

## How to build LookML Dashboards

### Parameter definitions

*dashboard*	Create a dashboard.
*preferred_viewer*	This parameter is ignored.
*title* (for dashboard)	Change the way a dashboard name appears to users.
*description* (for dashboard)	Add a description that can be viewed in the Dashboard Details panel or in a folder set to list view.
*enable_viz_full_screen*	Define whether dashboard viewers can see dashboard tiles in full-screen and expanded views.
*extends*	Base the LookML dashboard on another LookML dashboard.
*extension*	Require that the dashboard is extended by another dashboard.
*layout*	Define the way that the dashboard will place elements.
*rows*	Start a section of LookML to define the elements that should go into each row of a layout: grid dashboard.
*elements* (for rows)	Define the elements that should go into a row of a layout: grid dashboard.
*height* (for rows)	Define the height of a row for a layout: grid dashboard.
*tile_size*	Define the size of a tile for a layout: tile dashboard.
*width* (for dashboard)	Define the width of the dashboard for a layout: static dashboard.
*refresh* (for dashboard)	Set the interval on which dashboard elements will automatically refresh.
*auto_run*	Determine whether dashboards run automatically when initially opened or reloaded.

Filter Parameters
*crossfilter_enabled*	Enable or disable cross-filtering for a dashboard.
*filters_bar_collapsed*	Added 21.16 Set the dashboard filter bar as default collapsed or expanded for a dashboard.
*filters_location_top*	Added 22.8 Set the dashboard filter bar location as top or right for a dashboard.
*filters* (for dashboard)	Start a section of LookML to define dashboard filters.
*name* (for filters)	Create a filter.
*title* (for filters)	Change the way a filter name appears to users.
*type* (for filters)	Determine the type of filter to be used.
*default_value*	Set a default value for a filter.
*allow_multiple_values*	Limit users to a single filter value.
*required*	Require that users enter a filter value to run the dashboard.
*ui_config*	Configure the filter controls that are available when users view a LookML dashboard. Has subparameters type, display, and options.
*model* (for filters)	Specify the model that contains the underlying field of a type: field_filter filter.
*explore* (for filters)	Specify the Explore that contains the underlying field of a type: field_filter filter.
*field*	Specify the underlying field of a type: field_filter filter.
*listens_to_filters*	Narrow suggestions for dashboard filters of field_filter based on what the user enters for another dashboard filters of type: field_filter.

Embedded Dashboard Parameters
*embed_style*	Start a section of LookML to define embedded dashboard customizations.
*background_color*	Set a background color of an embedded dashboard.
*show_title*	Specify whether the dashboard title is visible on an embedded dashboard.
*title_color*	Set the color of the title of an embedded dashboard.
*show_filters_bar*	Specify whether the filters bar is visible on an embedded dashboard.
*tile_background_color*	Set the tile background color of an embedded dashboard.
*tile_text_color*	Set the tile text color of an embedded dashboard.

## LookML Dashboard examples

There are 10 examples for LookML Dashboards provided in the folder `project_name/dashboard_examples/`. Please analyze them before building the reports. 
The examples show LookML code for different set ups:
* different tile types
* different filter types
* different combinations of tiles and filters

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