view: profit_protection {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_Profit_Protection`;;

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

  dimension: PP_Actual   {
    type: number
    sql: ${TABLE}.PP_Actual  ;;
  }

  dimension: PP_Target{
    type: number
    sql: ${TABLE}.PP_Target ;;
  }

}
