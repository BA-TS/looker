 view: today_tracker_sales {
   derived_table: {
     sql: with sub1 as (SELECT distinct
"App" as platform,
event_name,
min(timestamp_add(timestamp_micros(event_timestamp), interval 1 HOUR)) as time,
ecommerce.transaction_id,
items.item_id,
items.item_revenue as item_revenue,
items.quantity as itemQ,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions_Today
FROM `toolstation-data-storage.analytics_265133009.events_intraday_*` left join unnest (items) as items
where _TABLE_SUFFIX = format_date("%Y%m%d", current_date())
and event_name in ("purchase", "Purchase", "session_start","add_to_cart")
group by 1,2,4,5,6,7,8
union distinct
SELECT distinct
"Web" as Platform,
event_name,
min(timestamp_add(timestamp_micros(event_timestamp), interval 1 HOUR)) as time,
ecommerce.transaction_id,
items.item_id,
items.item_revenue as item_revenue,
items.quantity as itemQ,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions_Today
FROM `toolstation-data-storage.analytics_251803804.events_intraday_*` left join unnest (items) as items
where _TABLE_SUFFIX = format_date("%Y%m%d", current_date())
and event_name in ("purchase", "Purchase", "session_start","add_to_cart")
group by 1,2,4,5,6,7,8)
select distinct row_number() over () as P_K, *
from sub1
order by 3 desc
       ;;
   }

  dimension: P_K {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: Platform {
    view_label: "Today Tracker"
    label: "Platform"
    description: "Was App or Web used to access toolstation"
    type: string
    sql: ${TABLE}.Platform ;;
  }

  dimension_group: time{
    group_label: "Datetime"
    view_label: "Today Tracker"
    description: "Min datetime of event"
    label: ""
    type: time
    timeframes: [date,time_of_day, hour]
    sql: ${TABLE}.Time ;;
  }

  dimension: event_name {
    hidden: yes
    description: "event_name"
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: transaction_id {
    hidden: yes
    description: "Transaction ID"
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: session {
    hidden: yes
    description: "Session ID"
    type: string
    sql: ${TABLE}.sessions_Today ;;
  }

  dimension: item_id {
    description: "Item ID"
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
  }

  measure: revenue {
    view_label: "Today Tracker"
    label: "Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.item_revenue ;;
  }

  dimension: itemQ {
    type: number
    hidden: yes
    sql: ${TABLE}.itemQ ;;
  }

  measure: session_start {
    description: "Total sessions with event session Start"
    view_label: "Today Tracker"
    label: "Total Sessions"
    type: count_distinct
    sql: ${session} ;;
    filters: [event_name: "session_start"]
  }

  measure: add_to_cart {
    description: "Total sessions with event add_to_cart"
    view_label: "Today Tracker"
    label: "Add to Cart sessions"
    type: count_distinct
    sql: ${session} ;;
    filters: [event_name: "add_to_cart"]
  }

  measure: purchase {
    description: "Total sessions with purchase"
    view_label: "Today Tracker"
    label: "Purchase sessions"
    type: count_distinct
    sql: ${session} ;;
    filters: [event_name: "purchase"]
  }

  measure: add_to_cart_quantity {
    description: "Add to Cart item quantity"
    view_label: "Today Tracker"
    label: "Add to Cart items"
    type: sum
    sql: ${itemQ} ;;
    filters: [event_name: "add_to_cart"]
  }

  measure: purchase_quantity {
    description: "purchase Quantity"
    view_label: "Today Tracker"
    label: "Purchase Items"
    type: sum
    sql: ${itemQ} ;;
    filters: [event_name: "purchase"]
  }
}
