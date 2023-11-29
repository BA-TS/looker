view: customers_wks47_23 {
  required_access_grants: [lz_testing]
  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
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
        value: "202347"
      }
    }
  }
  dimension: customer_uid {
    label: "Customers Customer UID wk47 23"
    description: ""
  }

  dimension: flag_wk47_23 {
    type: yesno
    sql: case when ${customer_uid} is not null then true else false end;;
  }
}
