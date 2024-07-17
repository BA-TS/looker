view: order_comments {
  sql_table_name: `toolstation-data-storage.sales.order_comments`;;

  dimension: order_id {
    label: "Order ID"
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
    hidden:  yes
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
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
