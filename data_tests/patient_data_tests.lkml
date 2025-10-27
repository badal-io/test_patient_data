# Data Tests for test_patient_data project

# Tests for Inpatient & Outpatient Explore

# Test 1: Check that provider zipcode field from inpatient_charges_2013 doesn't have any NULLs
test: inpatient_provider_zipcode_not_null {
  explore_source: inpatient_outpatient {
    column: provider_zipcode {
      field: inpatient_outpatient.provider_zipcode
    }
    sorts: [inpatient_outpatient.provider_zipcode: desc]
    limit: 1
  }
  assert: zipcode_is_not_null {
    expression: NOT is_null(${inpatient_outpatient.provider_zipcode}) ;;
  }
}

# Test 2: Check that measure outpatient_services from outpatient_charges_2013 is greater than 1000 by city
test: outpatient_services_greater_than_1000_by_city {
  explore_source: inpatient_outpatient {
    column: provider_city {
      field: inpatient_outpatient.provider_city
    }
    column: outpatient_services {
      field: outpatient_charges_2013.outpatient_services
    }
    filters: [inpatient_outpatient.provider_city: "-NULL"]
  }
  assert: outpatient_services_above_threshold {
    expression: ${outpatient_charges_2013.outpatient_services} > 1000 ;;
  }
}

# Tests for Bikeshare Info Explore

# Test 3: Check that start_station_id in bikeshare_trips view is not NULL
test: bikeshare_start_station_id_not_null {
  explore_source: bikeshare_info {
    column: start_station_id {
      field: bikeshare_info.start_station_id
    }
    sorts: [bikeshare_info.start_station_id: desc]
    limit: 1
  }
  assert: start_station_id_is_not_null {
    expression: NOT is_null(${bikeshare_info.start_station_id}) ;;
  }
}

# Test 4: Check that end_station_id in bikeshare_trips view is not NULL
test: bikeshare_end_station_id_not_null {
  explore_source: bikeshare_info {
    column: end_station_id {
      field: bikeshare_info.end_station_id
    }
    sorts: [bikeshare_info.end_station_id: desc]
    limit: 1
  }
  assert: end_station_id_is_not_null {
    expression: NOT is_null(${bikeshare_info.end_station_id}) ;;
  }
}
