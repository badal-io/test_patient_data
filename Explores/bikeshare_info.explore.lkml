include: "../Views/*.view.lkml"

explore: bikeshare_info {
  label: "Bikeshare Info"
  description: "Explore that combines bikeshare trips with station information"
  group_label: "Bikeshare"
  view_label: "Bikeshare Trips"
  from: bikeshare_trips
  persist_with: week_end

  join: bikeshare_stations_start {
    type: left_outer
    relationship: many_to_one
    sql_on: CAST(${bikeshare_trips.start_station_id} AS INT64) = ${bikeshare_stations_start.station_id} ;;
    from: bikeshare_stations
    view_label: "Start Bike Stations"
  }

  join: bikeshare_stations_end {
    type: left_outer
    relationship: many_to_one
    sql_on: CAST(${bikeshare_trips.end_station_id} AS INT64) = ${bikeshare_stations_end.station_id} ;;
    from: bikeshare_stations
    view_label: "End Bike Stations"
  }
}
