{{ config(materialized='table') }}

with fhv_table as (
    select *, 
        'fhv' as service_type 
    from {{ ref('stg_fhv_tripdata') }}
), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    fhv_table.dispatching_base_num,
    fhv_table.pickup_datetime,
    fhv_table.dropoff_datetime,
    fhv_table.pulocationid,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    fhv_table.dolocationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    -- trips_unioned.pickup_datetime, 
    -- trips_unioned.dropoff_datetime, 
    fhv_table.SR_flag,
    fhv_table.Affiliated_base_number
    -- trips_unioned.store_and_fwd_flag, 
    -- trips_unioned.passenger_count, 
    -- trips_unioned.trip_distance, 
    -- trips_unioned.trip_type, 
    -- trips_unioned.fare_amount, 
    -- trips_unioned.extra, 
    -- trips_unioned.mta_tax, 
    -- trips_unioned.tip_amount, 
    -- trips_unioned.tolls_amount, 
    -- trips_unioned.ehail_fee, 
    -- trips_unioned.improvement_surcharge, 
    -- trips_unioned.total_amount, 
    -- trips_unioned.payment_type, 
    -- trips_unioned.payment_type_description, 
    -- trips_unioned.congestion_surcharge
from fhv_table
inner join dim_zones as pickup_zone
on fhv_table.pulocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_table.dolocationid = dropoff_zone.locationid