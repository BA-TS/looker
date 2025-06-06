view: hyperfinity_transactions_count {
  derived_table: {
    explore_source: hyperfinity {
      bind_all_filters: yes
      column: customer_uid { field: customers.customer_uid }
      column: number_of_transactions { field: looker_hyperfinity_customer_spending_roll_up.number_of_transactions }
    }
  }
  dimension: customer_uid {
    description: ""
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: number_of_transactions {
    label: "Hyperfinity Number of months (Transacted)"
    description: ""
    type: number
    sql: ${TABLE}.number_of_transactions ;;
  }

  dimension: transacted {
    type: yesno
    sql: case when ${number_of_transactions}>0 then true else false end;;
  }

}
