view: transactions_incomplete {

  sql_table_name:`toolstation-data-storage.sales.transactions_incomplete`;;

  dimension: parent_order_uid {
    group_label: "Order Details"
    label: "Parent Order UID"
    description: "Main order ID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: incomplete_order_status {
    group_label: "Order Details"
    description: "Order Status (Incomplete orders only)"
    type: string
    sql: ${TABLE}.status ;;
  }
}
