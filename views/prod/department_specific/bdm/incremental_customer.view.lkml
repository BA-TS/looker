
view: incremental_customer {
  derived_table: {
    explore_source: bdm {
      column: total_net_sales { field: transactions.total_net_sales }
      column: total_margin_incl_funding { field: transactions.total_margin_incl_funding }
      column: spc_net_sales { field: transactions.spc_net_sales }
      column: py_date { field: calendar_completed_date.date }
      column: bdm { field: bdm_ka_customers.bdm }
      column: customer_uid { field: bdm_ka_customers.customer_uid }

      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2019/01/01 to 2031/08/14"
      }
      filters: {
        field: bdm_ka_customers.is_active
        value: "Yes"
      }
    }
  }

  dimension: prim_key {
    type: string
    sql: concat(${customer_uid},${bdm},${py_date}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: customer_uid {
    label: "Incremental Customer UID"
    type: string
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
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
    type: number
    sql: ${TABLE}.total_net_sales;;
    hidden: yes
  }

  dimension: py_date {
    label: "PY - Date "
    type: date
    sql: date(${TABLE}.py_date) ;;
    hidden: yes
  }

  dimension: ty_date {
    label: "TY - Date "
    type: date
    sql: date_add(${py_date}, interval 1 year) ;;
    hidden: yes
  }

  measure: total_net_sales {
    label: "PY - Net Sales"
    value_format_name: gbp_0
    type: sum
    sql: ${total_net_sales_dim};;
  }

  measure: total_customer_number {
    label: "PY - Number of Customers"
    type: count_distinct
    sql: ${customer_uid};;
  }

  measure: spc_net_sales {
    label: "PY - Spend Per Customer (Net sales)"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${total_net_sales}, ${total_customer_number}),0) ;;
    value_format_name: gbp_0
  }

  measure: incremental_spc {
    label: "Incremental SPC"
    type: number
    sql: ${transactions.spc_net_sales} - ${spc_net_sales} ;;
    value_format_name: gbp_0
  }

  measure: incremental_customer_number{
    label: "Incremental Customer Number"
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


}
