view: bdm_targets {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.retailReporting.BDM_TARGETS_LOOKER`
    where bdm is not null
    ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: bdm {
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: month {
    type: string
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: net_new {
    group_label: "BDM"
    type: number
    sql: ${TABLE}.netNew ;;
  }

  dimension: existing_incremental {
    group_label: "BDM"
    type: number
    sql: ${TABLE}.existingIncremental ;;
  }

  dimension: overall {
    group_label: "BDM"
    type: number
    sql: ${TABLE}.overall ;;
  }

  measure: net_new_total {
    group_label: "BDM"
    type: sum_distinct
    sql: ${net_new};;
  }

  measure: total_existing_incremental {
    group_label: "BDM"
    type: sum_distinct
    sql: ${existing_incremental};;
  }

  measure: total_net_new {
    group_label: "BDM"
    type: sum_distinct
    sql: ${overall};;
  }

 }
