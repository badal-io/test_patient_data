connection: "badal_internal_projects"

# Include all view files from Views folder
include: "/Views/*.view.lkml"

# Include all explore files from Explores folder
include: "/Explores/*.explore.lkml"

# Include all dashboard files from LookML_Dashboards folder
include: "/LookML_Dashboards/*.dashboard.lookml"

# Include all data test files from data_tests folder
include: "/data_tests/*.lkml"

# Datagroup: Triggers every Monday at 9am Eastern Time
datagroup: week_end {
  label: "Week End"
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger: SELECT CASE
    WHEN EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP()) = 2
      AND EXTRACT(HOUR FROM CURRENT_TIMESTAMP()) >= 9
    THEN 1
    ELSE 0
  END ;;
  max_cache_age: "12 hours"
}
