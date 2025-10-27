view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${station_id} ;;
  }

  # Dimensions
  dimension: station_id {
    type: number
    label: "Station ID"
    description: "Unique identifier for bike station"
    sql: ${TABLE}.station_id ;;
  }

  dimension: name {
    type: string
    label: "Station Name"
    description: "Name of the bike station"
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    type: string
    label: "Status"
    description: "Current status of the bike station"
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    type: location
    label: "Location"
    description: "Geographic location of the bike station"
    sql_latitude: CAST(SPLIT(${TABLE}.location, ',')[OFFSET(0)] AS FLOAT64) ;;
    sql_longitude: CAST(SPLIT(${TABLE}.location, ',')[OFFSET(1)] AS FLOAT64) ;;
  }

  dimension: address {
    type: string
    label: "Address"
    description: "Street address of the bike station"
    sql: ${TABLE}.address ;;
  }

  dimension: alternate_name {
    type: string
    label: "Alternate Name"
    description: "Alternative name for the bike station"
    sql: ${TABLE}.alternate_name ;;
  }

  dimension: city_asset_number {
    type: number
    label: "City Asset Number"
    description: "City asset identification number"
    sql: ${TABLE}.city_asset_number ;;
  }

  dimension: property_type {
    type: string
    label: "Property Type"
    description: "Type of property where station is located"
    sql: ${TABLE}.property_type ;;
  }

  dimension: power_type {
    type: string
    label: "Power Type"
    description: "Type of power source for the station"
    sql: ${TABLE}.power_type ;;
  }

  dimension: notes {
    type: string
    label: "Notes"
    description: "Additional notes about the bike station"
    sql: ${TABLE}.notes ;;
  }

  dimension: council_district {
    type: number
    label: "Council District"
    description: "City council district number"
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    type: string
    label: "Image"
    description: "URL to station image"
    sql: ${TABLE}.image ;;
  }

  # Dimension Groups (Time)
  dimension_group: modified {
    type: time
    label: "Modified"
    description: "Date when station information was last modified"
    timeframes: [time, date, week, month, year, raw]
    sql: ${TABLE}.modified_date ;;
  }

  dimension: modified_month_year {
    group_label: "Modified Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${modified_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Hidden dimensions for measures (with NULL handling)
  dimension: number_of_docks_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.number_of_docks, 0) ;;
  }

  dimension: footprint_length_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.footprint_length, 0) ;;
  }

  dimension: footprint_width_raw {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.footprint_width, 0) ;;
  }

  # Measures
  measure: number_of_docks {
    type: sum
    label: "Total Number of Docks"
    description: "Total number of bike docks"
    sql: ${number_of_docks_raw} ;;
    value_format: "#,##0.00"
  }

  measure: average_number_of_docks {
    type: average
    label: "Average Number of Docks"
    description: "Average number of bike docks per station"
    sql: ${number_of_docks_raw} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    type: sum
    label: "Total Footprint Length"
    description: "Total footprint length of stations"
    sql: ${footprint_length_raw} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    type: sum
    label: "Total Footprint Width"
    description: "Total footprint width of stations"
    sql: ${footprint_width_raw} ;;
    value_format: "#,##0.00"
  }

  measure: count_stations {
    type: count
    label: "Count of Stations"
    description: "Total number of bike stations"
    value_format: "#,##0.00"
  }
}
