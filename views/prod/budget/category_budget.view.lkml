view: category_budget {
  derived_table: {
   sql:
   select * from
  `toolstation-data-storage.ts_finance.categoryBudget`;;
  datagroup_trigger: ts_monthly_datagroup
  }

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
    description: "Date"
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
    value_format_name: gbp
  }

  measure: department_margin_inc_Retro_funding_budget {
    label: "Margin Inc Retro Funding Budget"
    description: "Budget Margin Inc Retro Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro} ;;
    value_format_name: gbp
  }

  measure: department_margin_inc_all_funding_budget {
    label: "Margin Inc All Funding Budget"
    description: "Budget Margin Inc Retro & Fixed Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro} + ${fixed_funding} ;;
    value_format_name: gbp
  }

  measure: department_margin_rate_inc_retro_funding_budget {
    label: "Margin Rate Inc Retro Funding Budget"
    type: number
    group_label: "Department"
    sql:  sum(${gross_margin_inc_retro}) / sum(${net_sales}) ;;
    value_format: "##0.0%;(##0.0%)"
  }

  measure: department_cogs_inc_retro_funding_budget {
    label: "COGS Inc Retro Funding Budget"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_budget} - ${department_margin_inc_Retro_funding_budget} ;;
    value_format_name: gbp
  }

  measure: department_cogs_inc_all_funding_budget {
    label: "COGS Inc All Funding Budget"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_budget} - ${department_margin_inc_all_funding_budget} ;;
    value_format_name: gbp
  }

  measure: department_fixed_funding_budget {
    label: "Fixed Funding Budget"
    type: sum
    group_label: "Department"
    sql: ${fixed_funding} ;;
    value_format_name: gbp
  }

  dimension: fixed_funding_rf1 {
    hidden: yes
    type: number
    sql: ${TABLE}.rf1.fixedFunding ;;
  }

  dimension: gross_margin_inc_retro_rf1 {
    hidden: yes
    type: number
    sql: ${TABLE}.rf1.grossMarginIncRetro ;;
  }

  dimension: net_sales_rf1 {
    type: number
    sql: ${TABLE}.rf1.netSales ;;
    hidden:  yes
  }

  measure: department_net_sales_rf1 {
    label: "Net Sales RF1"
    description: "RF1 Net Sales at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${net_sales_rf1} ;;
    value_format_name: gbp
  }

  measure: department_margin_inc_Retro_funding_rf1 {
    label: "Margin Inc Retro Funding RF1"
    description: "RF1 Margin Inc Retro Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro_rf1} ;;
    value_format_name: gbp
  }

  measure: department_margin_inc_all_funding_rf1 {
    label: "Margin Inc All Funding RF1"
    description: "RF1 Margin Inc Retro & Fixed Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro_rf1} + ${fixed_funding_rf1} ;;
    value_format_name: gbp
  }

  measure: department_margin_rate_inc_retro_funding_rf1 {
    label: "Margin Rate Inc Retro Funding rf1"
    type: number
    group_label: "Department"
    sql:  sum(${gross_margin_inc_retro_rf1}) / sum(${net_sales_rf1}) ;;
    value_format: "##0.0%;(##0.0%)"
  }

  measure: department_cogs_inc_retro_funding_rf1 {
    label: "COGS Inc Retro Funding RF1"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_rf1} - ${department_margin_inc_Retro_funding_rf1} ;;
    value_format_name: gbp
  }

  measure: department_cogs_inc_all_funding_rf1 {
    label: "COGS Inc All Funding rf1"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_rf1} - ${department_margin_inc_all_funding_rf1} ;;
    value_format_name: gbp
  }

  measure: department_fixed_funding_rf1 {
    label: "Fixed Funding RF1"
    type: sum
    group_label: "Department"
    sql: ${fixed_funding_rf1} ;;
    value_format_name: gbp
  }

  dimension: fixed_funding_rf2 {
    hidden: yes
    type: number
    sql: ${TABLE}.rf2.fixedFunding ;;
  }

  dimension: gross_margin_inc_retro_rf2 {
    hidden: yes
    type: number
    sql: ${TABLE}.rf2.grossMarginIncRetro ;;
  }

  dimension: net_sales_rf2 {
    type: number
    sql: ${TABLE}.rf2.netSales ;;
    hidden:  yes
  }

  measure: department_net_sales_rf2 {
    label: "Net Sales RF2"
    description: "RF2 Net Sales at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${net_sales_rf2} ;;
    value_format_name: gbp
  }

  measure: department_margin_inc_Retro_funding_rf2 {
    label: "Margin Inc Retro Funding RF2"
    description: "RF2 Margin Inc Retro Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro_rf2} ;;
    value_format_name: gbp
  }

  measure: department_margin_inc_all_funding_rf2 {
    label: "Margin Inc All Funding RF2"
    description: "RF2 Margin Inc Retro & Fixed Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro_rf2} + ${fixed_funding_rf2} ;;
    value_format_name: gbp
  }

  measure: department_margin_rate_inc_retro_funding_rf2 {
    label: "Margin Rate Inc Retro Funding rf2"
    type: number
    group_label: "Department"
    sql:  sum(${gross_margin_inc_retro_rf2}) / sum(${net_sales_rf2}) ;;
    value_format: "##0.0%;(##0.0%)"
  }

  measure: department_cogs_inc_retro_funding_rf2 {
    label: "COGS Inc Retro Funding RF2"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_rf2} - ${department_margin_inc_Retro_funding_rf2} ;;
    value_format_name: gbp
  }

  measure: department_cogs_inc_all_funding_rf2 {
    label: "COGS Inc All Funding rf2"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_rf2} - ${department_margin_inc_all_funding_rf2} ;;
    value_format_name: gbp
  }

  measure: department_fixed_funding_rf2 {
    label: "Fixed Funding RF2"
    type: sum
    group_label: "Department"
    sql: ${fixed_funding_rf2} ;;
    value_format_name: gbp
  }

  dimension: fixed_funding_rf3 {
    hidden: yes
    type: number
    sql: ${TABLE}.rf3.fixedFunding ;;
  }

  dimension: gross_margin_inc_retro_rf3 {
    hidden: yes
    type: number
    sql: ${TABLE}.rf3.grossMarginIncRetro ;;
  }

  dimension: net_sales_rf3 {
    type: number
    sql: ${TABLE}.rf3.netSales ;;
    hidden:  yes
  }

  measure: department_net_sales_rf3 {
    label: "Net Sales RF3"
    description: "RF3 Net Sales at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${net_sales_rf3} ;;
    value_format_name: gbp
  }

  measure: department_margin_inc_Retro_funding_rf3 {
    label: "Margin Inc Retro Funding RF3"
    description: "RF3 Margin Inc Retro Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro_rf3} ;;
    value_format_name: gbp
  }

  measure: department_margin_inc_all_funding_rf3 {
    label: "Margin Inc All Funding RF3"
    description: "RF3 Margin Inc Retro & Fixed Funding at Department level only"
    group_label: "Department"
    type:  sum
    sql: ${gross_margin_inc_retro_rf3} + ${fixed_funding_rf3} ;;
    value_format_name: gbp
  }

  measure: department_margin_rate_inc_retro_funding_rf3 {
    label: "Margin Rate Inc Retro Funding rf3"
    type: number
    group_label: "Department"
    sql:  sum(${gross_margin_inc_retro_rf3}) / sum(${net_sales_rf3}) ;;
    value_format: "##0.0%;(##0.0%)"
  }

  measure: department_cogs_inc_retro_funding_rf3 {
    label: "COGS Inc Retro Funding RF3"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_rf3} - ${department_margin_inc_Retro_funding_rf3} ;;
    value_format_name: gbp
  }

  measure: department_cogs_inc_all_funding_rf3 {
    label: "COGS Inc All Funding rf3"
    type: number
    group_label: "Department"
    sql: ${department_net_sales_rf3} - ${department_margin_inc_all_funding_rf3} ;;
    value_format_name: gbp
  }

  measure: department_fixed_funding_rf3 {
    label: "Fixed Funding RF3"
    type: sum
    group_label: "Department"
    sql: ${fixed_funding_rf3} ;;
    value_format_name: gbp
  }
}
