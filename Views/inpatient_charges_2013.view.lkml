view: inpatient_charges_2013 {
  sql_table_name: `@{inpatient_charges_table}` ;;

  # Primary Key (hidden)
  dimension: inpatient_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '_', ${drg_definition}) ;;
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

  dimension: drg_definition {
    label: "DRG Definition"
    description: "Diagnosis Related Group (DRG) definition describing the type of inpatient service"
    type: string
    sql: ${TABLE}.drg_definition ;;
  }

  dimension: hospital_referral_region_description {
    label: "Hospital Referral Region"
    description: "Description of the hospital referral region"
    type: string
    sql: ${TABLE}.hospital_referral_region_description ;;
  }

  # Hidden dimensions for measures
  dimension: _total_discharges {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.total_discharges, 0) ;;
  }

  dimension: _average_covered_charges {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_covered_charges, 0) ;;
  }

  dimension: _average_total_payments {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_total_payments, 0) ;;
  }

  dimension: _average_medicare_payments {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.average_medicare_payments, 0) ;;
  }

  # Measures
  measure: total_discharges {
    label: "Total Discharges"
    description: "Total number of discharges"
    type: sum
    sql: ${_total_discharges} ;;
    value_format: "#,##0.00"
  }

  measure: average_covered_charges {
    label: "Average Covered Charges"
    description: "Average amount of charges covered by insurance"
    type: average
    sql: ${_average_covered_charges} ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    label: "Average Total Payments"
    description: "Average total payment amount"
    type: average
    sql: ${_average_total_payments} ;;
    value_format: "#,##0.00"
  }

  measure: average_medicare_payments {
    label: "Average Medicare Payments"
    description: "Average payment amount from Medicare"
    type: average
    sql: ${_average_medicare_payments} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    label: "Count"
    type: count
    drill_fields: [provider_id, provider_name, count]
  }
}
