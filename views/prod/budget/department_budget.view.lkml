
view: category_budget {
  sql_table_name:

  `toolstation-data-storage.ts_finance.categoryBudget`

  ;;

  fields_hidden_by_default: yes

  dimension: category_budget_in_query {
    hidden: yes
    sql:
      {% if
        category_budget.department_net_sales_budget._in_query
        or category_budget.department_margin_inc_Retro_funding_budget._in_query
        or category_budget.department_margin_inc_all_funding_budget._in_query
        or category_budget.department_margin_rate_inc_retro_funding_budget._in_query
      %}
      TRUE
      {% else %}
      FALSE
      {% endif %};;
  }

  dimension: date {
    hidden: yes
    type: date
    sql: ${TABLE}.date ;;
  }
  dimension: date_department_pkey {
    type:  string
    primary_key: yes
    hidden: yes
    sql: ${date}||${department} ;;
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
    label: "Net Sales Budget"
    description: "Budget Net Sales at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${net_sales} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: department_margin_inc_Retro_funding_budget {
    label: "Margin Inc Retro Funding Budget"
    description: "Budget Margin Inc Retro Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: department_margin_inc_all_funding_budget {
    label: "Margin Inc All Funding Budget"
    description: "Budget Margin Inc Retro & Fixed Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro} + ${fixed_funding} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: department_margin_rate_inc_retro_funding_budget {
    label: "Margin Rate Inc Retro Funding Budget"
    type: number
    group_label: "Department"
    sql:  sum(${gross_margin_inc_retro}) / sum(${net_sales}) ;;
    value_format: "##0.0%;(##0.0%)"
  }

}
