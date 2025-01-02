include: "/views/**/scorecard_branch_dev.view"
include: "/views/**/date/**.view"

view: holiday_management {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_Holiday_Management` ;;

  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: CAST(${TABLE}.month AS string);;
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

  # dimension: holiday_Q1_error_flag {
  #   type: yesno
  #   sql: (${scorecard_branch_dev.holiday_Q1_Taken_Percent} is null) ;;
  # }

  # dimension: holiday_Q2_error_flag {
  #   type: yesno
  #   sql:
  #   (${scorecard_branch_dev.holiday_Q2_Taken_Percent} is null)
  #   ;;
  # }

  # dimension: holiday_Q3_error_flag {
  #   type: yesno
  #   sql: (${scorecard_branch_dev.holiday_Q3_Taken_Percent} is null) ;;
  # }

  # dimension: holiday_Q4_error_flag {
  #   type: yesno
  #   sql:
  # (${scorecard_branch_dev.holiday_Q4_Taken_Percent} is null) ;;
  # }
}
