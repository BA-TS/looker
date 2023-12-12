view: assumed_trade_measures {
  derived_table: {
    explore_source: base {
      bind_all_filters: yes
      column: number_of_unique_products { field: transactions.number_of_unique_products }
      column: customer_uid { field: customers.customer_uid }
      column: number_of_branches { field: transactions.number_of_branches }
      column: distinct_month_count { field: calendar_completed_date.distinct_month_count }
      column: distinct_week_count { field: calendar_completed_date.distinct_week_count }
      column: working_day_hour_percent { field: transactions.working_day_hour_percent }
    }
  }

  dimension: number_of_unique_products {
    label: "Measures Number of Products"
    description: "Number of unique product codes sold"
    value_format: "#,##0;(#,##0)"
    type: number
    hidden: yes
    sql: ${TABLE}.number_of_unique_products ;;
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    description: ""
    hidden: yes
    sql: ${TABLE}.customer_uid ;;
  }

  dimension: number_of_branches {
    label: "Measures Number of Branches"
    description: "Number of branches"
    value_format: "#,##0;(#,##0)"
    type: number
    hidden: yes
    sql: ${TABLE}.number_of_branches ;;
  }

  dimension: distinct_month_count {
    label: "Measures Number of Distinct Months"
    description: ""
    type: number
    hidden: yes
    sql: ${TABLE}.distinct_month_count ;;
  }

  dimension: distinct_week_count {
    label: "Measures Number of Distinct Weeks"
    description: ""
    type: number
    hidden: yes
    sql: ${TABLE}.distinct_week_count ;;
  }

  dimension: working_day_hour_percent {
    label: "Measures Transactions within working day/hours %"
    description: ""
    value_format: "0.0%"
    type: number
    hidden: yes
    sql: ${TABLE}. working_day_hour_percent ;;
  }

  measure: distinct_month_count_per_customer {
    label: "Measures Number of Distinct Months"
    description: ""
    type: average
    sql: 1 ;;
  }

  measure: number_of_branches_per_customer {
    label: "Number of branches per customer"
    type: average
    sql: ${number_of_branches} ;;
  }
}
