- dashboard: provider_metrics
  title: Provider Metrics
  layout: newspaper
  refresh: auto
  description: Dashboard showing inpatient and outpatient charges metrics

  filters:
    - name: provider_city_filter
      title: City
      type: field_filter
      explore: inpatient_and_outpatient
      field: inpatient_charges_2013.provider_city

    - name: hospital_referral_region_filter
      title: Hospital
      type: field_filter
      explore: inpatient_and_outpatient
      field: inpatient_charges_2013.hospital_referral_region_description

    - name: provider_zipcode_filter
      title: Zipcode
      type: field_filter
      explore: inpatient_and_outpatient
      field: inpatient_charges_2013.provider_zipcode

  elements:
    - name: number_of_providers
      title: Number of Providers
      type: single_value
      explore: inpatient_and_outpatient
      measures: [inpatient_charges_2013.count]
      dimensions: [inpatient_charges_2013.provider_id]
      filters:
        inpatient_charges_2013.provider_city: "{{ provider_city_filter._value }}"
        inpatient_charges_2013.hospital_referral_region_description: "{{ hospital_referral_region_filter._value }}"
        inpatient_charges_2013.provider_zipcode: "{{ provider_zipcode_filter._value }}"
      query_timezone: America/Los_Angeles

    - name: city_hospital_outpatient_services
      title: City, Hospital and Outpatient Services
      type: column
      explore: inpatient_and_outpatient
      dimensions: [inpatient_charges_2013.provider_city, inpatient_charges_2013.hospital_referral_region_description]
      measures: [outpatient_charges_2013.outpatient_services]
      filters:
        inpatient_charges_2013.provider_city: "{{ provider_city_filter._value }}"
        inpatient_charges_2013.hospital_referral_region_description: "{{ hospital_referral_region_filter._value }}"
        inpatient_charges_2013.provider_zipcode: "{{ provider_zipcode_filter._value }}"
      query_timezone: America/Los_Angeles
      series_colors:
        outpatient_charges_2013.outpatient_services: "#1f77b4"
