
# include: "bdm.explore.lkml"

view: incremental {
  derived_table: {
    explore_source: bdm {
      column: total_net_sales { field: transactions.total_net_sales }
      column: total_margin_incl_funding { field: transactions.total_margin_incl_funding }
      column: spc_net_sales { field: transactions.spc_net_sales }
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month }
      column: bdm { field: bdm_ka_customers.bdm }
      column: team { field: bdm_ka_customers.team }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2022/08/14 to 2024/08/14"
      }
    }
  }

  dimension: total_net_sales {
    label: "Measures Net Sales"
    value_format_name: gbp_0
    type: number
    sql: ${TABLE}.total_net_sales ;;
  }

  dimension: total_margin_incl_funding {
    label: "Measures Margin (Including Funding)"
    value_format_name: gbp_0
    type: number
    sql: ${TABLE}.total_margin_incl_funding ;;
  }

  dimension: spc_net_sales {
    label: "Measures Spend Per Customer (Net sales)"
    value_format_name: gbp_0
    type: number
    sql: ${TABLE}.spc_net_sales ;;
  }

  dimension: calendar_year_month {
    label: "Date Year Month (yyyy-mm)"
    sql: ${TABLE}.calendar_year_month ;;
  }

  dimension: bdm {
    sql: ${TABLE}.bdm ;;
  }

  dimension: team {
    sql: ${TABLE}.team ;;
  }
}
