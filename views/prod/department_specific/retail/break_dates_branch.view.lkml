view: break_dates_branch {

  derived_table: {
    sql:
    SELECT
    *
    FROM
    `toolstation-data-storage.retailReporting.break_dates_branch`
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
    primary_key: yes
  }

  dimension: break_notice_date {
    label: "Branch Availability YTD"
    type: string
    sql: ${TABLE}.break_notice_date;;
    hidden: yes
  }

}
