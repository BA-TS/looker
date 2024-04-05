view: customers_2wk_ty {

  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }

      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }

      filters: {
        field: base.select_date_range
        value: "2 week ago for 1 week"
      }
    }
  }

  dimension: customer_uid {
    hidden: yes
  }

  dimension: is_customer{
    group_label: "Flags"
    label: "Is Customer 2 Wks Ago TY"
    type: yesno
    sql: ${customer_uid} is not null;;
  }
}
