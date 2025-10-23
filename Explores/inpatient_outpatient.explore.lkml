# Include view files needed for this explore
include: "/Views/*.view.lkml"

explore: inpatient_outpatient {
  label: "Inpatient & Outpatient"
  description: "Combined view of inpatient and outpatient charges data for healthcare providers"
  view_label: "Inpatient & Outpatient Analysis"

  view_name: inpatient_charges_2013

  # Use the datagroup for caching
  persist_with: week_end

  join: outpatient_charges_2013 {
    type: left_outer
    relationship: one_to_many
    sql_on: ${inpatient_charges_2013.provider_id} = ${outpatient_charges_2013.provider_id} ;;
    view_label: "Outpatient Data"
  }
}
