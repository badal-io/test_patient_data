view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key (hidden)
  dimension: _id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${station_id} ;;
  }

  # Dimensions
  dimension: station_id {
    type: number
    label: "Station ID"
    description: "Unique identifier for the station"
    sql: ${TABLE}.station_id ;;
  }

  dimension: name {
    type: string
    label: "Name"
    description: "Name of the station"
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    type: string
    label: "Status"
    description: "Status of the station"
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    type: location
    label: "Location"
    description: "Geographic location of the station"
    sql_latitude: CAST(SPLIT(TRIM(${TABLE}.location, '()'), ',')[OFFSET(0)] AS FLOAT64) ;;
    sql_longitude: CAST(SPLIT(TRIM(${TABLE}.location, '()'), ',')[OFFSET(1)] AS FLOAT64) ;;
  }

  dimension: address {
    type: string
    label: "Address"
    description: "Address of the station"
    sql: ${TABLE}.address ;;
  }

  dimension: alternate_name {
    type: string
    label: "Alternate Name"
    description: "Alternate name for the station"
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
    description: "Type of property where the station is located"
    sql: ${TABLE}.property_type ;;
  }

  dimension: power_type {
    type: string
    label: "Power Type"
    description: "Type of power supply for the station"
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
    description: "Council district where the station is located"
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    type: string
    label: "Image"
    description: "Image URL for the station"
    sql: ${TABLE}.image ;;
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

  # Dimension Group for modified_date
  dimension_group: modified {
    type: time
    label: "Modified"
    description: "Date when the station was last modified"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.modified_date ;;
  }

  dimension: modified_month_year {
    group_label: "Modified Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${modified_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Measures
  measure: number_of_docks {
    type: sum
    label: "Number of Docks"
    description: "Total number of docks"
    sql: COALESCE(${_number_of_docks}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    type: sum
    label: "Footprint Length"
    description: "Total footprint length"
    sql: COALESCE(${_footprint_length}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    type: sum
    label: "Footprint Width"
    description: "Total footprint width"
    sql: COALESCE(${_footprint_width}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count of Stations"
    description: "Number of stations"
  }
}
