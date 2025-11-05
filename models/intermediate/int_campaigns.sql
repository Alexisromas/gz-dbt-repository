select
    date_date,
    sum(cast(ads_cost as float64)) as total_ads_cost,
    sum(impression) as total_impressions,
    sum(click) as total_clicks,
    count(distinct campaign_key) as nb_campaigns

from (
    select * from {{ ref('stg_raw__adwords') }}
    union all
    select * from {{ ref('stg_raw__bing') }}
    union all
    select * from {{ ref('stg_raw__criteo') }}
    union all
    select * from {{ ref('stg_raw__facebook') }}
) campaigns

group by date_date
order by date_date desc


     
