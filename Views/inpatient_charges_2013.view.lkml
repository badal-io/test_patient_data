view: inpatient_charges_2013 {
  sql_table_name: `@{inpatient_charges_2013_table}` ;;

  # Primary Key (hidden)
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${provider_id}, ${drg_definition}) ;;
  }

  # Dimensions
  dimension: provider_id {
    primary_key: no
    type: string
    label: "Provider ID"
    description: "Unique identifier for the healthcare provider"
    sql: ${TABLE}.provider_id ;;
  }

  dimension: provider_name {
    type: string
    label: "Provider Name"
    description: "Name of the healthcare provider"
    sql: ${TABLE}.provider_name ;;
  }

  dimension: provider_street_address {
    type: string
    label: "Provider Street Address"
    description: "Street address of the provider"
    sql: ${TABLE}.provider_street_address ;;
  }

  dimension: provider_city {
    type: string
    label: "Provider City"
    description: "City where the provider is located"
    sql: ${TABLE}.provider_city ;;
  }

  dimension: provider_state {
    type: string
    label: "Provider State"
    description: "State where the provider is located"
    sql: ${TABLE}.provider_state ;;
  }

  dimension: provider_zipcode {
    type: zipcode
    label: "Provider Zipcode"
    description: "Zip code of the provider location"
    sql: ${TABLE}.provider_zipcode ;;
  }

  dimension: drg_definition {
    type: string
    label: "DRG Definition"
    description: "Diagnosis-Related Group definition"
    sql: ${TABLE}.drg_definition ;;
  }

  dimension: hospital_referral_region_description {
    type: string
    label: "Hospital Referral Region Description"
    description: "Description of the hospital referral region"
    sql: ${TABLE}.hospital_referral_region_description ;;
  }

  # Hidden dimensions for measures
  dimension: total_discharges_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.total_discharges ;;
  }

  dimension: average_covered_charges_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.average_covered_charges ;;
  }

  dimension: average_total_payments_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.average_total_payments ;;
  }

  dimension: average_medicare_payments_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.average_medicare_payments ;;
  }

  # Measures
  measure: total_discharges {
    type: sum
    label: "Total Discharges"
    description: "Total number of discharges"
    sql: COALESCE(${total_discharges_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_covered_charges {
    type: average
    label: "Average Covered Charges"
    description: "Average covered charges per discharge"
    sql: COALESCE(${average_covered_charges_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    type: average
    label: "Average Total Payments"
    description: "Average total payments per discharge"
    sql: COALESCE(${average_total_payments_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_medicare_payments {
    type: average
    label: "Average Medicare Payments"
    description: "Average Medicare payments per discharge"
    sql: COALESCE(${average_medicare_payments_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Count of records"
    drill_fields: [provider_id, provider_name, provider_city, provider_state]
  }
}
