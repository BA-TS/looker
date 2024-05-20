view: summarised_daily_Sales {
  derived_table: {
    sql: with sub1 as (SELECT distinct
    timestamp(dated) as date,
    fiscalYearWeek,
    case when App_Web = 'Web Trolley' then 'Web'
    when App_Web = 'App Trolley' then 'App'
    else null end as App_web,
    max(Weeklytotal_customers) as Weeklytotal_customers,
    max(total_customers) as total_customers,
    max(WeeklyOrders) as Weekly_Orders,
    max(ordersDaily) as ordersDaily,
    max(revenueDaily) as revenueDaily,
    max(TotalNetSaleDaily) as TotalNetSaleDaily,
    max(MarginDaily) as MarginDaily
    from `toolstation-data-storage.sales.SummarisedSales_byApp_orWeb`
    group by 1,2,3
    order by 2 desc)

    select distinct row_number() over () as P_K ,*
    from sub1
    order by 2 desc;;
  }

dimension: Primary_key {
  description: "unique ID for row"
  primary_key: yes
  hidden: yes
  type: number
  sql: ${TABLE}.P_K ;;
}

  dimension_group: date  {
    description: "transaction_date"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: fiscalYearWeek {
    description: "fiscalYearWeek"
    type: string
    sql: ${TABLE}.fiscalYearWeek ;;
  }

  dimension: App_Web {
    description: "trolley method"
    type: string
    sql: ${TABLE}.App_Web ;;
  }

  dimension: Weeklytotal_customers {
    description: "Weekly Customer"
    type: number
    sql: ${TABLE}.Weeklytotal_customers ;;
  }

  dimension: Weekly_Orders {
    description: "Weekly_Orders"
    type: number
    sql: ${TABLE}.Weekly_Orders ;;
  }

  dimension: Dailytotal_customers {
    description: "Daily customers"
    type: number
    sql: ${TABLE}.total_customers ;;
  }

  dimension: ordersDaily {
    description: "Daily orders"
    type: number
    sql: ${TABLE}.ordersDaily ;;
  }

  dimension: revenueDaily {
    description: "Daily revenue"
    type: number
    sql: ${TABLE}.revenueDaily ;;
  }

  dimension: TotalNetSaleDaily {
    description: "Daily Net sales"
    type: number
    sql: ${TABLE}.TotalNetSaleDaily ;;
  }

  dimension: MarginDaily {
    description: "Daily Margin"
    type: number
    sql: ${TABLE}.MarginDaily ;;
  }

 # dimension: transaction_date_filter {
    #type: date
    #datatype: date
    #sql:

    #{% if base.select_date_reference._parameter_value == "Placed" %} DATE(${transactions.placed_date}) {% else %} DATE(${transactions.transaction_date}) {% endif %}

          #;;
  #}
}


#revenueDaily,
#TotalNetSaleDaily,
#MarginDaily

# view: summarised_app_web {
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
