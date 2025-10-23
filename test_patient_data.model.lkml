connection: "badal_internal_projects"

# Include all project elements
include: "/Views/*.view.lkml"
include: "/Explores/*.explore.lkml"
include: "/Dashboards/*.dashboard.lookml"
include: "/data_tests/*.lkml"

# Datagroup for weekly refresh on Mondays at 9am Eastern Time
datagroup: week_end {
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger: SELECT CASE
    WHEN EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP() AT TIME ZONE 'America/New_York') = 2
      AND EXTRACT(HOUR FROM CURRENT_TIMESTAMP() AT TIME ZONE 'America/New_York') = 9
    THEN 1
    ELSE 0
  END ;;
  max_cache_age: "12 hours"
}

