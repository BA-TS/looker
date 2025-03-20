view: yoy_comparison {
  derived_table: {
    explore_source: retail {
      column: site_uid { field: sites.site_uid }
      column: number_of_customers { field: customers.number_of_customers }
      column: aov_price { field: transactions.aov_price }
      # column: py_date { field: calendar_completed_date.date }
      column: calendar_year_month2 { field: calendar_completed_date.today_calendar_year_month2 }
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
    sql: concat(${site_uid},${calendar_year_month2}) ;;
    hidden: yes
    primary_key: yes
  }

  # dimension: ty_date {
  #   label: "TY - Date "
  #   type: date
  #   sql: date(${TABLE}.py_date) ;;
  #   # hidden: yes
  # }

  dimension: number_of_customers {
    type: number
    sql: ${TABLE}.number_of_customers ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
  }

  dimension: calendar_year_month2 {
    type: number
    sql: ${TABLE}.calendar_year_month2 ;;
  }

  dimension: number_of_customers_yoy {
    type: number
    value_format_name: percent_1
    sql: safe_divide((${number_of_customers}-${yoy_comparison_py.number_of_customers},${yoy_comparison_py.number_of_customers}) ;;
  }

  dimension: aov_price {
    label: "Net ASP (PY)"
    type: number
    sql: ${TABLE}.aov_price ;;
    value_format_name: gbp
  }

  dimension: aov_price_yoy {
    type: number
    value_format_name: percent_1
    sql: safe_divide((${aov_price}-${yoy_comparison_py.aov_price},${yoy_comparison_py.aov_price}) ;;
  }

}
