view: promo_orders {
  #using ecrebo data
   derived_table: {
     sql: SELECT distinct row_number() over () as P_K,
      date(ts.placedDate) as date,
      ts.parentOrderUID as OrdersFromTrolleySales,
      et.transaction_uuid as transactionID_ecrebo,
      ec.issuance_redemption as CouponType,
      ec.campaign_id as CampaignID,
      ec.campaign_name as EcreboCoupon_name,
      from`toolstation-data-storage.sales.TrolleySales` ts
      inner join `toolstation-data-storage.sales.ecreboTransactions` as et on ts.trolleyUID=et.transaction_uuid
      inner join `toolstation-data-storage.sales.ecreboCoupons` as ec on et.transaction_uuid = ec.transaction_uuid
       ;;
   }

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
    hidden: yes
    type: string
    sql: ${TABLE}.OrdersFromTrolleySales ;;
  }

  dimension: promo_id {
    description: "promo ID"
    type: number
    hidden: yes
    sql: ${TABLE}.CampaignID ;;
  }

  dimension: promo_name {
    description: "promo name"
    label: "Promo Name"
    group_label: "Order Details"
    view_label: "Transactions"
    type: string
    sql: ${TABLE}.EcreboCoupon_name ;;
  }

  dimension: promo_type {
    description: "promo type"
    label: "Promo Type"
    group_label: "Order Details"
    view_label: "Transactions"
    type: string
    sql: ${TABLE}.CouponType ;;
  }

  #dimension: grant_type {
    #description: "grant type"
    #label: "Grant Type"
    #type: string
    #sql: ${TABLE}.grant_type ;;
  #}

  measure: Orders_using_promo {
    description: "Orders using Promo"
    label: "Transactions (using Promo)"
    hidden: yes
    type: count_distinct
    sql: ${order_id} ;;
  }

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
