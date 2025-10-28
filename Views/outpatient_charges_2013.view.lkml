view: outpatient_charges_2013 {
  sql_table_name: `@{outpatient_charges_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '-', ${apc}, '-', CAST(ROW_NUMBER() OVER (PARTITION BY ${provider_id}, ${apc} ORDER BY ${provider_id}) AS STRING)) ;;
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
    type: string
    label: "Provider Zipcode"
    description: "Zipcode of the provider location"
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
    description: "4-digit APC code extracted from the beginning of APC field"
    sql: SUBSTR(${TABLE}.apc, 1, 4) ;;
  }

  dimension: hospital_referral_region {
    type: string
    label: "Hospital Referral Region"
    description: "Hospital referral region"
    sql: ${TABLE}.hospital_referral_region ;;
  }

  # Hidden dimensions for measures
  dimension: _outpatient_services {
    hidden: yes
    type: number
    label: "Outpatient Services"
    description: "Number of outpatient services"
    sql: COALESCE(${TABLE}.outpatient_services, 0) ;;
  }

  dimension: _average_estimated_submitted_charges {
    hidden: yes
    type: number
    label: "Average Estimated Submitted Charges"
    description: "Average estimated submitted charges"
    sql: COALESCE(${TABLE}.average_estimated_submitted_charges, 0) ;;
  }

  dimension: _average_total_payments {
    hidden: yes
    type: number
    label: "Average Total Payments"
    description: "Average total payments"
    sql: COALESCE(${TABLE}.average_total_payments, 0) ;;
  }

  # Measures
  measure: outpatient_services {
    type: sum
    label: "Outpatient Services"
    description: "Sum of outpatient services"
    sql: ${_outpatient_services} ;;
    value_format: "#,##0.00"
  }

  measure: average_estimated_submitted_charges {
    type: sum
    label: "Average Estimated Submitted Charges"
    description: "Sum of average estimated submitted charges"
    sql: ${_average_estimated_submitted_charges} ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    type: sum
    label: "Average Total Payments"
    description: "Sum of average total payments"
    sql: ${_average_total_payments} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of records"
  }
}
