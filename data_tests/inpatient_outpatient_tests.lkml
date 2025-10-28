# Data tests for Inpatient & Outpatient Explores

test: inpatient_zipcode_not_null {
  title: "Inpatient Provider Zipcode Not Null"
  description: "Check that provider zipcode field from inpatient_charges_2013 doesn't have any NULLs"

  explore_source: inpatient_charges_2013 {
    column: provider_zipcode {
      field: inpatient_charges_2013.provider_zipcode
    }
    sorts: [inpatient_charges_2013.provider_zipcode: desc]
    limit: 1
  }

  assert: zipcode_is_not_null {
    expression: NOT is_null(${inpatient_charges_2013.provider_zipcode}) ;;
  }
}

test: outpatient_services_greater_than_1000_by_city {
  title: "Outpatient Services Greater Than 1000 by City"
  description: "Check that measure outpatient_services from outpatient_charges_2013 is greater than 1000 by city"

  explore_source: inpatient_charges_2013 {
    column: provider_city {
      field: inpatient_charges_2013.provider_city
    }
    measures:
      - outpatient_charges_2013.outpatient_services
    dimensions:
      - inpatient_charges_2013.provider_city
    sorts:
      - outpatient_charges_2013.outpatient_services desc
  }

  assert: services_over_threshold {
    expression: ${outpatient_charges_2013.outpatient_services} > 1000 OR is_null(${outpatient_charges_2013.outpatient_services}) ;;
  }
}
