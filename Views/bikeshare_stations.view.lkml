view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;
  label: "Bikeshare Stations"

  # Primary Key - Hidden
  dimension: station_id {
    primary_key: yes
    type: number
    label: "Station ID"
    description: "Unique identifier for the station"
    sql: ${TABLE}.station_id ;;
  }

  # Dimensions
  dimension: name {
    type: string
    label: "Name"
    description: "Station name"
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    type: string
    label: "Status"
    description: "Current status of the station"
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    type: location
    label: "Location"
    description: "Geographic coordinates of the station"
    sql_latitude: CAST(SPLIT(${TABLE}.location, ',')[SAFE.OFFSET(0)] AS FLOAT64) ;;
    sql_longitude: CAST(SPLIT(${TABLE}.location, ',')[SAFE.OFFSET(1)] AS FLOAT64) ;;
  }

  dimension: address {
    type: string
    label: "Address"
    description: "Street address of the station"
    sql: ${TABLE}.address ;;
  }

  dimension: alternate_name {
    type: string
    label: "Alternate Name"
    description: "Alternative name for the station"
    sql: ${TABLE}.alternate_name ;;
  }

  dimension: city_asset_number {
    type: number
    label: "City Asset Number"
    description: "City asset number for the station"
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
    description: "Type of power available at the station"
    sql: ${TABLE}.power_type ;;
  }

  dimension: notes {
    type: string
    label: "Notes"
    description: "Additional notes about the station"
    sql: ${TABLE}.notes ;;
  }

  dimension: council_district {
    type: number
    label: "Council District"
    description: "City council district where station is located"
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    type: string
    label: "Image"
    description: "Image URL for the station"
    sql: ${TABLE}.image ;;
  }

  # Time Dimension Group
  dimension_group: modified {
    type: time
    label: "Modified"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.modified_date ;;
  }

  # Hidden Dimensions for Measures
  dimension: _number_of_docks {
    hidden: yes
    type: number
    sql: ${TABLE}.number_of_docks ;;
  }

  dimension: _footprint_length {
    hidden: yes
    type: number
    sql: ${TABLE}.footprint_length ;;
  }

  dimension: _footprint_width {
    hidden: yes
    type: number
    sql: ${TABLE}.footprint_width ;;
  }

  # Measures
  measure: number_of_docks {
    type: sum
    label: "Total Number of Docks"
    description: "Total number of bike docks across all records"
    sql: COALESCE(${_number_of_docks}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    type: sum
    label: "Total Footprint Length"
    description: "Total length of station footprint"
    sql: COALESCE(${_footprint_length}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    type: average
    label: "Average Footprint Width"
    description: "Average width of station footprint"
    sql: COALESCE(${_footprint_width}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of stations"
  }
}
