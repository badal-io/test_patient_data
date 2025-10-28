connection: "badal_internal_projects"

# Include all view files
include: "Views/*.view.lkml"

# Include all explore files
include: "Explores/*.explore.lkml"

# Include all dashboard files
include: "LookML_Dashboards/*.dashboard.lookml"

# Include data tests
include: "data_tests/*.lkml"

# Datagroup for cache management
datagroup: week_end {
  label: "Week End"
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger:
    SELECT CASE
      WHEN EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP() AT TIME ZONE "America/New_York") = 2
        AND EXTRACT(HOUR FROM CURRENT_TIMESTAMP() AT TIME ZONE "America/New_York") = 9
      THEN CURRENT_TIMESTAMP()
      ELSE NULL
    END ;;
  max_cache_age: "12 hours"
}
