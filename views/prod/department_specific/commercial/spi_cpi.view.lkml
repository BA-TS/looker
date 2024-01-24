view: spi_cpi{
  sql_table_name: `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`;;

  # dimension: date {
  #   # type: time
  #   # timeframes: [date,raw]
  #   type: date
  #   sql: date(${TABLE}.dims.fullDate) ;;
  #   label: "SPI date"
  # }

  dimension: date{
    group_label: "Dates"
    label: "SPI Date (dd/mm/yyyy)"
    type: date
    primary_key: yes
    sql: timestamp(${TABLE}.fullDate) ;;
    html: {{ rendered_value | date: "%d/%m/%Y" }};;
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
