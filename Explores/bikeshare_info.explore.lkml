include: "/Views/*.view.lkml"

explore: bikeshare_info {
  label: "Bikeshare Info"
  description: "Explore combining bikeshare trips and station data"

  view_name: bikeshare_trips

  join: bikeshare_stations_start {
    from: bikeshare_stations
    type: left_outer
    relationship: many_to_one
    sql_on: ${bikeshare_trips.start_station_id} = ${bikeshare_stations_start.station_id} ;;
    view_label: "Start Bike Stations"
  }

  join: bikeshare_stations_end {
    from: bikeshare_stations
    type: left_outer
    relationship: many_to_one
    sql_on: CAST(${bikeshare_trips.end_station_id} AS INTEGER) = ${bikeshare_stations_end.station_id} ;;
    view_label: "End Bike Stations"
  }
}
