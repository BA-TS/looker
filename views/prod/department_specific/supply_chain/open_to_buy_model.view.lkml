view: open_to_buy_model {
  sql_table_name: `toolstation-data-storage.ts_analytics.open_to_buy`;;

  parameter: budget_type {
    type: unquoted
    allowed_value: {
      label: "Budget"
      value: "0"
    }
    allowed_value: {
      label: "RF1"
      value: "1"
    }
    allowed_value: {
      label: "RF2"
      value: "2"
    }
    allowed_value: {
      label: "RF3"
      value: "3"
    }
    default_value: "0"
  }

  dimension: table_last_updated {
    type: date_time
    datatype: timestamp
    sql: ${TABLE}.__table_last_updated__ ;;
  }

  dimension_group: date {
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

  dimension: cogs_budget_rf1 {
    type: number
    sql: ${TABLE}.cogs_budget_rf1 ;;
    hidden: yes
  }

  dimension: cogs_budget_rf2 {
    type: number
    sql: ${TABLE}.cogs_budget_rf2 ;;
    hidden: yes
  }

  dimension: cogs_budget_rf3 {
    type: number
    sql: ${TABLE}.cogs_budget_rf3 ;;
    hidden: yes
  }

  dimension: open_to_buy_rf1 {
    type: number
    sql: ${TABLE}.open_to_buy_rf1 ;;
    hidden: yes
  }

  dimension: open_to_buy_rf2 {
    type: number
    sql: ${TABLE}.open_to_buy_rf2 ;;
    hidden: yes
  }

  dimension: open_to_buy_rf3 {
    type: number
    sql: ${TABLE}.open_to_buy_rf3 ;;
    hidden: yes
  }

  dimension: orders_budget_rf1 {
    type: number
    sql: ${TABLE}.orders_budget_rf1 ;;
    hidden: yes
  }

  dimension: orders_budget_rf2 {
    type: number
    sql: ${TABLE}.orders_budget_rf2 ;;
    hidden: yes
  }

  dimension: orders_budget_rf3 {
    type: number
    sql: ${TABLE}.orders_budget_rf3 ;;
    hidden: yes
  }

  dimension: stock_budget_rf1 {
    type: number
    sql: ${TABLE}.stock_budget_rf1 ;;
    hidden: yes
  }

  dimension: stock_budget_rf2 {
    type: number
    sql: ${TABLE}.stock_budget_rf2 ;;
    hidden: yes
  }

  dimension: stock_budget_rf3 {
    type: number
    sql: ${TABLE}.stock_budget_rf3 ;;
    hidden: yes
  }

  dimension: stock_forecast_rf1 {
    type: number
    sql: ${TABLE}.stock_forecast_rf1 ;;
    hidden: yes
  }

  dimension: stock_forecast_rf2 {
    type: number
    sql: ${TABLE}.stock_forecast_rf2 ;;
    hidden: yes
  }

  dimension: stock_forecast_rf3 {
    type: number
    sql: ${TABLE}.stock_forecast_rf3 ;;
    hidden: yes
  }

  measure: total_cogs_budget {
    label: "COGS Budget"
    group_label: "COGS"
    type: sum
    sql:
    {% if budget_type._parameter_value == "1" %}
      ${cogs_budget_rf1}
    {% elsif budget_type._parameter_value == "2" %}
      ${cogs_budget_rf2}
    {% elsif budget_type._parameter_value == "3" %}
      ${cogs_budget_rf3}
    {% else %}
      ${cogs_budget}
    {% endif %};;
    value_format_name: gbp
  }

  measure: total_stock_budget {
    label: "Stock Budget"
    group_label: "Stock"
    type: sum
    sql:
    {% if budget_type._parameter_value == "1" %}
      ${stock_budget_rf1}
    {% elsif budget_type._parameter_value == "2" %}
      ${stock_budget_rf2}
    {% elsif budget_type._parameter_value == "3" %}
      ${stock_budget_rf3}
    {% else %}
      ${stock_budget}
    {% endif %};;
    value_format_name: gbp
  }

  measure: total_orders_budget {
    label: "Orders Budget"
    group_label: "Orders"
    type: sum
    sql:
    {% if budget_type._parameter_value == "1" %}
      ${orders_budget_rf1}
    {% elsif budget_type._parameter_value == "2" %}
      ${orders_budget_rf2}
    {% elsif budget_type._parameter_value == "3" %}
      ${orders_budget_rf3}
    {% else %}
      ${orders_budget}
    {% endif %};;
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
    sql:
    {% if budget_type._parameter_value == "1" %}
      CASE WHEN ${open_to_buy_rf1} > 0 THEN ${open_to_buy_rf1} ELSE 0 END
    {% elsif budget_type._parameter_value == "2" %}
      CASE WHEN ${open_to_buy_rf2} > 0 THEN ${open_to_buy_rf2} ELSE 0 END
    {% elsif budget_type._parameter_value == "3" %}
      CASE WHEN ${open_to_buy_rf3} > 0 THEN ${open_to_buy_rf3} ELSE 0 END
    {% else %}
      CASE WHEN ${open_to_buy} > 0 THEN ${open_to_buy} ELSE 0 END
    {% endif %};;
    value_format_name: gbp
  }

  measure: total_open_to_buy_raw {
    label: "Open to Buy (Raw)"
    group_label: "Open to Buy"
    type: sum
    sql:
    {% if budget_type._parameter_value == "1" %}
      ${open_to_buy_rf1}
    {% elsif budget_type._parameter_value == "2" %}
      ${open_to_buy_rf2}
    {% elsif budget_type._parameter_value == "3" %}
      ${open_to_buy_rf3}
    {% else %}
      ${open_to_buy}
    {% endif %};;
    value_format_name: gbp
  }

  measure: total_stock_forecast {
    label: "Stock Forecast"
    group_label: "Stock"
    type: sum
    sql:
    {% if budget_type._parameter_value == "1" %}
      ${stock_forecast_rf1}
    {% elsif budget_type._parameter_value == "2" %}
      ${stock_forecast_rf2}
    {% elsif budget_type._parameter_value == "3" %}
      ${stock_forecast_rf3}
    {% else %}
      ${stock_forecast}
    {% endif %};;
    value_format_name: gbp
  }

  measure: variance_to_budget {
    label: "Variance to Budget"
    group_label: "Open to Buy"
    type: number
    sql:
    ${total_stock_budget} - ${total_stock_forecast} ;;
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
