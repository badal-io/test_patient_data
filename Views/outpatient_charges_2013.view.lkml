view: outpatient_charges_2013 {
  sql_table_name: `@{outpatient_charges_table}` ;;

  # Primary Key (hidden)
  dimension: outpatient_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '_', ${apc}) ;;
  }

  # Dimensions
  dimension: provider_id {
    label: "Provider ID"
    description: "Unique identifier for the healthcare provider"
    type: string
    sql: ${TABLE}.provider_id ;;
  }

  dimension: provider_name {
    label: "Provider Name"
    description: "Name of the healthcare provider"
    type: string
    sql: ${TABLE}.provider_name ;;
  }

  dimension: provider_street_address {
    label: "Provider Street Address"
    description: "Street address of the healthcare provider"
    type: string
    sql: ${TABLE}.provider_street_address ;;
  }

  dimension: provider_city {
    label: "Provider City"
    description: "City where the healthcare provider is located"
    type: string
    sql: ${TABLE}.provider_city ;;
  }

  dimension: provider_state {
    label: "Provider State"
    description: "State where the healthcare provider is located"
    type: string
    sql: ${TABLE}.provider_state ;;
  }

  dimension: provider_zipcode {
    label: "Provider Zipcode"
    description: "Zipcode of the healthcare provider"
    type: zipcode
    sql: ${TABLE}.provider_zipcode ;;
  }

  dimension: apc {
    label: "APC"
    description: "Ambulatory Payment Classification code"
    type: string
    sql: ${TABLE}.apc ;;
  }

  # Extracted APC code dimension
  dimension: apc_code {
    label: "APC Code"
    description: "4-digit APC code extracted from the beginning of the APC field"
    type: string
    sql: SUBSTR(${apc}, 1, 4) ;;
  }

  dimension: hospital_referral_region {
    label: "Hospital Referral Region"
    description: "Hospital referral region for the provider"
    type: string
    sql: ${TABLE}.hospital_referral_region ;;
  }

  # Hidden dimensions for measures
  dimension: _outpatient_services {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.outpatient_services, 0) ;;
  }

  dimension: _average_estimated_submitted_charges {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_estimated_submitted_charges, 0) ;;
  }

  dimension: _average_total_payments {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_total_payments, 0) ;;
  }

  # Measures
  measure: outpatient_services {
    label: "Outpatient Services"
    description: "Total number of outpatient services"
    type: sum
    sql: ${_outpatient_services} ;;
    value_format: "#,##0.00"
  }

  measure: average_estimated_submitted_charges {
    label: "Average Estimated Submitted Charges"
    description: "Average estimated charges submitted"
    type: average
    sql: ${_average_estimated_submitted_charges} ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    label: "Average Total Payments"
    description: "Average total payment amount"
    type: average
    sql: ${_average_total_payments} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    label: "Count"
    type: count
    drill_fields: [provider_id, provider_name, count]
  }
}
