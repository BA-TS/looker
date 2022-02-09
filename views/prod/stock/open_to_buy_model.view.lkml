view: open_to_buy_model {

  # https://console.cloud.google.com/bigquery?sq=277683357807:1d3c4ddab5b14c02a28d88d53e3e7a70 #

  sql_table_name: `toolstation-data-storage.ts_analytics.open_to_buy_model`;;

  dimension: date_raw {
    type: date_time
    sql: ${TABLE}.date ;;
    hidden: yes
  }

  dimension_group: period {
    type: time
    timeframes: [
      month
    ]
    sql: timestamp(${date_raw}) ;;
    order_by_field: date_raw
  }

  ##############################

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: stock_days {
    type: number
    sql: ${TABLE}.stock_days  ;; # * (1 + ${stock_day_modifier})
    hidden: yes
  }

  dimension: repeater_buy {
    type: number
    sql: ${TABLE}.repeater_buy ;;
    hidden: yes
  }

  dimension: orders_due_in {
    type: number
    sql: ${TABLE}.orders_due_in ;;
    hidden: yes
  }

  dimension: stock_budget {
    type: number
    sql: ${TABLE}.stock_budget ;;
    hidden: no
  }

  dimension: cogs_budget {
    type: number
    sql: ${TABLE}.cogs_budget ;;
    hidden: yes
  }

  dimension: forecast_orders {
    type: number
    sql: ${TABLE}.orders_budget ;;
    hidden: yes
  }

  dimension: stock_actual {
    type: number
    sql: ${TABLE}.stock_actual ;;
    hidden: yes
  }
  dimension: cogs_actual {
    type: number
    sql: ${TABLE}.cogs_actual ;;
    hidden: yes
  }
  dimension: orders_actual {
    type: number
    sql: ${TABLE}.orders_actual ;;
    hidden: yes
  }

  dimension: open_to_buy_raw {
    type: number
    sql: ${TABLE}.open_to_buy ;;
    hidden: yes
  }

  dimension: stock_forecast {
    type: number
    sql: ${TABLE}.forecast_stock ;;
    hidden: yes
  }



  # filter: stock_day_filter {
  #   label: "Stock Day Adjustment"
  #   description: "State as percentage - e.g. 10% = 0.1 / -5% = -0.05"
  #   type: string
  # }

  # dimension: stock_day_modifier{
  #   type: string
  #   sql:

  #   {% if stock_day_filter._is_filtered %}
  #     coalesce(CAST({% parameter stock_day_filter %} AS FLOAT64),0)
  #   {% else %}
  #     0
  #   {% endif %}

  #   ;;
  #   hidden: yes
  # }


  dimension: variance_to_budget {
    sql:

    ${stock_actual} - ${stock_budget}

    ;;
    hidden: yes
  }








  measure: average_stock_days {
    type: average
    sql: ${stock_days} ;;
    value_format_name: decimal_0
  }
  measure: average_repeater_buy {
    type: average
    sql: ${repeater_buy} ;;
    value_format_name: percent_1
  }


  measure: total_orders_due_in {
    type: sum
    sql: ${orders_due_in} ;;
    value_format_name:gbp
  }

  measure: total_stock_budget {
    type: sum
    sql: ${stock_budget} ;;
    value_format_name: gbp
  }

  measure: total_cogs_budget {
    type: sum
    sql: ABS(${cogs_budget}) ;;
    value_format_name:gbp
  }

  measure: total_forecast_orders {
    type: sum
    sql: ${forecast_orders} ;;
    value_format_name:gbp
  }
  measure: total_stock_actual {
    type: sum
    sql: ${stock_actual};;
    value_format_name: gbp
  }
  measure: total_cogs_actual {
    type: sum
    sql: ${cogs_actual};;
    value_format_name: gbp
  }
  measure: total_orders_actual {
    type: sum
    sql: ${orders_actual};;
    value_format_name: gbp
  }











  # Visible Measures #

  measure: average_stock_forecast {
    type: average
    sql: ${stock_forecast} ;;
  }
  measure: open_to_buy {
    label: "Total Open to Buy"
    type: sum
    sql: ${open_to_buy_raw} ;;
    value_format_name: gbp
  }


  measure: average_variance_to_budget {
    type: average
    sql: ${variance_to_budget} ;;
    value_format_name: gbp
  }

  measure: buying_performance {
    description: "Combines Open to Buy and Variance to Budget to show the combination of where there is still stock availability, versus where overspending has occurred versus the budget."
    type: number
    sql: case when ${open_to_buy} = 0 then -${average_variance_to_budget} else ${open_to_buy} end  ;;
    value_format_name: gbp
  }

}
