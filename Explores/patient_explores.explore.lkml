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

# Explore 2: Single explore for inpatient_charges_2013
explore: inpatient_charges_2013_simple {
  from: inpatient_charges_2013
  label: "Inpatient Charges"
}

# Explore 3: Single explore for outpatient_charges_2013
explore: outpatient_charges_2013_simple {
  from: outpatient_charges_2013
  label: "Outpatient Charges"
}
