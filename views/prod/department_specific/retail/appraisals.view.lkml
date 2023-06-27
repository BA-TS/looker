view: appraisals {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_APPRAISALS` ;;

  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: ${TABLE}.month ;;
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
  }

  dimension: colleagues {
    type: number
    sql: ${TABLE}.colleagues ;;
  }

  dimension: appraisals {
    type: number
    sql: ${TABLE}.appraisals ;;
  }
}
