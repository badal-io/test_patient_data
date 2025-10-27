view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key (hidden)
  dimension: station_id {
    primary_key: yes
    hidden: no
    label: "Station ID"
    description: "Unique identifier for the bikeshare station"
    type: number
    sql: ${TABLE}.station_id ;;
  }

  # Dimensions
  dimension: name {
    label: "Station Name"
    description: "Name of the bikeshare station"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    label: "Status"
    description: "Status of the bikeshare station"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    label: "Location"
    description: "Geographic coordinates of the station"
    type: location
    sql_latitude: CAST(SPLIT(SUBSTR(${TABLE}.location, 2, LENGTH(${TABLE}.location) - 2), ',')[OFFSET(0)] AS FLOAT64) ;;
    sql_longitude: CAST(SPLIT(SUBSTR(${TABLE}.location, 2, LENGTH(${TABLE}.location) - 2), ',')[OFFSET(1)] AS FLOAT64) ;;
  }

  dimension: address {
    label: "Address"
    description: "Physical address of the station"
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
    description: "City asset identification number"
    type: number
    sql: ${TABLE}.city_asset_number ;;
  }

  dimension: property_type {
    label: "Property Type"
    description: "Type of property where the station is located"
    type: string
    sql: ${TABLE}.property_type ;;
  }

  dimension: power_type {
    label: "Power Type"
    description: "Type of power supply for the station"
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
    description: "City council district where the station is located"
    type: number
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    label: "Image"
    description: "Image URL of the station"
    type: string
    sql: ${TABLE}.image ;;
  }

  # Time dimension
  dimension_group: modified_date {
    type: time
    label: "Modified"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.modified_date ;;
  }

  # Hidden dimensions for measures
  dimension: _number_of_docks {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.number_of_docks, 0) ;;
  }

  dimension: _footprint_length {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.footprint_length, 0) ;;
  }

  dimension: _footprint_width {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.footprint_width, 0) ;;
  }

  # Measures
  measure: number_of_docks {
    label: "Number of Docks"
    description: "Total number of docks at the station"
    type: sum
    sql: ${_number_of_docks} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    label: "Footprint Length"
    description: "Length of the station footprint"
    type: sum
    sql: ${_footprint_length} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    label: "Footprint Width"
    description: "Width of the station footprint"
    type: average
    sql: ${_footprint_width} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    label: "Count"
    type: count
    drill_fields: [station_id, name, address, count]
  }
}
