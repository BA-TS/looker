view: yoy_comparison {
  derived_table: {
    explore_source: retail {
      column: site_uid { field: sites.site_uid }
      column: number_of_customers { field: customers.number_of_customers }
      column: total_net_sales { field: transactions.total_net_sales }
      column: number_of_transactions { field: transactions.number_of_transactions }
      column: total_units { field: transactions.total_units }
      column: calendar_year { field: calendar_completed_date.calendar_year }
      column: month_in_year { field: calendar_completed_date.month_in_year }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "this year"
      }
    }
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
  }

  dimension: calendar_year {
    type: number
    sql: ${TABLE}.calendar_year ;;
    hidden: yes
  }

  dimension: month_in_year {
    type: number
    sql: ${TABLE}.month_in_year ;;
    hidden: yes
  }

  dimension: prim_key {
    type: string
    sql: concat(${site_uid},${month_in_year},${calendar_year}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: number_of_customers_dim {
    type: number
    sql: ${TABLE}.number_of_customers ;;
    hidden: yes
  }

  measure: number_of_customers {
    type: sum
    sql: ${number_of_customers_dim} ;;
    hidden: yes
  }

  measure: number_of_customers_py {
    type: sum
    sql: ${yoy_comparison_py.number_of_customers} ;;
    hidden: yes
  }

  measure: number_of_customers_yoy2 {
    type: number
    value_format_name: percent_2
    label: "Number of Customers YOY"
    sql: safe_divide(${number_of_customers}-${number_of_customers_py},${number_of_customers_py}) ;;
  }

  dimension: total_net_sales_dim {
    type: number
    sql: ${TABLE}.total_net_sales ;;
    hidden: yes
  }

  measure: total_net_sales {
    type: sum
    sql: ${total_net_sales_dim} ;;
    hidden: yes
  }

  dimension: number_of_transactions_dim {
    type: number
    sql: ${TABLE}.number_of_transactions ;;
    hidden: yes
  }

  measure: number_of_transactions {
    type: sum
    sql: ${number_of_transactions_dim} ;;
    hidden: yes
  }

  dimension: total_units_dim {
    type: number
    sql: ${TABLE}.total_units ;;
    hidden: yes
  }

  measure: total_units {
    type:  sum
    sql: ${total_units_dim};;
    hidden: yes
  }

  measure: aov_price{
    type: number
    label: "Net ASP"
    sql: COALESCE(SAFE_DIVIDE(SAFE_DIVIDE(${total_net_sales}, ${number_of_transactions}), SAFE_DIVIDE(${total_units}, ${number_of_transactions})),0) ;;
    value_format_name: gbp
  }

  measure: aov_price_yoy {
    type: number
    value_format_name: percent_2
    label: "ASP YOY"
    sql: safe_divide(${aov_price}-${yoy_comparison_py.aov_price},${yoy_comparison_py.aov_price}) ;;
  }
}
