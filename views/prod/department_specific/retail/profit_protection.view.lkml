view: profit_protection {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_Profit_Protection`;;

  dimension: month {
    type: string
    label: "Month_test"
    sql: CAST(${TABLE}.month AS string);;
    required_access_grants: [lz_testing]
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
