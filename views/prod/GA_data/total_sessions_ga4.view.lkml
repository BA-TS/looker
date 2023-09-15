view: total_sessions_ga4 {
  derived_table: {
    explore_source: GA4 {
      column: date {field: ga4.date_date}
      column: total_sessions {field:ga4.session_start}
      column: channel_grouping {field: ga4.channelGrouping}
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

  dimension: sessions {
    hidden: yes
    type: number
    sql: ${TABLE}.total_sessions ;;
  }

  dimension: channel_grouping {
    hidden: yes
    type: string
    sql: ${TABLE}.channel_grouping ;;
  }


  measure: Sessions {
    view_label: "Ga4"
    label: "Total Sessions"
    group_label: "Measures"
    type: sum
    sql: ${sessions} ;;
  }

}
