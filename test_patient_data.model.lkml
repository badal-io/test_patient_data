connection: "badal_internal_projects"

# Include all elements from folders
include: "/Views/*.view.lkml"
include: "/Explores/*.explore.lkml"
include: "/Dashboards/*.dashboard.lookml"
include: "/data_tests/*.lkml"

# Datagroup for weekly refresh
datagroup: week_end {
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger: SELECT FLOOR((UNIX_SECONDS(CURRENT_TIMESTAMP()) - 32400) / 604800) ;;
  max_cache_age: "24 hours"
}
