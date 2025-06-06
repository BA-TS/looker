view: most_recent_run_by_period {
  derived_table: {
    explore_source: hyperfinity {
      bind_all_filters: yes
      # column: customer_uid { field: customers.customer_uid }
      column: last_date_period { field: calendar_completed_date.last_date_period }
    }
  }

  # dimension: customer_uid {
  #   label: "Customers Customer UID"
  #   description: ""
  #   hidden: yes
  #   sql: ${TABLE}.customer_uid ;;
  # }

  dimension: last_date_period {
    label: "Date Last Date Period"
    description: ""
    type: date
    sql: ${TABLE}.last_date_period ;;
    hidden: yes
  }

  dimension: use_latest {
    type: yesno
    sql: ${last_date_period} is not null ;;
  }

}
