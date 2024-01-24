view: spi_cpi{
  sql_table_name: `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`;;

  dimension_group: date {
    type: time
    timeframes: [date,raw]
    sql: date(${TABLE}.dims.fullDate) ;;
    hidden: yes
  }

  dimension: productCode {
    type: string
    sql: ${TABLE}.dims.productCode;;
    hidden: yes
  }

  dimension: SPI_abs {
    type: number
    sql: ${TABLE}.metrics.SPI_abs;;
  }
}
