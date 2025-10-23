view: outpatient_charges_2013 {
  sql_table_name: `@{outpatient_charges_2013_table}` ;;

  # Primary Key
  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '-', ${apc}) ;;
  }

  # Dimensions
  dimension: provider_id {
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
    type: string
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
    description: "4 digit APC code extracted from APC field"
    sql: REGEXP_EXTRACT(${apc}, r'^(\d{4})') ;;
  }

  dimension: hospital_referral_region {
    type: string
    label: "Hospital Referral Region"
    description: "Hospital referral region"
    sql: ${TABLE}.hospital_referral_region ;;
  }

  # Hidden dimensions for measures
  dimension: outpatient_services_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.outpatient_services ;;
  }

  dimension: average_estimated_submitted_charges_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.average_estimated_submitted_charges ;;
  }

  dimension: average_total_payments_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.average_total_payments ;;
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
    description: "Average total payments"
    sql: ${average_total_payments_raw} ;;
    value_format: "#,##0.00"
  }

  measure: count_providers {
    type: count_distinct
    label: "Count of Providers"
    description: "Number of unique providers"
    sql: ${provider_id} ;;
    value_format: "#,##0.00"
  }
}
