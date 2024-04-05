view: customers_wk_ly {

  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }

      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }

      filters: {
        field: base.select_date_range
        value: "53 week ago for 1 week"
      }
    }
  }

  dimension: customer_uid {
    hidden: yes
  }

  dimension: customer_wk47_2022{
    group_label: "Flags"
    label: "Is Customer Fiscal Week PY"
    type: yesno
    sql: ${customer_uid} is not null;;
  }
}
