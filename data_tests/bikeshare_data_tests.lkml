# Data Test 1: Check that start_station_id in bikeshare_trips view is not NULL
test: bikeshare_start_station_id_not_null {
  explore_source: bikeshare_info {
    column: start_station_id {
      field: bikeshare_trips.start_station_id
    }
    sorts: [bikeshare_trips.start_station_id: desc]
    limit: 1
  }
  assert: start_station_id_is_not_null {
    expression: NOT is_null(${bikeshare_trips.start_station_id}) ;;
  }
}

# Data Test 2: Check that end_station_id in bikeshare_trips view is not NULL
test: bikeshare_end_station_id_not_null {
  explore_source: bikeshare_info {
    column: end_station_id {
      field: bikeshare_trips.end_station_id
    }
    sorts: [bikeshare_trips.end_station_id: desc]
    limit: 1
  }
  assert: end_station_id_is_not_null {
    expression: NOT is_null(${bikeshare_trips.end_station_id}) ;;
  }
}
