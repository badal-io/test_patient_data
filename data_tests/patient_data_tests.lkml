# Data tests for Inpatient & Outpatient Explore

# Test 1: Check that provider zipcode from inpatient_charges_2013 doesn't have any NULLs
test: provider_zipcode_not_null {
  explore_source: inpatient_charges_2013 {
    column: provider_zipcode {
      field: inpatient_charges_2013.provider_zipcode
    }
    sorts: [inpatient_charges_2013.provider_zipcode: desc]
    limit: 1
  }
  assert: provider_zipcode_is_not_null {
    expression: NOT is_null(${inpatient_charges_2013.provider_zipcode}) ;;
  }
}

# Test 2: Check that measure outpatient_services from outpatient_charges_2013 is greater than 1000 by city
test: outpatient_services_greater_than_1000_by_city {
  explore_source: inpatient_charges_2013 {
    column: provider_city {
      field: inpatient_charges_2013.provider_city
    }
    column: outpatient_services {
      field: outpatient_charges_2013.outpatient_services
    }
    sorts: [outpatient_charges_2013.outpatient_services: asc]
  }
  assert: outpatient_services_gt_1000 {
    expression: ${outpatient_charges_2013.outpatient_services} > 1000 ;;
  }
}
