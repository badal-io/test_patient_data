# Data tests for test_patient_data project

# Test 1: Check that provider zipcode field from inpatient_charges_2013 doesn't have any NULLs
test: inpatient_zipcode_not_null {
  explore_source: inpatient_outpatient {
    column: provider_zipcode {
      field: inpatient_outpatient.provider_zipcode
    }
    column: count {
      field: inpatient_outpatient.count
    }
    filters: [
      inpatient_outpatient.provider_zipcode: "NULL"
    ]
  }
  assert: zipcode_has_no_nulls {
    expression: ${inpatient_outpatient.count} = 0 ;;
  }
}

# Test 2: Check that measure outpatient_services from outpatient_charges_2013 is greater than 1000 by city
test: outpatient_services_threshold_by_city {
  explore_source: inpatient_outpatient {
    column: provider_city {
      field: outpatient_charges_2013.provider_city
    }
    column: outpatient_services {
      field: outpatient_charges_2013.outpatient_services
    }
  }
  assert: services_above_threshold {
    expression: ${outpatient_charges_2013.outpatient_services} > 1000 ;;
  }
}
