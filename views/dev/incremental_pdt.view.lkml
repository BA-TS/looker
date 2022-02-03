view: incremental_pdt {

  derived_table: {
    sql:

      SELECT
        date,
        sum(value) as value
      FROM `toolstation-data-storage.tmp.incremental_pdt_testing_data` pdt
      GROUP BY
        date

    ;;

    partition_keys: ["date"]

    increment_key: "date"
    increment_offset: 3

    datagroup_trigger: ts_dev_datagroup

  }

  dimension: date {
    type: date
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }
  measure: total_value {
    type: sum
    sql: ${value} ;;
  }

}
