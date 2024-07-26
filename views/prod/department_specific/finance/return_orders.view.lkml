view: return_orders {

  derived_table: {
    sql:
    select *
    from  `toolstation-data-storage.ts_finance.DS_DAILY_RETURNS_ORDERS_2023`;;
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
    tiers: [0,31,46,181,366]
    sql:  ${return_days};;
  }

}
