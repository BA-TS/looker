
view: tmp_looker_daily_conversion {
  sql_table_name: `toolstation-data-storage.digitalreporting.tmp_looker_daily_conversion`
    ;;

  dimension: aov {
    type: number
    sql: ${TABLE}.AOV ;;
    hidden: yes
  }

  dimension: conversion {
    type: number
    sql: ${TABLE}.conversion ;;
    hidden: yes
  }

  measure: total_conversion {
    type: sum
    sql: ${conversion} ;;
  }

  measure: average_conversion {
    type: average
    sql: ${conversion} ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.NetSales ;;
    hidden: yes
  }

  dimension: orders {
    type: number
    sql: ${TABLE}.totalOrders ;;
    hidden: yes
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.Totalsessions ;;
    hidden: yes
  }

  dimension_group: transaction {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transactionDate ;;
  }

  measure: average_order_value {
    type: sum
    sql:${aov};;
  }

  measure: total_net_sales {
    type: sum
    sql:${net_sales};;
  }

  measure: total_orders {
    type: sum
    sql:${orders} ;;
  }

  measure: total_sessions {
    type: sum
    sql: ${sessions} ;;
  }

}
