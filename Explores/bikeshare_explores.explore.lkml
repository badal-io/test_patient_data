include: "../Views/*.view.lkml"

# Explore 2: Bikeshare Info combined explore
explore: bikeshare_info {
  label: "Bikeshare Info"
  description: "Combined view of bikeshare trips with start and end station information"
  view_name: bikeshare_trips
  persist_with: daily_datagroup

  join: bikeshare_stations_start {
    from: bikeshare_stations
    type: left_outer
    relationship: many_to_one
    sql_on: ${bikeshare_trips.start_station_id} = ${bikeshare_stations_start.station_id} ;;
  }

  join: bikeshare_stations_end {
    from: bikeshare_stations
    type: left_outer
    relationship: many_to_one
    sql_on: CAST(${bikeshare_trips.end_station_id} AS INT64) = ${bikeshare_stations_end.station_id} ;;
  }
}

# Explore 5: Simple explore for bikeshare_trips
explore: bikeshare_trips_explore {
  label: "Bikeshare Trips"
  description: "Explore bikeshare trips data"
  view_name: bikeshare_trips
  persist_with: daily_datagroup
}

# Explore 6: Simple explore for bikeshare_stations
explore: bikeshare_stations_explore {
  label: "Bikeshare Stations"
  description: "Explore bikeshare stations data"
  view_name: bikeshare_stations
  persist_with: daily_datagroup
}
