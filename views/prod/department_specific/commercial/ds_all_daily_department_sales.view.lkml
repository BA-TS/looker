view: ds_all_daily_department_sales {
  derived_table: {
    sql:
      SELECT distinct row_number() over () as P_K,
      *
      FROM `toolstation-data-storage.digitalreporting.DS_All_Daily_Department_Sales`
      where date between date_sub(current_date(), interval 14 day) and current_date()
      ;;
    datagroup_trigger: ts_daily_datagroup
  }

  dimension: P_K {
    description: "Primary Key"
    type: string
    sql: ${TABLE}.P_K ;;
    primary_key: yes
    hidden: yes
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
    hidden: yes
  }

  dimension_group: date {
    type: time
    datatype: date
    timeframes: [date,month]
    hidden: yes
    sql: date(${TABLE}.date) ;;
  }

  dimension: netSales_raw {
    type: number
    sql: ${TABLE}.netSales ;;
    hidden: yes
  }

  measure: netSales {
    label: "Net Sales"
    group_label: "By Department"
    type: sum
    sql: ${netSales_raw} ;;
    value_format_name: decimal_1
  }

  dimension: netSalesLY_raw {
    type: number
    sql: ${TABLE}.netSalesLY ;;
    hidden: yes
  }

  measure: netSalesLY {
    label: "Net Sales LY"
    group_label: "By Department"
    type: sum
    sql: ${netSalesLY_raw} ;;
    value_format_name: decimal_1
  }

  dimension: marginInclRetro_raw {
    type: number
    sql: ${TABLE}.marginInclRetro ;;
    hidden: yes
  }

  measure: marginInclRetro {
    label: "Margin Inc Funding"
    group_label: "By Department"
    type: sum
    sql: ${marginInclRetro_raw} ;;
    value_format_name: decimal_1
  }

  measure: marginInclRetro_percent {
    label: "Margin Inc Funding %"
    group_label: "By Department"
    type: number
    value_format_name: percent_1
    sql: safe_divide(${marginInclRetro},${netSales}) ;;
  }

  dimension: netSalesLW_raw {
    type: number
    sql: ${TABLE}.netSalesLW ;;
    hidden: yes
  }

  measure: netSalesLW {#
    group_label: "By Department"
    label: "Net Sales LW"
    type: sum
    sql: ${netSalesLW_raw} ;;
    value_format_name: decimal_1
  }

  measure: WOW_change {
    group_label: "By Department"
    label: "WOW Change %"
    type: number
    sql: safe_divide(${netSales},${netSalesLW})-1 ;;
    value_format_name: percent_1
  }

  measure: YOY_change {
    group_label: "By Department"
    label: "YOY Change %"
    type: number
    sql: safe_divide(${netSales},${netSalesLY})-1 ;;
    value_format_name: percent_1
  }

 }
