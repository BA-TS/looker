include: "/views/**/scorecard_branch_dev.view"

view: appraisals_ytd {

  derived_table: {
    sql:
      SELECT
      siteUID,
      avg(colleagues) as colleagues,
      avg(appraisals) as appraisals,
      concat(extract (year from current_date), right(concat(0, extract (month from current_date)-1),2)) as month,
      FROM `toolstation-data-storage.retailReporting.SC_APPRAISALS`
      where left(month,4) = cast(extract(year from current_date) as string)
      group by all
      ;;
    # datagroup_trigger: ts_transactions_datagroup
  }


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

  dimension: appraisal_percent {
    label: "Appraisal %"
    type: number
    sql: safe_divide(${number_of_colleagues},${number_of_appraisals}) ;;
    value_format_name: percent_1
  }

  # dimension: appraisals_error_flag {
  #   type: yesno
  #   sql: (${scorecard_branch_dev.appraisal_Percent} is null)
  #   or  (${scorecard_branch_dev.appraisal_Percent} != ${appraisal_percent})
  #   ;;
  # }

}
