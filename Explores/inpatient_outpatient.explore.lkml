include: "/Views/inpatient_charges_2013.view.lkml"
include: "/Views/outpatient_charges_2013.view.lkml"

explore: inpatient_outpatient {
  label: "Inpatient & Outpatient"
  view_label: "Inpatient Charges"

  from: inpatient_charges_2013

  join: outpatient_charges_2013 {
    view_label: "Outpatient Charges"
    type: left_outer
    relationship: many_to_one
    sql_on: ${inpatient_outpatient.provider_id} = ${outpatient_charges_2013.provider_id} ;;
  }
}
