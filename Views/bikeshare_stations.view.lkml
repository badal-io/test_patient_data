view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key (hidden)
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${station_id} ;;
  }

  # Dimensions
  dimension: station_id {
    primary_key: no
    type: number
    label: "Station ID"
    description: "Unique identifier for the station"
    sql: CAST(${TABLE}.station_id AS INT64) ;;
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
    description: "Current status of the station"
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    type: location
    label: "Location"
    description: "Geographic location of the station"
    sql_latitude: CAST(REGEXP_EXTRACT(${TABLE}.location, r'^POINT\(([^)]*)\)') AS FLOAT64) ;;
    sql_longitude: CAST(REGEXP_EXTRACT(${TABLE}.location, r'^POINT\([^)]*\s+([^)]*)\)') AS FLOAT64) ;;
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
    description: "Type of property"
    sql: ${TABLE}.property_type ;;
  }

  dimension: power_type {
    type: string
    label: "Power Type"
    description: "Type of power system"
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
    description: "Council district number"
    sql: ${TABLE}.council_district ;;
  }

  dimension: image {
    type: string
    label: "Image"
    description: "Image URL or reference"
    sql: ${TABLE}.image ;;
  }

  # Dimension Group for time (modified_date)
  dimension_group: modified {
    type: time
    label: "Modified"
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
    label: "Number of Docks"
    description: "Sum of number of docks"
    sql: COALESCE(${_number_of_docks}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    type: sum
    label: "Footprint Length"
    description: "Sum of footprint length"
    sql: COALESCE(${_footprint_length}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    type: sum
    label: "Footprint Width"
    description: "Sum of footprint width"
    sql: COALESCE(${_footprint_width}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Count of stations"
  }
}
