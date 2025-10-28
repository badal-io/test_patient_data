view: outpatient_charges_2013 {
  sql_table_name: `@{outpatient_charges_2013_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '-', ${apc}) ;;
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

  dimension: apc {
    label: "APC"
    description: "Ambulatory Payment Classification"
    type: string
    sql: ${TABLE}.apc ;;
  }

  dimension: apc_code {
    label: "APC Code"
    description: "The 4-digit APC code extracted from the beginning of the APC field"
    type: string
    sql: SUBSTR(${TABLE}.apc, 1, 4) ;;
  }

  dimension: hospital_referral_region {
    label: "Hospital Referral Region"
    description: "The hospital referral region"
    type: string
    sql: ${TABLE}.hospital_referral_region ;;
  }

  # Hidden dimensions for measures
  dimension: outpatient_services_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.outpatient_services ;;
  }

  dimension: average_estimated_submitted_charges_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.average_estimated_submitted_charges ;;
  }

  dimension: average_total_payments_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.average_total_payments ;;
  }

  # Measures
  measure: outpatient_services {
    label: "Outpatient Services"
    description: "The total number of outpatient services"
    type: sum
    sql: COALESCE(${outpatient_services_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_estimated_submitted_charges {
    label: "Average Estimated Submitted Charges"
    description: "The average estimated submitted charges"
    type: average
    sql: COALESCE(${average_estimated_submitted_charges_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    label: "Average Total Payments"
    description: "The average total payments"
    type: average
    sql: COALESCE(${average_total_payments_hidden}, 0) ;;
    value_format: "#,##0.00"
  }
}
