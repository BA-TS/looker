view: holiday_management {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_Holiday_Management` ;;

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

  dimension: Holiday_Entitlement   {
    type: number
    sql: ${TABLE}.Holiday_Entitlement  ;;
  }

  dimension: Holiday_Taken {
    type: number
    sql: ${TABLE}.Holiday_Taken ;;
  }

  dimension: Holiday_Booked{
    type: number
    sql: ${TABLE}.Holiday_Booked ;;
  }
}
