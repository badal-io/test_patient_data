explore: inpatient_outpatient {
  label: "Inpatient & Outpatient"
  description: "Combined view of inpatient and outpatient charges data"

  view_name: inpatient_charges_2013

  join: outpatient_charges_2013 {
    type: left_outer
    relationship: one_to_many
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
  }
}
