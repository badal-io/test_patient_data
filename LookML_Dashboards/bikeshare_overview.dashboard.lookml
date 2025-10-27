- dashboard: bikeshare_overview
  title: Bikeshare Overview
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Dashboard for Bikeshare trips and stations information"

  elements:
  - title: Total Trips
    name: Total Trips
    model: test_patient_data
    explore: bikeshare_info
    type: single_value
    fields: [bikeshare_info.count_trips]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0"
    listen:
      Start Station Name: start_station.name
      End Station Name: end_station.name
      Subscriber Type: bikeshare_info.subscriber_type
      Bike Type: bikeshare_info.bike_type
    row: 0
    col: 0
    width: 6
    height: 4

  - title: Average Trip Duration
    name: Average Trip Duration
    model: test_patient_data
    explore: bikeshare_info
    type: single_value
    fields: [bikeshare_info.average_duration_minutes]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0.00"
    listen:
      Start Station Name: start_station.name
      End Station Name: end_station.name
      Subscriber Type: bikeshare_info.subscriber_type
      Bike Type: bikeshare_info.bike_type
    row: 0
    col: 6
    width: 6
    height: 4

  - title: Total Stations (Start)
    name: Total Stations Start
    model: test_patient_data
    explore: bikeshare_info
    type: single_value
    fields: [start_station.count_stations]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0"
    listen:
      Start Station Name: start_station.name
      End Station Name: end_station.name
      Subscriber Type: bikeshare_info.subscriber_type
      Bike Type: bikeshare_info.bike_type
    row: 0
    col: 12
    width: 6
    height: 4

  - title: Total Docks Available
    name: Total Docks Available
    model: test_patient_data
    explore: bikeshare_info
    type: single_value
    fields: [start_station.number_of_docks]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "#,##0"
    listen:
      Start Station Name: start_station.name
      End Station Name: end_station.name
      Subscriber Type: bikeshare_info.subscriber_type
      Bike Type: bikeshare_info.bike_type
    row: 0
    col: 18
    width: 6
    height: 4

  - title: Bike Station Locations Map
    name: Bike Station Locations Map
    model: test_patient_data
    explore: bikeshare_info
    type: looker_map
    fields: [start_station.location, start_station.name, start_station.count_stations]
    sorts: [start_station.count_stations desc]
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 30.27
    map_longitude: -97.74
    map_zoom: 12
    map_value_colors: ["#3366cc"]
    map_value_scale_clamp_min: 0
    map_value_scale_clamp_max:
    series_types: {}
    defaults_version: 1
    listen:
      Start Station Name: start_station.name
      End Station Name: end_station.name
      Subscriber Type: bikeshare_info.subscriber_type
      Bike Type: bikeshare_info.bike_type
    row: 4
    col: 0
    width: 24
    height: 12

  filters:
  - name: Start Station Name
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
    field: start_station.name

  - name: End Station Name
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
    field: end_station.name

  - name: Subscriber Type
    title: Subscriber Type
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
    field: bikeshare_info.subscriber_type

  - name: Bike Type
    title: Bike Type
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
    field: bikeshare_info.bike_type
