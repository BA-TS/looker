view: total_budget {
  view_label: "Budget"
  derived_table: {
    datagroup_trigger: toolstation_core_datagroup
    sql:

      SELECT
        date,
        sum(netSales) AS net_sales_budget,
        sum(grossProfit) AS gross_margin_budget,
        sum(retroFunding) AS retro_funding_budget,
        sum(fixedFunding) AS fixed_funding_budget,
        sum(grossProfit) + sum(retroFunding) AS gross_margin_inc_retro_budget,
        sum(grossProfit) + sum(retroFunding) + sum(fixedFunding) AS gross_margin_inc_retro_and_fixed_budget
      FROM
        `toolstation-data-storage.ts_finance.channelBudget`
      GROUP BY
        1

      ;;
      # publish_as_db_view: yes # look at this
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
    value_format_name: gbp
  }

  measure: gross_margin_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.gross_margin_budget ;;
    value_format_name: gbp
  }

  measure: retro_funding_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.retro_funding_budget ;;
    value_format_name: gbp
  }

  measure: fixed_funding_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.fixed_funding_budget ;;
    value_format_name: gbp
  }

  measure: gross_margin_inc_retro_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.gross_margin_inc_retro_budget ;;
    value_format_name: gbp
  }

  measure: gross_margin_inc_retro_and_fixed_budget {
    group_label: "Total"
    type: sum
    sql: ${TABLE}.gross_margin_inc_retro_and_fixed_budget ;;
    value_format_name: gbp
  }

  measure: gross_margin_rate_inc_retro_funding_budget {
    group_label: "Total"
    type: number
    sql:  SAFE_DIVIDE(${gross_margin_inc_retro_budget}, ${net_sales_budget}) ;;
    value_format: "##0.0%;(##0.0%)"
  }

}
