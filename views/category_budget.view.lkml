view: category_budget {
  sql_table_name: `toolstation-data-storage.ts_finance.categoryBudget`
    ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    hidden: yes
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: date_department_pkey {
    type:  string
    primary_key: yes
    hidden: yes
    sql: ${date_date}||${department} ;;
  }

  dimension: department {
    hidden: yes
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: fixed_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.fixedFunding ;;
  }

  dimension: gross_margin_inc_retro {
    hidden: yes
    type: number
    sql: ${TABLE}.grossMarginIncRetro ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.netSales ;;
    hidden:  yes
  }

  measure: department_net_sales_budget {
    description: "Budget Net Sales at Department level only"
    type:  sum
    sql: ${net_sales} ;;
  }

  measure: department_margin_inc_all_funding_budget {
    description: "Budget Margin Inc Retro at Department level only"
    type:  sum
    sql: ${gross_margin_inc_retro} + ${fixed_funding} ;;
  }


}
