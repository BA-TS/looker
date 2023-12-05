view: basket_buy_to_detail_trends {

  derived_table: {
    sql: SELECT distinct
          row_number() over () as P_K,
          platform,
          date(timestamp_sub(MinTime, interval 1 HOUR)) as date,
          CASE WHEN (Screen_name LIKE '%| Search |%') THEN 'search-page' ELSE Screen_name END AS screen_name,
          aw.item_id,
          event_name,
          #############Sessions#####################
          count(distinct session_id) as sessions,
          #############Events#####################
          sum(events) as events
          FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
          where _TABLE_SUFFIX >= FORMAT_DATE('%Y%m%d', '2023-11-02')
          and event_name in ("screen_view", "page_view","view_item","add_to_cart","purchase","session_start") and
          ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.
          item_id is null))
      group by 2,3,4,5,6
             ;;
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
    group_label: "Basket to Detail"
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
    hidden: yes
    description: "events"
    type: sum
    sql: ${TABLE}.events ;;
  }

  dimension: sessions {
    hidden: yes
    description: "sessions"
    type: number
    sql: ${TABLE}.sessions ;;
  }

  measure: total_Sessions {
    description: "Sessions with Session Start"
    type: sum
    sql: ${sessions} ;;
    filters: [event_name: "session_start"]
  }

  measure: add_to_cart_sessions {
    description: "Add to Cart Sessions"
    type: sum
    sql: ${sessions} ;;
    filters: [event_name: "add_to_cart"]
  }



}
