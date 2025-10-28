include: "/Views/**/*.view.lkml"

explore: bikeshare_info {
  label: "Bikeshare Info"
  description: "Analysis of bikeshare trips and station information"
  view_name: bikeshare_trips
  view_label: "Bikeshare Trips"

  join: bikeshare_stations_start {
    type: left_outer
    relationship: many_to_one
    sql_on: ${bikeshare_trips.start_station_id} = ${bikeshare_stations_start.station_id} ;;
    view_label: "Start Bike Stations"
    fields: [bikeshare_stations_start.name, bikeshare_stations_start.address, bikeshare_stations_start.status]
  }

  join: bikeshare_stations_end {
    type: left_outer
    relationship: many_to_one
    sql_on: CAST(${bikeshare_trips.end_station_id} AS INTEGER) = ${bikeshare_stations_end.station_id} ;;
    view_label: "End Bike Stations"
    fields: [bikeshare_stations_end.name, bikeshare_stations_end.address, bikeshare_stations_end.status]
  }
}
