include: "Views/*.view.lkml"

explore: inpatient_and_outpatient {
  label: "Inpatient & Outpatient"
  description: "Explore inpatient and outpatient charges data"

  from: inpatient_charges_2013
  view_label: "Inpatient Charges"

  join: outpatient_charges_2013 {
    type: left_outer
    relationship: many_to_one
    label: "Outpatient Charges"
    view_label: "Outpatient Charges"
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
  }
}
