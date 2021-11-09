view: total_budget {
  view_label: "Budget"
  derived_table: {
    datagroup_trigger: toolstation_transactions_datagroup
    sql:
      select
        date,
        sum(netSales) as net_sales_budget,
        sum(grossProfit) as gross_margin_budget,
        sum(retroFunding) as retro_funding_budget,
        sum(fixedFunding) as fixed_funding_budget,
        sum(grossProfit) + sum(retroFunding) as gross_margin_inc_retro_budget,
        sum(grossProfit) + sum(retroFunding) + sum(fixedFunding) as gross_margin_inc_retro_and_fixed_budget

       from `toolstation-data-storage.ts_finance.channelBudget`

       group by 1;;
  }

  dimension: total_budget_date {
    group_label: "Total"
    type: date
    datatype: date
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date ;;
  }

  measure: net_sales_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.net_sales_budget ;;
  }

  measure: gross_margin_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.gross_margin_budget ;;
  }

  measure: retro_funding_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.retro_funding_budget ;;
  }

  measure: fixed_funding_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.fixed_funding_budget ;;
  }

  measure: gross_margin_inc_retro_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.gross_margin_inc_retro_budget ;;
  }

  measure: gross_margin_inc_retro_and_fixed_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.gross_margin_inc_retro_and_fixed_budget ;;
  }

}
