view: spi_cpi{

  derived_table: {
    sql:
    SELECT
    date(dims.fullDate) as date,
    productCode,
    SPI_abs
    FROM `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`;;
  }

  # dimension: date {
  #   type: date
  #   sql: ${TABLE}.date ;;
  #   label: "SPI date"
  # }


  dimension_group: date {
    type: time
    timeframes: [date,raw]
    hidden: yes
    sql: ${TABLE}.date ;;
  }

  # dimension: fiscalYearWeek {
  #   type: string
  #   sql: cast(${TABLE}.dims.fiscalYearWeek as string) ;;
  # }

  # dimension: date{
  #   group_label: "Dates"
  #   label: "Date (dd/mm/yyyy)"
  #   type: date
  #   primary_key: yes
  #   sql: timestamp(${TABLE}.dims.fullDate) ;;
  #   html: {{ rendered_value | date: "%d/%m/%Y" }};;
  # }

  # dimension: date{
  #   group_label: "Dates"
  #   label: "SPI Date (dd/mm/yyyy)"
  #   type: string
  #   primary_key: yes
  #   sql: replace(cast(${TABLE}.dims.fullDate as string),"-","") ;;
  #   # html: {{ rendered_value | date: "%d/%m/%Y" }};;
  # }

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
