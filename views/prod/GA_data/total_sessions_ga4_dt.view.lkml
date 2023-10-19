view: total_sessions_ga4_dt {
  derived_table: {
    explore_source: GA4_test {
      column: date {field: ga_digital_transactions.date_date}
      #column: date2 {field: calendar.date}
      column: total_sessions {field:ga_digital_transactions.session_start}
      column: channel_grouping {field: ga_digital_transactions.channel_Group}
      derived_column: rn {
        sql: row_number() over () ;;

      }
    }
    #datagroup_trigger: ts_googleanalytics_datagroup
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
    view_label: "GA4"
    label: "Total Sessions"
    group_label: "Measures"
    type: sum
    sql: ${sessions} ;;
  }
}
