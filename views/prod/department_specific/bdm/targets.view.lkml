view: targets {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    --from `toolstation-data-storage.retailReporting.BDM_KA_TARGETS_LOOKER`
    from `toolstation-data-storage.retailReporting.BDM_RUNNING_TARGET_2025`
    ;;
    # datagroup_trigger: ts_weekly_datagroup
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

  dimension: target {
    type: number
    sql: ${TABLE}.target ;;
    hidden: yes
  }

  dimension: target_running {
    type: number
    sql: ${TABLE}.targetRunningTotal ;;
    hidden: yes
  }

  measure: monthly_target {
    # type: sum_distinct
    type: sum
    sql: ${target};;
    value_format_name: gbp_0
  }

  measure: target_running_total {
    # type: sum_distinct
    type: sum
    sql: ${target_running};;
    value_format_name: gbp_0
  }

}
