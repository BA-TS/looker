view: basket_buy_to_detail_trends {

  derived_table: {
    sql: SELECT distinct
      row_number() over () as P_K,
      event_name,
      platform,
      date(timestamp_sub(MinTime, interval 1 HOUR)) as date,
      screen_name,
      aw.item_id,
      cast(bounces as string) as bounces,
      session_id as session_id,
      sum(transactions.net_value) as revenue
      FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
      where _TABLE_SUFFIX >= FORMAT_DATE('%Y%m%d', '2023-11-02')
      and
      ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.
      item_id is null))
      group by 2,3,4,5,6,7,8
                   ;;
    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 9 ;;
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

  dimension: screen_name {
    hidden: yes
    type: string
    sql: ${TABLE}.screen_name ;;
  }

  dimension: item_id {
    type: string
    hidden: yes
    sql: ${TABLE}.item_id ;;
  }

  dimension: bounce_def {
    description: "if session is bounce 0 = no, 1 = yes"
    type: string
    hidden: yes
    sql: ${TABLE}.bounces ;;
  }

  dimension: revenue {
    description: "revenue"
    type: number
    value_format_name: gbp
    hidden: yes
    sql: ${TABLE}.revenue ;;
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


  measure: PDP_sessions {
    description: "Sessions with PDP event"
    type: count_distinct
    group_label: "Page"
    label: "PDP sessions"
    sql:${TABLE}.session_id;;
    filters: [event_name: "view_item", screen_name: "product-detail-page",bounce_def: "1"]
    }

  measure: PDP_events {
    description: "Page views"
    type: sum
    group_label: "Page"
    label: "PDP events"
    sql:${TABLE}.events;;
    filters: [event_name: "view_item", screen_name: "product-detail-page",bounce_def: "1"]
    }

  measure: add_to_cart_sessions {
    description: "Add to Cart Sessions"
    group_label: "Add to Cart"
    label: "ATC Sessions"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
    filters: [event_name: "add_to_cart",bounce_def: "1"]
  }

  measure: add_to_cart_rate {
    description: "Add to Cart Rate"
    group_label: "Add to Cart"
    label: "ATC C.R (From Total sessions)"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${add_to_cart_sessions},${total_Sessions}) ;;
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

  measure: revenu {
    description: "Revenue"
    group_label: "Purchase"
    label: "Net Revenue"
    type: number
    value_format_name: gbp
    sql: ${revenue} ;;
  }

  filter: filter_on_field_to_hide {
    label: "Date"
    type: date
    sql: {% condition filter_on_field_to_hide %} timestamp(${date_date}) {% endcondition %} ;;
  }

}
