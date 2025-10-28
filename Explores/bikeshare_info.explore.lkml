include: "Views/*.view.lkml"

explore: bikeshare_info {
  label: "Bikeshare Info"
  description: "Explore bikeshare trips and stations data"

  from: bikeshare_trips
  view_label: "Bikeshare Trips"

  join: start_stations {
    type: left_outer
    relationship: many_to_one
    from: bikeshare_stations
    label: "Start Bike Stations"
    view_label: "Start Bike Stations"
    sql_on: ${bikeshare_trips.start_station_id} = ${start_stations.station_id} ;;
  }

  join: end_stations {
    type: left_outer
    relationship: many_to_one
    from: bikeshare_stations
    label: "End Bike Stations"
    view_label: "End Bike Stations"
    sql_on: CAST(${bikeshare_trips.end_station_id} AS INTEGER) = ${end_stations.station_id} ;;
  }
}
