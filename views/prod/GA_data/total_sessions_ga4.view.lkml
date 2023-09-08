view: total_sessions_ga4 {
  derived_table: {
    explore_source: GA4 {
      column: date {field: ga4.date_date}
      column: session {field:ga4.sessions}
      column: event {field:ga4.event_name}
      derived_column: rn {
        sql: row_number() over () ;;
      }
    }
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

  dimension: event {
    hidden:yes
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: sessions {
    hidden: yes
    type: string
    sql: ${TABLE}.session ;;
  }

  measure: Sessions {
    view_label: "Ga4"
    label: "Total Sessions"
    group_label: "Measures"
    type: count_distinct
    filters: [event: "session_start"]
    sql: ${sessions} ;;
  }

}
