view: pl_sales_total_ytd {

  derived_table: {
    sql:
    select
    siteUID,TY,LY,AOP,vsAOP
     from `toolstation-data-storage.retailReporting.PL_DATA_YTD_BUDGET_Final_2025`
    where yearMonth = (select max (yearMonth)
     from `toolstation-data-storage.retailReporting.PL_DATA_YTD_BUDGET_Final_2025`
    )
    and type = "Sales Total"
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: sales_total_AOP_dim{
    group_label: "Sales Total YTD"
    label: "Sales Total AOP"
    type: number
    sql: ${TABLE}.AOP ;;
    value_format_name: gbp_0
  }

  measure: sales_total_AOP{
    group_label: "Sales Total YTD"
    label: "Sales Total AOP"
    type: sum
    sql: ${sales_total_AOP_dim} ;;
    value_format_name: gbp_0
  }

  dimension: sales_total_vs_AOP_dim{
    group_label: "Sales Total YTD"
    label: "Sales Total vs AOP"
    type: number
    sql: ${TABLE}.AOP ;;
    value_format_name: gbp_0
  }

  measure: sales_total_vs_AOP{
    group_label: "Sales Total YTD"
    label: "Sales Total vs AOP"
    type: sum
    sql: ${sales_total_vs_AOP_dim} ;;
    value_format_name: gbp_0
  }
}
