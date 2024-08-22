
view: incremental {
  derived_table: {
    explore_source: bdm {
      column: total_net_sales { field: transactions.total_net_sales }
      column: total_margin_incl_funding { field: transactions.total_margin_incl_funding }
      column: spc_net_sales { field: transactions.spc_net_sales }
      column: calendar_year_month { field: calendar_completed_date.calendar_year_month2 }
      column: bdm { field: bdm_ka_customers.bdm }
      column: number_of_customers { field: bdm_ka_customers.number_of_customers }
      # column: customer_uid { field: bdm_ka_customers.customer_uid }

      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2021/08/14 to 2024/08/14"
      }
      filters: {
        field: bdm_ka_customers.is_active
        value: "Yes"
      }
      filters: {
        field: bdm_ka_customers.team
        value: "BDM"
      }
    }
  }

  # dimension: prim_key {
  #   type: string
  #   sql: concat(${customer_uid},${calendar_year_month}) ;;
  #   hidden: yes
  #   primary_key: yes
  # }

  # dimension: customer_uid {
  #   type: string
  #   sql: ${TABLE}.customer_uid ;;
  #   hidden: yes
  # }

  dimension: prim_key {
    type: string
    sql: concat(${bdm},${calendar_year_month}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: bdm {
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: number_of_customers {
    sql: ${TABLE}.number_of_customers ;;
    hidden: yes
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
    hidden: yes
  }

  measure: total_net_sales {
    label: "PY - Net Sales"
    value_format_name: gbp
    type: sum
    sql: ${total_net_sales_dim};;
  }

  measure: total_customer_number {
    label: "PY - Number of Customers"
    type: sum
    sql: ${number_of_customers};;
  }

  measure: spc_net_sales {
    label: "PY - Spend Per Customer (Net sales)"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${total_net_sales}, ${total_customer_number}),0) ;;
    value_format_name: decimal_2
  }

  measure: incremental_spc {
    label: "Incremental SPC"
    type: number
    sql: ${transactions.spc_net_sales} - ${spc_net_sales} ;;
    value_format_name: decimal_2
  }

  measure: incremental_customer_number{
    type: number
    sql: ${bdm_ka_customers.number_of_customers}-${total_customer_number};;
    value_format_name: decimal_0
  }

  measure: incremental_net_sales {
    description: "Net Sale of TY - Net Sale of PY"
    value_format_name: gbp_0
    type: number
    sql: ${transactions.total_net_sales}-${total_net_sales};;
  }

  measure: total_margin_incl_funding {
    label: "PY - Margin"
    description: "PY- Margin incl Funding"
    value_format_name: gbp_0
    type: sum
    sql: ${total_margin_incl_funding_dim} ;;
  }

  measure: incremental_margin {
    description: "Margin incl Funding TY - Margin incl Funding PY"
    value_format_name: gbp_0
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
