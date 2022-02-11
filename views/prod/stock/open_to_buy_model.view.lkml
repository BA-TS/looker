
view: open_to_buy_model_new {

  sql_table_name:

  `toolstation-data-storage.ts_analytics.open_to_buy_model`

    ;;


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

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: stock_days_for_month {
    type: number
    sql: ${TABLE}.stock_days_for_month ;;
    hidden: yes
  }

  dimension: cogs_budget {
    type: number
    sql: ${TABLE}.cogs_budget ;;
    hidden: yes
  }

  dimension: stock_budget {
    type: number
    sql: ${TABLE}.stock_budget ;;
    hidden: yes
  }

  dimension: orders_budget {
    type: number
    sql: ${TABLE}.orders_budget ;;
    hidden: yes
  }

  dimension: cogs_actual {
    type: number
    sql: ${TABLE}.cogs_actual ;;
    hidden: yes
  }

  dimension: stock_actual {
    type: number
    sql: ${TABLE}.stock_actual ;;
    hidden: yes
  }

  dimension: orders_actual {
    type: number
    sql: ${TABLE}.orders_actual ;;
    hidden: yes
  }

  dimension: orders_due_in {
    type: number
    sql: ${TABLE}.orders_due_in ;;
    hidden: yes
  }

  dimension: cogs_fx {
    type: number
    sql: ${TABLE}.cogs_fx ;;
    hidden: yes
  }

  dimension: stock_fx {
    type: number
    sql: ${TABLE}.stock_fx ;;
    hidden: yes
  }

  dimension: orders_fx {
    type: number
    sql: ${TABLE}.orders_fx ;;
    hidden: yes
  }

  dimension: repeater_buy {
    type: number
    sql: ${TABLE}.repeater_buy ;;
    hidden: yes
  }

  # dimension: r_stock_budget {
  #   type: number
  #   sql: ${TABLE}.r_stock_budget ;;
  # }

  # dimension: r_orders_due_in {
  #   type: number
  #   sql: ${TABLE}.r_orders_due_in ;;
  # }

  # dimension: r_orders_budget_fx {
  #   type: number
  #   sql: ${TABLE}.r_orders_budget_fx ;;
  # }

  # dimension: r_cogs_fx {
  #   type: number
  #   sql: ${TABLE}.r_cogs_fx ;;
  # }

  # dimension: __rolling_stock_actual__ {
  #   type: number
  #   sql: ${TABLE}.__rolling_stock_actual__ ;;
  # }

  # dimension: __rolling_cogs_actual__ {
  #   type: number
  #   sql: ${TABLE}.__rolling_cogs_actual__ ;;
  # }

  # dimension: __rolling_stock_budget__ {
  #   type: number
  #   sql: ${TABLE}.__rolling_stock_budget__ ;;
  # }

  # dimension: __rolling_orders_due_in__ {
  #   type: number
  #   sql: ${TABLE}.__rolling_orders_due_in__ ;;
  # }

  # dimension: __rolling_orders_budget__ {
  #   type: number
  #   sql: ${TABLE}.__rolling_orders_budget__ ;;
  # }

  # dimension: __rolling_cogs_fx__ {
  #   type: number
  #   sql: ${TABLE}.__rolling_cogs_fx__ ;;
  # }

  # dimension: open_to_buy_raw {
  #   type: number
  #   sql: ${TABLE}.open_to_buy_raw ;;
  # }

  dimension: open_to_buy {
    type: number
    sql: ${TABLE}.open_to_buy ;;
    hidden: yes
  }

  # dimension: __rolling_open_to_buy__ {
  #   type: number
  #   sql: ${TABLE}.__rolling_open_to_buy__ ;;
  # }

  dimension: stock_forecast {
    type: number
    sql: ${TABLE}.stock_forecast ;;
    hidden: yes
  }


  # measure: total_stock_days_for_month {
  #   type: sum
  #   sql: ${TABLE}.stock_days_for_month ;;
  # }
  measure: total_cogs_budget {
    label: "COGS Budget"
    group_label: "COGS"
    type: sum
    sql: ${cogs_budget} ;;
    value_format_name: gbp
  }
  measure: total_stock_budget {
    label: "Stock Budget"
    group_label: "Stock"
    type: sum
    sql: ${stock_budget} ;;
    value_format_name: gbp
  }
  measure: total_orders_budget {
    label: "Orders Budget"
    group_label: "Orders"
    type: sum
    sql: ${orders_budget} ;;
    value_format_name: gbp
  }
  measure: total_cogs_actual {
    label: "COGS Actual"
    group_label: "COGS"
    type: sum
    sql: ${cogs_actual} ;;
    value_format_name: gbp
  }
  measure: total_stock_actual {
    label: "Stock Actual"
    group_label: "Stock"
    type: sum
    sql: ${stock_actual} ;;
    value_format_name: gbp
  }
  measure: total_orders_actual {
    label: "Orders Actual"
    group_label: "Orders"
    type: sum
    sql: ${orders_actual} ;;
    value_format_name: gbp
  }
  measure: total_orders_due_in {
    label: "Orders Due In"
    group_label: "Orders Due In"
    type: sum
    sql: ${orders_due_in} ;;
    value_format_name: gbp
  }
  measure: total_cogs_fx {
    label: "COGS Budget (FX)"
    group_label: "COGS"
    type: sum
    sql: ${cogs_fx} ;;
    value_format_name: gbp
  }
  measure: total_stock_fx {
    label: "Stock Budget (FX)"
    group_label: "Stock"
    type: sum
    sql: ${stock_fx} ;;
    value_format_name: gbp
  }
  measure: total_orders_fx {
    label: "Orders Budget (FX)"
    group_label: "Orders"
    type: sum
    sql: ${orders_fx} ;;
    value_format_name: gbp
  }
  # measure: total_repeater_buy {
  #   type: sum
  #   sql: ${TABLE}.repeater_buy ;;
  # }
  measure: total_open_to_buy {
    label: "Open to Buy"
    group_label: "Open to Buy"
    type: sum
    sql: CASE WHEN ${open_to_buy} > 0 THEN ${open_to_buy} ELSE 0 END ;;
    value_format_name: gbp
  }
  measure: total_open_to_buy_raw {
    label: "Open to Buy (Raw)"
    group_label: "Open to Buy"
    type: sum
    sql: ${open_to_buy} ;;
    value_format_name: gbp
  }
  measure: total_stock_forecast {
    label: "Stock Forecast"
    group_label: "Stock"
    type: sum
    sql: ${stock_forecast} ;;
    value_format_name: gbp
  }




  measure: variance_to_budget {
    label: "Variance to Budget"
    group_label: "Open to Buy"
    type: number
    sql: ${total_stock_forecast} - ${total_stock_budget} ;;
    value_format_name: gbp
  }





  measure: average_stock_days_for_month {
    label: "Stock Days"
    group_label: "Stock"
    type: average
    sql: ${TABLE}.stock_days_for_month ;;
    value_format_name: decimal_0
  }
  # measure: average_cogs_budget {
  #   type: average
  #   sql: ${TABLE}.cogs_budget ;;
  # }
  # measure: average_stock_budget {
  #   type: average
  #   sql: ${TABLE}.stock_budget ;;
  # }
  # measure: average_orders_budget {
  #   type: average
  #   sql: ${TABLE}.orders_budget ;;
  # }
  # measure: average_cogs_actual {
  #   type: average
  #   sql: ${TABLE}.cogs_actual ;;
  # }
  # measure: average_stock_actual {
  #   type: average
  #   sql: ${TABLE}.stock_actual ;;
  # }
  # measure: average_orders_actual {
  #   type: average
  #   sql: ${TABLE}.orders_actual ;;
  # }
  # measure: average_orders_due_in {
  #   type: average
  #   sql: ${TABLE}.orders_due_in ;;
  # }
  # measure: average_cogs_fx {
  #   type: average
  #   sql: ${TABLE}.cogs_fx ;;
  # }
  # measure: average_stock_fx {
  #   type: average
  #   sql: ${TABLE}.stock_fx ;;
  # }
  # measure: average_orders_fx {
  #   type: average
  #   sql: ${TABLE}.orders_fx ;;
  # }
  measure: average_repeater_buy {
    label: "Repeater Buy"
    group_label: "Open to Buy"
    type: average
    sql: ${TABLE}.repeater_buy ;;
    value_format_name: percent_2
  }
  # measure: average_open_to_buy {
  #   type: average
  #   sql: ${TABLE}.open_to_buy ;;
  # }
  # measure: average_stock_forecast {
  #   label: "Stock Forecast"
  #   group_label: "Stock"
  #   type: average
  #   sql: ${TABLE}.stock_forecast ;;
  # }














}
