view: assumed_trade_spend {
  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      column: total_net_sales { field: transactions.total_net_sales }
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month }
      column: working_day_hour_percent { field: transactions.working_day_hour_percent }
      column: trade_products_10_subdepartments { field: products.trade_products_10_subdepartments }
      derived_column: total_net_sales_ma{sql:AVG(total_net_sales)
               OVER(PARTITION BY customer_uid ORDER BY calendar_year_month DESC ROWS BETWEEN CURRENT ROW AND 11 FOLLOWING) ;;}
      derived_column: working_day_hour_ma{sql:AVG(working_day_hour_percent)
               OVER(PARTITION BY customer_uid ORDER BY calendar_year_month DESC ROWS BETWEEN CURRENT ROW AND 11 FOLLOWING) ;;}
      derived_column: trade_products_10_subdepartments_ma{sql:AVG(trade_products_10_subdepartments)
        OVER(PARTITION BY customer_uid ORDER BY calendar_year_month DESC ROWS BETWEEN CURRENT ROW AND 11 FOLLOWING) ;;}
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
  dimension: customer_uid {
    group_label:"Last R12 Months"
    label: "Customers Customer UID"
    description: ""
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: total_net_sales {
    label: "Gross Sales"
    description: "Sales value including VAT"
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
    description: "Sales value including VAT"
    sql: ${TABLE}.total_net_sales_ma ;;
    type: number
    value_format_name: gbp_0
  }

  dimension: working_day_hour_rolling {
    group_label:"Last R12 Months"
    label: "Working Day Hour %"
    description: "Sales value including VAT"
    sql: ${TABLE}.working_day_hour_ma ;;
    type: number
    value_format_name: percent_1
  }

  dimension: trade_products_10_subdepartments_rolling {
    group_label:"Last R12 Months"
    label: "Trade Products 10 Sub"
    description: "Sales value including VAT"
    sql: ${TABLE}.trade_products_10_subdepartments ;;
    type: number
    value_format_name: decimal_1
  }
}
