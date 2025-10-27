view: outpatient_charges_2013 {
  sql_table_name: `@{outpatient_charges_table}` ;;

  # Primary Key
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '-', ${apc}) ;;
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

  dimension: apc {
    type: string
    label: "APC"
    description: "Ambulatory Payment Classification"
    sql: ${TABLE}.apc ;;
  }

  dimension: apc_code {
    type: string
    label: "APC Code"
    description: "4-digit code extracted from APC field"
    sql: SUBSTR(${apc}, 1, 4) ;;
  }

  dimension: hospital_referral_region {
    type: string
    label: "Hospital Referral Region"
    description: "Hospital referral region identifier"
    sql: ${TABLE}.hospital_referral_region ;;
  }

  # Hidden dimensions for measures (with NULL handling)
  dimension: outpatient_services_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.outpatient_services, 0) ;;
  }

  dimension: average_estimated_submitted_charges_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_estimated_submitted_charges, 0) ;;
  }

  dimension: average_total_payments_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_total_payments, 0) ;;
  }

  # Measures
  measure: outpatient_services {
    type: sum
    label: "Outpatient Services"
    description: "Total number of outpatient services"
    sql: ${outpatient_services_raw} ;;
    value_format: "#,##0.00"
  }

  measure: average_estimated_submitted_charges {
    type: average
    label: "Average Estimated Submitted Charges"
    description: "Average estimated submitted charges"
    sql: ${average_estimated_submitted_charges_raw} ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    type: average
    label: "Average Total Payments"
    description: "Average total payments received"
    sql: ${average_total_payments_raw} ;;
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
