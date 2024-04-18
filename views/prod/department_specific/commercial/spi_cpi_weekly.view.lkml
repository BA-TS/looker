view: spi_cpi_weekly{

  derived_table: {
    sql:
    SELECT
    dims.fiscalYearWeek as fiscalYearWeek,
    dims.productCode as productCode,
    metrics.cy_netSales as cy_netSales,
    metrics.ly_netSales as ly_netSales,
    row_number() OVER(ORDER BY dims.productCode) AS prim_key
    FROM `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`;;
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension: productCode {
    type: string
    sql: ${TABLE}.productCode;;
    hidden: yes
  }

  dimension: fiscal_year_week {
    type: string
    sql: CAST(${TABLE}.fiscalYearWeek as string);;
    hidden: yes
  }

  dimension: cy_netSales {
    type: number
    label: "CY Net Sales"
    sql: ${TABLE}.cy_netSales;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: ly_netSales {
    type: number
    sql: ${TABLE}.ly_netSales;;
    value_format_name: gbp
    hidden: yes
  }

  measure: cy_netSales_total {
    type: sum
    group_label: "CY"
    sql: ${cy_netSales};;
    label: "CY Net Sales"
    value_format_name: gbp
  }

  measure: ly_netSales_total {
    type: sum
    group_label: "LY"
    sql: ${ly_netSales};;
    label: "LY Net Sales"
    value_format_name: gbp
  }
}
