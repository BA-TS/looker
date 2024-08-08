view: targets {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.retailReporting.BDM_KA_TARGETS_LOOKER`
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

  dimension: team {
    type: string
    sql: ${TABLE}.team ;;
    hidden: yes
  }

  dimension: month {
    type: string
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: net_new {
    type: number
    sql: ${TABLE}.netNew ;;
    hidden: yes
  }

  dimension: existing_incremental {
    type: number
    sql: ${TABLE}.existingIncremental ;;
    hidden: yes
  }

  dimension: overall {
    type: number
    sql: ${TABLE}.overall ;;
    hidden: yes
  }

  measure: net_new_total {
    label: "Net New"
    type: sum_distinct
    sql: ${net_new};;
  }

  measure: total_existing_incremental {
    label: "Existing Incremental"
    type: sum_distinct
    sql: ${existing_incremental};;
  }

  measure: total_overall {
    label: "Overall"
    type: sum_distinct
    sql: ${overall};;
  }

}
