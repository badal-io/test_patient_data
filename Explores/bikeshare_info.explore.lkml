include: "/Views/bikeshare_trips.view.lkml"
include: "/Views/bikeshare_stations.view.lkml"

explore: bikeshare_info {
  label: "Bikeshare Info"
  view_label: "Bikeshare Trips"

  from: bikeshare_trips

  join: start_station {
    from: bikeshare_stations
    view_label: "Start Bike Stations"
    type: left_outer
    relationship: many_to_one
    sql_on: ${bikeshare_info.start_station_id} = ${start_station.station_id} ;;
  }

  join: end_station {
    from: bikeshare_stations
    view_label: "End Bike Stations"
    type: left_outer
    relationship: many_to_one
    sql_on: CAST(${bikeshare_info.end_station_id} AS INT64) = ${end_station.station_id} ;;
  }
}
