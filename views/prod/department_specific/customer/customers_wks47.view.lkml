view: customers_wks47 {

  required_access_grants: [lz_testing]

  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      column: fiscal_year_week { field: calendar_completed_date.fiscal_year_week }
      column: number_of_transactions { field: transactions.number_of_transactions }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "NOT NULL"
      }
      filters: {
        field: calendar_completed_date.fiscal_year_week
        value: "202247,202347"
      }
      filters: {
        field: calendar_completed_date.date
        value: "NOT NULL"
      }
    }
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    description: ""
  }

  dimension: fiscal_year_week {
    label: "Date Fiscal Year Week (yyyyww)"
    description: ""
  }

  dimension: number_of_transactions {
    label: "Measures Number of Transactions"
    description: "Number of orders"
    value_format: "#,##0;(#,##0)"
    type: number
  }

  dimension: cust_wks47_22 {
    type: yesno
    sql: ${fiscal_year_week}='2022247'and ${number_of_transactions}>0 ;;
  }

}
