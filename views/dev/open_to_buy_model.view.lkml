# The name of this view in Looker is "Open to Buy Model"
view: open_to_buy_model {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.ts_analytics.open_to_buy_model`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cogs Budget" in Explore.

  dimension: cogs_budget {
    type: number
    sql: ${TABLE}.cogs_budget ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension: fixed_stock {
    type: number
    sql: ${TABLE}.fixed_stock ;;
  }

  dimension: forecast_orders {
    type: number
    sql: ${TABLE}.forecast_orders ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_forecast_orders {
    type: sum
    sql: ${forecast_orders} ;;
  }

  measure: average_forecast_orders {
    type: average
    sql: ${forecast_orders} ;;
  }

  dimension: ongoing_cogs {
    type: number
    sql: ${TABLE}.ongoing_cogs ;;
  }

  dimension: ongoing_forecast_orders {
    type: number
    sql: ${TABLE}.ongoing_forecast_orders ;;
  }

  dimension: ongoing_orders_due_in {
    type: number
    sql: ${TABLE}.ongoing_orders_due_in ;;
  }

  dimension: ongoing_stock_budget {
    type: number
    sql: ${TABLE}.ongoing_stock_budget ;;
  }

  dimension: open_to_buy_raw {
    type: number
    sql: ${TABLE}.open_to_buy_raw ;;
  }

  dimension: orders_due_in {
    type: number
    sql: ${TABLE}.orders_due_in ;;
  }

  dimension: repeater_buy {
    type: number
    sql: ${TABLE}.repeater_buy ;;
  }

  dimension: stock_budget {
    type: number
    sql: ${TABLE}.stock_budget ;;
  }

  dimension: stock_forecast {
    type: number
    sql: ${TABLE}.stock_forecast ;;
  }

  dimension: stock_forecast_pre_otb {
    type: number
    sql: ${TABLE}.stock_forecast_pre_otb ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
