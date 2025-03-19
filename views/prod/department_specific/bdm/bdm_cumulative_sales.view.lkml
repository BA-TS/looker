# include: "bdm.explore.lkml"

view: bdm_cumulative_sales {

  derived_table: {
    explore_source: bdm {
      # bind_all_filters: yes
      column: ty_date { field: calendar_completed_date.date }
      column: total_net_sales { field: transactions.total_net_sales }
      column: bdm { field: bdm_ka_customers.bdm }
      # derived_column: ytd_net_sales {
      #   sql: sum(total_net_sales) over (partition by bdm order by calendar_year_month) ;;
      # }
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

  dimension: prim_key {
    type: string
    sql: concat(${bdm},${ty_date}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: ty_date {
    type: string
    # hidden: yes
    sql: ${TABLE}.ty_date ;;
  }

  dimension: total_net_sales {
    value_format_name: gbp
    type: date
    sql: ${TABLE}.ty_date ;;
  }

  dimension: bdm {
    type: string
    sql: ${TABLE}.bdm ;;
    # hidden: yes
  }

  dimension: ytd_net_sales {
    label: "YTD Net Sales"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.bdm ;;
  }
}
