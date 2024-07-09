# The name of this view in Looker is "Ran Queries"
view: ran_queries {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  derived_table: {
    datagroup_trigger: ts_daily_datagroup
    sql:
    select * from `toolstation-data-storage.audit.ranQueries`
    ;;
  }

  dimension: composite_key {
    primary_key: yes
    type: string
    sql: CONCAT(${query}, '-', ${user_email}, '-', ${run_start_date_raw}, '-', ${run_start_hour}) ;;
    hidden: yes
  }

  dimension: cache_hit {
    type: yesno
    sql: ${TABLE}.cache_hit;;
    hidden: yes
  }

  dimension: user_group{
    type: string
    sql: CASE WHEN ${TABLE}.user_email IN ('david.martin@toolstation.com', 'lin.zhang@toolstation.com','iqra.naz@toolstation.com','ranjit.jagdev@toolstation.com') THEN 'Core Data Team'
              WHEN ${TABLE}.user_email IN ('heather.grayson@toolstation.com','vishesh.kulshreshtha@toolstation.com') THEN 'Supply Chain Analysts'
              WHEN ${TABLE}.user_email = 'taresh.patel@toolstation.com' THEN 'Commercial Analysts'
              WHEN ${TABLE}.user_email = 'hayley.fisher@toolstation.com' THEN 'CRM Analysts'
              WHEN ${TABLE}.user_email = 'data@toolstation.com' THEN 'Data Account'
               WHEN ${TABLE}.user_email = '681588707520-compute@developer.gserviceaccount.com' THEN 'ETL Account'
              ELSE 'Other' END;;
  }

  dimension: cost_in_gbp {
    type: number
    sql: ${TABLE}.cost_in_gbp;;
    hidden: yes
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: job_id_computed {
    label: "Job Destination Type"
    type: string
    sql: ${TABLE}.job_id_computed;;
  }

  dimension: query {
    label: "Query Text"
    type: string
    sql: ${TABLE}.query;;
  }

  dimension_group: run_start_date {
    label: "Date & Time"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.run_start_date ;;
  }

  dimension: run_start_hour {
    label: "Hour"
    type: number
    sql: ${TABLE}.run_start_hour ;;
  }

  dimension: user_email {
    label: "User Email"
    type: string
    sql: ${TABLE}.user_email;;
  }

  measure: total_cost_gbp {
    label: "Cost £"
    description: "Total cost in GBP"
    type:  sum
    view_label: "Measures"
    sql: ${cost_in_gbp} ;;
    value_format_name: gbp
  }

  measure: distinct_users {
    label: "Distinct Users"
    description: "Number of Distinct Users"
    type:  count_distinct
    view_label: "Measures"
    sql: ${user_email} ;;
  }

  measure: queries_ran {
    label: "Number of Queries"
    description: "Number of Queries Ran"
    type: count_distinct
    view_label: "Measures"
    sql: ${composite_key} ;;
  }
}
