view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key (hidden)
  dimension: id {
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
    label: "Station Name"
    description: "Name of the station"
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    type: string
    label: "Status"
    description: "Current status of the station"
    sql: ${TABLE}.status ;;
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
    description: "City asset identification number"
    sql: ${TABLE}.city_asset_number ;;
  }

  dimension: property_type {
    type: string
    label: "Property Type"
    description: "Type of property"
    sql: ${TABLE}.property_type ;;
  }

  dimension: power_type {
    type: string
    label: "Power Type"
    description: "Type of power at the station"
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
    description: "City council district"
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    type: string
    label: "Image"
    description: "URL or reference to station image"
    sql: ${TABLE}.image ;;
  }

  # Location dimension for mapping
  dimension: location {
    type: location
    label: "Location"
    description: "Geographic location of the station"
    sql_latitude: CAST(REGEXP_EXTRACT(${TABLE}.location, r'([\d\.-]+)\s*,') AS FLOAT64) ;;
    sql_longitude: CAST(REGEXP_EXTRACT(${TABLE}.location, r',\s*([\d\.-]+)') AS FLOAT64) ;;
  }

  # Dimension Group for time
  dimension_group: modified_date {
    type: time
    label: "Modified Date"
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
  dimension: _number_of_docks {
    hidden: yes
    type: number
    label: "Number of Docks"
    description: "Number of available docks"
    sql: COALESCE(${TABLE}.number_of_docks, 0) ;;
  }

  dimension: _footprint_length {
    hidden: yes
    type: number
    label: "Footprint Length"
    description: "Length of the station footprint"
    sql: COALESCE(${TABLE}.footprint_length, 0) ;;
  }

  dimension: _footprint_width {
    hidden: yes
    type: number
    label: "Footprint Width"
    description: "Width of the station footprint"
    sql: COALESCE(${TABLE}.footprint_width, 0) ;;
  }

  # Measures
  measure: number_of_docks {
    type: sum
    label: "Number of Docks"
    description: "Sum of available docks"
    sql: ${_number_of_docks} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    type: sum
    label: "Footprint Length"
    description: "Sum of footprint lengths"
    sql: ${_footprint_length} ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    type: sum
    label: "Footprint Width"
    description: "Sum of footprint widths"
    sql: ${_footprint_width} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of stations"
  }
}
