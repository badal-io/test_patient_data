- dashboard: bikeshare_dashboard
  title: "Bikeshare Analysis"
  description: "Dashboard analyzing bikeshare trips and station information"
  layout: grid
  tile_size: 100

  filters:
    - name: start_station_filter
      title: "Start Station"
      type: field_filter
      explore: bikeshare_info
      field: bikeshare_stations_start.name
      default_value: ""

    - name: end_station_filter
      title: "End Station"
      type: field_filter
      explore: bikeshare_info
      field: bikeshare_stations_end.name
      default_value: ""

    - name: subscriber_type_filter
      title: "Subscriber Type"
      type: field_filter
      explore: bikeshare_info
      field: bikeshare_trips.subscriber_type
      default_value: ""

    - name: bike_type_filter
      title: "Bike Type"
      type: field_filter
      explore: bikeshare_info
      field: bikeshare_trips.bike_type
      default_value: ""

  elements:
    - name: total_trips
      title: "Total Trips"
      type: single_value
      query:
        model: test_patient_data
        explore: bikeshare_info
        dimensions: []
        measures: [bikeshare_trips.count]
        filters:
          bikeshare_stations_start.name: "{{ start_station_filter._value }}"
          bikeshare_stations_end.name: "{{ end_station_filter._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
          bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
        limit: 500
      row: 0
      col: 0
      width: 6
      height: 4

    - name: avg_trip_duration
      title: "Average Trip Duration (Minutes)"
      type: single_value
      query:
        model: test_patient_data
        explore: bikeshare_info
        dimensions: []
        measures: [bikeshare_trips.duration_minutes]
        filters:
          bikeshare_stations_start.name: "{{ start_station_filter._value }}"
          bikeshare_stations_end.name: "{{ end_station_filter._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
          bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
        limit: 500
      row: 0
      col: 6
      width: 6
      height: 4

    - name: unique_bikes
      title: "Unique Bikes"
      type: single_value
      query:
        model: test_patient_data
        explore: bikeshare_info
        dimensions: [bikeshare_trips.bike_id]
        measures: []
        filters:
          bikeshare_stations_start.name: "{{ start_station_filter._value }}"
          bikeshare_stations_end.name: "{{ end_station_filter._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
          bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
        limit: 1
      row: 0
      col: 12
      width: 6
      height: 4

    - name: trips_by_date_and_type
      title: "Trips by Date and Subscriber Type"
      type: looker_bar
      query:
        model: test_patient_data
        explore: bikeshare_info
        dimensions: [bikeshare_trips.start_time_date, bikeshare_trips.subscriber_type]
        measures: [bikeshare_trips.count]
        filters:
          bikeshare_stations_start.name: "{{ start_station_filter._value }}"
          bikeshare_stations_end.name: "{{ end_station_filter._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
          bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
        sorts: [bikeshare_trips.start_time_date: desc]
        limit: 500
      row: 4
      col: 0
      width: 18
      height: 8

    - name: trips_details
      title: "Trip Details"
      type: looker_table
      query:
        model: test_patient_data
        explore: bikeshare_info
        dimensions: [bikeshare_trips.trip_id, bikeshare_trips.bike_id, bikeshare_trips.subscriber_type, bikeshare_stations_start.name, bikeshare_stations_end.name, bikeshare_trips.start_time_time]
        measures: [bikeshare_trips.duration_minutes]
        filters:
          bikeshare_stations_start.name: "{{ start_station_filter._value }}"
          bikeshare_stations_end.name: "{{ end_station_filter._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
          bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
        sorts: [bikeshare_trips.start_time_time: desc]
        limit: 500
      row: 12
      col: 0
      width: 18
      height: 8

    - name: stations_map
      title: "Bike Station Locations"
      type: looker_map
      query:
        model: test_patient_data
        explore: bikeshare_info
        dimensions: [bikeshare_stations_start.location, bikeshare_stations_start.name]
        measures: [bikeshare_stations_start.number_of_docks]
        filters:
          bikeshare_stations_start.name: "{{ start_station_filter._value }}"
          bikeshare_stations_end.name: "{{ end_station_filter._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type_filter._value }}"
          bikeshare_trips.bike_type: "{{ bike_type_filter._value }}"
        limit: 500
      row: 20
      col: 0
      width: 18
      height: 8
