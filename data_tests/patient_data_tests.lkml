# Data tests for Inpatient & Outpatient Explore

test: provider_zipcode_not_null {
  explore_source: inpatient_and_outpatient {
    column: provider_zipcode {}
    sorts: [inpatient_charges_2013.provider_zipcode: desc]
    limit: 1
  }
  assert: provider_zipcode_is_not_null {
    expression: NOT is_null(${inpatient_charges_2013.provider_zipcode}) ;;
  }
}

test: outpatient_services_greater_than_1000_by_city {
  explore_source: inpatient_and_outpatient {
    column: provider_city {}
    column: outpatient_services {
      field: outpatient_charges_2013.outpatient_services
    }
    dimensions: [inpatient_charges_2013.provider_city]
    measures: [outpatient_charges_2013.outpatient_services]
  }
  assert: outpatient_services_greater_than_1000 {
    expression: ${outpatient_charges_2013.outpatient_services} > 1000 ;;
  }
}
