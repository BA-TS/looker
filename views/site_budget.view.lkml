view: site_budget {
  sql_table_name: `toolstation-data-storage.ts_finance.site_budget`
    ;;

  dimension: aop {
    type: number
    sql: ${TABLE}.AOP ;;
    hidden: yes
  }

  dimension_group: date {
    hidden: yes
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
    hidden: yes
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  measure: site_net_sales_budget {
    description: "Budget Net Sales at Site level only"
    type: sum
    sql: ${aop} ;;
  }

  # measure: site_net_sales_budget_liquid {
  #   description: "Budget Net Sales at Site level only (liquid)"
  #   type: sum
  #   sql: {% if sites._in_query %}
  #           ${aop}
  #         {% else %}
  #           0
  #         {% endif %} ;;
  # }

}
