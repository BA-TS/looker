view: dgtl_product_conversion {
  label: "Digital Product Conversion"
  sql_table_name: `toolstation-data-storage.digitalreporting.DGTL_product_conversion`;;

  # DIMENSION GROUPS

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  # DIMENSIONS

  dimension: ga_sku {
    primary_key: yes
    label: "Product Code (SKU)"
    type: string
    sql: ${TABLE}.ga_SKU ;;
  }

  dimension: exit_rate {
    type: number
    sql: ${TABLE}.exitRate ;;
    hidden: yes
  }

  dimension: ga_brand {
    label: "Brand"
    type: string
    sql: ${TABLE}.ga_brand ;;
  }

  dimension: ga_category {
    label: "Category"
    type: string
    sql: ${TABLE}.ga_category ;;
  }

  dimension: ga_entrances {
    type: number
    sql: ${TABLE}.ga_entrances ;;
    hidden: yes
  }

  dimension: ga_product_conversion {
    type: number
    sql: ${TABLE}.ga_productConversion ;;
    hidden: yes
  }

  dimension: ga_product_exits {
    type: number
    sql: ${TABLE}.ga_productExits ;;
    hidden: yes
  }

  dimension: ga_total_product_page_views {
    type: number
    sql: ${TABLE}.ga_total_product_page_views ;;
    hidden: yes
  }

  dimension: ga_total_product_revenue {
    type: number
    sql: ${TABLE}.ga_total_productRevenue ;;
    hidden: yes
  }

  dimension: ga_total_product_sold {
    type: number
    sql: ${TABLE}.ga_total_product_sold ;;
    hidden: yes
  }

  dimension: ga_total_product_units {
    type: number
    sql: ${TABLE}.ga_total_productUnits ;;
    hidden: yes
  }

  dimension: ga_total_time_on_page_sec {
    type: number
    sql: ${TABLE}.ga_total_time_on_page_sec ;;
    hidden: yes
  }

  dimension: delivery_oos_pviews {
    type: number
    sql: ${TABLE}.delivery_oos_pviews ;;
    hidden: yes
  }
  dimension: cc_oos_pviews {
    type: number
    sql: ${TABLE}.cc_oos_pviews ;;
    hidden: yes
  }
  dimension: dual_oos_pviews {
    type: number
    sql: ${TABLE}.dual_oos_pviews ;;
    hidden: yes
  }

  # MEASURES

  measure: conversion_rate {
    label: "Conversion Rate"
    type: average
    sql: ${ga_product_conversion} ;;
    value_format:  "#,##0.00%;(#,##0.00%)"
  }

  measure: rate_of_exit{
    label: "Exit Rate"
    type: average
    sql: ${exit_rate} ;;
    value_format:  "#,##0.00%;(#,##0.00%)"
  }

  measure: sum_of_entrance {
    label: "Entrances"
    type: sum
    sql: ${ga_entrances} ;;
    value_format:  "#,##0;(#,##0)"
  }

  measure: sum_of_exits{
    label: "Exits"
    type: sum
    sql: ${ga_product_exits} ;;
    value_format:  "#,##0;(#,##0)"
  }

  measure: page_views {
    label: "Page Views"
    type: sum
    sql: ${ga_total_product_page_views} ;;
    value_format: "#,##0"
  }

  measure: product_revenue {
    label: "Revenue"
    type: sum
    sql: ${ga_total_product_revenue} ;;
    value_format:  "#,##0.00;(#,##0.00)"
  }

  measure: product_sold {
    label: "Product Sold"
    type: sum
    sql: ${ga_total_product_sold} ;;
    value_format:  "#,##0;(#,##0)"
  }

  measure: product_units {
    label: "Product Units"
    type: sum
    sql: ${ga_total_product_units} ;;
    value_format:  "#,##0;(#,##0)"
  }

  measure: time_on_page {
    label: "Total Time on Page"
    description: "Summation time on page"
    type: sum
    sql: ${ga_total_time_on_page_sec} ;;
    value_format:  "#,##0.00;(#,##0.00)"
  }

  measure: delivery_oos {
    label: "Total Delivery OOS Previews"
    description: "Summation delivery oos previews"
    type: sum
    sql: ${delivery_oos_pviews} ;;
    value_format:  "#,##0.00;(#,##0.00)"
  }
  measure: cc_oos {
    label: "Total CC OOS Previews"
    description: "Summation cc oos previews"
    type: sum
    sql: ${cc_oos_pviews} ;;
    value_format:  "#,##0.00;(#,##0.00)"
  }
  measure: dual_oos {
    label: "Total Dual OOS Previews"
    description: "Summation dual oos previews"
    type: sum
    sql: ${dual_oos_pviews} ;;
    value_format:  "#,##0.00;(#,##0.00)"
  }

}
