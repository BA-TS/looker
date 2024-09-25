view: customers_spend_over75_previous_month {

  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      column: date_first_day_prev_month { field: calendar_completed_date.date_first_day_prev_month }
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

  dimension: date_first_day_prev_month  {
    label: "Prev Month"
    sql:  ${TABLE}.date_first_day_prev_month ;;
  }

  dimension: over_loyalty_club_threshold {
    group_label: "Loyalty Club"
    type: yesno
    sql: ${TABLE}.customer_uid is not null;;
  }
}
