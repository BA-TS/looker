view: transactions_incomplete {

  sql_table_name:`toolstation-data-storage.sales.transactions_incomplete`;;

  dimension: parent_order_uid {
    view_label: "Transactions"
    group_label: "Order Details"
    label: "Parent Order UID"
    description: "Main order ID"
    type: string
    sql: ${TABLE}.parentOrderUID;;
    hidden:yes
  }

  dimension: transactions_status {
    view_label: "Transactions"
    group_label: "Incomplete Transactions"
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;

  }
}
