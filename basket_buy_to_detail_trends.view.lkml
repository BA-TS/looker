view: basket_buy_to_detail_trends {

  derived_table: {
    sql: SELECT distinct
          row_number() over () as P_K,
          platform,
          date(timestamp_sub(MinTime, interval 1 HOUR)) as date,
          screen_name,
          aw.item_id,
          #############Sessions#####################
          count(distinct case when event_name in ("screen_view", "page_view") then session_id else null end) as page_view_sessions,
          count(distinct case when event_name in ("view_item") and screen_name in ("product-detail-page") then session_id else null end) as PDP_sessions,
          count(distinct case when event_name in ("add_to_cart") then session_id else null end) as ATC_sessions,
          count(distinct case when event_name in ("purchase") then session_id else null end) as purchase_sessions,
          ############Events#######################
          sum(case when event_name in ("screen_view", "page_view") then events else null end) as page_views,
          sum(case when event_name in ("view_item") and screen_name in ("product-detail-page") then events else null end) as PDP_events,
          sum(case when event_name in ("add_to_cart") then events else null end) as ATC_events,
          sum(case when event_name in ("purchase") then events else null end) as purchase_events
          FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
          where _TABLE_SUFFIX >= FORMAT_DATE('%Y%m%d', '2023-11-02') and
           ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.item_id is null))
      group by 2,3,4,5
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

  dimension: item_id {
    type: string
    hidden: yes
    sql: ${TABLE}.item_id ;;
  }

  measure: page_view_sessions {
    hidden: yes
    description: "total page view sessions"
    type: sum
    sql: ${TABLE}.page_view_sessions ;;
  }

  measure: total_page_views {
    hidden: yes
    description: "total page views"
    type: sum
    sql: ${TABLE}.page_views ;;
  }

  measure: pdp_sessions {
    hidden: yes
    description: "total PDP sessions"
    type: sum
    sql: ${TABLE}.PDP_sessions ;;
  }

  measure: PDP_events {
    hidden: yes
    description: "total pdp events"
    type: sum
    sql: ${TABLE}.PDP_events ;;
  }

  measure: atc_sessions {
    description: "total ATC sessions"
    type: sum
    sql: ${TABLE}.ATC_sessions ;;
  }

  measure: atc_events {
    description: "total atc events"
    type: sum
    sql: ${TABLE}.ATC_events ;;
  }

  measure: purchase_sessions {
    description: "total purchase sessions"
    type: sum
    sql: ${TABLE}.purchase_sessions ;;
  }

  measure: purchase_events {
    description: "total purchase events"
    type: sum
    sql: ${TABLE}.purchase_events ;;
  }
}
