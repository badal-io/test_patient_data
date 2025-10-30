---
- dashboard: provider_analytics
  title: Provider Analytics Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Provider statistics and analysis dashboard for inpatient and outpatient services'
  preferred_slug: ProviderAnalyticsDashboard
  elements:
  - title: Number of Providers
    name: number_of_providers
    model: test_patient_data
    explore: inpatient_charges_2013
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
      City: inpatient_charges_2013.provider_city
      Hospital: outpatient_charges_2013.hospital_referral_region
      Zipcode: inpatient_charges_2013.provider_zipcode
    row: 0
    col: 0
    width: 6
    height: 4
  - title: City, Hospital and Outpatient Services
    name: city_hospital_outpatient
    model: test_patient_data
    explore: inpatient_charges_2013
    type: looker_column
    fields: [inpatient_charges_2013.provider_city, outpatient_charges_2013.hospital_referral_region, outpatient_charges_2013.outpatient_services]
    sorts: [outpatient_charges_2013.outpatient_services desc 0]
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
    series_colors: {}
    listen:
      City: inpatient_charges_2013.provider_city
      Hospital: outpatient_charges_2013.hospital_referral_region
      Zipcode: inpatient_charges_2013.provider_zipcode
    row: 0
    col: 6
    width: 18
    height: 8
  filters:
  - name: City
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: inpatient_charges_2013
    listens_to_filters: []
    field: inpatient_charges_2013.provider_city
  - name: Hospital
    title: Hospital
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: inpatient_charges_2013
    listens_to_filters: []
    field: outpatient_charges_2013.hospital_referral_region
  - name: Zipcode
    title: Zipcode
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: test_patient_data
    explore: inpatient_charges_2013
    listens_to_filters: []
    field: inpatient_charges_2013.provider_zipcode
