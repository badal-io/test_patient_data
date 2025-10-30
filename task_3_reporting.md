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

### Example usage

#### Example 1

Dashboard that
* named Test_Dashboard
* has 2 filters: Type and Country
* has 1 tile, named "Table tile" and it's table type of visualization

```
---
- dashboard: test_dashboard
  title: Test_Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: oRNjwHYklLaKEpJAOCpKMs
  elements:
  - title: Table tile
    name: Table tile
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    type: looker_grid
    fields: [v_netflix_titles_enriched.type, v_netflix_titles_enriched.count, v_netflix_titles_enriched.avg_tv_seasons,
      v_netflix_titles_enriched.country]
    sorts: [v_netflix_titles_enriched.count desc 0]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Type: v_netflix_titles_enriched.type
      Country: v_netflix_titles_enriched.country
    row: 0
    col: 0
    width: 24
    height: 9
  filters:
  - name: Type
    title: Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    listens_to_filters: []
    field: v_netflix_titles_enriched.type
  - name: Country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    listens_to_filters: []
    field: v_netflix_titles_enriched.country
```

#### Example 2

Dashboard that
* named Test_Dashboard
* has 3 filters: Type, Country and "Date Added Date"
* has 3 tiles
  * Pie chart named "Pie tile"
  * Single digit tile named "Total count"
  * Bar chart tile named "Bar chart tile"

```
---
- dashboard: test_dashboard
  title: Test_Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: oRNjwHYklLaKEpJAOCpKMs
  elements:
  - title: Pie tile
    name: Pie tile
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    type: looker_pie
    fields: [v_netflix_titles_enriched.type, v_netflix_titles_enriched.count]
    sorts: [v_netflix_titles_enriched.count desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Country: v_netflix_titles_enriched.country
      Type: v_netflix_titles_enriched.type
      Date Added Date: v_netflix_titles_enriched.date_added_date
    row: 0
    col: 0
    width: 9
    height: 8
  - title: Total count
    name: Total count
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    type: single_value
    fields: [v_netflix_titles_enriched.count]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_pivots: {}
    listen:
      Country: v_netflix_titles_enriched.country
      Type: v_netflix_titles_enriched.type
      Date Added Date: v_netflix_titles_enriched.date_added_date
    row: 0
    col: 9
    width: 5
    height: 4
  - title: Bar chart tile
    name: Bar chart tile
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    type: looker_bar
    fields: [v_netflix_titles_enriched.count, v_netflix_titles_enriched.country]
    sorts: [v_netflix_titles_enriched.count desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      v_netflix_titles_enriched.count: "#211B41"
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_pivots: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Country: v_netflix_titles_enriched.country
      Type: v_netflix_titles_enriched.type
      Date Added Date: v_netflix_titles_enriched.date_added_date
    row: 0
    col: 14
    width: 10
    height: 8
  filters:
  - name: Type
    title: Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    listens_to_filters: []
    field: v_netflix_titles_enriched.type
  - name: Country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    listens_to_filters: []
    field: v_netflix_titles_enriched.country
  - name: Date Added Date
    title: Date Added Date
    type: field_filter
    default_value: 90 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: bi_sandbox
    explore: v_netflix_titles_enriched
    listens_to_filters: []
    field: v_netflix_titles_enriched.date_added_date
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