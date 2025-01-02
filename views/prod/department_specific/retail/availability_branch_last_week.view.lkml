view: availability_branch_last_week {

  derived_table: {
    sql:
    with pv_week as (
      SELECT
      fiscalYearWeek-1 as fiscalYearWeek,
      from `toolstation-data-storage.ts_finance.dim_date` d
      where fullDate= current_date
    )

    SELECT
    siteUID,
    round(sum(instock)/(sum(instock)+sum(outOfStock)),3) as availability_dim
    FROM `toolstation-data-storage.availability_new.BranchDepartmentAvailabilityHistory` a
    left join `toolstation-data-storage.ts_finance.dim_date` d on a.date = d.fullDate
    inner join pv_week on pv_week.fiscalYearWeek=d.fiscalYearWeek
    group by all
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: availability_dim {
    label: "Branch Availability Last Week"
    type: number
    sql: ${TABLE}.availability_dim ;;
    hidden: yes
  }

  measure: availability {
    label: "Availability Last Week"
    type: average
    sql: ${availability_dim} ;;
    value_format_name: percent_1
  }

}
