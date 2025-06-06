view: customers_with_transactions {
  derived_table: {
    explore_source: hyperfinity {
      bind_all_filters: yes
      column: customer_uid { field: customers.customer_uid }
      column: date { field: calendar_completed_date.date }
    }
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: customer_made_a_transaction {
    sql: ${customer_uid} is not null ;;
    type: yesno
  }


  dimension: date {
    label: "Date Date (dd/mm/yyyy)"
    description: ""
    type: date
    sql: ${TABLE}.date ;;
  }
}
