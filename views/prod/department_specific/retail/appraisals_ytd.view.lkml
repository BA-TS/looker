include: "/views/**/scorecard_branch_dev.view"

view: appraisals_ytd {

  derived_table: {
    sql:
      SELECT
      siteUID,
      avg(colleagues) as colleagues,
      avg(appraisals) as appraisals,
      case when extract (month from current_date)=1 then concat(extract (year from current_date)-1,12) else concat(extract (year from current_date)-1,right(concat(0, extract (month from current_date)-1),2)) end as month
      FROM `toolstation-data-storage.retailReporting.SC_APPRAISALS`
      where left(month,4) = cast(extract(year from current_date)-1 as string)
      group by all
      ;;
  }


  dimension: month {
    type: string
    sql: cast(${TABLE}.month as string) ;;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: number_of_colleagues {
    group_label: "YTD"
    type: number
    sql: ${TABLE}.colleagues ;;
  }

  dimension: number_of_appraisals {
    group_label: "YTD"
    type: number
    sql: ${TABLE}.appraisals ;;
  }

  dimension: appraisal_percent {
    group_label: "YTD"
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
