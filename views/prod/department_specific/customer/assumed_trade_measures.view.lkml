view: assumed_trade_measures {
  derived_table: {
    explore_source: base {
      column: number_of_unique_products { field: transactions.number_of_unique_products }
      column: customer_uid { field: customers.customer_uid }
      column: number_of_branches { field: transactions.number_of_branches }
      column: distinct_month_count { field: calendar_completed_date.distinct_month_count }
      column: distinct_week_count { field: calendar_completed_date.distinct_week_count }
      column: working_day_hour_percent { field: transactions.working_day_hour_percent }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
    }
  }

  dimension: number_of_unique_products {
    label: "Measures Number of Products"
    description: "Number of unique product codes sold"
    value_format: "#,##0;(#,##0)"
    type: number
    hidden: yes
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    description: ""
    hidden: yes
  }

  dimension: number_of_branches {
    label: "Measures Number of Branches"
    description: "Number of branches"
    value_format: "#,##0;(#,##0)"
    type: number
    hidden: yes
  }

  dimension: distinct_month_count {
    label: "Measures Number of Distinct Months"
    description: ""
    type: number
    hidden: yes
  }

  dimension: distinct_week_count {
    label: "Measures Number of Distinct Weeks"
    description: ""
    type: number
    hidden: yes
  }

  dimension: working_day_hour_percent {
    label: "Measures Transactions within working day/hours %"
    description: ""
    value_format: "0.0%"
    type: number
    hidden: yes
  }

  measure: number_of_branches_per_customer {
    value_format: "#,##0;(#,##0)"
    type: average
    sql: ${number_of_branches} ;;
  }
}
