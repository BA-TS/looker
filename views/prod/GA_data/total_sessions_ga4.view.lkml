view: total_sessions_ga4 {
  derived_table: {
    explore_source: GA4 {
      column: date {field: ga4.date_date}
      column: total_session {field:ga4.Sessions}
      column: event {field:ga4.event_name}
      derived_column: rn {
        sql: row_number() over () ;;
      }
    }
  }

  dimension: P_K {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.rn ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: event {
    hidden:yes
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: total_sessions {
    view_label: "Total Sessions"
    hidden: yes
    type: number
    sql: ${TABLE}.total_session ;;
  }

  measure: Sessions {
    view_label: "Total Sessions"
    type: sum
    filters: [event: "session_start"]
    sql: ${total_sessions} ;;
  }

}

# view: total_sessions_ga4 {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
