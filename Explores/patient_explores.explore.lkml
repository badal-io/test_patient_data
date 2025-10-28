include: "/Views/*.view.lkml"

explore: inpatient_outpatient {
  label: "Inpatient & Outpatient"
  view_name: inpatient_charges_2013

  join: outpatient_charges_2013 {
    view_label: "Outpatient Charges"
    type: left_outer
    relationship: many_to_one
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
  }
}
