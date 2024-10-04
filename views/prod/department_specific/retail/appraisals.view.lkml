include: "/views/**/scorecard_branch_dev.view"

view: appraisals {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_APPRAISALS` ;;

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
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: number_of_colleagues {
    type: number
    sql: ${TABLE}.colleagues ;;
  }

  dimension: number_of_appraisals {
    type: number
    sql: ${TABLE}.appraisals ;;
  }

  dimension: appraisals_error_flag {
    type: yesno
    sql: ((${scorecard_branch_dev.appraisals} is null) ;;
  }

}
