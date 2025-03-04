view: retail_trading_profit_ytd {

  derived_table: {
    sql:
    select siteUID,TY,LY
     from `toolstation-data-storage.retailReporting.PL_DATA_YTD_BUDGET_Final_2025`
    where yearMonth-extract(year from current_date)*100 =extract (month from current_date)-1
    and type = "Retail Trading Profit"
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: retail_trading_profit_ty{
    group_label: "Contribution YTD"
    label: "Contribution YTD TY"
    type: number
    sql: ${TABLE}.TY ;;
    value_format_name: gbp_0
  }

  dimension: retail_trading_profit_ly{
    group_label: "Contribution YTD"
    label: "Contribution YTD PY"
    type: number
    sql: ${TABLE}.LY ;;
    value_format_name: gbp_0
  }

}
