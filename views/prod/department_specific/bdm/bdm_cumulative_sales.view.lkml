view: bdm_cumulative_sales {
  derived_table: {
    explore_source: bdm {
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month }
      column: total_net_sales { field: transactions.total_net_sales }
      column: bdm { field: bdm_ka_customers.bdm }
      derived_column: ytd_net_sales {
        sql: sum(total_net_sales)over partition by bdm order by calendar_year_month) ;;
      }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2025"
      }
      filters: {
        field: bdm_ka_customers.team
        value: ""
      }
      filters: {
        field: bdm_ka_customers.bdm
        value: "-NULL"
      }
    }
  }

  dimension: calendar_year_month {
    label: "Date Year Month (yyyy-mm)"
    description: ""
  }

  dimension: total_net_sales {
    label: "Measures Net Sales"
    description: "Sales value excluding VAT"
    value_format_name: gbp
    type: number
  }

  dimension: bdm {
    label: "Teams Name"
    description: ""
    sql: ${TABLE}.bdm ;;
  }

}
