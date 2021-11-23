view: site_budget {
  sql_table_name:

  `toolstation-data-storage.ts_finance.site_budget`

  ;;

  # fields_hidden_by_default: yes

  dimension: site_budget_in_query {
    hidden: yes
    sql:
      {% if site_budget.site_net_sales_budget._in_query %}
      TRUE
      {% else %}
      FALSE
      {% endif %};;

    }

  dimension: aop {
    type: number
    sql: ${TABLE}.AOP ;;
    hidden: yes
  }
  dimension: raw_date {
    hidden: yes
    type: date
    sql: ${TABLE}.date ;;
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
    label: "Net Sales Budget"
    description: "Budget Net Sales at Site level only"
    group_label: "Sites"
    type: sum
    sql: ${aop} ;;
    value_format_name: gbp
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
