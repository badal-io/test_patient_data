view: bikeshare_trips {
  sql_table_name: `@{bikeshare_trips_table}` ;;
  label: "Bikeshare Trips"

  # Primary Key - Hidden
  dimension: trip_id {
    primary_key: yes
    type: string
    label: "Trip ID"
    description: "Numeric ID of bike trip"
    sql: ${TABLE}.trip_id ;;
  }

  # Dimensions
  dimension: subscriber_type {
    type: string
    label: "Subscriber Type"
    description: "Type of the Subscriber"
    sql: ${TABLE}.subscriber_type ;;
  }

  dimension: bike_id {
    type: string
    label: "Bike ID"
    description: "ID of bike used"
    sql: ${TABLE}.bike_id ;;
  }

  dimension: bike_type {
    type: string
    label: "Bike Type"
    description: "Type of bike used"
    sql: ${TABLE}.bike_type ;;
  }

  dimension: start_station_id {
    type: string
    label: "Start Station ID"
    description: "Numeric reference for start station"
    sql: ${TABLE}.start_station_id ;;
  }

  dimension: start_station_name {
    type: string
    label: "Start Station Name"
    description: "Station name for start station"
    sql: ${TABLE}.start_station_name ;;
  }

  dimension: end_station_id {
    type: string
    label: "End Station ID"
    description: "Numeric reference for end station"
    sql: ${TABLE}.end_station_id ;;
  }

  dimension: end_station_name {
    type: string
    label: "End Station Name"
    description: "Station name for end station"
    sql: ${TABLE}.end_station_name ;;
  }

  # Time Dimension Group
  dimension_group: start {
    type: time
    label: "Start"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.start_time ;;
  }

  # Hidden Dimension for Measures
  dimension: _duration_minutes {
    hidden: yes
    type: number
    sql: ${TABLE}.duration_minutes ;;
  }

  # Measures
  measure: duration_minutes {
    type: average
    label: "Average Duration (minutes)"
    description: "Average duration of trips in minutes"
    sql: COALESCE(${_duration_minutes}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: total_duration_minutes {
    type: sum
    label: "Total Duration (minutes)"
    description: "Total duration of all trips in minutes"
    sql: COALESCE(${_duration_minutes}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of trips"
  }
}
