- dashboard: patient_dashboard
  title: "Inpatient & Outpatient Report"
  description: "Dashboard for analyzing Inpatient and Outpatient charges by provider"
  layout: grid
  rows:
    - elements: [provider_count, city_hospital_services]
      height: 300
    - elements: [provider_detail_table]
      height: 400

  filters:
    - name: provider_city_filter
      title: "City"
      type: field_filter
      model: test_patient_data
      explore: inpatient_charges_2013
      field: inpatient_charges_2013.provider_city
      allow_multiple_values: true

    - name: hospital_region_filter
      title: "Hospital"
      type: field_filter
      model: test_patient_data
      explore: inpatient_charges_2013
      field: inpatient_charges_2013.hospital_referral_region_description
      allow_multiple_values: true

    - name: provider_zipcode_filter
      title: "Zipcode"
      type: field_filter
      model: test_patient_data
      explore: inpatient_charges_2013
      field: inpatient_charges_2013.provider_zipcode
      allow_multiple_values: true

  elements:
    - name: provider_count
      title: "Total Number of Providers"
      type: single_value
      query:
        model: test_patient_data
        explore: inpatient_charges_2013
        dimensions: []
        measures: [inpatient_charges_2013.count]
        filters:
          inpatient_charges_2013.provider_city: "{% parameter provider_city_filter %}"
          inpatient_charges_2013.hospital_referral_region_description: "{% parameter hospital_region_filter %}"
          inpatient_charges_2013.provider_zipcode: "{% parameter provider_zipcode_filter %}"
        limit: 1

    - name: city_hospital_services
      title: "Outpatient Services by City and Hospital"
      type: looker_column
      query:
        model: test_patient_data
        explore: inpatient_charges_2013
        dimensions: [inpatient_charges_2013.provider_city, inpatient_charges_2013.hospital_referral_region_description]
        measures: [outpatient_charges_2013.outpatient_services]
        filters:
          inpatient_charges_2013.provider_city: "{% parameter provider_city_filter %}"
          inpatient_charges_2013.hospital_referral_region_description: "{% parameter hospital_region_filter %}"
          inpatient_charges_2013.provider_zipcode: "{% parameter provider_zipcode_filter %}"
        sorts: [outpatient_charges_2013.outpatient_services desc]
        limit: 500

    - name: provider_detail_table
      title: "Provider Details"
      type: looker_table
      query:
        model: test_patient_data
        explore: inpatient_charges_2013
        dimensions: [inpatient_charges_2013.provider_id, inpatient_charges_2013.provider_name, inpatient_charges_2013.provider_city, inpatient_charges_2013.provider_state]
        measures: [inpatient_charges_2013.total_discharges, outpatient_charges_2013.outpatient_services, outpatient_charges_2013.average_total_payments]
        filters:
          inpatient_charges_2013.provider_city: "{% parameter provider_city_filter %}"
          inpatient_charges_2013.hospital_referral_region_description: "{% parameter hospital_region_filter %}"
          inpatient_charges_2013.provider_zipcode: "{% parameter provider_zipcode_filter %}"
        sorts: [inpatient_charges_2013.provider_name]
        limit: 500
