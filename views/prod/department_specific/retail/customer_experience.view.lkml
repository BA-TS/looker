include: "/views/**/scorecard_branch_dev.view"

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
    value_format_name: decimal_2
  }

  # dimension: nps_error_flag {
  #   type: yesno
  #   sql: (${nps}!=${scorecard_branch_dev.nps}) or (${scorecard_branch_dev.nps} is null) ;;
  # }

  dimension: nps_error_flag {
    type: number
    sql:
    case when
    ${nps}!=${scorecard_branch_dev.nps} then 1
    when (${scorecard_branch_dev.nps} is null) then 2
    else 0
    end;;
  }

  # dimension: valued_error_flag {
  #   type: yesno
  #   sql: (${valued}!=${scorecard_branch_dev.valued}) or (${scorecard_branch_dev.valued} is null) ;;
  # }

  dimension: valued_error_flag {
    type: number
    sql:
    case when
    ${valued}!=${scorecard_branch_dev.valued} then 1
    when (${scorecard_branch_dev.valued} is null) then 2
    else 0
    end;;
  }

}
