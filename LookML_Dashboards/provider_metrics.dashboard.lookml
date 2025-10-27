- dashboard: provider_metrics
  title: Provider Metrics
  layout: newspaper
  elements:

  - name: number_of_providers
    title: Number of Providers
    query: inpatient_outpatient
    type: single_value
    fields: [inpatient_charges_2013.provider_id]
    measures: [inpatient_charges_2013.count]
    filters:
      inpatient_charges_2013.provider_id: "-NULL"
    listen:
      provider_city: inpatient_charges_2013.provider_city
      hospital_referral_region: inpatient_charges_2013.hospital_referral_region_description
      provider_zipcode: inpatient_charges_2013.provider_zipcode
    row: 0
    col: 0
    width: 6
    height: 4

  - name: services_by_city_and_hospital
    title: Services by City and Hospital
    query: inpatient_outpatient
    type: looker_column
    fields: [inpatient_charges_2013.provider_city, inpatient_charges_2013.hospital_referral_region_description, outpatient_charges_2013.outpatient_services]
    measures: [outpatient_charges_2013.outpatient_services]
    dimensions: [inpatient_charges_2013.provider_city, inpatient_charges_2013.hospital_referral_region_description]
    pivots: [inpatient_charges_2013.hospital_referral_region_description]
    listen:
      provider_city: inpatient_charges_2013.provider_city
      hospital_referral_region: inpatient_charges_2013.hospital_referral_region_description
      provider_zipcode: inpatient_charges_2013.provider_zipcode
    row: 0
    col: 6
    width: 12
    height: 4

  filters:
  - name: provider_city
    title: City
    type: field_filter
    explore: inpatient_outpatient
    field: inpatient_charges_2013.provider_city

  - name: hospital_referral_region
    title: Hospital
    type: field_filter
    explore: inpatient_outpatient
    field: inpatient_charges_2013.hospital_referral_region_description

  - name: provider_zipcode
    title: Zipcode
    type: field_filter
    explore: inpatient_outpatient
    field: inpatient_charges_2013.provider_zipcode
