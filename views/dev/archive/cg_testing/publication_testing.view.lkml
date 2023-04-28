
view: publication_testing {

  sql_table_name: `toolstation-data-storage.tmp.publication_testing`
    ;;

  dimension: catalogue_cycle {
    type: number
    sql: ${TABLE}.catalogue_cycle ;;
    value_format_name: id
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date
    ]
    sql: ${TABLE}.end_date ;;
  }

  dimension_group: live {
    type: time
    timeframes: [
      raw,
      date
    ]
    sql: ${TABLE}.live_date ;;
  }

  dimension: publication_id {
    type: number
    sql: ${TABLE}.publication_id ;;
    value_format_name: id
  }

  dimension: publication_name {
    type: string
    sql: ${TABLE}.publication_name ;;
    order_by_field: publication_id
  }

  dimension: publication_type {
    type: string
    sql: ${TABLE}.publication_type ;;
    order_by_field: publication_id
  }

}
