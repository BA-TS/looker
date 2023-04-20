view: app_stats {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.looker_mart.app_stats`;;

  measure: customer_first_installs {
    type: sum
    sql: ${TABLE}.customer_first_installs ;;
  }

  dimension_group: full {
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
    sql: ${TABLE}.fullDate ;;
  }

  measure: net_sales_value {
    type: sum
    sql: ${TABLE}.netSalesValue ;;
  }

  measure: number_of_customers {
    type: sum
    sql: ${TABLE}.number_of_customers ;;
  }

  # measure: total_number_of_customers {
  #   type: sum
  #   sql: ${number_of_customers} ;;
  # }

  # measure: average_number_of_customers {
  #   type: average
  #   sql: ${number_of_customers} ;;
  # }

  measure: number_of_orders {
    type: sum
    sql: ${TABLE}.number_of_orders ;;
  }

  measure: number_of_promo_customers {
    type: sum
    sql: ${TABLE}.number_of_promo_customers ;;
  }

  measure: number_of_promo_orders {
    type: sum
    sql: ${TABLE}.number_of_promo_orders ;;
  }

  measure: promo_orders_net_sales_value {
    type: sum
    sql: ${TABLE}.promo_orders_net_sales_value ;;
  }

  measure: raw_installs {
    type: sum
    sql: ${TABLE}.raw_installs ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: []
  # }
}
