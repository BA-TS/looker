# include: "transactions.explore.lkml"

view: latest_run_customers_list {
  derived_table: {
    explore_source: base {
      column: is_latest_run_all { field: behaviour_categories_monthly_most_recent_all.is_latest_run_all }
      column: customer_uid { field: customers.customer_uid }
      column: final_segment_high_level { field: behaviour_categories_monthly.final_segment_high_level }
      column: cluster_low_level { field: behaviour_categories_monthly.cluster_low_level }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "NOT NULL"
      }
      filters: {
        field: calendar_completed_date.previous_fiscal_week
        value: "Yes"
      }
      filters: {
        field: behaviour_categories_monthly_most_recent_all.is_latest_run_all
        value: "Yes"
      }
    }
  }

  dimension: is_latest_run_all {
    label: "Hyperfinity Is Latest Run (Yes / No)"
    description: ""
    type: yesno
    hidden: yes
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    type: string
    description: ""
    hidden: yes
    primary_key: yes
  }

  dimension: final_segment_high_level2 {
    description: ""
    type: string
    sql: coalesce(${TABLE}.final_segment_high_level,"Unknown") ;;
  }

  dimension: cluster_low_level2 {
    description: ""
    type: string
    sql: coalesce(${TABLE}.cluster_low_level,"Unknown") ;;
  }


  dimension: in_customer_list {
    type: yesno
    sql: ${TABLE}.customer_uid is not null ;;
  }
}
