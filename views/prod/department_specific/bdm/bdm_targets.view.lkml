view: bdm_targets {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.retailReporting.BDM_TARGETS_LOOKER`
    where bdm is not null
    ;;
    datagroup_trigger: ts_weekly_datagroup
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
    group_label: "BDM Targets"
    type: number
    sql: ${TABLE}.netNew ;;
    hidden: yes
  }

  dimension: existing_incremental {
    group_label: "BDM Targets"
    type: number
    sql: ${TABLE}.existingIncremental ;;
    hidden: yes
  }

  dimension: overall {
    group_label: "BDM Targets"
    type: number
    sql: ${TABLE}.overall ;;
    hidden: yes
  }

  measure: net_new_total {
    group_label: "BDM Targets"
    label: "Net New"
    type: sum_distinct
    sql: ${net_new};;
  }

  measure: total_existing_incremental {
    group_label: "BDM Targets"
    label: "Existing Incremental"
    type: sum_distinct
    sql: ${existing_incremental};;
  }

  measure: total_overall {
    group_label: "BDM Targets"
    label: "Overall"
    type: sum_distinct
    sql: ${overall};;
  }

 }
