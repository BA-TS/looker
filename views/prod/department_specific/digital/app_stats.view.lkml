# The name of this view in Looker is "App Stats"
view: app_stats {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.looker_mart.app_stats`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Customer First Installs" in Explore.

  measure: customer_first_installs {
    type: number
    sql: ${TABLE}.customer_first_installs ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
    type: number
    sql: ${TABLE}.netSalesValue ;;
  }

  measure: number_of_customers {
    type: number
    sql: ${TABLE}.number_of_customers ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_number_of_customers {
    type: sum
    sql: ${number_of_customers} ;;
  }

  # measure: average_number_of_customers {
  #   type: average
  #   sql: ${number_of_customers} ;;
  # }

  measure: number_of_orders {
    type: number
    sql: ${TABLE}.number_of_orders ;;
  }

  measure: number_of_promo_customers {
    type: number
    sql: ${TABLE}.number_of_promo_customers ;;
  }

  measure: number_of_promo_orders {
    type: number
    sql: ${TABLE}.number_of_promo_orders ;;
  }

  measure: promo_orders_net_sales_value {
    type: number
    sql: ${TABLE}.promo_orders_net_sales_value ;;
  }

  measure: raw_installs {
    type: number
    sql: ${TABLE}.raw_installs ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: []
  # }
}
