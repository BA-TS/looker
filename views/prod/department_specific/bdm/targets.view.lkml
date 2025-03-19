view: targets {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
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

  dimension: net_sales_vs_target_dim {
    type: number
    value_format_name: gbp
    hidden: yes
    sql: ${bdm_cumulative_sales.ytd_net_sales} - ${target_running} ;;
  }

  measure: target_monthly {
    type: sum
    sql: ${target};;
    value_format_name: gbp_0
  }

  measure: target_YTD {
    type: sum
    sql: ${target_running};;
    value_format_name: gbp_0
    hidden: yes

  }

  measure: sales_vs_target_monthly {
    label: "Sales vs Target (Monthly)"
    type: number
    sql: ${transactions.total_net_sales}-${target_monthly};;
    value_format_name: gbp_0
  }

  measure: total_net_sales_vs_target {
    label: "Sales vs Target (YTD)"
    type: sum
    sql: coalesce(${net_sales_vs_target_dim},null) ;;
    value_format_name: gbp_0
  }

}
