view: aac {
  sql_table_name: `toolstation-data-storage.stock.aacHistory`;;

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    primary_key: yes
    hidden: yes
  }

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
}