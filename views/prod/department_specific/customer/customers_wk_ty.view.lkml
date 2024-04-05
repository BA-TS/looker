include: "/views/prod/department_specific/customer/customers_wk_ly.view"

view: customers_wk_ty {

  derived_table: {
    explore_source: base {
      column: customer_uid {field: customers.customer_uid }

      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }

      filters: {
        field: base.select_date_range
        value: "last week"
      }
    }
  }
  dimension: customer_uid {
    hidden: yes
  }

  dimension: customer_wk47_2023{
    group_label: "Flags"
    label: "Is Customer Fiscal Week TY"
    type: yesno
    sql: ${customer_uid} is not null;;
  }
}
