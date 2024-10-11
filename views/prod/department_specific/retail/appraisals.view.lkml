include: "/views/**/scorecard_branch_dev.view"

view: appraisals {

  # sql_table_name:`toolstation-data-storage.retailReporting.SC_APPRAISALS` ;;

  derived_table: {
    sql:
      with base as (
       select siteUID, max(month) as month
       from
       `toolstation-data-storage.retailReporting.SC_APPRAISALS`
       group by all
      )

      select s.siteUID,
      s.month as last_appraisals_month,
      s.colleagues,
      s.appraisals,
      concat(extract (year from current_date), right(concat(0, extract (month from current_date)-1),2)) as month,
      from
      `toolstation-data-storage.retailReporting.SC_APPRAISALS` s
      inner join base b
      on s.siteUID = b.siteUID and s.month = b.month
      order by 2 desc
      ;;
    # datagroup_trigger: ts_transactions_datagroup
  }

  dimension: recent_visit_month {
    type: string
    sql: CAST(${TABLE}.last_appraisals_month AS string);;
    required_access_grants: [lz_testing]
    # hidden: yes
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
