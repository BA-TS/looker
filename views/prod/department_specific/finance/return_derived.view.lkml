include: "/explores/**/sales/single_line_transactions.explore.lkml"

view: return_derived {
  derived_table: {
    explore_source: base {
      column: parent_order_uid { field: transactions.parent_order_uid }
      column: order_reason { field: transactions.order_reason }
      column: date { field: calendar_completed_date.date }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "NOT NULL"
      }
      filters: {
        field: transactions.transaction_line_type
        value: "Return"
      }
      filters: {
        field: products.product_code
        value: "-0%"
      }
    }
  }
  dimension: parent_order_uid {
    label: "Transactions Parent Order UID"
    description: "Main order ID"
    sql: ${parent_order_uid} ;;
  }
  dimension: order_reason {
    label: "Transactions Reason for Order/Return"
    description: ""
  }
  dimension: date {
    label: "Date Date (dd/mm/yyyy)"
    description: ""
    type: date
  }
}
