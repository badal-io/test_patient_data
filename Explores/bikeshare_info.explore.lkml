explore: bikeshare_trips {
  label: "Bikeshare Info"
  description: "Bikeshare trips and stations information"

  view_name: bikeshare_trips
  view_label: "Bikeshare Trips"

  join: bikeshare_stations_start {
    type: left_outer
    relationship: many_to_one
    sql_on: ${bikeshare_trips.start_station_id} = CAST(${bikeshare_stations_start.station_id} AS STRING) ;;
    view_label: "Start Bike Stations"
    view_name: bikeshare_stations
  }

  join: bikeshare_stations_end {
    type: left_outer
    relationship: many_to_one
    sql_on: CAST(${bikeshare_trips.end_station_id} AS INTEGER) = ${bikeshare_stations_end.station_id} ;;
    view_label: "End Bike Stations"
    view_name: bikeshare_stations
  }
}
