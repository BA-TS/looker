view: customers_wks47_22 {

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
        value: "202247,202248"
      }
    }
  }
  dimension: customer_uid {
    label: "Customers Customer UID wk47 22"
    description: ""
    hidden: yes
  }

  dimension: customer_wk47_2022{
    view_label: "Customers"
    type: yesno
    sql: case when ${customer_uid} is not null then true else false end;;
  }
}
