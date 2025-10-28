view: outpatient_charges_2013 {
  sql_table_name: `@{outpatient_charges_2013_table}` ;;
  label: "Outpatient Charges 2013"

  # Primary Key - Hidden
  dimension: record_id {
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
    description: "Zipcode of the provider"
    sql: ${TABLE}.provider_zipcode ;;
  }

  dimension: apc {
    type: string
    label: "APC"
    description: "Ambulatory Payment Classification code"
    sql: ${TABLE}.apc ;;
  }

  dimension: apc_code {
    type: string
    label: "APC Code"
    description: "4-digit code extracted from the beginning of the APC field"
    sql: SUBSTR(${TABLE}.apc, 1, 4) ;;
  }

  dimension: hospital_referral_region {
    type: string
    label: "Hospital Referral Region"
    description: "Hospital referral region"
    sql: ${TABLE}.hospital_referral_region ;;
  }

  # Hidden Dimensions for Measures
  dimension: _outpatient_services {
    hidden: yes
    type: number
    sql: ${TABLE}.outpatient_services ;;
  }

  dimension: _average_estimated_submitted_charges {
    hidden: yes
    type: number
    sql: ${TABLE}.average_estimated_submitted_charges ;;
  }

  dimension: _average_total_payments {
    hidden: yes
    type: number
    sql: ${TABLE}.average_total_payments ;;
  }

  # Measures
  measure: outpatient_services {
    type: sum
    label: "Outpatient Services"
    description: "Total number of outpatient services"
    sql: COALESCE(${_outpatient_services}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_estimated_submitted_charges {
    type: average
    label: "Average Estimated Submitted Charges"
    description: "Average estimated submitted charges"
    sql: COALESCE(${_average_estimated_submitted_charges}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    type: average
    label: "Average Total Payments"
    description: "Average total payments"
    sql: COALESCE(${_average_total_payments}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of records"
  }
}
