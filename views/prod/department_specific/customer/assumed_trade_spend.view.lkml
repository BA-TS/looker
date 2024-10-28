view: assumed_trade_spend {
  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      column: total_net_sales { field: transactions.total_net_sales }
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month }
      column: working_day_hour_percent { field: transactions.working_day_hour_percent }
      column: has_trade_products_10_subdepartments { field: products.has_trade_products_10_subdepartments }
      derived_column: total_net_sales_ma{sql:AVG(total_net_sales)
               OVER(PARTITION BY customer_uid ORDER BY calendar_year_month DESC ROWS BETWEEN 1 FOLLOWING AND 12 FOLLOWING) ;;}
      derived_column: working_day_hour_ma{sql:AVG(working_day_hour_percent)
        OVER(PARTITION BY customer_uid ORDER BY calendar_year_month DESC ROWS BETWEEN 1 FOLLOWING AND 12 FOLLOWING) ;;}
      derived_column: trade_products_10_subdepartments_ma{sql:AVG(has_trade_products_10_subdepartments)
        OVER(PARTITION BY customer_uid ORDER BY calendar_year_month DESC ROWS BETWEEN 1 FOLLOWING AND 12 FOLLOWING) ;;}
      derived_column: primary_key{sql:row_number() OVER(order by customer_uid) ;;}
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "48 months"
      }
    }
  }

  dimension: primary_key {
    sql: ${TABLE}.primary_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer_uid {
    group_label:"Last R12 Months"
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: total_net_sales {
    label: "Gross Sales"
    sql: ${TABLE}.total_net_sales ;;
    type: number
    value_format_name: gbp_0
    hidden: yes
  }

  dimension: calendar_year_month {
    type: string
    sql: ${TABLE}.calendar_year_month;;
    hidden: yes
  }

  dimension: net_sales_rolling {
    group_label:"Last R12 Months"
    label: "SPC"
    sql: ${TABLE}.total_net_sales_ma ;;
    type: number
    value_format_name: gbp_0
    hidden: yes
  }

  measure: avg_net_sales_rolling {
    group_label:"Last R12 Months"
    label: "AVG SPC"
    sql: ${net_sales_rolling};;
    type: average
    value_format_name: gbp_0
  }

  dimension: working_day_hour_rolling {
    group_label:"Last R12 Months"
    label: "Working Day Hour %"
    sql: ${TABLE}.working_day_hour_ma ;;
    type: number
    value_format_name: percent_1
    hidden: yes
  }

  measure:  avg_working_day_hour_rollin {
    group_label:"Last R12 Months"
    label: "AVG Working Day Hour %"
    sql: ${working_day_hour_rolling} ;;
    type: average
    value_format_name: percent_1
  }

  dimension: trade_products_10_subdepartments_rolling {
    group_label:"Last R12 Months"
    label: "Trade Products 10 Sub"
    sql: ${TABLE}.trade_products_10_subdepartments_ma ;;
    type: number
    value_format_name: decimal_0
    hidden: yes
  }

  measure: trade_products_10_subdepartments_rolling_avg {
    group_label:"Last R12 Months"
    label: "AVG Trade 10 Sub"
    sql: ${trade_products_10_subdepartments_rolling};;
    type: average
    value_format_name: decimal_0
  }
}
