view: inpatient_charges_2013 {
  sql_table_name: `@{inpatient_charges_table}` ;;

  # Primary Key
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '-', ${drg_definition}) ;;
  }

  # Dimensions
  dimension: provider_id {
    type: string
    label: "Provider ID"
    description: "Unique identifier for healthcare provider"
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
    description: "Street address of the healthcare provider"
    sql: ${TABLE}.provider_street_address ;;
  }

  dimension: provider_city {
    type: string
    label: "Provider City"
    description: "City where the healthcare provider is located"
    sql: ${TABLE}.provider_city ;;
  }

  dimension: provider_state {
    type: string
    label: "Provider State"
    description: "State where the healthcare provider is located"
    sql: ${TABLE}.provider_state ;;
  }

  dimension: provider_zipcode {
    type: zipcode
    label: "Provider Zipcode"
    description: "Zipcode of the healthcare provider"
    sql: ${TABLE}.provider_zipcode ;;
  }

  dimension: drg_definition {
    type: string
    label: "DRG Definition"
    description: "Diagnosis Related Group definition"
    sql: ${TABLE}.drg_definition ;;
  }

  dimension: hospital_referral_region_description {
    type: string
    label: "Hospital Referral Region"
    description: "Description of hospital referral region"
    sql: ${TABLE}.hospital_referral_region_description ;;
  }

  # Hidden dimensions for measures (with NULL handling)
  dimension: total_discharges_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.total_discharges, 0) ;;
  }

  dimension: average_covered_charges_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_covered_charges, 0) ;;
  }

  dimension: average_total_payments_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_total_payments, 0) ;;
  }

  dimension: average_medicare_payments_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_medicare_payments, 0) ;;
  }

  # Measures
  measure: total_discharges {
    type: sum
    label: "Total Discharges"
    description: "Total number of discharges"
    sql: ${total_discharges_raw} ;;
    value_format: "#,##0.00"
  }

  measure: average_covered_charges {
    type: average
    label: "Average Covered Charges"
    description: "Average amount of covered charges"
    sql: ${average_covered_charges_raw} ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    type: average
    label: "Average Total Payments"
    description: "Average total payments received"
    sql: ${average_total_payments_raw} ;;
    value_format: "#,##0.00"
  }

  measure: average_medicare_payments {
    type: average
    label: "Average Medicare Payments"
    description: "Average Medicare payments received"
    sql: ${average_medicare_payments_raw} ;;
    value_format: "#,##0.00"
  }

  measure: count_providers {
    type: count_distinct
    label: "Count of Providers"
    description: "Distinct count of healthcare providers"
    sql: ${provider_id} ;;
    value_format: "#,##0.00"
  }
}
