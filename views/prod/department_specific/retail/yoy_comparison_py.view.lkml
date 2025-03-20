view: yoy_comparison_py {
  fields_hidden_by_default: yes

  derived_table: {
    explore_source: retail {
      column: site_uid { field: sites.site_uid }
      column: number_of_customers { field: customers.number_of_customers }
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

}
