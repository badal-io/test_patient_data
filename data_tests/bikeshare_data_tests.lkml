# Data tests for Bikeshare Info Explore

test: start_station_id_not_null {
  explore_source: bikeshare_info {
    column: start_station_id {}
    sorts: [bikeshare_trips.start_station_id: desc]
    limit: 1
  }
  assert: start_station_id_is_not_null {
    expression: NOT is_null(${bikeshare_trips.start_station_id}) ;;
  }
}

test: end_station_id_not_null {
  explore_source: bikeshare_info {
    column: end_station_id {}
    sorts: [bikeshare_trips.end_station_id: desc]
    limit: 1
  }
  assert: end_station_id_is_not_null {
    expression: NOT is_null(${bikeshare_trips.end_station_id}) ;;
  }
}
