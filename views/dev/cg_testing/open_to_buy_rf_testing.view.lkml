# The name of this view in Looker is "Open to Buy Rf Testing"
view: open_to_buy_rf_testing {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.ts_analytics.open_to_buy_rf_testing`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: __table_last_updated__ {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.__table_last_updated__ ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cogs Actual" in Explore.

  dimension: cogs_actual {
    type: number
    sql: ${TABLE}.cogs_actual ;;
  }

  dimension: cogs_budget {
    type: number
    sql: ${TABLE}.cogs_budget ;;
  }

  dimension: cogs_budget_rf1 {
    type: number
    sql: ${TABLE}.cogs_budget_rf1 ;;
  }

  dimension: cogs_budget_rf2 {
    type: number
    sql: ${TABLE}.cogs_budget_rf2 ;;
  }

  dimension: cogs_budget_rf3 {
    type: number
    sql: ${TABLE}.cogs_budget_rf3 ;;
  }

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

  dimension: open_to_buy {
    type: number
    sql: ${TABLE}.open_to_buy ;;
  }

  dimension: open_to_buy_rf1 {
    type: number
    sql: ${TABLE}.open_to_buy_rf1 ;;
  }

  dimension: open_to_buy_rf2 {
    type: number
    sql: ${TABLE}.open_to_buy_rf2 ;;
  }

  dimension: open_to_buy_rf3 {
    type: number
    sql: ${TABLE}.open_to_buy_rf3 ;;
  }

  dimension: orders_actual {
    type: number
    sql: ${TABLE}.orders_actual ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_orders_actual {
    type: sum
    sql: ${orders_actual} ;;
  }

  measure: average_orders_actual {
    type: average
    sql: ${orders_actual} ;;
  }

  dimension: orders_budget {
    type: number
    sql: ${TABLE}.orders_budget ;;
  }

  dimension: orders_budget_rf1 {
    type: number
    sql: ${TABLE}.orders_budget_rf1 ;;
  }

  dimension: orders_budget_rf2 {
    type: number
    sql: ${TABLE}.orders_budget_rf2 ;;
  }

  dimension: orders_budget_rf3 {
    type: number
    sql: ${TABLE}.orders_budget_rf3 ;;
  }

  dimension: orders_due {
    type: number
    sql: ${TABLE}.orders_due ;;
  }

  dimension: orders_received {
    type: number
    sql: ${TABLE}.orders_received ;;
  }

  dimension: repeater_buy {
    type: number
    sql: ${TABLE}.repeater_buy ;;
  }

  dimension: stock_actual {
    type: number
    sql: ${TABLE}.stock_actual ;;
  }

  dimension: stock_budget {
    type: number
    sql: ${TABLE}.stock_budget ;;
  }

  dimension: stock_budget_rf1 {
    type: number
    sql: ${TABLE}.stock_budget_rf1 ;;
  }

  dimension: stock_budget_rf2 {
    type: number
    sql: ${TABLE}.stock_budget_rf2 ;;
  }

  dimension: stock_budget_rf3 {
    type: number
    sql: ${TABLE}.stock_budget_rf3 ;;
  }

  dimension: stock_days {
    type: number
    sql: ${TABLE}.stock_days ;;
  }

  dimension: stock_forecast {
    type: number
    sql: ${TABLE}.stock_forecast ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
