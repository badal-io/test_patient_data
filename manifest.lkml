project_name: "test_patient_data"

# BigQuery Table Constants
constant: inpatient_charges_2013_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013"
  export: override_required
}

constant: outpatient_charges_2013_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013"
  export: override_required
}

constant: bikeshare_trips_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips"
  export: override_required
}

constant: bikeshare_stations_table {
  value: "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_stations"
  export: override_required
}
