view: order_comments {
  sql_table_name: `toolstation-data-storage.sales.order_comments`;;

  dimension: order_id {
    label: "Order ID"
    description: "Transaction Parent Order UID"
    primary_key: yes
    type: string
    sql: ${TABLE}.orderID ;;
    hidden:  yes
  }

  dimension: date {
    type: date
    sql: ${TABLE}.date ;;
    hidden:  yes
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
  }

  dimension: linked_order_id {
    type: string
    sql: TRIM(REGEXP_EXTRACT(${comments}, r'This order is a return for(.{12})')) ;;
  }

}
