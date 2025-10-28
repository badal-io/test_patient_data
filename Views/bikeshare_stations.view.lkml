view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key (hidden)
  dimension: station_id {
    hidden: no
    primary_key: yes
    type: number
    label: "Station ID"
    description: "Unique identifier for the station"
    sql: ${TABLE}.station_id ;;
  }

  # Dimensions
  dimension: name {
    type: string
    label: "Station Name"
    description: "Name of the bike station"
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
    sql_latitude: CAST(REGEXP_EXTRACT(${TABLE}.location, r'(\-?\d+\.\d+),') AS FLOAT64) ;;
    sql_longitude: CAST(REGEXP_EXTRACT(${TABLE}.location, r',\s*(\-?\d+\.\d+)') AS FLOAT64) ;;
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
    description: "City council district of the station"
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    type: string
    label: "Image"
    description: "Image URL for the station"
    sql: ${TABLE}.image ;;
  }

  # Dimension group for modified_date
  dimension_group: modified {
    type: time
    label: "Modified"
    description: "Last modification timestamp"
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
    type: sum
    label: "Total Number of Docks"
    description: "Sum of number of docks across all stations"
    sql: ${_number_of_docks} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    type: sum
    label: "Total Footprint Length"
    description: "Sum of footprint length"
    sql: ${_footprint_length} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    type: sum
    label: "Total Footprint Width"
    description: "Sum of footprint width"
    sql: ${_footprint_width} ;;
    value_format: "#,##0.00"
  }

  measure: average_footprint_width {
    type: average
    label: "Average Footprint Width"
    description: "Average of footprint width"
    sql: ${_footprint_width} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count of Stations"
    description: "Count of bike stations"
  }
}
