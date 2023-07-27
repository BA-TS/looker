view: pdp_purchase_funnel {
  derived_table: {
    sql: with sub0 as (with test as (SELECT distinct
"Web" as UserUID,
PARSE_DATE('%Y%m%d', event_date) as date,
min(TIMESTAMP_MICROS(event_timestamp)) as timestamp,
event_name,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
case when items.item_id is null then
(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'event_label') else items.item_id end as item_id,
ecommerce.transaction_id,
items.item_revenue as item_revenue
FROM `toolstation-data-storage.analytics_251803804.events_*`, unnest (items) as items
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and event_name in ("view_item", "Purchase", "purchase", "session_start")
and concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) is not null
group by 1,2,4,5,6,7,8),

PDP as (SELECT distinct * from test where event_name in ("view_item")),
purchase as (SELECT distinct * from test where event_name in ("purchase"))

SELECT distinct PDP.date as PDP_date,
purchase.date as Purchase_date,
PDP.timestamp as PDP_Timestamp,
purchase.timestamp as purchase_timestamp,
--PDP.event_name, purchase.event_name,
PDP.session_id as PDP_sessionID,
purchase.session_id as Purchase_sessionID,
PDP.item_id as ItemID,
purchase.item_revenue,
purchase.transaction_id
--, purchase.item_id as purchase_itemID
from PDP left join purchase on cast(PDP.session_id as string) = cast(purchase.session_id as string)
and cast(PDP.item_id as string) = cast(purchase.item_id as string)
WHERE (PDP.timestamp < purchase.timestamp) or purchase.timestamp is null)

SELECT distinct row_number() over () as row_num, * from sub0
       ;;
    datagroup_trigger: ts_googleanalytics_datagroup
   }

   dimension: P_K {
     description: "PK"
     type: number
     primary_key: yes
     hidden: yes
     sql: ${TABLE}.row_num ;;
   }


  dimension_group: PDP_date {
    description: "Date of PDP"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.PDP_date ;;
  }

  dimension: PDP_SessionID {
    description: "Session ID of PDP View"
    hidden: yes
    type: string
    sql: ${TABLE}.PDP_sessionID ;;
  }

  dimension: Purchase_SessionID {
    description: "Session ID of Purchase event"
    hidden: yes
    type: string
    sql: ${TABLE}.Purchase_sessionID ;;
  }

  dimension: ItemID {
    description: "Item"
    hidden: yes
    type: string
    sql: ${TABLE}.ItemID ;;
  }

  dimension: item_revenue {
    description: "Revenue"
    hidden: yes
    type: number
    value_format_name: gbp
    sql: ${TABLE}.item_revenue ;;
  }

  measure: Transactions {
    description: "Transactions"
    label: "Transactions"
    type: count_distinct
    sql: ${TABLE}.transaction_id ;;
  }

  measure: PDP_sessions {
    description: "Distinct sessions with PDP View"
    label: "PDP view sessions"
    type: count_distinct
    sql: ${PDP_SessionID} ;;
  }

  measure: PDP_Purchase_sessions {
    description: "Distinct sessions with PDP View then Purchase"
    label: "PDP then Purchase sessions"
    type: count_distinct
    sql: ${Purchase_SessionID} ;;
  }

  measure: Revenue {
    description: "sum of revenue"
    label: "Revenue"
    type: sum
    value_format_name: gbp
    sql: ${item_revenue} ;;
  }

  measure: PDP_Purchase_CR {
    description: "PDP then Purchase CR"
    label: "PDP then Purchase CR"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${PDP_Purchase_sessions},${PDP_sessions}) ;;
  }

  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: pdp_purchase_funnel {
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
