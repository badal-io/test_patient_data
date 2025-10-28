include: "/Views/**/*.view.lkml"

explore: inpatient_outpatient {
  label: "Inpatient & Outpatient"
  description: "Analysis of inpatient and outpatient charges by provider"
  view_name: inpatient_charges_2013
  view_label: "Inpatient Chargers"

  join: outpatient_charges_2013 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
    fields: [outpatient_charges_2013.provider_name, outpatient_charges_2013.provider_city, outpatient_charges_2013.provider_state]
  }
}
