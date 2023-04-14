view: aac {
  sql_table_name: `toolstation-data-storage.stock.aacHistory`;;

  dimension: average_cost_price {
    type: number
    sql: ${TABLE}.averageCostPrice ;;
    hidden: yes
  }

  dimension: date {
    type: number
    sql: ${TABLE}.date ;;
    hidden: yes
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }
}
