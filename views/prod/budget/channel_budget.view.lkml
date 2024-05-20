view: channel_budget {
  derived_table: {
    sql: SELECT distinct row_number() over () as PK, date,
-- HEAD
case when channel in ("NEXT DAY C&C") then "CLICK & COLLECT" else channel end as channel,
sum(netSales) as netSales,
sum(grossProfit) as grossProfit,
sum(retroFunding) as retroFunding,
sum(fixedFunding) as fixedFunding,
sum(rf1.netSales) as rf1_netSales,
sum(rf1.grossProfit) as rf1_grossProfit,
sum(rf1.retroFunding) as rf1_retroFunding,
sum(rf1.fixedFunding) as rf1_fixedFunding,
sum(rf2.netSales) as rf2_netSales,
sum(rf2.grossProfit) as rf2_grossProfit,
sum(rf2.retroFunding) as rf2_retroFunding,
sum(rf2.fixedFunding) as rf2_fixedFunding,
sum(rf3.netSales) as rf3_netSales,
sum(rf3.grossProfit) as rf3_grossProfit,
sum(rf3.retroFunding) as rf3_retroFunding,
sum(rf3.fixedFunding) as rf3_fixedFunding
from`toolstation-data-storage.ts_finance.channelBudget`
group by 2,3;;

    # case when channel in ("NEXT DAY C&C") then "CLICK & COLLECT" else channel end as channel,
    # sum(netSales) as netSales,
    # sum(grossProfit) as grossProfit,
    # sum(retroFunding) as retroFunding,
    # sum(fixedFunding) as retroFunding,
    # sum(rf1.netSales) as rf1_netSales,
    # sum(rf1.grossProfit) as rf1_grossProfit,
    # sum(rf1.retroFunding) as rf1_retroFunding,
    # sum(rf1.fixedFunding) as rf1_fixedFunding,
    # sum(rf2.netSales) as rf2_netSales,
    # sum(rf2.grossProfit) as rf2_grossProfit,
    # sum(rf2.retroFunding) as rf2_retroFunding,
    # sum(rf2.fixedFunding) as rf2_fixedFunding,
    # sum(rf3.netSales) as rf3_netSales,
    # sum(rf3.grossProfit) as rf3_grossProfit,
    # sum(rf3.retroFunding) as rf3_retroFunding,
    # sum(rf3.fixedFunding) as rf3_fixedFunding
    # from`toolstation-data-storage.ts_finance.channelBudget`
    # group by 2,3;;
    datagroup_trigger: ts_monthly_datagroup
# branch 'master' of git@github.com:BA-TS/looker.git
}
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

  dimension: P_K {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.PK ;;
  }

  dimension: channel {
    #hidden: yes
    label: "Channel"
    group_label: "Sales Channel"
    description: "Sales Channel where budget has been detirmined"
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

  dimension: rf2_fixed_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.rf2_fixedFunding ;;
  }

  dimension: rf2_gross_profit {
    hidden: yes
    type: number
    sql: ${TABLE}.rf2_grossProfit ;;
  }

  dimension: rf2_net_sales {
    type: number
    sql: ${TABLE}.rf2_netSales ;;
    hidden: yes
  }

  dimension: rf2_retro_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.rf2_retroFunding ;;
  }

  measure: rf2_channel_net_sales_budget {
    label: "Net Sales RF2"
    description: "RF2 - Net Sales at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf2_net_sales} ;;
    value_format_name: gbp
  }

  measure: rf2_channel_gross_profit_Excl_funding_budget {
    label: "Gross Profit RF2"
    description: "RF2 - Gross Profit at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf2_gross_profit} ;;
    value_format_name: gbp
  }

  measure: channel_retro_funding_rf2 {
    label: "Retro Funding RF2"
    description: "RF2 - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf2_retro_funding} ;;
    value_format_name: gbp
  }

  measure: channel_fixed_funding_rf2 {
    label: "Fixed Funding RF2"
    description: "RF2 - fixed Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf2_fixed_funding} ;;
    value_format_name: gbp
  }

  measure: channel_gross_margin_inc_unit_funding_RF2 {
    label: "Gross Margin Inc Unit Funding RF2"
    description: "RF2 - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: ${rf2_channel_gross_profit_Excl_funding_budget} + ${channel_retro_funding_rf2}  ;;
    value_format_name: gbp
  }

  measure: channel_gross_margin_inc_all_funding_rf2 {
    label: "Gross Margin Inc All Funding RF2"
    description: "RF2 - Gross Margin Inc All Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: ${rf2_channel_gross_profit_Excl_funding_budget} + ${channel_retro_funding_rf2} + ${channel_fixed_funding_rf2} ;;
    value_format_name: gbp
  }

  measure: channel_margin_rate_inc_retro_funding_rf2 {
    label: "Margin Rate Inc Retro Funding RF2"
    type: number
    group_label: "Sales Channel"
    sql:  SAFE_DIVIDE(${channel_gross_margin_inc_unit_funding_RF2}, ${rf2_channel_net_sales_budget}) ;;
    value_format: "##0.0%;(##0.0%)"
  }

  dimension: rf3_fixed_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.rf3_fixedFunding ;;
  }

  dimension: rf3_gross_profit {
    hidden: yes
    type: number
    sql: ${TABLE}.rf3_grossProfit ;;
  }

  dimension: rf3_net_sales {
    type: number
    sql: ${TABLE}.rf3_netSales ;;
    hidden: yes
  }

  dimension: rf3_retro_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.rf3_retroFunding ;;
  }

  measure: channel_net_sales_rf3 {
    label: "Net Sales RF3"
    description: "RF3 - Net Sales at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf3_net_sales} ;;
    value_format_name: gbp
  }

  measure: channel_gross_profit_Excl_funding_rf3 {
    label: "Gross Profit RF3"
    description: "RF3 - Gross Profit at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf3_gross_profit} ;;
    value_format_name: gbp
  }

  measure: channel_retro_funding_rf3 {
    label: "Retro Funding RF3"
    description: "RF3 - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf3_retro_funding} ;;
    value_format_name: gbp
  }

  measure: channel_fixed_funding_rf3 {
    label: "Fixed Funding RF3"
    description: "RF3 - fixed Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${rf3_fixed_funding} ;;
    value_format_name: gbp
  }

  measure: channel_gross_margin_inc_unit_funding_RF3 {
    label: "Gross Margin Inc Unit Funding RF3"
    description: "RF3 - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: ${channel_gross_profit_Excl_funding_rf3} + ${channel_retro_funding_rf3}  ;;
    value_format_name: gbp
  }

  measure: channel_gross_margin_inc_all_funding_rf3 {
    label: "Gross Margin Inc All Funding RF3"
    description: "RF3 - Gross Margin Inc All Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: ${channel_gross_profit_Excl_funding_rf3} + ${channel_retro_funding_rf3} + ${channel_fixed_funding_rf3} ;;
    value_format_name: gbp
  }

  measure: channel_margin_rate_inc_retro_funding_rf3 {
    label: "Margin Rate Inc Retro Funding RF3"
    type: number
    group_label: "Sales Channel"
    sql:  SAFE_DIVIDE(${channel_gross_margin_inc_unit_funding_RF3}, ${channel_net_sales_rf3}) ;;
    value_format: "##0.0%;(##0.0%)"
  }
}
