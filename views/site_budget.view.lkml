view: site_budget {
  sql_table_name: `toolstation-data-storage.ts_finance.site_budget`
    ;;

  dimension: aop {
    type: number
    sql: ${TABLE}.AOP ;;
    hidden: yes
  }

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

  dimension: date_site  {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${date_date}||${site_uid} ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  measure: site_net_sales_budget {
    type: sum
    sql: ${aop} ;;
  }
}
