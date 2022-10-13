# The name of this view in Looker is "Digital Sales Matrix"
view: digital_sales_matrix {

  fields_hidden_by_default: yes
  sql_table_name: `toolstation-data-storage.tmp.digitalSalesMatrix`;;

  dimension_group: full {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fullDate ;;
    hidden: no
  }

  dimension: on_dotwpromo {
    type: yesno
    sql: ${TABLE}.onDOTWPromo ;;
    hidden: no
  }

  dimension: on_egvpromo {
    type: yesno
    sql: ${TABLE}.onEGVPromo ;;
    hidden: no
  }

  dimension: sku {
    type: number
    sql: ${TABLE}.SKU ;;
    hidden: yes
  }

}
