include: "../Views/*.view.lkml"

# Explore 1: Inpatient & Outpatient combined explore
explore: inpatient_outpatient {
  label: "Inpatient & Outpatient"
  description: "Combined view of inpatient and outpatient charges by provider"
  view_name: inpatient_charges_2013
  persist_with: daily_datagroup

  join: outpatient_charges_2013 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
  }
}

# Explore 3: Simple explore for inpatient_charges_2013
explore: inpatient_charges_2013_explore {
  label: "Inpatient Charges"
  description: "Explore inpatient charges data"
  view_name: inpatient_charges_2013
  persist_with: daily_datagroup
}

# Explore 4: Simple explore for outpatient_charges_2013
explore: outpatient_charges_2013_explore {
  label: "Outpatient Charges"
  description: "Explore outpatient charges data"
  view_name: outpatient_charges_2013
  persist_with: daily_datagroup
}
