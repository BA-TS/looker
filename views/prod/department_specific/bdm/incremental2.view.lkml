
view: incremental2 {
  derived_table: {
    explore_source: bdm {
      column: total_net_sales { field: transactions.total_net_sales }
      column: py_date { field: calendar_completed_date.date }
      column: customer_uid { field: bdm_ka_customers.customer_uid }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2022/01/01 to 2031/08/14"
      }
    }
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: prim_key {
    type: string
    sql: concat(${customer_uid},${py_date}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: total_net_sales_dim {
    value_format_name: gbp
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

  measure: incremental_net_sales {
    description: "Net Sale of TY - Net Sale of PY"
    value_format_name: gbp_0
    type: number
    sql: ${transactions.total_net_sales}-${total_net_sales};;
  }
}
