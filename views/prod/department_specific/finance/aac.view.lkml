view: aac {
  derived_table: {
    sql: select distinct *, row_number() over () as P_K from
   `toolstation-data-storage.stock.aacHistory`;;
    datagroup_trigger: ts_daily_datagroup
  }

  dimension: P_K {
    type: number
    sql: ${TABLE}.P_K ;;
    hidden: yes
    primary_key: yes
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
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
