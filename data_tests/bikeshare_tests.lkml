# Data tests for Bikeshare Info Explore

test: bikeshare_start_station_id_not_null {
  title: "Bikeshare Start Station ID Not Null"
  description: "Check that start_station_id in bikeshare_trip view is not NULL"

  explore_source: bikeshare_trips {
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

test: bikeshare_end_station_id_not_null {
  title: "Bikeshare End Station ID Not Null"
  description: "Check that end_station_id in bikeshare_trip view is not NULL"

  explore_source: bikeshare_trips {
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
