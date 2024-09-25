view: customers_spend_over75_previous_month {

  required_access_grants: [lz_testing]

  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      column: date_first_day_month { field: calendar_completed_date.date_first_day_month }
      column: spc_gross_sales { field: transactions.spc_gross_sales }
      column: total_gross_sales { field: transactions.total_gross_sales }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2024"
      }
    }
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: date_first_day_month  {
    label: "Prev Month (test)"
    sql:  ${TABLE}.date_first_day_month ;;
    hidden: yes
  }

  dimension: spc_gross_sales {
    group_label: "Loyalty Club"
    type: number
    sql: ${TABLE}.total_gross_sales;;
    hidden: yes
  }

  dimension: over_loyalty_club_threshold {
    label: "Over Loyalty Club Threshold (Prev Month)"
    group_label: "Loyalty Club"
    type: yesno
    sql: ${spc_gross_sales}>=75;;
  }
}
