view: bikeshare_stations {
  sql_table_name: `@{bikeshare_stations_table}` ;;

  # Primary Key (hidden)
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: CAST(${station_id} AS INT64) ;;
  }

  # Dimensions
  dimension: station_id {
    primary_key: no
    type: number
    label: "Station ID"
    description: "Unique identifier for the bike station"
    sql: CAST(${TABLE}.station_id AS INT64) ;;
  }

  dimension: name {
    type: string
    label: "Name"
    description: "Name of the bike station"
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    type: string
    label: "Status"
    description: "Status of the bike station"
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    type: location
    label: "Location"
    description: "Geographic location of the station"
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: address {
    type: string
    label: "Address"
    description: "Physical address of the station"
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
    sql: CAST(${TABLE}.city_asset_number AS INT64) ;;
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
    description: "Type of power supply at the station"
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
    sql: CAST(${TABLE}.council_district AS INT64) ;;
  }

  dimension: image {
    type: string
    label: "Image"
    description: "Image URL or reference for the station"
    sql: ${TABLE}.image ;;
  }

  # Time dimension
  dimension_group: modified_date {
    type: time
    label: "Modified Date"
    description: "Date when station information was last modified"
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
    type: sum
    label: "Number of Docks"
    description: "Total number of docks across all stations"
    sql: COALESCE(${number_of_docks_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_length {
    type: sum
    label: "Footprint Length"
    description: "Total footprint length"
    sql: COALESCE(${footprint_length_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: footprint_width {
    type: average
    label: "Footprint Width"
    description: "Average footprint width"
    sql: COALESCE(${footprint_width_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Count of bike stations"
    drill_fields: [station_id, name, status, address, city_asset_number]
  }
}
