
view: incremental {
  derived_table: {
    explore_source: bdm {
      column: total_net_sales { field: transactions.total_net_sales }
      column: total_margin_incl_funding { field: transactions.total_margin_incl_funding }
      column: spc_net_sales { field: transactions.spc_net_sales }
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month2 }
      column: bdm { field: bdm_ka_customers.bdm }
      column: team { field: bdm_ka_customers.team }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2021/08/14 to 2024/08/14"
      }
    }
  }

  dimension: prim_key {
    type: string
    sql: concat(${bdm},${calendar_year_month}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: total_net_sales_dim {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.total_net_sales;;
    hidden: yes
  }

  dimension: total_margin_incl_funding_dim {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.total_margin_incl_funding ;;
    hidden: yes
  }

  dimension: spc_net_sales_dim {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.spc_net_sales ;;
    hidden: yes
  }

  dimension: PY_calendar_year_month {
    type: number
    sql: cast(${TABLE}.calendar_year_month as int) ;;
    hidden: yes
  }

  dimension: calendar_year_month {
    label: "PY - Date Year Month (yyyy-mm)"
    type: string
    sql: cast(${PY_calendar_year_month}+100 as string) ;;
  }

  dimension: bdm {
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: team {
    sql: ${TABLE}.team ;;
    hidden: yes
  }

  measure: total_net_sales {
    label: "PY - Net Sales"
    value_format_name: gbp
    type: sum
    sql: ${total_net_sales_dim};;
  }

  measure: incremental_net_sales {
    value_format_name: gbp
    type: number
    sql: ${transactions.total_net_sales}-${total_net_sales};;
  }

  measure: total_margin_incl_funding {
    label: "PY - Margin (Including Funding)"
    value_format_name: gbp
    type: sum
    sql: ${total_margin_incl_funding_dim} ;;
  }

  # measure: spc_net_sales {
  #   label: "PY - Spend Per Customer (Net sales)"
  #   value_format_name: gbp
  #   type: average
  #   sql: ${spc_net_sales_dim} ;;
  # }
}
