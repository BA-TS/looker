view: site_budget {
  derived_table: {
    sql:
      (SELECT
      date,
      CASE WHEN siteUID = 'RDS' THEN 'ZZ' ELSE siteUID END as siteUID,
      sum(AOP) AOP,
      sum(margin) margin,
      sum(COGs) COGs
      FROM `toolstation-data-storage.ts_finance.AOPBySiteAndDate`
      GROUP BY 1, 2);;
     datagroup_trigger: ts_monthly_datagroup
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

  dimension: margin {
    type: number
    sql: ${TABLE}.margin ;;
    hidden: yes
  }

  dimension: COGs {
    type: number
    sql: ${TABLE}.COGs ;;
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

  measure: site_net_sales_budget {
    label: "Net Sales Budget"
    description: "Budget Net Sales at Site level only"
    group_label: "Sites"
    type: sum
    sql: ${aop} ;;
    value_format_name: gbp
  }

  measure: site_margin_budget {
    label: "Margin Budget"
    description: "Budget Margin at Site level only"
    group_label: "Sites"
    type: sum
    sql: ${margin} ;;
    value_format_name: gbp
  }

  measure: site_COGs_budget {
    label: "COGs Budget"
    description: "Budget COGs at Site level only"
    group_label: "Sites"
    type: sum
    sql: ${COGs} ;;
    value_format_name: gbp
  }
}
