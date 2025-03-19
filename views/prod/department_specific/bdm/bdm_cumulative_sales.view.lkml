view: bdm_cumulative_sales {

  derived_table: {
    explore_source: bdm {
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month }
      column: total_net_sales { field: transactions.total_net_sales }
      column: bdm { field: bdm_ka_customers.bdm }
      column: target_YTD { field: targets.target_YTD }
      derived_column: ytd_net_sales {
        sql: sum(total_net_sales) over (partition by bdm order by calendar_year_month) ;;
      }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "this year"
      }
    }
  }

  dimension: ty_calendar_year_month {
    label: "Date Year Month (yyyy-mm)"
    description: ""
    type: string
    sql: cast(${TABLE}.calendar_year_month as string);;
    hidden: yes
  }

  dimension: total_net_sales {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.total_net_sales ;;
    hidden: yes
  }

  dimension: bdm {
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: ytd_net_sales {
    label: "Net Sales (YTD)"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.ytd_net_sales ;;
  }

  dimension: target_YTD {
    type: number
    label: "Target (YTD)"
    value_format_name: gbp
    hidden: yes
    sql: ${TABLE}.target_YTD ;;
  }

  dimension: target_vs_net_sales_dim {
    type: number
    value_format_name: gbp
    # hidden: yes
    sql: ${ytd_net_sales} - ${target_YTD} ;;
  }

  measure: target_vs_net_sales {
    type: sum
    value_format_name: gbp
    sql: ${target_vs_net_sales_dim} ;;
  }
}
