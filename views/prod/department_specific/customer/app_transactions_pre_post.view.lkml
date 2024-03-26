view: app_transactions_pre_post {
  derived_table: {
    explore_source: base {
      bind_all_filters: yes
      column: customer_uid { field: customers.customer_uid }
      column: date { field: calendar_completed_date.date }
      column: first_app_transaction_date { field: transactions.first_app_transaction_date }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
    }
  }
  dimension: customer_uid {
    label: "Customers Customer UID"
    description: ""
  }

  dimension: date {
    label: "Date Date (dd/mm/yyyy)"
    description: ""
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: first_app_transaction_date {
    label: "Measures First APP Transaction Date"
    sql: ${TABLE}.first_app_transaction_date ;;
    type: date
  }

  dimension: days_since_first_app_transaction_date {
    type: number
    sql: date_diff(${first_app_transaction_date},${date},day);;
  }
}
