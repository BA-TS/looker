view: spi_cpi{

  derived_table: {
    sql:
    SELECT
    date(dims.fullDate) as date,
    dims.productCode as productCode,
    metrics.SPI_abs as SPI_abs,
    metrics.cy_unitsSOLD as cy_unitsSOLD,
    metrics.ly_unitsSOLD as ly_unitsSOLD,
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

  dimension: SPI_abs {
    type: number
    sql: ${TABLE}.SPI_abs;;
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

  dimension: SPI_comparator {
    type: number
    sql: ${TABLE}.SPI_comparator;;
    hidden: yes
  }

  measure: cy_unitsSOLD_total {
    type: sum
    label: "CY Units Sold"
    sql: ${cy_unitsSOLD};;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: ly_unitsSOLD_total {
    type: sum
    label: "LY Units Sold"
    sql: ${ly_unitsSOLD};;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: SPI_comparator_total {
    type: sum
    label: "SPI Comparator"
    sql: ${SPI_comparator};;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: SPI_total {
    type: sum
    label: "SPI"
    sql: ${SPI_abs};;
    value_format: "#,##0.00;(#,##0.00)"
  }
}
