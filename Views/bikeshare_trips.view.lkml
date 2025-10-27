view: bikeshare_trips {
  sql_table_name: `@{bikeshare_trips_table}` ;;

  # Primary Key (hidden)
  dimension: trip_id {
    primary_key: yes
    hidden: no
    label: "Trip ID"
    description: "Numeric ID of bike trip"
    type: string
    sql: ${TABLE}.trip_id ;;
  }

  # Dimensions
  dimension: subscriber_type {
    label: "Subscriber Type"
    description: "Type of the subscriber"
    type: string
    sql: ${TABLE}.subscriber_type ;;
  }

  dimension: bike_id {
    label: "Bike ID"
    description: "ID of bike used"
    type: string
    sql: ${TABLE}.bike_id ;;
  }

  dimension: bike_type {
    label: "Bike Type"
    description: "Type of bike used"
    type: string
    sql: ${TABLE}.bike_type ;;
  }

  dimension: start_station_id {
    label: "Start Station ID"
    description: "Numeric reference for start station"
    type: number
    sql: ${TABLE}.start_station_id ;;
  }

  dimension: start_station_name {
    label: "Start Station Name"
    description: "Station name for start station"
    type: string
    sql: ${TABLE}.start_station_name ;;
  }

  dimension: end_station_id {
    label: "End Station ID"
    description: "Numeric reference for end station"
    type: string
    sql: ${TABLE}.end_station_id ;;
  }

  dimension: end_station_name {
    label: "End Station Name"
    description: "Station name for end station"
    type: string
    sql: ${TABLE}.end_station_name ;;
  }

  # Time dimension
  dimension_group: start_time {
    type: time
    label: "Start"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.start_time ;;
  }

  # Hidden dimension for measure
  dimension: _duration_minutes {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.duration_minutes, 0) ;;
  }

  # Measures
  measure: duration_minutes {
    label: "Duration (Minutes)"
    description: "Time of trip in minutes"
    type: average
    sql: ${_duration_minutes} ;;
    value_format: "#,##0.00"
  }

  measure: total_duration_minutes {
    label: "Total Duration (Minutes)"
    description: "Total time of all trips in minutes"
    type: sum
    sql: ${_duration_minutes} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    label: "Count"
    type: count
    drill_fields: [trip_id, start_station_name, end_station_name, count]
  }
}
