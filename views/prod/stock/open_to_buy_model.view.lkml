
view: open_to_buy_model_new {

  sql_table_name:

  `toolstation-data-storage.ts_analytics.open_to_buy`

    ;;

  dimension_group: date {
    label: ""
    type: time
    timeframes: [
      raw,
      month,
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: stock_days {
    type: number
    sql: ${TABLE}.stock_days ;;
    hidden: yes
  }

  dimension: repeater_buy {
    type: number
    sql: ${TABLE}.repeater_buy ;;
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

  dimension: orders_due {
    type: number
    sql: ${TABLE}.orders_due ;;
    hidden: yes
  }

  dimension: orders_received {
    type: number
    sql: ${TABLE}.orders_received ;;
    hidden: yes
  }

  dimension: open_to_buy {
    type: number
    sql: ${TABLE}.open_to_buy ;;
    hidden: yes
  }

  dimension: stock_forecast {
    type: number
    sql: ${TABLE}.stock_forecast ;;
    hidden: yes
  }


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
  measure: total_orders_received {
    label: "Orders Received (Current Month)"
    group_label: "Orders"
    type: sum
    sql: ${orders_received} ;;
    value_format_name: gbp
  }
  measure: total_orders_due {
    label: "Orders Due In"
    group_label: "Orders Due In"
    type: sum
    sql: ${orders_due} ;;
    value_format_name: gbp
  }
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
    sql: ${total_stock_budget} - ${total_stock_forecast} ;;
    value_format_name: gbp
  }





  measure: average_stock_days {
    label: "Stock Days"
    group_label: "Stock"
    type: average
    sql: ${TABLE}.stock_days ;;
    value_format_name: decimal_0
  }
  measure: average_repeater_buy {
    label: "Repeater Buy"
    group_label: "Open to Buy"
    type: average
    sql: ${TABLE}.repeater_buy ;;
    value_format_name: percent_2
  }













}
