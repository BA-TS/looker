view: customers_wks47_22 {

  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      column: fiscal_year_week { field: calendar_completed_date.fiscal_year_week }

      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "NOT NULL"
      }
      filters: {
        field: calendar_completed_date.calendar_year
        value: "2022"
      }
      filters: {
        field: calendar_completed_date.month_in_year
        value: "10,11,12"
      }

    }
  }
  dimension: customer_uid {
    description: ""
    hidden: yes
  }

  dimension: fiscal_year_week {
    label: "Is Customer Fiscal week 2022"
    description: ""
  }

  # dimension: customer_wk47_2022{
  #   label: "Is Customer Fiscal Week 2022"
  #   type: yesno
  #   sql: case when ${customer_uid} is not null then true else false end;;
  # }
}
