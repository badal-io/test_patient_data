view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key (hidden)
  dimension: station_id {
    primary_key: yes
    hidden: no
    label: "Station ID"
    description: "The unique station identifier"
    type: number
    sql: ${TABLE}.station_id ;;
  }

  # Dimensions
  dimension: name {
    label: "Name"
    description: "The name of the station"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    label: "Status"
    description: "The operational status of the station"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    label: "Location"
    description: "The geographic location of the station"
    type: location
    sql_latitude: CAST(SUBSTR(${TABLE}.location, 2, STRPOS(${TABLE}.location, ',') - 2) AS FLOAT64) ;;
    sql_longitude: CAST(SUBSTR(${TABLE}.location, STRPOS(${TABLE}.location, ',') + 2, LENGTH(${TABLE}.location) - STRPOS(${TABLE}.location, ',') - 2) AS FLOAT64) ;;
  }

  dimension: address {
    label: "Address"
    description: "The address of the station"
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: alternate_name {
    label: "Alternate Name"
    description: "Alternative name for the station"
    type: string
    sql: ${TABLE}.alternate_name ;;
  }

  dimension: city_asset_number {
    label: "City Asset Number"
    description: "The city asset number for the station"
    type: number
    sql: ${TABLE}.city_asset_number ;;
  }

  dimension: property_type {
    label: "Property Type"
    description: "The type of property"
    type: string
    sql: ${TABLE}.property_type ;;
  }

  dimension: power_type {
    label: "Power Type"
    description: "The type of power available at the station"
    type: string
    sql: ${TABLE}.power_type ;;
  }

  dimension: notes {
    label: "Notes"
    description: "Additional notes about the station"
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: council_district {
    label: "Council District"
    description: "The city council district number"
    type: number
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    label: "Image"
    description: "Image URL for the station"
    type: string
    sql: ${TABLE}.image ;;
  }

  # Dimension Group - Time
  dimension_group: modified_date {
    label: "Modified Date"
    description: "The date the station was last modified"
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.modified_date ;;
  }

  dimension: modified_date_month_year {
    group_label: "Modified Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${modified_date_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Hidden dimensions for measures
  dimension: number_of_docks_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.number_of_docks ;;
  }

  dimension: footprint_length_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.footprint_length ;;
  }

  dimension: footprint_width_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.footprint_width ;;
  }

  # Measures
  measure: number_of_docks {
    label: "Number of Docks"
    description: "The total number of docks"
    type: sum
    sql: COALESCE(${number_of_docks_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    label: "Footprint Length"
    description: "The length of the footprint"
    type: sum
    sql: COALESCE(${footprint_length_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    label: "Footprint Width"
    description: "The width of the footprint"
    type: average
    sql: COALESCE(${footprint_width_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: station_count {
    label: "Station Count"
    description: "Total number of stations"
    type: count
  }
}
