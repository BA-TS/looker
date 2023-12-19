view: basket_buy_to_detail_trends {

  derived_table: {
    sql: SELECT distinct
row_number() over () as P_K,
event_name,
date(timestamp_sub(MinTime, interval 1 HOUR)) as date,
aw.item_id,
case when screen_name like "%| Search |%" then "search-page" else Screen_name end as Screen_name,
session_id,
bounces,
events
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
where _TABLE_SUFFIX >= FORMAT_DATE('%Y%m%d', '2023-12-02')
and bounces <= 1
and event_name in ("screen_view", "page_view","view_item","add_to_cart","purchase","session_start")
and
((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.
item_id is null))
group by 2,3,4,5,6,7,8
             ;;
    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 10 ;;
    partition_keys: ["date"]
  }

#
#   # Define your dimensions and measures here, like this:
  dimension: P_K {
    description: "Primary key"
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.P_K ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: Screen_name {
    view_label: "Trends"
    label: "Screen name"
    type: string
    sql: ${TABLE}.Screen_name ;;
  }

  dimension: event_name {
    hidden: yes
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: item_id {
    type: string
    hidden: yes
    sql: ${TABLE}.item_id ;;
  }

  measure: events {
    description: "events"
    type: sum
    sql: ${TABLE}.events ;;
  }


  measure: total_Sessions {
    description: "Sessions with Session Start"
    type: count_distinct
    hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  measure: screen_views {
    description: "Page views"
    type: sum
    label: "Views"
    sql: ${TABLE}.events ;;
    filters: [event_name: "screen_view, page_view"]
  }

  measure: add_to_cart_sessions {
    description: "Add to Cart Sessions"
    label: "Add to Cart Sessions"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
    filters: [event_name: "add_to_cart"]
  }

  measure: add_to_cart_rate {
    description: "Add to Cart Rate"
    label: "Add to Cart Rate (From Total sessions)"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${add_to_cart_sessions},${total_Sessions}) ;;
  }

  measure: add_to_cart_rate_views {
    description: "Add to Cart Rate"
    label: "Add to Cart Rate (From Page Views)"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${add_to_cart_sessions},${screen_views}) ;;
  }

  measure: purchase_sessions {
    description: "Purchase Sessions"
    label: "Purchase Sessions"
    type: sum
    sql: ${TABLE}.session_id ;;
    filters: [event_name: "purchase"]
  }

  measure: purchase_rate {
    description: "Purchase Rate"
    label: "Purchase Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions},${total_Sessions}) ;;
  }
}
