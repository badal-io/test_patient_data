- dashboard: provider_metrics
  title: Provider Metrics Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next

  elements:
  - name: number_of_providers
    title: Number of Providers
    type: single_value
    model: test_patient_data
    explore: inpatient_outpatient
    measures: [outpatient_charges_2013.count_providers]
    filters:
      outpatient_charges_2013.provider_id: "-NULL"
    limit: 500
    query_timezone: America/New_York
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      City: outpatient_charges_2013.provider_city
      Hospital: outpatient_charges_2013.hospital_referral_region
      Zipcode: outpatient_charges_2013.provider_zipcode
    row: 0
    col: 0
    width: 8
    height: 4

  - name: outpatient_services_by_city_and_hospital
    title: Outpatient Services by City and Hospital
    type: looker_column
    model: test_patient_data
    explore: inpatient_outpatient
    dimensions: [outpatient_charges_2013.provider_city, outpatient_charges_2013.hospital_referral_region]
    measures: [outpatient_charges_2013.outpatient_services]
    filters:
      outpatient_charges_2013.provider_city: "-NULL"
      outpatient_charges_2013.hospital_referral_region: "-NULL"
    sorts: [outpatient_charges_2013.outpatient_services desc]
    limit: 20
    query_timezone: America/New_York
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
    y_axes: [{label: Outpatient Services, orientation: left, series: [{axisId: outpatient_charges_2013.outpatient_services,
            id: outpatient_charges_2013.outpatient_services, name: Outpatient Services}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: City and Hospital
    series_types: {}
    series_colors:
      outpatient_charges_2013.outpatient_services: "#1f77b4"
    defaults_version: 1
    listen:
      City: outpatient_charges_2013.provider_city
      Hospital: outpatient_charges_2013.hospital_referral_region
      Zipcode: outpatient_charges_2013.provider_zipcode
    row: 4
    col: 0
    width: 24
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
    explore: inpatient_outpatient
    listens_to_filters: []
    field: outpatient_charges_2013.provider_city

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
    explore: inpatient_outpatient
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
    explore: inpatient_outpatient
    listens_to_filters: []
    field: outpatient_charges_2013.provider_zipcode
