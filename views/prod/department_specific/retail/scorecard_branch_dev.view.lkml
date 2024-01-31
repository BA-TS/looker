view: scorecard_branch_dev {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_24_MONTHLY_DATA_DEV`;;

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

  dimension: headcount_sum_12m   {
    type: number
    sql: ${TABLE}.headcount_sum_12m  ;;
  }

  dimension: ltoPercent   {
    type: number
    sql: ${TABLE}.ltoPercent  ;;
  }

  # dimension: PP_Target{
  #   type: number
  #   sql: ${TABLE}.PP_Target ;;
  # }

}
