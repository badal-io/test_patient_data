---
- dashboard: bikeshare_analysis
  title: Bikeshare Analysis Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Bikeshare trip analysis with station information and metrics'
  preferred_slug: BikeshareAnalysisDashboard
  elements:
  - title: Total Trips
    name: total_trips
    model: test_patient_data
    explore: bikeshare_trips
    type: single_value
    fields: [bikeshare_trips.count]
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
      Start Station: bikeshare_stations.name
      End Station: bikeshare_stations_end.name
      Subscriber Type: bikeshare_trips.subscriber_type
      Bike Type: bikeshare_trips.bike_type
    row: 0
    col: 0
    width: 5
    height: 4
  - title: Total Duration Minutes
    name: total_duration
    model: test_patient_data
    explore: bikeshare_trips
    type: single_value
    fields: [bikeshare_trips.duration_minutes]
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
      Start Station: bikeshare_stations.name
      End Station: bikeshare_stations_end.name
      Subscriber Type: bikeshare_trips.subscriber_type
      Bike Type: bikeshare_trips.bike_type
    row: 0
    col: 5
    width: 5
    height: 4
  - title: Station Count
    name: station_count
    model: test_patient_data
    explore: bikeshare_trips
    type: single_value
    fields: [bikeshare_stations.count]
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
      Start Station: bikeshare_stations.name
      End Station: bikeshare_stations_end.name
      Subscriber Type: bikeshare_trips.subscriber_type
      Bike Type: bikeshare_trips.bike_type
    row: 0
    col: 10
    width: 5
    height: 4
  - title: Trips by Bike Type
    name: trips_by_bike_type
    model: test_patient_data
    explore: bikeshare_trips
    type: looker_grid
    fields: [bikeshare_trips.bike_type, bikeshare_trips.count]
    sorts: [bikeshare_trips.count desc 0]
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
      Start Station: bikeshare_stations.name
      End Station: bikeshare_stations_end.name
      Subscriber Type: bikeshare_trips.subscriber_type
      Bike Type: bikeshare_trips.bike_type
    row: 0
    col: 15
    width: 9
    height: 9
  - title: Trips by Subscriber Type
    name: trips_by_subscriber
    model: test_patient_data
    explore: bikeshare_trips
    type: looker_bar
    fields: [bikeshare_trips.subscriber_type, bikeshare_trips.count]
    sorts: [bikeshare_trips.count desc 0]
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
    series_colors: {}
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
      Start Station: bikeshare_stations.name
      End Station: bikeshare_stations_end.name
      Subscriber Type: bikeshare_trips.subscriber_type
      Bike Type: bikeshare_trips.bike_type
    row: 4
    col: 0
    width: 15
    height: 8
  - title: Bike Station Locations
    name: station_map
    model: test_patient_data
    explore: bikeshare_trips
    type: looker_map
    fields: [bikeshare_stations.location, bikeshare_stations.name, bikeshare_stations.count]
    sorts: [bikeshare_stations.count desc 0]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
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
      Start Station: bikeshare_stations.name
      End Station: bikeshare_stations_end.name
      Subscriber Type: bikeshare_trips.subscriber_type
      Bike Type: bikeshare_trips.bike_type
    row: 4
    col: 15
    width: 9
    height: 8
  filters:
  - name: Start Station
    title: Start Station
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: bikeshare_trips
    listens_to_filters: []
    field: bikeshare_stations.name
  - name: End Station
    title: End Station
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: bikeshare_trips
    listens_to_filters: []
    field: bikeshare_stations_end.name
  - name: Subscriber Type
    title: Subscriber Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: test_patient_data
    explore: bikeshare_trips
    listens_to_filters: []
    field: bikeshare_trips.subscriber_type
  - name: Bike Type
    title: Bike Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: test_patient_data
    explore: bikeshare_trips
    listens_to_filters: []
    field: bikeshare_trips.bike_type
