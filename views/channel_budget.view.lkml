view: channel_budget {
  sql_table_name: `toolstation-data-storage.ts_finance.channelBudget`
    ;;

  dimension: channel {
    hidden: yes
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: date {
    hidden: yes
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: date_channel {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${date}||${channel} ;;
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
    description: "Budget - Net Sales at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${net_sales} ;;
  }

  measure: channel_gross_profit_Excl_funding_budget {
    description: "Budget - Gross Profit at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${gross_profit} ;;
  }

  measure: channel_retro_funding_budget {
    description: "Budget - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${retro_funding} ;;
  }

  measure: channel_fixed_funding_budget {
    description: "Budget - fixed Funding at Channel level only"
    group_label: "Sales Channel"
    type: sum
    sql: ${fixed_funding} ;;
  }

  measure: channel_gross_margin_inc_unit_funding_budget {
    description: "Budget - Retro Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: sum(${gross_profit}+${retro_funding}) ;;
  }

  measure: channel_gross_margin_inc_all_funding_budget {
    description: "Budget - Gross Margin Inc All Funding at Channel level only"
    group_label: "Sales Channel"
    type: number
    sql: sum(${gross_profit}+${retro_funding}+${fixed_funding}) ;;
  }
}
