view: inpatient_charges_2013 {
  sql_table_name: `@{inpatient_charges_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${provider_id}, '-', ${drg_definition}, '-', CAST(ROW_NUMBER() OVER (PARTITION BY ${provider_id}, ${drg_definition} ORDER BY ${provider_id}) AS STRING)) ;;
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

  dimension: drg_definition {
    type: string
    label: "DRG Definition"
    description: "Diagnosis Related Group definition"
    sql: ${TABLE}.drg_definition ;;
  }

  dimension: hospital_referral_region_description {
    type: string
    label: "Hospital Referral Region"
    description: "Description of the hospital referral region"
    sql: ${TABLE}.hospital_referral_region_description ;;
  }

  # Hidden dimensions for measures
  dimension: _total_discharges {
    hidden: yes
    type: number
    label: "Total Discharges"
    description: "Total number of discharges"
    sql: COALESCE(${TABLE}.total_discharges, 0) ;;
  }

  dimension: _average_covered_charges {
    hidden: yes
    type: number
    label: "Average Covered Charges"
    description: "Average covered charges"
    sql: COALESCE(${TABLE}.average_covered_charges, 0) ;;
  }

  dimension: _average_total_payments {
    hidden: yes
    type: number
    label: "Average Total Payments"
    description: "Average total payments"
    sql: COALESCE(${TABLE}.average_total_payments, 0) ;;
  }

  dimension: _average_medicare_payments {
    hidden: yes
    type: number
    label: "Average Medicare Payments"
    description: "Average Medicare payments"
    sql: COALESCE(${TABLE}.average_medicare_payments, 0) ;;
  }

  # Measures
  measure: total_discharges {
    type: sum
    label: "Total Discharges"
    description: "Sum of total discharges"
    sql: ${_total_discharges} ;;
    value_format: "#,##0.00"
  }

  measure: average_covered_charges {
    type: sum
    label: "Average Covered Charges"
    description: "Sum of average covered charges"
    sql: ${_average_covered_charges} ;;
    value_format: "#,##0.00"
  }

  measure: average_total_payments {
    type: sum
    label: "Average Total Payments"
    description: "Sum of average total payments"
    sql: ${_average_total_payments} ;;
    value_format: "#,##0.00"
  }

  measure: average_medicare_payments {
    type: sum
    label: "Average Medicare Payments"
    description: "Sum of average Medicare payments"
    sql: ${_average_medicare_payments} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of records"
  }
}
