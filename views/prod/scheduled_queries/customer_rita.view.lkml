view: customer_rita {
  derived_table: {

    datagroup_trigger: ts_transactions_datagroup
    sql: select * from toolstation-data-storage.tmp.stg_customer_rita
      order by ucn_val;;
  }

  dimension: ucn_uid {
    type: number
    sql: ${TABLE}.ucn_uid ;;
  }

  dimension: ucn_ucu_uid {
    type: string
    sql: ${TABLE}.ucn_ucu_uid ;;
  }

  dimension: ucn_sst_uid {
    type: number
    sql: ${TABLE}.ucn_sst_uid ;;
  }

  dimension_group: ucn_val {
    type: time
    sql: ${TABLE}.ucn_val ;;
  }

  dimension: ucn_ts {
    type: number
    sql: ${TABLE}.ucn_ts ;;
  }

  dimension: ucn_who {
    type: string
    sql: ${TABLE}.ucn_who ;;
  }


}
