- dashboard: patient_analytics
  title: Patient Analytics
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Comprehensive analysis of inpatient and outpatient charges by provider
  elements:
  - title: Total Providers
    name: Total Providers
    model: test_patient_data
    explore: inpatient_outpatient
    type: single_value
    fields: [inpatient_charges_2013.provider_id]
    filters:
      inpatient_charges_2013.provider_id: "-NULL"
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
      City Filter: inpatient_charges_2013.provider_city
      Hospital Referral Region Filter: inpatient_charges_2013.hospital_referral_region_description
      Zipcode Filter: inpatient_charges_2013.provider_zipcode
    row: 0
    col: 0
    width: 6
    height: 4

  - title: Outpatient Services by City and Hospital
    name: Outpatient Services by City and Hospital
    model: test_patient_data
    explore: inpatient_outpatient
    type: looker_column
    fields: [inpatient_charges_2013.provider_city, inpatient_charges_2013.hospital_referral_region_description, outpatient_charges_2013.outpatient_services]
    pivots: [inpatient_charges_2013.hospital_referral_region_description]
    sorts: [outpatient_charges_2013.outpatient_services desc 0]
    limit: 25
    column_limit: 50
    query_timezone: America/Los_Angeles
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
      City Filter: inpatient_charges_2013.provider_city
      Hospital Referral Region Filter: inpatient_charges_2013.hospital_referral_region_description
      Zipcode Filter: inpatient_charges_2013.provider_zipcode
    row: 0
    col: 6
    width: 18
    height: 9

  filters:
  - name: City Filter
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: inpatient_outpatient
    listens_to_filters: []
    field: inpatient_charges_2013.provider_city

  - name: Hospital Referral Region Filter
    title: Hospital Referral Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: inpatient_outpatient
    listens_to_filters: []
    field: inpatient_charges_2013.hospital_referral_region_description

  - name: Zipcode Filter
    title: Zipcode
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: inpatient_outpatient
    listens_to_filters: []
    field: inpatient_charges_2013.provider_zipcode
