include: "/views/**/*transactions.view"

view: order_comments {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    TRIM(REGEXP_EXTRACT(comments, r'This order is a return for(.{12})')) as linked_order_id,
    * FROM
   `toolstation-data-storage.sales.order_comments`;;
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: order_id {
    label: "Return Parent Order UID "
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: date {
    label: "Return Date"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
    # hidden: yes
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
    hidden: yes
  }

  dimension: linked_order_id {
    type: string
    sql:${TABLE}.linked_order_id ;;
  }

  dimension: return_days {
    type: number
    sql:  date_diff(${date_date},${transactions.order_completed_date},day);;
  }

  dimension: return_days_tier {
    type: tier
    style: integer
    tiers: [0,31,46,181,366]
    sql:  ${return_days};;
  }

}
