view: spi_cpi{

  derived_table: {
    sql:
    SELECT
    date(dims.fullDate) as date,
    dims.productCode as productCode,
    metrics.SPI_abs as SPI_abs
    FROM `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`;;
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
    # hidden: yes
  }

  measure: SPI_total {
    type: sum
    label: "SPI"
    sql: ${SPI_abs};;
    value_format: "#,##0;(#,##0)"
  }

}
