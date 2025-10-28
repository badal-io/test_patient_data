include: "../Views/*.view.lkml"

explore: inpatient_outpatient {
  label: "Inpatient & Outpatient"
  description: "Explore that combines inpatient and outpatient charge data by provider"
  group_label: "Healthcare"
  view_label: "Inpatient Charges"
  from: inpatient_charges_2013
  persist_with: week_end

  join: outpatient_charges_2013 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
    view_label: "Outpatient Charges"
  }
}
