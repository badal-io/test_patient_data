- dashboard: bikeshare_overview
  title: Bikeshare Overview
  layout: newspaper
  elements:

  - name: total_trips
    title: Total Trips
    query: bikeshare_info
    type: single_value
    measures: [bikeshare_trips.count]
    listen:
      start_station_name: bikeshare_stations_start.name
      end_station_name: bikeshare_stations_end.name
      subscriber_type: bikeshare_trips.subscriber_type
      bike_type: bikeshare_trips.bike_type
    row: 0
    col: 0
    width: 6
    height: 3

  - name: average_duration
    title: Average Trip Duration (minutes)
    query: bikeshare_info
    type: single_value
    measures: [bikeshare_trips.duration_minutes]
    listen:
      start_station_name: bikeshare_stations_start.name
      end_station_name: bikeshare_stations_end.name
      subscriber_type: bikeshare_trips.subscriber_type
      bike_type: bikeshare_trips.bike_type
    row: 0
    col: 6
    width: 6
    height: 3

  - name: total_stations
    title: Total Stations
    query: bikeshare_info
    type: single_value
    fields: [bikeshare_stations_start.station_id]
    measures: [bikeshare_stations_start.count]
    listen:
      start_station_name: bikeshare_stations_start.name
      end_station_name: bikeshare_stations_end.name
      subscriber_type: bikeshare_trips.subscriber_type
      bike_type: bikeshare_trips.bike_type
    row: 0
    col: 12
    width: 6
    height: 3

  - name: trips_by_subscriber
    title: Trips by Subscriber Type
    query: bikeshare_info
    type: single_value
    dimensions: [bikeshare_trips.subscriber_type]
    measures: [bikeshare_trips.count]
    listen:
      start_station_name: bikeshare_stations_start.name
      end_station_name: bikeshare_stations_end.name
      subscriber_type: bikeshare_trips.subscriber_type
      bike_type: bikeshare_trips.bike_type
    row: 0
    col: 18
    width: 6
    height: 3

  - name: station_locations
    title: Bikeshare Station Locations
    query: bikeshare_info
    type: looker_map
    fields: [bikeshare_stations_start.location, bikeshare_stations_start.name, bikeshare_stations_start.count]
    dimensions: [bikeshare_stations_start.location, bikeshare_stations_start.name]
    measures: [bikeshare_stations_start.count]
    listen:
      start_station_name: bikeshare_stations_start.name
      end_station_name: bikeshare_stations_end.name
      subscriber_type: bikeshare_trips.subscriber_type
      bike_type: bikeshare_trips.bike_type
    row: 3
    col: 0
    width: 24
    height: 6

  filters:
  - name: start_station_name
    title: Start Station Name
    type: field_filter
    explore: bikeshare_info
    field: bikeshare_stations_start.name

  - name: end_station_name
    title: End Station Name
    type: field_filter
    explore: bikeshare_info
    field: bikeshare_stations_end.name

  - name: subscriber_type
    title: Subscriber Type
    type: field_filter
    explore: bikeshare_info
    field: bikeshare_trips.subscriber_type

  - name: bike_type
    title: Bike Type
    type: field_filter
    explore: bikeshare_info
    field: bikeshare_trips.bike_type
