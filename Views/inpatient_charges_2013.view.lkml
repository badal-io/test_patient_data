view: inpatient_charges_2013 {
  sql_table_name: `@{inpatient_charges_2013_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '-', ${drg_definition}) ;;
  }

  # Dimensions
  dimension: provider_id {
    label: "Provider ID"
    description: "The unique provider identifier"
    type: string
    sql: ${TABLE}.provider_id ;;
  }

  dimension: provider_name {
    label: "Provider Name"
    description: "The name of the provider"
    type: string
    sql: ${TABLE}.provider_name ;;
  }

  dimension: provider_street_address {
    label: "Provider Street Address"
    description: "The street address of the provider"
    type: string
    sql: ${TABLE}.provider_street_address ;;
  }

  dimension: provider_city {
    label: "Provider City"
    description: "The city of the provider"
    type: string
    sql: ${TABLE}.provider_city ;;
  }

  dimension: provider_state {
    label: "Provider State"
    description: "The state of the provider"
    type: string
    sql: ${TABLE}.provider_state ;;
  }

  dimension: provider_zipcode {
    label: "Provider Zipcode"
    description: "The zipcode of the provider"
    type: zipcode
    sql: ${TABLE}.provider_zipcode ;;
  }

  dimension: drg_definition {
    label: "DRG Definition"
    description: "The diagnosis-related group definition"
    type: string
    sql: ${TABLE}.drg_definition ;;
  }

  dimension: hospital_referral_region_description {
    label: "Hospital Referral Region"
    description: "The hospital referral region description"
    type: string
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
    label: "Total Discharges"
    description: "The total number of discharges"
    type: sum
    sql: COALESCE(${total_discharges_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_covered_charges {
    label: "Average Covered Charges"
    description: "The average covered charges"
    type: average
    sql: COALESCE(${average_covered_charges_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    label: "Average Total Payments"
    description: "The average total payments"
    type: average
    sql: COALESCE(${average_total_payments_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_medicare_payments {
    label: "Average Medicare Payments"
    description: "The average Medicare payments"
    type: average
    sql: COALESCE(${average_medicare_payments_hidden}, 0) ;;
    value_format: "#,##0.00"
  }
}
