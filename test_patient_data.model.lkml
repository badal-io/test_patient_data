connection: "badal_internal_projects"

# Include all views, explores, and dashboards
include: "/Views/*.view.lkml"
include: "/Explores/*.explore.lkml"
include: "/LookML_Dashboards/*.dashboard.lookml"
include: "/data_tests/*.lkml"

# Datagroup for caching - triggers every Monday at 9am Eastern Time
datagroup: week_end {
  label: "Weekly Cache"
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger:
    SELECT CASE
      WHEN EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP()) = 2
      AND EXTRACT(HOUR FROM TIMESTAMP(CURRENT_TIMESTAMP(), 'America/New_York')) >= 9
      THEN CAST(CURRENT_DATE() AS STRING)
      ELSE NULL
    END ;;
  max_cache_age: "12 hours"
}

