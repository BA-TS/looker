view: ga4_totalsessions_channelgrouping {
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

  dimension:  channel_grouping {
    hidden: yes
    type: string
    sql: ${TABLE}.channel_grouping ;;
  }

  measure: session_start_cg {
    view_label: "Ga4"
    label: "Total Sessions by Channel Group"
    group_label: "Measures"
    #hidden: yes
    type: sum
    sql:CASE WHEN ${channel_grouping} = {% parameter channel_group %} then ${sessions} end;;

  }

  parameter: channel_group {
    view_label: "Ga4"
    label: "Channel Grouping for Total Sessions"
    type: string
    allowed_value: {
      label: "Direct"
      value: "Direct"
    }

    allowed_value: {
      label: "Paid Search"
      value: "Paid Search"
    }

    allowed_value: {
      label: "Organic Search"
      value: "Organic Search"
    }

    allowed_value: {
      label: "Affiliates"
      value: "Affiliates"
    }

    allowed_value: {
      label: "Organic Social"
      value: "Organic Social"
    }

    allowed_value: {
      label: "Paid Shopping"
      value: "Paid Shopping"
    }

    allowed_value: {
      label: "Paid Social"
      value: "Paid Social"
    }

    allowed_value: {
      label: "Email"
      value: "Email"
    }

    allowed_value: {
      label: "Referral"
      value: "Referral"
    }

    allowed_value: {
      label: "Other"
      value: "(other)"
    }

    allowed_value: {
      label: "Paid Other"
      value: "Paid Other"
    }

    allowed_value: {
      label: "Organic Shopping"
      value: "Organic Shopping"
    }

  }

}
