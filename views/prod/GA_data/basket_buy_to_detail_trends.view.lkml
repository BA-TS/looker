view: basket_buy_to_detail_trends {

  derived_table: {
    sql: SELECT distinct
      row_number() over () as P_K,
      event_name,
      platform,
      date(timestamp_sub(MinTime, interval 1 HOUR)) as date,
      aw.item_id,
      case when screen_name like "%| Search |%" then "search-page" else Screen_name end as Screen_name,
      session_id,
      bounces,
      events
      FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
      where _TABLE_SUFFIX >= FORMAT_DATE('%Y%m%d', '2023-11-02')
      and bounces <= 1
      and event_name in ("screen_view", "page_view","view_item","add_to_cart","purchase","session_start","view_item_list")
      and
      ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.
      item_id is null))
      group by 2,3,4,5,6,7,8,9
                   ;;
    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 13 ;;
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
    group_label: "Page"
    label: "Screen name"
    type: string
    sql: ${TABLE}.Screen_name ;;
  }

  dimension: Platform {
    view_label: "Trends"
    label: "Web/App"
    type: string
    sql: ${TABLE}.platform ;;
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

  measure: purchase_events {
    description: "Purchase events"
    group_label: "Purchase"
    label: "Purchase Events"
    type: sum
    sql: ${TABLE}.events ;;
    filters: [event_name: "purchase"]
  }

  measure: atc_events {
    description: "Add to cart events"
    group_label: "Add to Cart"
    label: "ATC Events"
    type: sum
    sql: ${TABLE}.events ;;
    filters: [event_name: "add_to_cart"]
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
    group_label: "Page"
    label: "Page Views"
    sql:
    case when ${event_name} in ("screen_view","page_view") or (${event_name} in ("view_item_list") and ${Screen_name} in ("search-page")) then
    ${TABLE}.events else null end;;
    #filters: [event_name: "screen_view OR page_view"]
  }

  measure: unique_screen_views {
    description: "Page views"
    type: count_distinct
    group_label: "Page"
    label: "Unique Page Views"
    sql:
    case when ${event_name} in ("screen_view","page_view") or (${event_name} in ("view_item_list") and ${Screen_name} in ("search-page")) then
    ${TABLE}.session_id else null end;;
    #filters: [event_name: "screen_view OR page_view"]
    }

  measure: add_to_cart_sessions {
    description: "Add to Cart Sessions"
    group_label: "Add to Cart"
    label: "ATC Sessions"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
    filters: [event_name: "add_to_cart"]
  }

  measure: add_to_cart_rate {
    description: "Add to Cart Rate"
    group_label: "Add to Cart"
    label: "ATC C.R (From Total sessions)"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${add_to_cart_sessions},${total_Sessions}) ;;
  }

  measure: add_to_cart_rate_views {
    description: "Add to Cart Rate from page views"
    group_label: "Add to Cart"
    label: "ATC C.R (From Page Views)"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${atc_events},${screen_views}) ;;
  }

  measure: purchase_sessions {
    description: "Purchase Sessions"
    group_label: "Purchase"
    label: "Purchase Sessions"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
    filters: [event_name: "purchase"]
  }

  measure: purchase_rate {
    description: "Purchase Rate"
    group_label: "Purchase"
    label: "Purchase C.R"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions},${total_Sessions}) ;;
  }

}
