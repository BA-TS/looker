view: promo_orders {
   derived_table: {
     sql: SELECT distinct
row_number() over () as P_K,
date,
order_id,
pm.promo_id,
pm.title,
pm.type,
pm.grant_type,
FROM `toolstation-data-storage.promotions.promotions_applied_by_order`
, unnest (promotions_applied) as pm
where pm.type not in ("trade_account_5%", "staff_discount")
order by 1 asc;
       ;;
   }

#
#   # Define your dimensions and measures here, like this:
   dimension: P_K {
    description: "Primary Key"
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
   }

  dimension_group: date {
    type: time
    timeframes: [date,raw]
    hidden: yes
    sql: ${TABLE}.date ;;
  }

  dimension: order_id {
    description: "To be joined to transaction table"
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: promo_id {
    description: "promo ID"
    type: number
    sql: ${TABLE}.promo_id ;;
  }

  dimension: promo_name {
    description: "promo name"
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: promo_type {
    description: "promo type"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: grant_type {
    description: "grant type"
    type: string
    sql: ${TABLE}.grant_type ;;
  }

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
}
