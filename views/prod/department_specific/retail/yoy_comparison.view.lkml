view: yoy_comparison {
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
        value: ""
      }
    }
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
  }

  dimension: number_of_customers {
    label: "Number of Customers (PY)"
    type: number
    sql: ${TABLE}.number_of_customers ;;
  }

  dimension: aov_price {
    label: "Net ASP (PY)"
    type: number
    sql: ${TABLE}.aov_price ;;
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
