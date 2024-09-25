view: customers_spend_over75_previous_month {

  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2024"
      }
      filters: {
        field: spc_buckets_customers.spend_per_customer_buckets75
        value: "75 or Above"
      }
    }
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    sql: ${TABLE}.customer_uid ;;
  }

  dimension: calendar_year_prev_month {
    label: "Prev Month"
    sql:  ${TABLE}.calendar_year_month;;
  }

  dimension: calendar_year_month {
    type: date
    sql: date_add(${calendar_year_prev_month}, interval 1 month) ;;
    hidden: yes
  }

  dimension: over_loyalty_club_threshold {
    group_label: "Loyalty Club"
    type: yesno
    sql: ${TABLE}.customer_uid is not null;;
  }
}
