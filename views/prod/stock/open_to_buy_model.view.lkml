view: open_to_buy_model {

  # https://console.cloud.google.com/bigquery?sq=277683357807:1d3c4ddab5b14c02a28d88d53e3e7a70 #

  sql_table_name: `toolstation-data-storage.ts_analytics.open_to_buy_model`;;

  # Visible Dimensions #

  dimension_group: period {
    type: time
    timeframes: [
      month,
    ]
    sql: ${date_raw} ;;
    order_by_field: date_raw
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  # Hidden Dimensions #

  dimension: date_raw {
    type: date
    sql: ${TABLE}.date ;;
    hidden: yes
  }

  dimension: cogs_budget {
    type: number
    sql: ${TABLE}.cogs_budget ;;
    hidden: yes
  }

  dimension: fixed_stock {
    type: number
    sql: ${TABLE}.fixed_stock ;;
    hidden: yes
  }

  dimension: forecast_orders {
    type: number
    sql: ${TABLE}.forecast_orders ;;
    hidden: yes
  }

  dimension: ongoing_cogs {
    type: number
    sql: ${TABLE}.ongoing_cogs ;;
    hidden: yes
  }

  dimension: ongoing_forecast_orders {
    type: number
    sql: ${TABLE}.ongoing_forecast_orders ;;
    hidden: yes
  }

  dimension: ongoing_orders_due_in {
    type: number
    sql: ${TABLE}.ongoing_orders_due_in ;;
    hidden: yes
  }

  dimension: ongoing_stock_budget {
    type: number
    sql: ${TABLE}.ongoing_stock_budget ;;
    hidden: yes
  }

  dimension: open_to_buy_raw {
    type: number
    sql: ${TABLE}.open_to_buy_raw ;;
    hidden: yes
  }

  dimension: orders_due_in {
    type: number
    sql: ${TABLE}.orders_due_in ;;
    hidden: yes
  }

  dimension: repeater_buy {
    type: number
    sql: ${TABLE}.repeater_buy ;;
    hidden: yes
  }

  dimension: stock_budget {
    type: number
    sql: ${TABLE}.stock_budget ;;
    hidden: yes
  }

  dimension: stock_forecast {
    type: number
    sql: ${TABLE}.stock_forecast ;;
    hidden: yes
  }

  dimension: stock_forecast_pre_otb {
    type: number
    sql: ${TABLE}.stock_forecast_pre_otb ;;
    hidden: yes
  }

  # Visible Measures #

  measure: total_cogs_budget {
    type: sum
    sql: ${cogs_budget} ;;
    value_format_name:gbp
  }

  measure: total_stock_budget {
    type: sum
    sql: ${stock_budget} ;;
    value_format_name:gbp
  }

  measure: total_orders_due_in {
    type: sum
    sql: ${orders_due_in} ;;
    value_format_name:gbp
  }

  measure: total_forecast_orders {
    type: sum
    sql: ${forecast_orders} ;;
    value_format_name:gbp
  }

  measure: open_to_buy {
    description: "FX: stock_budget - (cogs_budget + orders_due_in + forecast_orders)"
    type: sum
    sql: CASE WHEN ${open_to_buy_raw} < 0 THEN 0 ELSE ${open_to_buy_raw} END ;;
    value_format_name: gbp
  }

  measure: average_repeater_buy {
    type: average
    sql: ${repeater_buy} ;;
    value_format_name: percent_1
  }

















}
