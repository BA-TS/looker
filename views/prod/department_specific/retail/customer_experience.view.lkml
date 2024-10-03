view: customer_experience {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_CUSTOMER_EXPERIENCE`;;

  dimension: month {
    type: string
    view_label: "Date"
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
    label: "Customer Experience Month"
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: nps {
    type: number
    label: "NPS"
    sql: ${TABLE}.nps ;;
  }

  dimension:valued  {
    type: number
    label: "Valued"
    sql: ${TABLE}.valued ;;
  }

  dimension: nps_error_flag {
    type: yesno
    sql: (${valued}-${scorecard_branch_dev.branch_NPS}>0) or (${scorecard_branch_dev.branch_NPS} is null) ;;
  }

}
