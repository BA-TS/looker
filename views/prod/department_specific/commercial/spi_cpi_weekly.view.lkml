view: spi_cpi_weekly{
  derived_table: {
    sql:
    SELECT
    dims.fiscalYearWeek as fiscalYearWeek,
    dims.productCode as productCode,
    dims.promo as promo,
    dims.promo_cy as promo_cy,
    dims.promo_ly as promo_ly,
    sum(metrics.cy_netSales) as cy_netSales,
    sum(metrics.ly_netSales) as ly_netSales,
    sum(metrics.cy_unitsSOLD) as cy_unitsSOLD,
    sum(metrics.ly_unitsSOLD) as ly_unitsSOLD,
    row_number() OVER(ORDER BY dims.productCode) AS prim_key
    FROM `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`
    Where dims.productCode not in ("00053", "44842","85699")
    GROUP BY ALL
    ;;
    datagroup_trigger: ts_daily_datagroup
  }

    #   metrics.cy_aac_cogs as cy_aac_cogs,
    # metrics.ly_aac_cogs as ly_aac_cogs,
    # metrics.cy_aac_unit_cogs as cy_aac_unit_cogs,
    # metrics.ly_aac_unit_cogs as ly_aac_unit_cogs,
    # metrics.cy_ccp_cogs as cy_ccp_cogs,
    # metrics.ly_ccp_cogs as ly_ccp_cogs,
    # metrics.aac_comparator as aac_comparator,
    # metrics.SPI_comparator as SPI_comparator,
    # metrics.SPI_abs as SPI_abs,
    # metrics.SPI_abs2 as SPI_abs2,
    # metrics.SPI_abs3 as SPI_abs3,
    # metrics.AAC_CPI_abs as AAC_CPI_abs,
    # metrics.AAC_CPI_abs2 as AAC_CPI_abs2,

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }
  dimension: fiscal_year_week {
    type: string
    sql: CAST(${TABLE}.fiscalYearWeek as string);;
    hidden: yes
  }
  dimension: productCode {
    type: string
    sql: ${TABLE}.productCode;;
    hidden: yes
  }

  dimension: is_promo_cy_ly {
    type: yesno
    group_label: "Promo"
    label: "Promo CY/LY"
    sql: ${TABLE}.promo=1 ;;
    hidden: yes
  }

  dimension: is_promo_cy {
    type: yesno
    group_label: "Promo"
    label: "Promo CY"
    sql: ${TABLE}.promo_cy=1 ;;
    hidden: yes
  }

  dimension: is_promo_ly {
    type: yesno
    group_label: "Promo"
    label: "Promo LY"
    sql: ${TABLE}.promo_ly=1 ;;
    hidden: yes
  }

  dimension: promo_nonpromo_cyly {
    type: yesno
    group_label: "Promo"
    label: "Both Promos or Non Promos CY and LY"
    sql:
    (${TABLE}.promo_cy=1 and ${TABLE}.promo_ly=1) OR (${TABLE}.promo_cy=0 and ${TABLE}.promo_ly=0);;
    hidden: yes
  }

  dimension: cy_netSales {
    type: number
    label: "CY Net Sales"
    sql: coalesce(${TABLE}.cy_netSales,0);;
    hidden: yes
  }

  dimension: ly_netSales {
    type: number
    sql: coalesce(${TABLE}.ly_netSales,0);;
    hidden: yes
  }

  dimension: cy_unitsSOLD {
    type: number
    sql: coalesce(${TABLE}.cy_unitsSOLD,0);;
    hidden: yes
  }

  dimension: ly_unitsSOLD {
    type: number
    sql: coalesce(${TABLE}.ly_unitsSOLD,0);;
    hidden: yes
  }

  dimension: cy_asp_dim {
    label: "CY ASP"
    group_label: "CY"
    description: "Net Sales AOV / Average Units"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${cy_netSales}, ${cy_unitsSOLD}),0) ;;
    value_format: "\"£\"#,##0.0"
    hidden: yes
  }

  dimension: ly_asp_dim {
    label: "LY ASP"
    group_label: "LY"
    description: "Net Sales AOV / Average Units"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${ly_netSales}, ${ly_unitsSOLD}),0) ;;
    value_format: "\"£\"#,##0.0"
    hidden: yes
  }

  dimension: unit_var_dim {
    label: "Unit Var Dim"
    group_label: "Var"
    type: number
    sql: ${cy_unitsSOLD}-${ly_unitsSOLD};;
    value_format: "#,##0"
    hidden: yes
  }

  # dimension: SPI_abs {
  #   type: number
  #   sql: ${TABLE}.SPI_abs;;
  #   hidden: yes
  # }

  # dimension: SPI_abs2_raw {
  #   type: number
  #   sql: ${TABLE}.SPI_abs2;;
  #   hidden: yes
  # }

  # dimension: SPI_abs2 {
  #   type: number
  #   sql:
  #   CASE WHEN ${is_promo_ly} is true and ${is_promo_cy} is false THEN ${SPI_abs2_raw}
  #   ELSE ${SPI_abs}
  #   END ;;
  #   hidden: yes
  # }

  # dimension: SPI_abs3 {
  #   type: number
  #   sql: ${TABLE}.SPI_abs3;;
  #   hidden: yes
  # }

  # dimension: AAC_CPI_abs {
  #   type: number
  #   sql: ${TABLE}.AAC_CPI_abs;;
  #   hidden: yes
  # }

  # dimension: AAC_CPI_abs2 {
  #   type: number
  #   sql: ${TABLE}.AAC_CPI_abs2;;
  #   hidden: yes
  # }

  # dimension: cy_aac_cogs {
  #   type: number
  #   sql: ${TABLE}.cy_aac_cogs;;
  #   hidden: yes
  # }

  # dimension: ly_aac_cogs {
  #   type: number
  #   sql: ${TABLE}.ly_aac_cogs;;
  #   hidden: yes
  # }

  # dimension: cy_aac_unit_cogs {
  #   type: number
  #   sql: ${TABLE}.cy_aac_unit_cogs;;
  #   hidden: yes
  # }

  # dimension: ly_aac_unit_cogs {
  #   type: number
  #   sql: ${TABLE}.ly_aac_unit_cogs;;
  #   hidden: yes
  # }

  # dimension: cy_ccp_cogs {
  #   type: number
  #   sql: ${TABLE}.cy_ccp_cogs;;
  #   hidden: yes
  # }

  # dimension: ly_ccp_cogs {
  #   type: number
  #   sql: ${TABLE}.ly_ccp_cogs;;
  #   hidden: yes
  # }

  # dimension: aac_comparator {
  #   type: number
  #   sql: ${TABLE}.aac_comparator;;
  #   hidden: yes
  # }

  # dimension: SPI_comparator {
  #   type: number
  #   sql: ${TABLE}.SPI_comparator;;
  #   hidden: yes
  # }


  # measure: aac_comparator_total {
  #   type: sum
  #   group_label: "CPI"
  #   label: "AAC Comparator"
  #   sql: ${aac_comparator};;
  #   value_format: "0.00;"
  # }

  # measure: SPI_comparator_total {
  #   type: sum
  #   group_label: "SPI"
  #   label: "SPI Comparator"
  #   sql: ${SPI_comparator};;
  #   value_format: "0.00;"
  # }

  # measure: SPI_total {
  #   type: sum
  #   group_label: "SPI"
  #   label: "SPI"
  #   sql: ${SPI_abs};;
  #   value_format: "0.00"
  # }

  # measure: SPI_total2 {
  #   type: sum
  #   group_label: "SPI"
  #   label: "SPI New"
  #   sql: ${SPI_abs2};;
  #   value_format: "0.00"
  # }

  # measure: SPI_LY_VOL {
  #   type: sum
  #   group_label: "SPI"
  #   sql: ${SPI_abs3};;
  #   value_format: "0.00"
  # }

  # measure: AAC_CPI_abs_total {
  #   type: sum
  #   group_label: "CPI"
  #   label: "AAC CPI (TY Vol)"
  #   sql: ${AAC_CPI_abs};;
  #   value_format: "0.00"
  # }

  # measure: AAC_CPI_abs2_total {
  #   type: sum
  #   group_label: "CPI"
  #   label: "AAC CPI (LY Vol)"
  #   sql: ${AAC_CPI_abs2};;
  #   value_format: "0.00"
  # }

  # measure: cy_aac_unit_cogs_ {
  #   type: number
  #   group_label: "CY"
  #   sql:  COALESCE(SAFE_DIVIDE(${cy_aac_cogs_total}, ${cy_unitsSOLD_total}),0) ;;
  #   label: "CY Unit COGs (AAC)"
  #   value_format: "0.00"
  # }

  # measure: ly_aac_unit_cogs_ {
  #   type: number
  #   group_label: "LY"
  #   label: "LY Unit COGs (AAC)"
  #   sql:  COALESCE(SAFE_DIVIDE(${ly_aac_cogs_total}, ${ly_unitsSOLD_total}),0) ;;
  #   value_format: "0.00"
  # }

  # measure: cy_aac_cogs_total {
  #   type: sum
  #   label: "CY AAC COGS"
  #   group_label: "CY"
  #   sql: ${TABLE}.cy_aac_cogs;;
  #   value_format: "0.00"
  # }

  # measure: ly_aac_cogs_total {
  #   type: sum
  #   label: "LY AAC COGS"
  #   group_label: "LY"
  #   sql: ${TABLE}.ly_aac_cogs;;
  #   value_format: "0.00"
  # }

  # measure: cy_ccp_cogs_total {
  #   type: sum
  #   label: "CY CCP COGS"
  #   group_label: "CY"
  #   sql: ${TABLE}.cy_ccp_cogs;;
  #   value_format: "0.00"
  # }

  # measure: ly_ccp_cogs_total {
  #   type: sum
  #   label: "LY CCP COGS"
  #   group_label: "LY"
  #   sql: ${TABLE}.ly_ccp_cogs;;
  #   value_format: "0.00"
  # }

  measure: cy_unitsSOLD_total {
    type: sum
    group_label: "CY"
    label: "CY Units Sold"
    sql: coalesce(${cy_unitsSOLD},0);;
    value_format: "#,##0"
  }

  measure: ly_unitsSOLD_total {
    type: sum
    group_label: "LY"
    label: "LY Units Sold"
    sql: coalesce(${ly_unitsSOLD},0);;
    value_format: "#,##0"
  }

  measure: cy_netSales_total {
    type: sum
    group_label: "CY"
    sql: coalesce(${cy_netSales},0);;
    label: "CY Net Sales"
    value_format: "\"£\"#,##0.0"
  }

  measure: ly_netSales_total {
    type: sum
    group_label: "LY"
    sql: coalesce(${ly_netSales},0);;
    label: "LY Net Sales"
    value_format: "\"£\"#,##0.0"
  }

  measure: netSales_var {
    type: sum
    sql: ${cy_netSales}-${ly_netSales};;
    label: "Net Sales Var"
    group_label: "Var"
    value_format: "\"£\"#,##0.0"
  }

  measure: cy_unitPrice {
    type: number
    group_label: "CY"
    sql:  COALESCE(SAFE_DIVIDE(${cy_netSales_total}, ${cy_unitsSOLD_total}),0) ;;
    label: "CY Unit Price"
    value_format: "\"£\"#,##0.0"
  }

  measure: ly_unitPrice {
    type: number
    group_label: "LY"
    sql:  COALESCE(SAFE_DIVIDE(${ly_netSales_total}, ${ly_unitsSOLD_total}),0) ;;
    label: "LY Unit Price"
    value_format: "\"£\"#,##0.0"
  }

  measure: cy_asp {
    label: "CY ASP"
    group_label: "CY"
    description: "Net Sales AOV / Average Units"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${cy_netSales_total}, ${cy_unitsSOLD_total}),0) ;;
    value_format: "\"£\"#,##0.0"
  }

  measure: ly_asp {
    label: "LY ASP"
    group_label: "LY"
    description: "Net Sales AOV / Average Units"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${ly_netSales_total}, ${ly_unitsSOLD_total}),0) ;;
    value_format: "\"£\"#,##0.0"
  }

  measure: asp_var {
    label: "ASP Var"
    group_label: "Var"
    type: number
    sql: COALESCE(${cy_asp}-${ly_asp},0);;
    value_format: "\"£\"#,##0.0"
  }

  measure: price_var {
    label: "Price Var"
    group_label: "Var"
    type: sum
    sql:
    Case WHEN cast(${productCode} as int) <10000 THEN ${cy_netSales}-${ly_netSales}
    WHEN abs(${cy_unitsSOLD}) > 0 THEN (${cy_asp_dim}-${ly_asp_dim})*${ly_unitsSOLD}
    ELSE (${cy_asp_dim}-${ly_asp_dim})*${cy_unitsSOLD}
    END ;;
    value_format: "\"£\"#,##0.0"
  }

  measure: volume_var {
    label: "Volume Var"
    group_label: "Var"
    type: sum
    sql:
    Case WHEN cast(${productCode} as int) <10000 THEN 0
    WHEN abs(${cy_unitsSOLD}) > 0 THEN ${unit_var_dim}*${cy_asp_dim}
    ELSE ${unit_var_dim}*${ly_asp_dim}
    END ;;
    value_format: "#,##0.0"
  }
}
