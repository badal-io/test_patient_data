- dashboard: bikeshare_dashboard
  title: Bikeshare Information
  layout: newspaper

  filters:
    - name: start_station_name
      title: Start Station Name
      type: field_filter
      explore: bikeshare_trips
      field: bikeshare_stations_start.name

    - name: end_station_name
      title: End Station Name
      type: field_filter
      explore: bikeshare_trips
      field: bikeshare_stations_end.name

    - name: subscriber_type
      title: Subscriber Type
      type: field_filter
      explore: bikeshare_trips
      field: bikeshare_trips.subscriber_type

    - name: bike_type
      title: Bike Type
      type: field_filter
      explore: bikeshare_trips
      field: bikeshare_trips.bike_type

  elements:
    - name: total_trips
      title: Total Trips
      type: single_value
      query:
        dimensions: []
        measures:
          - bikeshare_trips.count
        filters:
          bikeshare_stations_start.name: "{{ start_station_name._value }}"
          bikeshare_stations_end.name: "{{ end_station_name._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type._value }}"
          bikeshare_trips.bike_type: "{{ bike_type._value }}"
        limit: 500
      listen:
        start_station_name: start_station_name
        end_station_name: end_station_name
        subscriber_type: subscriber_type
        bike_type: bike_type

    - name: average_trip_duration
      title: Average Trip Duration (minutes)
      type: single_value
      query:
        dimensions: []
        measures:
          - bikeshare_trips.duration_minutes
        filters:
          bikeshare_stations_start.name: "{{ start_station_name._value }}"
          bikeshare_stations_end.name: "{{ end_station_name._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type._value }}"
          bikeshare_trips.bike_type: "{{ bike_type._value }}"
        limit: 500
      listen:
        start_station_name: start_station_name
        end_station_name: end_station_name
        subscriber_type: subscriber_type
        bike_type: bike_type

    - name: total_stations
      title: Total Stations
      type: single_value
      query:
        dimensions: []
        measures:
          - bikeshare_stations_start.count
        filters:
          bikeshare_stations_start.name: "{{ start_station_name._value }}"
          bikeshare_stations_end.name: "{{ end_station_name._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type._value }}"
          bikeshare_trips.bike_type: "{{ bike_type._value }}"
        limit: 500
      listen:
        start_station_name: start_station_name
        end_station_name: end_station_name
        subscriber_type: subscriber_type
        bike_type: bike_type

    - name: trips_by_subscriber_type
      title: Trips by Subscriber Type
      type: looker_bar
      query:
        dimensions:
          - bikeshare_trips.subscriber_type
        measures:
          - bikeshare_trips.count
        filters:
          bikeshare_stations_start.name: "{{ start_station_name._value }}"
          bikeshare_stations_end.name: "{{ end_station_name._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type._value }}"
          bikeshare_trips.bike_type: "{{ bike_type._value }}"
        sorts:
          - bikeshare_trips.count desc
        limit: 500
      listen:
        start_station_name: start_station_name
        end_station_name: end_station_name
        subscriber_type: subscriber_type
        bike_type: bike_type

    - name: trips_detail_table
      title: Trips Detail
      type: looker_table
      query:
        dimensions:
          - bikeshare_trips.bike_id
          - bikeshare_trips.bike_type
          - bikeshare_stations_start.name
          - bikeshare_stations_end.name
          - bikeshare_trips.start_date
        measures:
          - bikeshare_trips.count
          - bikeshare_trips.duration_minutes
        filters:
          bikeshare_stations_start.name: "{{ start_station_name._value }}"
          bikeshare_stations_end.name: "{{ end_station_name._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type._value }}"
          bikeshare_trips.bike_type: "{{ bike_type._value }}"
        sorts:
          - bikeshare_trips.count desc
        limit: 500
      listen:
        start_station_name: start_station_name
        end_station_name: end_station_name
        subscriber_type: subscriber_type
        bike_type: bike_type

    - name: bikeshare_stations_map
      title: Bike Stations Map
      type: looker_map
      query:
        dimensions:
          - bikeshare_stations_start.location
          - bikeshare_stations_start.name
        measures:
          - bikeshare_stations_start.count
          - bikeshare_stations_start.number_of_docks
        filters:
          bikeshare_stations_start.name: "{{ start_station_name._value }}"
          bikeshare_stations_end.name: "{{ end_station_name._value }}"
          bikeshare_trips.subscriber_type: "{{ subscriber_type._value }}"
          bikeshare_trips.bike_type: "{{ bike_type._value }}"
        limit: 500
      listen:
        start_station_name: start_station_name
        end_station_name: end_station_name
        subscriber_type: subscriber_type
        bike_type: bike_type
