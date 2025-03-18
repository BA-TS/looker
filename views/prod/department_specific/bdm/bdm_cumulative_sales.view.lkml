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
        value: "this year"
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

  dimension: yearMonth {
    hidden: yes
    sql: ${TABLE}.calendar_year_month ;;
  }

  dimension: total_net_sales {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.total_net_sales ;;
  }

  dimension: bdm {
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: ytd_net_sales {
    label: "YTD Net Sales"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.bdm ;;
  }
}
