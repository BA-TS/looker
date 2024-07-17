include: "/views/**/*transactions.view"
include: "/views/**/calendar.view"
include: "/views/**/base.view"

view: order_comments {
  sql_table_name: `toolstation-data-storage.sales.order_comments`;;

  dimension: order_id {
    label: "Return Parent Order UID "
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: date {
    label: "Return Date"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
    hidden: yes
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
    hidden: yes
  }

  dimension: linked_order_id {
    type: string
    sql: TRIM(REGEXP_EXTRACT(${comments}, r'This order is a return for(.{12})')) ;;
    hidden: yes
  }

  dimension: return_days {
    type: number
    sql:  date_diff(${date_date},${transactions.placed_date},day);;
  }

  dimension: return_days_tier {
    type: tier
    style: integer
    tiers: [0,30,60]
    sql:  ${return_days};;
  }

}
