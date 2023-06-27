view: compliance_support {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_Compliance_Support` ;;

  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: ${TABLE}.month ;;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.Shop_code ;;
    hidden: yes
  }

  dimension: Compliance_Actual {
    type: number
    sql: ${TABLE}.Comp_Actual ;;
  }

  dimension: Compliance_Target {
    type: number
    sql: ${TABLE}.Comp_Target ;;
  }

  dimension: TargetActual{
    type: number
    label: "Target - Actual"
    sql: ${Compliance_Target}-${Compliance_Actual} ;;
  }
}
