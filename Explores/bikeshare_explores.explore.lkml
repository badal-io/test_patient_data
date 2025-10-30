include: "/Views/*.view.lkml"

# Explore 1: Bikeshare Info with joined stations
explore: bikeshare_trips {
  label: "Bikeshare Info"

  view_label: "Bikeshare Trips"

  join: bikeshare_stations {
    type: left_outer
    relationship: many_to_one
    sql_on: ${bikeshare_trips.start_station_id} = ${bikeshare_stations.station_id} ;;
    view_label: "Start Bike Stations"
  }

  join: bikeshare_stations_end {
    from: bikeshare_stations
    type: left_outer
    relationship: many_to_one
    sql_on: ${bikeshare_trips.end_station_id} = ${bikeshare_stations_end.station_id} ;;
    view_label: "End Bike Stations"
  }
}

# Explore 2: Simple explore for bikeshare_trips
explore: bikeshare_trips_simple {
  label: "Bikeshare Trips"
}

# Explore 3: Simple explore for bikeshare_stations
explore: bikeshare_stations {
  label: "Bikeshare Stations"
}
