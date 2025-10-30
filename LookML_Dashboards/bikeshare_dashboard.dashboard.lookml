- dashboard: bikeshare_dashboard
  title: "Bikeshare Information"
  description: "Dashboard for analyzing bikeshare trips and station information"
  layout: grid
  rows:
    - elements: [total_trips, avg_duration, total_stations]
      height: 200
    - elements: [trips_by_subscriber]
      height: 300
    - elements: [trips_table]
      height: 400
    - elements: [station_map]
      height: 400

  filters:
    - name: start_station_filter
      title: "Start Station Name"
      type: field_filter
      model: test_patient_data
      explore: bikeshare_trips
      field: bikeshare_stations.name
      listens_to_filters: []
      allow_multiple_values: true

    - name: end_station_filter
      title: "End Station Name"
      type: field_filter
      model: test_patient_data
      explore: bikeshare_trips
      field: bikeshare_stations_end.name
      listens_to_filters: []
      allow_multiple_values: true

    - name: subscriber_type_filter
      title: "Subscriber Type"
      type: field_filter
      model: test_patient_data
      explore: bikeshare_trips
      field: bikeshare_trips.subscriber_type
      allow_multiple_values: true

    - name: bike_type_filter
      title: "Bike Type"
      type: field_filter
      model: test_patient_data
      explore: bikeshare_trips
      field: bikeshare_trips.bike_type
      allow_multiple_values: true

  elements:
    - name: total_trips
      title: "Total Trips"
      type: single_value
      query:
        model: test_patient_data
        explore: bikeshare_trips
        dimensions: []
        measures: [bikeshare_trips.count]
        filters:
          bikeshare_stations.name: "{% parameter start_station_filter %}"
          bikeshare_stations_end.name: "{% parameter end_station_filter %}"
          bikeshare_trips.subscriber_type: "{% parameter subscriber_type_filter %}"
          bikeshare_trips.bike_type: "{% parameter bike_type_filter %}"
        limit: 1

    - name: avg_duration
      title: "Average Trip Duration (minutes)"
      type: single_value
      query:
        model: test_patient_data
        explore: bikeshare_trips
        dimensions: []
        measures: [bikeshare_trips.duration_minutes]
        filters:
          bikeshare_stations.name: "{% parameter start_station_filter %}"
          bikeshare_stations_end.name: "{% parameter end_station_filter %}"
          bikeshare_trips.subscriber_type: "{% parameter subscriber_type_filter %}"
          bikeshare_trips.bike_type: "{% parameter bike_type_filter %}"
        limit: 1

    - name: total_stations
      title: "Total Stations"
      type: single_value
      query:
        model: test_patient_data
        explore: bikeshare_stations_explore
        dimensions: []
        measures: [bikeshare_stations.count]
        limit: 1

    - name: trips_by_subscriber
      title: "Trips by Subscriber Type"
      type: looker_bar
      query:
        model: test_patient_data
        explore: bikeshare_trips
        dimensions: [bikeshare_trips.subscriber_type]
        measures: [bikeshare_trips.count]
        filters:
          bikeshare_stations.name: "{% parameter start_station_filter %}"
          bikeshare_stations_end.name: "{% parameter end_station_filter %}"
          bikeshare_trips.subscriber_type: "{% parameter subscriber_type_filter %}"
          bikeshare_trips.bike_type: "{% parameter bike_type_filter %}"
        sorts: [bikeshare_trips.count desc]
        limit: 500

    - name: trips_table
      title: "Trip Details"
      type: looker_table
      query:
        model: test_patient_data
        explore: bikeshare_trips
        dimensions: [bikeshare_trips.trip_id, bikeshare_trips.subscriber_type, bikeshare_trips.bike_type, bikeshare_stations.name, bikeshare_stations_end.name, bikeshare_trips.start_date]
        measures: [bikeshare_trips.duration_minutes]
        filters:
          bikeshare_stations.name: "{% parameter start_station_filter %}"
          bikeshare_stations_end.name: "{% parameter end_station_filter %}"
          bikeshare_trips.subscriber_type: "{% parameter subscriber_type_filter %}"
          bikeshare_trips.bike_type: "{% parameter bike_type_filter %}"
        sorts: [bikeshare_trips.start_date desc]
        limit: 500

    - name: station_map
      title: "Bikeshare Station Locations"
      type: looker_map
      query:
        model: test_patient_data
        explore: bikeshare_stations_explore
        dimensions: [bikeshare_stations.location, bikeshare_stations.name, bikeshare_stations.status]
        measures: [bikeshare_stations.number_of_docks]
        sorts: [bikeshare_stations.number_of_docks desc]
        limit: 500
