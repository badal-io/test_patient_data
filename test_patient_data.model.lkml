connection: "badal_internal_projects"

# Include all elements from folders
include: "/Views/*.view.lkml"
include: "/Explores/*.explore.lkml"
include: "/LookML Dashboards/*.dashboard.lookml"
include: "/data_tests/*.lkml"

# Datagroup for weekly refresh
datagroup: week_end {
  description: "Triggers every Monday at 9am Eastern Time"
  sql_trigger_value: SELECT CASE
    WHEN EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP()) = 2
    AND EXTRACT(HOUR FROM TIMESTAMP(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', CURRENT_TIMESTAMP(), 'America/New_York'))) >= 9
    THEN CONCAT(CAST(CURRENT_DATE() AS STRING), ' Week Start')
    ELSE CONCAT(CAST(DATE_SUB(CURRENT_DATE(), INTERVAL MOD(EXTRACT(DAYOFWEEK FROM CURRENT_TIMESTAMP()) + 5, 7) DAY) AS STRING), ' Week Start')
  END ;;
  max_cache_age: "1 hour"
}
