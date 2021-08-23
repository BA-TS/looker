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
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: fixed_funding {
    type: number
    sql: ${TABLE}.fixedFunding ;;
  }

  dimension: gross_margin_inc_retro {
    type: number
    sql: ${TABLE}.grossMarginIncRetro ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.netSales ;;
  }
}
