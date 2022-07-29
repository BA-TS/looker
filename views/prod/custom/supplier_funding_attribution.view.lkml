
view: supplier_funding_attribution {

  sql_table_name: `toolstation-data-storage.looker_custom_tables.supplier_funding_attribution`
    ;;

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: total_units {
    type: number
    sql: ${TABLE}.totalUnits ;;
    hidden: yes
  }

  measure: total_total_units {
    type: sum
    sql: ${total_units} ;;
  }

  dimension_group: transaction {
    type: time
    timeframes: [
      raw,
      date,
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transactionDate ;;
  }

}
