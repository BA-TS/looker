view: product_quantity {
  derived_table: {
    sql:
    parentOrderUID,
    sum(quantity) as quantity,
    row_number() OVER(ORDER BY parentOrderUID) AS prim_key
    from toolstation-data-storage.sales.transactions
    where productCode NOT IN ('85699', '00053','44842') and productCode not like "0%"
    group by 1;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension: quantity {
    type: number
    label: "Quantity Test"
    sql: ${TABLE}.quantity ;;
  }

  dimension_group: transaction {
    label: "Transaction"
    type: time
    timeframes: [
      raw,
      time,
      date,
      month_num,
      day_of_week_index
    ]
    sql: ${TABLE}.transactionDate ;;
    hidden: yes
  }

  dimension: parent_order_uid {
    group_label: "Order Details"
    label: "Parent Order UID2"
    description: "Main order ID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }





}
