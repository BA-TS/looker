# If necessary, uncomment the line below to include explore_source.

# include: "transactions.explore.lkml"

view: ecrebo_product_code_flag {
  derived_table: {
    explore_source: base {
      column: parent_order_uid { field: transactions.parent_order_uid }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "NOT NULL"
      }
      filters: {
        field: products.product_code
        value: "00021"
      }
    }
  }

  dimension: parent_order_uid {
    label: "Transactions Parent Order UID"
    description: "Main order ID"
    sql: ${TABLE}.parent_order_uid ;;
    hidden: yes
  }

  dimension: ecrebo_order_flag {
    label: "Ecrebo Order (Product Code 21)"
    type: yesno
    sql: ${parent_order_uid} is not null ;;
  }

}
