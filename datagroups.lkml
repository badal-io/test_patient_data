# Datagroups for caching policies

datagroup: daily_datagroup {
  label: "Daily Cache"
  description: "Triggers every day at midnight UTC and caches results for 24 hours"
  max_cache_age: "24 hours"
  interval_trigger: "24 hours"
}
