view: spi_cpi{

  derived_table: {
    sql:
    SELECT
    date(dims.fullDate) as date,
    dims.productCode as productCode,
    dims.promo as promo,
    dims.promo_cy as promo_cy,
    dims.promo_ly as promo_ly,
    metrics.SPI_abs as SPI_abs,
    metrics.SPI_abs2 as SPI_abs2,
    metrics.cy_netSales as cy_netSales,
    metrics.ly_netSales as ly_netSales,
    metrics.cy_unitsSOLD as cy_unitsSOLD,
    metrics.ly_unitsSOLD as ly_unitsSOLD,
    metrics.cy_unitPRICE as cy_unitPRICE,
    metrics.ly_unitPRICE as ly_unitPRICE,
    metrics.cy_aac_cogs as cy_aac_cogs,
    metrics.cy_ccp_cogs as cy_ccp_cogs,
    metrics.SPI_comparator as SPI_comparator,
    row_number() OVER(ORDER BY dims.productCode) AS prim_key
    FROM `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`;;
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension_group: date {
    type: time
    timeframes: [date,raw]
    hidden: yes
    sql: ${TABLE}.date ;;
  }

  dimension: productCode {
    type: string
    sql: ${TABLE}.productCode;;
    hidden: yes
  }

  dimension: is_promo_cy_ly {
    type: yesno
    label: "Promo CY/LY"
    sql: ${TABLE}.promo=1 ;;
  }

  dimension: is_promo_cy {
    type: yesno
    label: "Promo CY"
    sql: ${TABLE}.promo_cy=1 ;;
  }

  dimension: is_promo_ly {
    type: yesno
    label: "Promo LY"
    sql: ${TABLE}.promo_ly=1 ;;
  }

  dimension: SPI_abs {
    type: number
    sql: ${TABLE}.SPI_abs;;
    hidden: yes
  }

  dimension: SPI_abs2 {
    type: number
    sql: ${TABLE}.SPI_abs2;;
    hidden: yes
  }

  dimension: cy_netSales {
    type: number
    sql: ${TABLE}.cy_netSales;;
    hidden: yes
  }

  dimension: ly_netSales {
    type: number
    sql: ${TABLE}.ly_netSales;;
    hidden: yes
  }

  dimension: cy_unitsSOLD {
    type: number
    sql: ${TABLE}.cy_unitsSOLD;;
    hidden: yes
  }

  dimension: ly_unitsSOLD {
    type: number
    sql: ${TABLE}.ly_unitsSOLD;;
    hidden: yes
  }

  dimension: cy_unitPRICE {
    type: number
    sql: ${TABLE}.cy_unitPRICE;;
    hidden: yes
  }

  dimension: ly_unitPRICE {
    type: number
    sql: ${TABLE}.ly_unitPRICE;;
    hidden: yes
  }

  dimension: cy_aac_cogs {
    type: number
    sql: ${TABLE}.cy_aac_cogs;;
    hidden: yes
  }

  dimension: cy_ccp_cogs {
    type: number
    sql: ${TABLE}.cy_ccp_cogs;;
    hidden: yes
  }

  dimension: SPI_comparator {
    type: number
    sql: ${TABLE}.SPI_comparator;;
    hidden: yes
  }

  measure: cy_unitsSOLD_total {
    type: sum
    group_label: "CY"
    label: "CY Units Sold"
    sql: ${cy_unitsSOLD};;
    value_format: "0.00"
  }

  measure: ly_unitsSOLD_total {
    type: sum
    group_label: "LY"
    label: "LY Units Sold"
    sql: ${ly_unitsSOLD};;
    value_format: "0.00"
  }

  measure: SPI_comparator_total {
    type: sum
    label: "SPI Comparator"
    sql: ${SPI_comparator};;
    value_format: "0.00;"
  }

  measure: SPI_total {
    type: sum
    label: "SPI"
    sql: ${SPI_abs};;
    value_format: "0.00"
  }

  measure: SPI_total2 {
    type: sum
    label: "SPI_New"
    sql: ${SPI_abs2};;
    value_format: "0.00"
  }

  measure: cy_netSales_total {
    type: sum
    group_label: "CY"
    sql: ${cy_netSales};;
    label: "CY Net Sales"
    value_format: "0.00"
  }

  measure: ly_netSales_total {
    type: sum
    group_label: "LY"
    sql: ${ly_netSales};;
    label: "LY Net Sales"
    value_format: "0.00"
  }

  measure: cy_unitPrice {
    type: number
    group_label: "CY"
    sql:  COALESCE(SAFE_DIVIDE(${cy_netSales_total}, ${cy_unitsSOLD_total}),0) ;;
    label: "CY Unit Price"
    value_format: "0.00"
  }

  measure: ly_unitPrice {
    type: number
    group_label: "LY"
    sql:  COALESCE(SAFE_DIVIDE(${ly_netSales_total}, ${ly_unitsSOLD_total}),0) ;;
    label: "LY Unit Price"
    value_format: "0.00"
  }

  measure: cy_aac_cogs_total {
    type: sum
    label: "CY AAC COGS"
    group_label: "CY"
    sql: ${TABLE}.cy_aac_cogs;;
    value_format: "0.00"
  }

  measure: cy_ccp_cogs_total {
    type: sum
    label: "CY CCP COGS"
    group_label: "CY"
    sql: ${TABLE}.cy_ccp_cogs;;
    value_format: "0.00"
  }
}
