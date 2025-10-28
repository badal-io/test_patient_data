project_name: "test_patient_data"

# Table name constants
constant: inpatient_charges_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013"
  export: override_required
}

constant: outpatient_charges_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013"
  export: override_required
}

constant: bikeshare_trips_table {
  value: "bigquery-public-data.austin_bikeshare.bikeshare_trips"
  export: override_required
}

constant: bikeshare_stations_table {
  value: "bigquery-public-data.austin_bikeshare.bikeshare_stations"
  export: override_required
}

# Datagroup for caching
datagroup: week_end {
  label: "Weekly Cache"
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger: SELECT CASE WHEN EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP() AT TIME ZONE 'US/Eastern') = 2
               AND EXTRACT(HOUR FROM CURRENT_TIMESTAMP() AT TIME ZONE 'US/Eastern') >= 9 THEN 1 ELSE 0 END ;;
  max_cache_age: "12 hours"
}
