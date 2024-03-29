view: ga4 {

  derived_table: {
    sql: with pages as (with sub0 as (SELECT distinct event_name,
(SELECT distinct value.string_value from UNNEST(event_params) WHERE key = 'page_location'
) as page_location,
(SELECT distinct value.string_value from UNNEST(event_params) WHERE key = 'page_title') as page_title,
countif(event_name = 'page_view') as page_views
FROM `toolstation-data-storage.analytics_251803804.events_*`
where event_name in ("page_view") and
PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
group by 1,2,3
union distinct
SELECT distinct event_name,
(SELECT distinct value.string_value from UNNEST(event_params) WHERE key = 'page_location'
) as page_location,
(SELECT distinct value.string_value from UNNEST(event_params) WHERE key = 'page_title') as page_title,
countif(event_name = 'page_view') as page_views
FROM `toolstation-data-storage.analytics_251803804.events_intraday_*`
where event_name in ("page_view") and
PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
group by 1,2,3)

select page_location,
max_by(page_title, page_views) as page_title from sub0
 where page_title not in ("Trolley", "Delivery", "Login", "My Account")
group by 1
),

sub0 as (SELECT distinct
"Web" as UserUID,
date(PARSE_DATE('%Y%m%d', event_date)) as date,
geo.country as country,
device.category as DeviceCategory,
`toolstation-data-storage.analytics_251803804.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name, (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'page_referrer')) as channel_grouping,
case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
 event_name as event_name,
 coalesce((SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'action'),
 (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'content_type'),
 (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'method')) as key,
 coalesce((SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'event_label'),
 (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'item_id'),
(SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'Destination'),
(SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key in ('shipping_tier', 'payment_type'))) as label,
cast(null as string) as key_2,
cast(null as string) as label_2,
cast(null as float64) as value,
 cast(null as string) as error_message,
ecommerce.transaction_id,
case when user_id is null then user_pseudo_id else user_id end as user_id,
CASE when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/p([0-9]*)$") then "product-detail-page"
when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'), ".*/p[0-9]*[^0-9a-zA-Z]") then "product-detail-page"
when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/c([0-9]*)$") then "product-listing-page"
else
(SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') end as Screen_name,
(SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') as page_location,
case when items.item_id is null then
COALESCE((SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key in ('event_label','item_id')),regexp_extract((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'), r'p(\d+)')) else items.item_id end as item_id,
items.price,
items.promotion_id as PromoID,
items.promotion_name as PromoName,
items.creative_name as creative_name,
items.item_revenue as item_revenue,
items.quantity as item_quantity,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
countif(event_name = 'page_view') as page_views,
case when (select value.string_value from unnest(event_params) where key = 'session_engaged') = '1' then "1" else "0" end as bounces,
min(timestamp_micros(event_timestamp)) as MinTime,
max(timestamp_micros(event_timestamp)) as MaxTime,
FROM `toolstation-data-storage.analytics_251803804.events_*` left join unnest (items) as items
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29
union distinct
SELECT distinct
"Web" as UserUID,
date(PARSE_DATE('%Y%m%d', event_date)) as date,
geo.country as country,
device.category as DeviceCategory,
`toolstation-data-storage.analytics_251803804.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name, (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'page_referrer')) as channel_grouping,
case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
 event_name as event_name,
 coalesce((SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'action'),
 (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'content_type'),
 (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'method')) as key,
 coalesce((SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'event_label'),
 (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'item_id'),
(SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'Destination'),
(SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key in ('shipping_tier', 'payment_type'))) as label,
cast(null as string) as key_2,
cast(null as string) as label_2,
cast(null as float64) as value,
 cast(null as string) as error_message,
ecommerce.transaction_id,
case when user_id is null then user_pseudo_id else user_id end as user_id,
CASE when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/p([0-9]*)$") then "product-detail-page"
when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'), ".*/p[0-9]*[^0-9a-zA-Z]") then "product-detail-page"
when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/c([0-9]*)$") then "product-listing-page"
else
(SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') end as Screen_name,
(SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') as page_location,
case when items.item_id is null then
COALESCE((SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key in ('event_label','item_id')),regexp_extract((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'), r'p(\d+)')) else items.item_id end as item_id,
items.price,
items.promotion_id as PromoID,
items.promotion_name as PromoName,
items.creative_name as creative_name,
items.item_revenue as item_revenue,
items.quantity as item_quantity,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
countif(event_name = 'page_view') as page_views,
case when (select value.string_value from unnest(event_params) where key = 'session_engaged') = '1' then "1" else "0" end as bounces,
min(timestamp_micros(event_timestamp)) as MinTime,
max(timestamp_micros(event_timestamp)) as MaxTime,
FROM `toolstation-data-storage.analytics_251803804.events_intraday_*` left join unnest (items) as items
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29
union distinct
SELECT distinct
'App' as UserUID,
date(PARSE_DATE('%Y%m%d', event_date)) as date,
geo.country as country,
device.category as DeviceCategory,
`toolstation-data-storage.analytics_251803804.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name, (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'page_referrer')) as channel_grouping,
case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
event_name,
coalesce((
SELECT distinct key FROM UNNEST(event_params) WHERE key in ('search_term', 'query', 'category_id','redirected_query','redirected_category', 'branch_name', 'action', 'content','trolley_id','previous_app_version','previous_os_version', 'list_id','page', 'id', 'method','promo_code','site_id','category'))) as key,
coalesce((SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params)WHERE key in ('search_term', 'query', 'category_id', 'redirected_query','redirected_category','branch_name', 'action', 'content','trolley_id','previous_app_version','previous_os_version', 'list_id','page','id','method','promo_code','site_id','category')),(SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params) WHERE key = 'title')) as label,
coalesce((SELECT distinct key FROM UNNEST(event_params)WHERE key in ('title','key_word'))) as key_2,
coalesce((SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params)WHERE key in ('title','key_word'))) as label_2,
coalesce((SELECT distinct coalesce(cast(value.string_value as float64), cast(value.int_value as float64), cast(value.float_value as float64), cast(value.double_value as float64)) FROM UNNEST(event_params)WHERE key in ('value', 'trolley_value','order_request_total_amount','order_total'))) as value,
(SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params) WHERE key in ('error_message','payment_gateway_error')) as error_message,
ecommerce.transaction_id,
case when user_id is null then user_pseudo_id else user_id end as user_id,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') as screen,
cast(null as string) as page_location,
case when items.item_id is null then
(SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params) WHERE key in ('product_code')) else items.item_id end as item_id,
items.price as Item_Price,
items.promotion_id as PromoID,
items.promotion_name as PromoName,
items.creative_name as creative_name,
items.item_revenue as item_revenue,
items.quantity as itemQ,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
countif(event_name = 'screen_view') as page_views,
case when (select distinct cast(value.int_value as string) from unnest(event_params) where key = 'engaged_session_event') = '1' then "1" else "0" end as bounces,
min(timestamp_micros(event_timestamp)) as MinTime,
max(timestamp_micros(event_timestamp)) as MaxTime,
FROM `toolstation-data-storage.analytics_265133009.events_*` left join unnest(items) as items
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29
union distinct
SELECT distinct
'App' as UserUID,
date(PARSE_DATE('%Y%m%d', event_date)) as date,
geo.country as country,
device.category as DeviceCategory,
`toolstation-data-storage.analytics_251803804.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name, (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'page_referrer')) as channel_grouping,
case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
event_name,
coalesce((
SELECT distinct key FROM UNNEST(event_params) WHERE key in ('search_term', 'query', 'category_id','redirected_query','redirected_category', 'branch_name', 'action', 'content','trolley_id','previous_app_version','previous_os_version', 'list_id','page', 'id', 'method','promo_code','site_id','category'))) as key,
coalesce((SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params)WHERE key in ('search_term', 'query', 'category_id', 'redirected_query','redirected_category','branch_name', 'action', 'content','trolley_id','previous_app_version','previous_os_version', 'list_id','page','id','method','promo_code','site_id','category')),(SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params) WHERE key = 'title')) as label,
coalesce((SELECT distinct key FROM UNNEST(event_params)WHERE key in ('title','key_word'))) as key_2,
coalesce((SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params)WHERE key in ('title','key_word'))) as label_2,
coalesce((SELECT distinct coalesce(cast(value.string_value as float64), cast(value.int_value as float64), cast(value.float_value as float64), cast(value.double_value as float64)) FROM UNNEST(event_params)WHERE key in ('value', 'trolley_value','order_request_total_amount','order_total'))) as value,
(SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params) WHERE key in ('error_message','payment_gateway_error')) as error_message,
ecommerce.transaction_id,
case when user_id is null then user_pseudo_id else user_id end as user_id,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') as screen,
cast(null as string) as page_location,
case when items.item_id is null then
(SELECT distinct coalesce((value.string_value), cast(value.int_value as string), cast(value.float_value as string), cast(value.double_value as string)) FROM UNNEST(event_params) WHERE key in ('product_code')) else items.item_id end as item_id,
items.price as Item_Price,
items.promotion_id as PromoID,
items.promotion_name as PromoName,
items.creative_name as creative_name,
items.item_revenue as item_revenue,
items.quantity as itemQ,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
countif(event_name = 'screen_view') as page_views,
case when (select distinct cast(value.int_value as string) from unnest(event_params) where key = 'engaged_session_event') = '1' then "1" else "0" end as bounces,
min(timestamp_micros(event_timestamp)) as MinTime,
max(timestamp_micros(event_timestamp)) as MaxTime,
FROM `toolstation-data-storage.analytics_265133009.events_intraday_*` left join unnest(items) as items
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29)
select distinct row_number() over () as P_K, sub0.* except (MaxTime,label),
case when pages.page_title is null then label else pages.page_title end as label,
timestamp_diff(max(MaxTime) over (partition by sessions),min(MinTime) over (partition by sessions), second) as session_duration,
from sub0 left join pages on sub0.label = pages.page_location;;
#datagroup_trigger: ts_googleanalytics_datagroup
  }
  #Event names for Web
  #and event_name in ("view_item", "out_of_stock", "purchase", "add_to_cart", "videoly", "session_start", "search_actions")
  #Event names for App
  # and event_name in ("search","search_suggestion_tapped","search_category_viewed", "search_recent_tapped", "search_product_tapped", "search_category_tapped",'purchase', 'add_to_cart', 'out_of_stock', "screen_view", "videoly")

  dimension: P_K {
    description: "Primary key"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: app_web_sessions {
    label: "Web/App"
    description: "Web or App sessions"
    type: string
    sql: ${TABLE}.UserUID ;;
  }

  dimension_group: date {
    description: "Date of sessions"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension_group: time{
    group_label: "Time"
    view_label: "Date"
    type: time
    timeframes: [time_of_day,hour_of_day,minute, second]
    sql: ${TABLE}.minTime ;;
  }

  dimension: Medium {
    label: "Medium"
    group_label: "Traffic Source"
    description: "Medium of acquisition"
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: Country {
    label: "Country"
    group_label: "User Attributes"
    description: "country of session"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: Campaign_name {
    label: "Campaign Name"
    group_label: "Traffic Source"
    description: "Campaign Name of acquisition"
    type: string
    sql: ${TABLE}.Campaign_name ;;
  }

  dimension: channelGrouping {
    description: "Channel Grouping of acquisition"
    label: "Channel Grouping"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.channel_grouping ;;
  }

  dimension: deviceCategory {
    label: "Device Category"
    group_label: "User Attributes"
    description: "Device Category of sessions"
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }


  dimension: event_name {
    label: "Event Name"
    group_label: "Event"
    description: "event_name"
    type: string
    sql: ${TABLE}.event_name;;
  }

  dimension: action {
    hidden: yes
    label: "Event Key"
    group_label: "Event"
    description: "Key"
    type: string
    sql: ${TABLE}.key;;
  }

  dimension: event_label {
    hidden: yes
    label: "Event Label"
    group_label: "Event"
    description: "label"
    type: string
    sql: ${TABLE}.label;;
  }

  dimension: error_message {
    label: "Error Message"
    group_label: "Event"
    description: "Error Message"
    type: string
    sql: ${TABLE}.error_message;;
  }

  dimension: event_key {
    label: "Event Key"
    group_label: "Event"
    description: "Event Key"
    type: string
    sql: case when ${event_label} is null and ${action} is not null then "action"
         when ${action} is null and ${event_label} is not null then "action"
         else ${action} end;;
  }

  dimension: event_value {
    label: "Event Label"
    group_label: "Event"
    description: "Event label"
    type: string
    sql: case when ${event_label} is null then ${action} else ${event_label} end ;;
  }

  dimension: event_key_2 {
    label: "2.Event Key"
    group_label: "Event"
    description: "2nd Event Key (if applicable)"
    type: string
    sql: ${TABLE}.key_2;;
  }

  dimension: event_label_2 {
    label: "2.Event Label"
    group_label: "Event"
    description: "2nd Event label (if applicable)"
    type: string
    sql: ${TABLE}.label_2;;
  }

  dimension: event_values {
    hidden: yes
    label: "Value"
    group_label: "Event"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.value;;
  }

  measure: event_valueSum {
    label: "Event Value"
    group_label: "Measures"
    type: sum
    description: "Monetary value of event"
    value_format_name: gbp
    sql: ${event_values} ;;
  }

  # dimension: event_attribute {
  #   label: "Event info"
  #   group_label: "Event"
  #   description: "event_attribute"
  #   hidden: yes
  #   type: string
  #   sql: ${TABLE}.event_attribute;;
  # }

  # dimension: Event_Act {
  #   label: "Event Action"
  #   group_label: "Event"
  #   description: "event_action and info"
  #   type: string
  #   sql: case when ${action} is null then ${event_attribute} else ${action} end;;
  # }

  dimension: transaction_id {
    label: "Transaction ID"
    group_label: "Ecommerce"
    description: "transaction_id"
    hidden: yes
    type: string
    sql: ${TABLE}.transaction_id;;
  }

  dimension: user_id {
    label: "User ID"
    group_label: "User Attributes"
    description: "user_id"
    type: string
    hidden: yes
    sql: ${TABLE}.user_id;;
  }

  dimension: screen {
    label: "Screen"
    group_label: "Page"
    description: "Page of site/platform"
    type: string
    sql: ${TABLE}.screen_name;;
  }

  dimension: page_location {
    hidden: yes
    type: string
    sql: ${TABLE}.page_location ;;
  }

  dimension: Promotion_ID{
    description: "Promotion ID"
    label: "Promotion ID"
    group_label: "Promotion Inormation"
    type: string
    sql: ${TABLE}.PromoID;;
  }

  dimension: Promotion_name{
    description: "Promotion Name"
    label: "Promotion Name"
    group_label: "Promotion Inormation"
    type: string
    sql: ${TABLE}.PromoName;;
  }

  dimension: Creative_Name{
    description: "Creative Name"
    label: "Creative Name"
    group_label: "Promotion Inormation"
    type: string
    sql: ${TABLE}.creative_name;;
  }

  dimension: product_Sku{
    description: "product code"
    label: "Product SKU"
    hidden: yes
    group_label: "Product Info"
    type: string
    sql: ${TABLE}.item_id;;
  }

  dimension: Item_price {
    label: "Product Price"
    group_label: "Pricing"
    view_label: "Products"
    description: "Pricing when not on promo"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.price ;;
  }

  measure: item_revenue {
    label: "Product revenue"
    group_label: "Ecommerce"
    description: "item_revenue"
    type: sum
    value_format_name: gbp
    filters: [event_name: "purchase"]
    sql: ${TABLE}.item_revenue ;;
  }

  measure: item_revenue_CG {
    label: "Product revenue by Channel Group"
    group_label: "Ecommerce"
    description: "item_revenue by channel group"
    type: sum
    value_format_name: gbp
    filters: [event_name: "purchase"]
    sql: CASE
            WHEN ${channelGrouping} = {% parameter channel_group %}
            THEN ${TABLE}.item_revenue END;;
  }

  measure: Item_Quantity {
    label: "Product Quantity"
    group_label: "Measures"
    description: "Item_Quantity"
    type: sum
    sql: ${TABLE}.item_quantity ;;
  }

  measure: Item_Quantity_CG {
    label: "Product Quantity by Channel Group"
    group_label: "Measures"
    description: "Item_Quantity by channel group"
    type: sum
    sql: CASE
         WHEN ${channelGrouping} = {% parameter channel_group %}
        THEN ${TABLE}.item_quantity END;;
  }

  dimension: bounce_def {
    description: "if session is bounce 0 = no, 1 = yes"
    type: string
    hidden: yes
    sql: ${TABLE}.bounces ;;
  }

  dimension: sessions {
    description: "number of sessions with event"
    type: string
    hidden:  yes
    sql: ${TABLE}.sessions;;
  }

  measure: Sessions {
    label: "Sessions (per event)"
    group_label: "Measures"
    type: count_distinct
    description: "Sessions where event happened at least once"
    sql: ${TABLE}.sessions;;
  }

  dimension: Events {
    label: "Events"
    group_label: "Event"
    description: "number of events"
    hidden: yes
    type: number
    sql: ${TABLE}.events;;
  }

  measure: Count_transaction_id {
    label: "Transactions"
    group_label: "Ecommerce"
    description: "distinct transaction Ids"
    type: count_distinct
    filters: [transaction_id: "-(not set)"]
    sql: ${TABLE}.transaction_id;;
  }

  measure: Count_transaction_id_by_CG {
    label: "Transactions by Channel Group"
    group_label: "Ecommerce"
    description: "distinct transaction_ids by channel group"
    type: count_distinct
    filters: [transaction_id: "-(not set)"]
    sql: CASE
         WHEN ${channelGrouping} = {% parameter channel_group %}
        THEN ${TABLE}.transaction_id END;;
  }

  measure: sumEvents {
    label: "Events"
    group_label: "Measures"
    type: sum
    description: "Events"
    sql: ${TABLE}.events;;
  }

  measure: sumEvents_byCG {
    label: "Events by Channel Grouping"
    group_label: "Measures"
    type: sum
    description: "Total events by channel group"
    sql: CASE
         WHEN ${channelGrouping} = {% parameter channel_group %} then ${TABLE}.events END;;
  }

  measure: sumPageViews {
    label: "Page Views"
    group_label: "Measures"
    type: sum
    sql: ${TABLE}.page_views;;
  }

  measure: sumViews_byCG {
    label: "Page Views by Channel Grouping"
    group_label: "Measures"
    type: sum
    sql: CASE
      WHEN ${channelGrouping} = {% parameter channel_group %} then ${TABLE}.page_views END;;
  }

  measure: bounces {
    label: "bounces"
    group_label: "Measures"
    hidden: yes
    type: count_distinct
    filters: [bounce_def: "1"]
    sql: ${TABLE}.sessions;;
  }

  measure: session_start {
    label: "Total Sessions"
    group_label: "Measures"
    hidden: yes
    type: count_distinct
    filters: [event_name: "session_start"]
    sql: ${TABLE}.sessions;;
  }

  measure: session_start_cg {
    label: "Total Sessions by Channel Group"
    group_label: "Measures"
    hidden: yes
    type: count_distinct
    filters: [event_name: "session_start"]
    sql:CASE
         WHEN ${channelGrouping} = {% parameter channel_group %} then ${TABLE}.sessions end;;
  }

  measure: session_purchase {
    label: "Purchase sessions"
    group_label: "Measures"
    description: "Sessions where a purchase event happened"
    #hidden: yes
    type: count_distinct
    filters: [event_name: "Purchase, purchase"]
    sql: ${TABLE}.sessions;;
  }

  measure: session_purchase_byCG {
    label: "Purchase sessions by Channel Group"
    group_label: "Measures"
    description: "Sessions where a purchase event happened by channel group"
    #hidden: yes
    type: count_distinct
    filters: [event_name: "Purchase, purchase"]
    sql: CASE WHEN ${channelGrouping} = {% parameter channel_group %} then ${TABLE}.sessions end;;
  }

  measure: bs {
    label: "Bounced sessions"
    group_label: "Measures"
    description: "Sessions where user left site after viewing 1 page"
    sql: ${Sessions}-${bounces} ;;
  }

  measure: bs_cg {
    label: "Bounced sessions by Channel Group"
    group_label: "Measures"
    description: "Sessions where user left site after viewing 1 page by channel group"
    sql: CASE WHEN ${channelGrouping} = {% parameter channel_group %} then ${Sessions}-${bounces} end;;
  }

  measure: bounce_rate {
    label: "Bounce rate"
    group_label: "Measures"
    type: number
    description: "rate of total sessions where user left site after viewing 1 page"
    value_format_name: percent_2
    #sql: (${bs}/${session_start}) * 100
    sql: safe_divide(${bs},${session_start});;
  }

  measure: bounce_rate_by_CG {
    label: "Bounce rate by Channel Grouping"
    group_label: "Measures"
    type: number
    description: "rate of total sessions where user left site after viewing 1 page by channel group"
    value_format_name: percent_2
    #sql: (${bs}/${session_start}) * 100
    sql: CASE WHEN ${channelGrouping} = {% parameter channel_group %} then safe_divide(${bs},${session_start}) end;;
  }


  measure: conversion_rate {
    label: "Purchase Conversion rate"
    group_label: "Ecommerce"
    type: number
    value_format_name: percent_2
    description: "rate of total sessions where a pucrhase event happened"
    #sql: ${Count_transaction_id}/${session_start} * 100
    sql: safe_divide(${session_purchase},${session_start});;
  }

  measure: conversion_rate_CG {
    label: "Purchase Conversion rate by Channel Grouping"
    group_label: "Ecommerce"
    type: number
    value_format_name: percent_2
    description: "rate of total sessions where a pucrhase event happened by channel group"
    #sql: ${Count_transaction_id}/${session_start} * 100
    sql: CASE
         WHEN ${channelGrouping} = {% parameter channel_group %}
        THEN safe_divide(${session_purchase},${session_start}) END;;
  }

  measure: Average_order_value{
    label: "AOV"
    group_label: "Ecommerce"
    type: number
    description: "Average Order Value"
    value_format_name: gbp
    sql: safe_divide(${item_revenue},${Count_transaction_id}) ;;
  }

  measure: Average_order_value_CG{
    label: "AOV by Channel Grouping"
    group_label: "Ecommerce"
    type: number
    description: "Average Order Value of Channel Group selected"
    value_format_name: gbp
    sql: CASE
         WHEN ${channelGrouping} = {% parameter channel_group %}
        THEN safe_divide(${item_revenue},${Count_transaction_id}) END;;
  }

  measure: total_users {
    label: "Total Users"
    group_label: "Measures"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: New_users {
    label: "New Users"
    group_label: "Measures"
    description: "users who visted the platform for the first time or accepted cookies"
    type: count_distinct
    filters: [event_name: "first_visit,first_open"]
    sql: ${user_id} ;;
  }

  measure: returning_users {
    label: "Returning Users"
    group_label: "Measures"
    type: number
    description: "users who visted the platform prior"
    sql: ${total_users}-${New_users} ;;
  }

  measure: Active_Users {
    label: "Active Users"
    group_label: "Measures"
    type: count_distinct
    description: "Users who had an active session"
    filters: [bounce_def: "1"]
    sql: ${user_id};;
  }

  measure:  time_hours {
    type: average
    hidden: yes
    label: "Avg Session Duration"
    group_label: "Measures"
    value_format: "h:mm:ss"
    sql: ${TABLE}.session_duration / 86400.0;;
  }

  measure:  time_sec {
    type: average
    hidden: yes
    label: "Avg Session Duration ss"
    group_label: "Measures"
    sql: ${TABLE}.session_duration;;
  }

  filter: select_date_range {
    label: "GA4 Date Range"
    group_label: "Date Filter"
    view_label: "Date"
    type: date
    datatype: date
    convert_tz: yes
  }

  parameter: channel_group {
    label: "Channel Grouping"
    description: "Channel grouping filter for measures"
    type: string
    allowed_value: {
      label: "Direct"
      value: "Direct"
    }

    allowed_value: {
      label: "Paid Search"
      value: "Paid Search"
    }

    allowed_value: {
      label: "Organic Search"
      value: "Organic Search"
    }

    allowed_value: {
      label: "Affiliates"
      value: "Affiliates"
    }

    allowed_value: {
      label: "Organic Social"
      value: "Organic Social"
    }

    allowed_value: {
      label: "Paid Shopping"
      value: "Paid Shopping"
    }

    allowed_value: {
      label: "Paid Social"
      value: "Paid Social"
    }

    allowed_value: {
      label: "Email"
      value: "Email"
    }

    allowed_value: {
      label: "Referral"
      value: "Referral"
    }

    allowed_value: {
      label: "Other"
      value: "(other)"
    }

    allowed_value: {
      label: "Paid Other"
      value: "Paid Other"
    }

    allowed_value: {
      label: "Organic Shopping"
      value: "Organic Shopping"
    }

  }

}
