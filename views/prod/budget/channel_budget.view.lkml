view: channel_budget {
  sql_table_name:`toolstation-data-storage.ts_finance.channelBudget`;;

  dimension: channel_budget_in_query {
    hidden: yes
    sql:
      {% if
        channel_budget.channel_net_sales_budget._is_selected
        or channel_budget.channel_gross_profit_Excl_funding_budget._is_selected
        or channel_budget.channel_retro_funding_budget._is_selected
        or channel_budget.channel_fixed_funding_budget._is_selected
        or channel_budget.channel_gross_margin_inc_unit_funding_budget._is_selected
        or channel_budget.channel_gross_margin_inc_all_funding_budget._is_selected
      %}
      1
      {% else %}
      0
      {% endif %};;
  }

  dimension: channel {
    #hidden: yes
    label: "Channel"
    group_label: "Sales Channel"
    type: string
    sql: upper(${TABLE}.channel) ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: date_channel {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date||${channel} ;;
  }

  dimension: fixed_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.fixedFunding ;;
  }

  dimension: gross_profit {
    hidden: yes
    type: number
    sql: ${TABLE}.grossProfit ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.netSales ;;
    hidden: yes
  }

  dimension: retro_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.retroFunding ;;
  }

  measure: channel_net_sales_budget {
    label: "Net Sales Budget"
    description: "Budget - Net Sales at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${net_sales} ;;
    value_format_name: gbp
  }

  measure: channel_gross_profit_Excl_funding_budget {
    label: "Gross Profit Budget"
    description: "Budget - Gross Profit at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${gross_profit} ;;
    value_format_name: gbp
  }

  measure: channel_retro_funding_budget {
    label: "Retro Funding Budget"
    description: "Budget - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${retro_funding} ;;
    value_format_name: gbp
  }

  measure: channel_fixed_funding_budget {
    label: "Fixed Funding Budget"
    description: "Budget - fixed Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${fixed_funding} ;;
    value_format_name: gbp
  }

  measure: channel_gross_margin_inc_unit_funding_budget {
    label: "Gross Margin Inc Unit Funding Budget"
    description: "Budget - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: ${channel_gross_profit_Excl_funding_budget} + ${channel_retro_funding_budget}  ;;
    value_format_name: gbp
  }

  measure: channel_gross_margin_inc_all_funding_budget {
    label: "Gross Margin Inc All Funding Budget"
    description: "Budget - Gross Margin Inc All Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: ${channel_gross_profit_Excl_funding_budget} + ${channel_retro_funding_budget} + ${channel_fixed_funding_budget} ;;
    value_format_name: gbp
  }

  measure: channel_margin_rate_inc_retro_funding_budget {
    label: "Margin Rate Inc Retro Funding Budget"
    type: number
    group_label: "Sales Channel"
    sql:  SAFE_DIVIDE(${channel_gross_margin_inc_unit_funding_budget}, ${channel_net_sales_budget}) ;;
    value_format: "##0.0%;(##0.0%)"
  }
}
