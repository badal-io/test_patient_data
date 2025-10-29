include: "/Views/*.view.lkml"

explore: inpatient_outpatient {
  view_name: inpatient_charges_2013
  label: "Inpatient & Outpatient"

  view_label: "Inpatient Chargers"

  join: outpatient_charges_2013 {
    view_label: "Outpatient Chargers"
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
    relationship: many_to_one
    type: left_outer
  }
}
