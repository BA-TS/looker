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

view: incremental_transactions {

  derived_table: {
    sql:

    SELECT *
    FROM `toolstation-data-storage.tmp.incremental_pdt_trans`

          ;;

      partition_keys: ["transactionDate"]
      cluster_keys: ["salesChannel", "productDepartment", "productCode"]

      # increment_key: "transaction_date"
      # increment_offset: 100 # change to yearly when done... funding is calculated over last 3 months (limited to YTD) ie 30/1 is only 29 days

      datagroup_trigger: toolstation_transactions_datagroup
  }
  dimension: date {
    type: date
    datatype: date
  }
}
