include: "/Views/*.view.lkml"

# Explore 1: Inpatient & Outpatient
explore: inpatient_charges_2013 {
  label: "Inpatient & Outpatient"
  view_label: "Inpatient Charges"

  join: outpatient_charges_2013 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
    view_label: "Outpatient Charges"
  }
}

# Explore 2: Simple explore for inpatient_charges_2013
explore: inpatient_charges_2013_explore {
  label: "Inpatient Charges"
  view_name: inpatient_charges_2013
}

# Explore 3: Simple explore for outpatient_charges_2013
explore: outpatient_charges_2013_explore {
  label: "Outpatient Charges"
  view_name: outpatient_charges_2013
}
