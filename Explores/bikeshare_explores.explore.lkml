include: "/Views/*.view.lkml"

explore: bikeshare_trips {
  label: "Bikeshare Info"

  join: bikeshare_stations_start {
    view_label: "Start Bike Stations"
    from: bikeshare_stations
    sql_on: ${bikeshare_trips.start_station_id} = CAST(${bikeshare_stations_start.station_id} AS STRING) ;;
    relationship: many_to_one
    type: left_outer
  }

  join: bikeshare_stations_end {
    view_label: "End Bike Stations"
    from: bikeshare_stations
    sql_on: CAST(${bikeshare_trips.end_station_id} AS INTEGER) = ${bikeshare_stations_end.station_id} ;;
    relationship: many_to_one
    type: left_outer
  }
}

# Simple explores for individual views
explore: inpatient_charges_2013 {}

explore: outpatient_charges_2013 {}

explore: bikeshare_stations {}
