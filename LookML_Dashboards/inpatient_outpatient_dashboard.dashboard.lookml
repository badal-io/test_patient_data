- dashboard: inpatient_outpatient_dashboard
  title: Inpatient & Outpatient Charges
  layout: newspaper

  filters:
    - name: provider_city
      title: City
      type: field_filter
      explore: inpatient_charges_2013
      field: inpatient_charges_2013.provider_city

    - name: hospital_referral_region
      title: Hospital Referral Region
      type: field_filter
      explore: inpatient_charges_2013
      field: inpatient_charges_2013.hospital_referral_region_description

    - name: provider_zipcode
      title: Zipcode
      type: field_filter
      explore: inpatient_charges_2013
      field: inpatient_charges_2013.provider_zipcode

  elements:
    - name: provider_count
      title: Number of Providers
      type: single_value
      query:
        dimensions: []
        measures:
          - inpatient_charges_2013.count
        filters:
          inpatient_charges_2013.provider_city: "{{ provider_city._value }}"
          inpatient_charges_2013.hospital_referral_region_description: "{{ hospital_referral_region._value }}"
          inpatient_charges_2013.provider_zipcode: "{{ provider_zipcode._value }}"
        limit: 500
      listen:
        provider_city: provider_city
        hospital_referral_region: hospital_referral_region
        provider_zipcode: provider_zipcode

    - name: outpatient_services_by_city_hospital
      title: Outpatient Services by City & Hospital Region
      type: looker_column
      query:
        dimensions:
          - inpatient_charges_2013.provider_city
          - inpatient_charges_2013.hospital_referral_region_description
        measures:
          - outpatient_charges_2013.outpatient_services
        filters:
          inpatient_charges_2013.provider_city: "{{ provider_city._value }}"
          inpatient_charges_2013.hospital_referral_region_description: "{{ hospital_referral_region._value }}"
          inpatient_charges_2013.provider_zipcode: "{{ provider_zipcode._value }}"
        sorts:
          - outpatient_charges_2013.outpatient_services desc
        limit: 500
      listen:
        provider_city: provider_city
        hospital_referral_region: hospital_referral_region
        provider_zipcode: provider_zipcode
