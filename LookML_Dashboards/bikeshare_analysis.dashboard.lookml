- dashboard: bikeshare_analysis
  title: Bikeshare Analysis
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Comprehensive analysis of bikeshare trips with station locations
  elements:
  - title: Total Trips
    name: Total Trips
    model: test_patient_data
    explore: bikeshare_info
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
    show_value_labels: false
    value_labels: legend
    label_type: labPer
    defaults_version: 1
    listen:
      Start Station Name Filter: bikeshare_stations_start.name
      End Station Name Filter: bikeshare_stations_end.name
      Subscriber Type Filter: bikeshare_trips.subscriber_type
      Bike Type Filter: bikeshare_trips.bike_type
    row: 0
    col: 0
    width: 4
    height: 4

  - title: Average Trip Duration (Minutes)
    name: Average Trip Duration (Minutes)
    model: test_patient_data
    explore: bikeshare_info
    type: single_value
    fields: [bikeshare_trips.average_duration_minutes]
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
    show_value_labels: false
    value_labels: legend
    label_type: labPer
    defaults_version: 1
    listen:
      Start Station Name Filter: bikeshare_stations_start.name
      End Station Name Filter: bikeshare_stations_end.name
      Subscriber Type Filter: bikeshare_trips.subscriber_type
      Bike Type Filter: bikeshare_trips.bike_type
    row: 0
    col: 4
    width: 4
    height: 4

  - title: Bike Type Distribution
    name: Bike Type Distribution
    model: test_patient_data
    explore: bikeshare_info
    type: single_value
    fields: [bikeshare_trips.bike_type]
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
    show_value_labels: false
    value_labels: legend
    label_type: labPer
    defaults_version: 1
    listen:
      Start Station Name Filter: bikeshare_stations_start.name
      End Station Name Filter: bikeshare_stations_end.name
      Subscriber Type Filter: bikeshare_trips.subscriber_type
      Bike Type Filter: bikeshare_trips.bike_type
    row: 0
    col: 8
    width: 4
    height: 4

  - title: Trips by Subscriber Type
    name: Trips by Subscriber Type
    model: test_patient_data
    explore: bikeshare_info
    type: looker_bar
    fields: [bikeshare_trips.subscriber_type, bikeshare_trips.count]
    sorts: [bikeshare_trips.count desc]
    limit: 25
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
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen:
      Start Station Name Filter: bikeshare_stations_start.name
      End Station Name Filter: bikeshare_stations_end.name
      Subscriber Type Filter: bikeshare_trips.subscriber_type
      Bike Type Filter: bikeshare_trips.bike_type
    row: 0
    col: 12
    width: 12
    height: 9

  - title: Trip Details Table
    name: Trip Details Table
    model: test_patient_data
    explore: bikeshare_info
    type: table
    fields: [bikeshare_trips.subscriber_type, bikeshare_trips.bike_type, bikeshare_stations_start.name, bikeshare_stations_end.name, bikeshare_trips.count]
    sorts: [bikeshare_trips.count desc 0]
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    listen:
      Start Station Name Filter: bikeshare_stations_start.name
      End Station Name Filter: bikeshare_stations_end.name
      Subscriber Type Filter: bikeshare_trips.subscriber_type
      Bike Type Filter: bikeshare_trips.bike_type
    row: 9
    col: 0
    width: 12
    height: 8

  - title: Bike Station Locations
    name: Bike Station Locations
    model: test_patient_data
    explore: bikeshare_info
    type: looker_map
    fields: [bikeshare_stations_start.location, bikeshare_stations_start.name, bikeshare_stations_start.count]
    sorts: [bikeshare_stations_start.count desc]
    limit: 500
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_on: 'false'
    map_tile_provider: light
    map_position: fit_bounds
    showlegend: true
    defaults_version: 1
    listen:
      Start Station Name Filter: bikeshare_stations_start.name
      End Station Name Filter: bikeshare_stations_end.name
      Subscriber Type Filter: bikeshare_trips.subscriber_type
      Bike Type Filter: bikeshare_trips.bike_type
    row: 9
    col: 12
    width: 12
    height: 8

  filters:
  - name: Start Station Name Filter
    title: Start Station Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: bikeshare_info
    listens_to_filters: []
    field: bikeshare_stations_start.name

  - name: End Station Name Filter
    title: End Station Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: bikeshare_info
    listens_to_filters: []
    field: bikeshare_stations_end.name

  - name: Subscriber Type Filter
    title: Subscriber Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: test_patient_data
    explore: bikeshare_info
    listens_to_filters: []
    field: bikeshare_trips.subscriber_type

  - name: Bike Type Filter
    title: Bike Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: test_patient_data
    explore: bikeshare_info
    listens_to_filters: []
    field: bikeshare_trips.bike_type
