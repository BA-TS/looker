view: return_orders {

  derived_table: {
    sql:
    select
    distinct row_number() over () as prim_key,
    *
    from  `toolstation-data-storage.ts_finance.DS_DAILY_RETURNS_ORDERS_2023`;;
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    hidden: yes
    primary_key: yes
  }

  dimension: return_ID {
    group_label: "Return Order"
    label: "Parent Order UID"
    type: string
    sql: ${TABLE}.return_ID ;;
    hidden: yes
  }

  dimension: is_return {
    label: "Order - Is Return"
    type: yesno
    sql: ${return_ID} is not null;;
  }

  dimension: is_return_product {
    label: "Product - Is Return"
    type: yesno
    sql: ${products.product_code} is not null;;
  }

  measure: number_of_return_orders {
    label: "Number of Returns (Transactions)"
    type: count_distinct
    sql: ${return_ID};;
  }

  measure: return_rate {
    type: number
    label: "Return Rate %"
    description: "Number of returned transactions / Number of transactions"
    sql: safe_divide(${number_of_return_orders},${transactions.number_of_transactions});;
    value_format_name: percent_1
  }

  measure: number_of_return_products {
    label: "Number of Returns (Products)"
    type: count_distinct
    sql: case when ${return_ID} is not null then ${products.product_code} else null end ;;
  }

  dimension: transaction_uid{
    group_label: "Link Order"
    label: "Parent Order UID"
    type: string
    sql: ${TABLE}.link_OrderID ;;
  }

  dimension: sales_channel{
    group_label: "Link Order"
    label: "Sales Channel"
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  dimension_group: link_order {
    group_label: "Link Order"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.link_OrderDate ;;
  }

  dimension: return_days {
    group_label: "Return Days"
    label: "Number of Days"
    type: number
    sql: date_diff(${transactions.order_completed_date},${link_order_date},day);;
  }

  dimension: return_days_tier {
    group_label: "Return Days"
    label: "Number of Days - Tier"
    type: tier
    style: integer
    tiers: [0,31,46,91,181,366]
    sql:  ${return_days};;
  }

}
