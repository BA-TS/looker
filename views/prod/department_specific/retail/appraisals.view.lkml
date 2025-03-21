include: "/views/**/scorecard_branch_dev.view"

view: appraisals {

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
 case when extract (month from current_date)=1 then concat(extract (year from current_date)-1,12) else concat(extract (year from current_date)-1,right(concat(0, extract (month from current_date)-1),2)) end as month
      from
      `toolstation-data-storage.retailReporting.SC_APPRAISALS` s
      inner join base b
      on s.siteUID = b.siteUID and s.month = b.month
      order by 2 desc
      ;;
  }

  dimension: recent_visit_month {
    group_label: "Monthly"
    type: string
    sql: CAST(${TABLE}.last_appraisals_month AS string);;
    required_access_grants: [lz_testing]
    # hidden: yes
  }

  dimension: month {
    type: string
    sql: cast(${TABLE}.month as string);;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: number_of_colleagues {
    group_label: "Monthly"
    type: number
    sql: ${TABLE}.colleagues ;;
  }

  dimension: number_of_appraisals {
    group_label: "Monthly"
    type: number
    sql: ${TABLE}.appraisals ;;
  }

  dimension: appraisal_percent {
    group_label: "Monthly"
    label: "Appraisal %"
    type: number
    sql: safe_divide(${number_of_colleagues},${number_of_appraisals}) ;;
    value_format_name: percent_1
  }

}
