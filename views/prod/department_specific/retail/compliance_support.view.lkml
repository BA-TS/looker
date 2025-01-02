include: "/views/**/scorecard_branch_dev.view"

view: compliance_support {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_Compliance_Support` ;;

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

  dimension: siteUID_month {
    type: string
    view_label: "Site Information"
    sql: concat(${month},${siteUID}) ;;
    hidden: yes
    primary_key: yes
  }

  measure: siteUID_count {
    type: count_distinct
    view_label: "Site Information"
    label: "Number of sites (Compliance)"
    sql: ${siteUID} ;;
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

  # dimension: compliance_support_error_flag {
  #   type: yesno
  #   sql: (${scorecard_branch_dev.Comp_Actual} is null) ;;
  # }

}
