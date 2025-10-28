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
    description: "Type of the Subscriber"
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

  # Dimension Group - Time
  dimension_group: start_time {
    label: "Start Time"
    description: "Start timestamp of trip"
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.start_time ;;
  }

  dimension: start_time_month_year {
    group_label: "Start Time"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${start_time_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Hidden dimension for measures
  dimension: duration_minutes_hidden {
    hidden: yes
    type: number
    sql: ${TABLE}.duration_minutes ;;
  }

  # Measures
  measure: duration_minutes {
    label: "Duration Minutes"
    description: "Time of trip in minutes"
    type: sum
    sql: COALESCE(${duration_minutes_hidden}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: trip_count {
    label: "Trip Count"
    description: "Total number of trips"
    type: count
  }
}
