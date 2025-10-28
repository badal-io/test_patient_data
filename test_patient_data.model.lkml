connection: "badal_internal_projects"

include: "*.lkml"
include: "Views/*.view.lkml"
include: "Explores/*.explore.lkml"
include: "LookML_Dashboards/*.dashboard.lookml"
include: "data_tests/*.lkml"

# Datagroup for caching (also defined in manifest.lkml)
datagroup: week_end {
  label: "Weekly Cache"
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger: SELECT CASE WHEN EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP() AT TIME ZONE 'US/Eastern') = 2
               AND EXTRACT(HOUR FROM CURRENT_TIMESTAMP() AT TIME ZONE 'US/Eastern') >= 9 THEN 1 ELSE 0 END ;;
  max_cache_age: "12 hours"
}


