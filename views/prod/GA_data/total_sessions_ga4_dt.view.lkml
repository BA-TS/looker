view: total_sessions_ga4_dt {
  derived_table: {
  sql:
    SELECT distinct row_number() over () as rn,*
    FROM `toolstation-data-storage.Digital_reporting.TotalSessionsAcquisition`
  ;;

  }

  dimension: P_K {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.rn ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: channel_grouping {
    hidden: yes
    type: string
    sql: ${TABLE}.Channel_group ;;
  }

  dimension: Medium {
    hidden: yes
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: Campaign {
    hidden: yes
    type: string
    sql: ${TABLE}.Campaign ;;
  }

  dimension: sessions {
    hidden: yes
    type: number
    sql: ${TABLE}.Total_sessions ;;
  }

  measure: Sessions {
    view_label: "GA4"
    label: "Total Sessions"
    group_label: "Measures"
    type: sum
    sql: ${sessions} ;;
  }
}
