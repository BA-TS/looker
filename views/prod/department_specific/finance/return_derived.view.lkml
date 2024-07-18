view: return_derived {
  derived_table: {
    explore_source: base {
      bind_all_filters: yes
      column: parent_order_uid { field: transactions.parent_order_uid }
      column: order_reason { field: transactions.order_reason }
      column: date { field: calendar_completed_date.date }
    }
  }

  dimension: parent_order_uid {
    label: "Transactions Parent Order UID"
    description: "Main order ID"
    sql: ${TABLE}.parent_order_uid ;;
  }

  dimension: order_reason {
    label: "Transactions Reason for Order/Return"
    description: ""
    sql: ${TABLE}.order_reason ;;
  }

  dimension: date {
    label: "Date Date (dd/mm/yyyy)"
    description: ""
    type: date
    sql: ${TABLE}.date ;;
  }
}
