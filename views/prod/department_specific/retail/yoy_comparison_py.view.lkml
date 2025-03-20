view: yoy_comparison_py {
  derived_table: {
    explore_source: retail {
      column: site_uid { field: sites.site_uid }
      column: number_of_customers { field: customers.number_of_customers }
      column: aov_price { field: transactions.aov_price }
      column: py_date { field: calendar_completed_date.date }
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
    sql: concat(${site_uid},${py_date}) ;;
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

  dimension: py_date {
    label: "PY - Date "
    type: date
    sql: date(${TABLE}.py_date) ;;
    # hidden: yes
  }

  dimension: ty_date {
    label: "TY - Date "
    type: date
    sql: date_add(${py_date}, interval 1 year) ;;
    # hidden: yes
  }
}
