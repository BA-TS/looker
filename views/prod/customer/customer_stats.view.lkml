view: customer_stats {

  sql_table_name: `toolstation-data-storage.looker_mart.customer_stats`;;

  dimension: app_total_net_sales {
    type: number
    sql: ${TABLE}.app_total_net_sales ;;
  }

  dimension: branch_total_net_sales {
    type: number
    sql: ${TABLE}.branch_total_net_sales ;;
  }

  dimension: calendar_year {
    type: number
    sql: ${TABLE}.calendarYear ;;
  }

  dimension: cluster {
    type: string
    sql: ${TABLE}.cluster ;;
  }

  dimension: customer_lifetime_net_sales {
    type: number
    sql: ${TABLE}.customer_lifetime_net_sales ;;
  }

  dimension: customer_lifetime_orders {
    type: number
    sql: ${TABLE}.customer_lifetime_orders ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_customer_lifetime_orders {
    type: sum
    sql: ${customer_lifetime_orders} ;;
  }

  measure: average_customer_lifetime_orders {
    type: average
    sql: ${customer_lifetime_orders} ;;
  }

  dimension: customer_lifetime_units {
    type: number
    sql: ${TABLE}.customer_lifetime_units ;;
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
  }

  dimension: dbs_trade_category {
    type: string
    sql: ${TABLE}.DBS_trade_category ;;
  }

  dimension: dbs_trade_detail {
    type: string
    sql: ${TABLE}.DBS_trade_detail ;;
  }

  dimension: fiscal_year {
    type: number
    sql: ${TABLE}.fiscalYear ;;
  }

  dimension: is_app_user {
    type: number
    sql: ${TABLE}.is_app_user ;;
  }

  dimension: is_dbs_trade {
    type: number
    sql: ${TABLE}.is_DBS_trade ;;
  }

  dimension: is_rita_event {
    type: number
    sql: ${TABLE}.is_rita_event ;;
  }

  dimension: is_trade_account {
    type: number
    sql: ${TABLE}.is_trade_account ;;
  }

  dimension: total_net_sales {
    type: number
    sql: ${TABLE}.total_net_sales ;;
  }

  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }

  dimension: total_units {
    type: number
    sql: ${TABLE}.total_units ;;
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
    sql: ${TABLE}.transaction_date ;;
  }

  dimension: web_total_net_sales {
    type: number
    sql: ${TABLE}.web_total_net_sales ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
