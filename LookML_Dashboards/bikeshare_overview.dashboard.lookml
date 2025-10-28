- dashboard: bikeshare_overview
  title: Bikeshare Overview
  layout: newspaper
  refresh: auto
  description: Dashboard showing bikeshare trips and stations data

  filters:
    - name: start_station_name_filter
      title: Start Station Name
      type: field_filter
      explore: bikeshare_info
      field: start_stations.name

    - name: end_station_name_filter
      title: End Station Name
      type: field_filter
      explore: bikeshare_info
      field: end_stations.name

    - name: subscriber_type_filter
      title: Subscriber Type
      type: field_filter
      explore: bikeshare_info
      field: bikeshare_trips.subscriber_type

    - name: bike_type_filter
      title: Bike Type
      type: field_filter
      explore: bikeshare_info
      field: bikeshare_trips.bike_type

  elements:
    - name: total_number_of_trips
      title: Total Number of Trips
      type: single_value
      explore: bikeshare_info
      measures: [bikeshare_trips.count]
      filters:
        start_stations.name: "{{ start_station_name_filter._value }}"
        end_stations.name: "{{ end_station_name_filter._value }}"
        bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
        bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
      query_timezone: America/Los_Angeles

    - name: average_trip_duration
      title: Average Trip Duration
      type: single_value
      explore: bikeshare_info
      measures: [bikeshare_trips.average_duration_minutes]
      filters:
        start_stations.name: "{{ start_station_name_filter._value }}"
        end_stations.name: "{{ end_station_name_filter._value }}"
        bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
        bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
      query_timezone: America/Los_Angeles

    - name: total_number_of_stations
      title: Total Number of Stations
      type: single_value
      explore: bikeshare_info
      measures: [end_stations.count]
      filters:
        start_stations.name: "{{ start_station_name_filter._value }}"
        end_stations.name: "{{ end_station_name_filter._value }}"
        bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
        bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
      query_timezone: America/Los_Angeles

    - name: end_station_trips_treemap
      title: Trips by End Station (Treemap)
      type: treemap
      explore: bikeshare_info
      dimensions: [end_stations.name]
      measures: [bikeshare_trips.count]
      filters:
        start_stations.name: "{{ start_station_name_filter._value }}"
        end_stations.name: "{{ end_station_name_filter._value }}"
        bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
        bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
      query_timezone: America/Los_Angeles

    - name: bike_type_subscriber_type_report
      title: Bike Type and Subscriber Type Report
      type: table
      explore: bikeshare_info
      dimensions: [bikeshare_trips.bike_type, bikeshare_trips.subscriber_type]
      measures: [bikeshare_trips.count, bikeshare_trips.duration_minutes]
      filters:
        start_stations.name: "{{ start_station_name_filter._value }}"
        end_stations.name: "{{ end_station_name_filter._value }}"
        bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
        bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
      query_timezone: America/Los_Angeles
      show_view_names: false
      theme: contemporary
      conditional_formatting: []

    - name: end_station_trips_histogram
      title: Trip Distribution by End Station
      type: looker_histogram
      explore: bikeshare_info
      dimensions: [end_stations.name]
      measures: [bikeshare_trips.count]
      filters:
        start_stations.name: "{{ start_station_name_filter._value }}"
        end_stations.name: "{{ end_station_name_filter._value }}"
        bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
        bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
      query_timezone: America/Los_Angeles
      series_colors:
        bikeshare_trips.count: "#e83461"

    - name: bike_stations_map
      title: Bike Stations Map
      type: looker_map
      explore: bikeshare_info
      dimensions: [end_stations.location]
      measures: [bikeshare_trips.count]
      filters:
        start_stations.name: "{{ start_station_name_filter._value }}"
        end_stations.name: "{{ end_station_name_filter._value }}"
        bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
        bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
      query_timezone: America/Los_Angeles
