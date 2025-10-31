datagroup: daily_datagroup {
  label: "Daily Datagroup"
  description: "Triggers every day at midnight UTC to refresh cached query results"
  sql_trigger: SELECT CURRENT_DATE() ;;
  max_cache_age: "24 hours"
}
