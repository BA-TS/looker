view: yoy_comparison_py {
required_access_grants: [lz_only]

  derived_table: {
    explore_source: retail {
      column: site_uid { field: sites.site_uid }
      column: number_of_customers { field: customers.number_of_customers }
      # column: total_net_sales { field: customers.total_net_sales }
      # column: number_of_transactions { field: customers.number_of_transactions }
      column: aov_price { field: transactions.aov_price }
      column: py_calendar_year { field: calendar_completed_date.calendar_year }
      column: month_in_year { field: calendar_completed_date.month_in_year }

      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "2019/01/01 to 2031/08/14"
      }
    }
  }

  dimension: prim_key {
    type: string
    sql: concat(${site_uid},${month_in_year},${calendar_year}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
  }

  dimension: number_of_customers {
    type: number
    sql: ${TABLE}.number_of_customers ;;
    hidden: yes
  }

  measure: total_number_of_customers {
    label: "Number of Customers (PY)"
    type: sum
    sql: ${number_of_customers} ;;
  }

  dimension: aov_price {
    label: "Net ASP (PY)"
    type: number
    sql: ${TABLE}.aov_price ;;
    value_format_name: gbp
  }

  dimension: py_calendar_year {
    type: number
    sql: ${TABLE}.py_calendar_year ;;
  }

  dimension: calendar_year {
    type: number
    sql: ${py_calendar_year}+1;;
  }

  dimension: month_in_year {
    type: number
    sql: ${TABLE}.month_in_year ;;
  }

  dimension: total_net_sales_dim {
    type: number
    sql: ${TABLE}.total_net_sales ;;
    hidden: yes
  }

  dimension: number_of_transactions_dim {
    type: number
    sql: ${TABLE}.number_of_transactions ;;
    hidden: yes
  }

  measure: total_net_sales {
    type: sum
    sql: ${total_net_sales_dim} ;;
    hidden: yes
  }

  measure: number_of_transactions {
    type: sum
    sql: ${number_of_transactions_dim} ;;
    hidden: yes
  }

  measure: aov_net_sales {
    label: "Net Sales AOV"
    view_label: "Measures"
    group_label: "AOV"
    description: "Average net sales per order"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_net_sales}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
    hidden: yes
  }

}
