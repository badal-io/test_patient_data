view: bikeshare_trips {
  sql_table_name: `@{bikeshare_trips_table}` ;;

  # Primary Key (hidden)
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${trip_id} ;;
  }

  # Dimensions
  dimension: trip_id {
    primary_key: no
    type: string
    label: "Trip ID"
    description: "Numeric ID of bike trip"
    sql: ${TABLE}.trip_id ;;
  }

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
    type: number
    label: "Start Station ID"
    description: "Numeric reference for start station"
    sql: CAST(${TABLE}.start_station_id AS INT64) ;;
  }

  dimension: start_station_name {
    type: string
    label: "Start Station Name"
    description: "Station name for start station"
    sql: ${TABLE}.start_station_name ;;
  }

  dimension: end_station_id {
    type: number
    label: "End Station ID"
    description: "Numeric reference for end station"
    sql: CAST(${TABLE}.end_station_id AS INT64) ;;
  }

  dimension: end_station_name {
    type: string
    label: "End Station Name"
    description: "Station name for end station"
    sql: ${TABLE}.end_station_name ;;
  }

  # Dimension Group for time (start_time)
  dimension_group: start {
    type: time
    label: "Start"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.start_time ;;
  }

  dimension: start_month_year {
    group_label: "Start Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${start_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Hidden dimension for measure
  dimension: _duration_minutes {
    hidden: yes
    type: number
    sql: ${TABLE}.duration_minutes ;;
  }

  # Measures
  measure: duration_minutes {
    type: sum
    label: "Duration Minutes"
    description: "Sum of trip duration in minutes"
    sql: COALESCE(${_duration_minutes}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Count of bike trips"
  }
}
