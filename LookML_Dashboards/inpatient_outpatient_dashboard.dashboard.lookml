- dashboard: inpatient_outpatient_dashboard
  title: "Inpatient & Outpatient Analysis"
  description: "Dashboard analyzing inpatient and outpatient charges by provider"
  layout: grid
  tile_size: 100

  filters:
    - name: city_filter
      title: "City"
      type: field_filter
      explore: inpatient_outpatient
      field: inpatient_charges_2013.provider_city
      default_value: ""

    - name: hospital_filter
      title: "Hospital Referral Region"
      type: field_filter
      explore: inpatient_outpatient
      field: inpatient_charges_2013.hospital_referral_region_description
      default_value: ""

    - name: zipcode_filter
      title: "Zipcode"
      type: field_filter
      explore: inpatient_outpatient
      field: inpatient_charges_2013.provider_zipcode
      default_value: ""

  elements:
    - name: provider_count
      title: "Number of Providers"
      type: single_value
      query:
        model: test_patient_data
        explore: inpatient_outpatient
        dimensions: []
        measures: [inpatient_charges_2013.count]
        filters:
          inpatient_charges_2013.provider_city: "{{ city_filter._value }}"
          inpatient_charges_2013.hospital_referral_region_description: "{{ hospital_filter._value }}"
          inpatient_charges_2013.provider_zipcode: "{{ zipcode_filter._value }}"
        limit: 500
      row: 0
      col: 0
      width: 6
      height: 4

    - name: outpatient_by_city_hospital
      title: "Outpatient Services by City and Hospital Region"
      type: looker_column
      query:
        model: test_patient_data
        explore: inpatient_outpatient
        dimensions: [inpatient_charges_2013.provider_city, inpatient_charges_2013.hospital_referral_region_description]
        measures: [outpatient_charges_2013.outpatient_services]
        filters:
          inpatient_charges_2013.provider_city: "{{ city_filter._value }}"
          inpatient_charges_2013.hospital_referral_region_description: "{{ hospital_filter._value }}"
          inpatient_charges_2013.provider_zipcode: "{{ zipcode_filter._value }}"
        sorts: [outpatient_charges_2013.outpatient_services: desc]
        limit: 500
      row: 0
      col: 6
      width: 12
      height: 8
