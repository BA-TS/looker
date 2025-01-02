view: bdm_ka_incremental {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    yearMonth,
    trim(bdm) as bdm,
    actualSalesTY,
    actualSalesPY,
    incrementalSales,
    newSales
    from `toolstation-data-storage.retailReporting.DS_DAILY_BDM_SALES_V_TARGET`
    group by all
    ;;
    datagroup_trigger: ts_daily_datagroup
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: bdm {
    label: "BDM"
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: yearMonth {
    type: string
    sql: CAST(${TABLE}.yearMonth AS string);;
    hidden: yes
  }

  dimension: actual_sales_PY_dim {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.actualSalesPY;;
    hidden: yes
  }

  measure: actual_sales_PY {
    label: "PY - Net Sales"
    group_label: "PY"
    value_format_name: gbp
    type: sum
    sql: ${actual_sales_PY_dim};;
  }

  dimension: incremental_sales_dim {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.incrementalSales;;
    hidden: yes
  }

  measure: incremental_sales_existing {
    value_format_name: gbp
    group_label: "Incremental"
    label: "Incremental Sales - Existing"
    type: sum
    sql: ${incremental_sales_dim};;
  }

  dimension: new_sales_dim {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.newSales;;
    hidden: yes
  }

  measure: incremental_sales_new {
    value_format_name: gbp
    group_label: "Incremental"
    label: "Incremental Sales - New"
    type: sum
    sql: ${new_sales_dim};;
  }

  measure: incremental_sales_total {
    value_format_name: gbp
    group_label: "Incremental"
    label: "Incremental Sales - Total"
    type: number
    sql: ${incremental_sales_existing}+${incremental_sales_new};;
  }
}
