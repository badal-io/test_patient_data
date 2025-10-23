- dashboard: provider_metrics
  title: Provider Metrics Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next

  elements:
  - name: total_providers
    title: Total Number of Providers
    model: test_patient_data
    explore: inpatient_outpatient
    type: single_value
    fields: [outpatient_charges_2013.count_providers]
    limit: 500
    listen:
      City: outpatient_charges_2013.provider_city
      Hospital: outpatient_charges_2013.hospital_referral_region
      Zipcode: outpatient_charges_2013.provider_zipcode
    row: 0
    col: 0
    width: 24
    height: 4

  - name: outpatient_services_by_city_hospital
    title: Outpatient Services by City and Hospital
    model: test_patient_data
    explore: inpatient_outpatient
    type: looker_column
    fields: [outpatient_charges_2013.provider_city, outpatient_charges_2013.hospital_referral_region, outpatient_charges_2013.outpatient_services]
    sorts: [outpatient_charges_2013.outpatient_services desc]
    limit: 500
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
