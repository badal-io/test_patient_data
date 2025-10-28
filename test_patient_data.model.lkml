connection: "badal_internal_projects"

include: "/manifest.lkml"
include: "/Views/*.view.lkml"
include: "/Explores/*.explore.lkml"
include: "/data_tests/*.lkml"

# Datagroup that triggers every Monday at 9am Eastern Time
# Cache is stored for 12 hours
datagroup: week_end {
  label: "Week End"
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger: SELECT IF(EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP()) = 2, EXTRACT(HOUR FROM CURRENT_TIMESTAMP()) >= 9, FALSE) ;;
  max_cache_age: "12 hours"
}

