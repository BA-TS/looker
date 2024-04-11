view: ga4_landingpage {
  derived_table: {
    sql: SELECT distinct
    case when date(minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(minTime, interval 1 HOUR)) else (timestamp_add(minTime, interval 1 HOUR)) end as date,
    session_id, minTime, Screen_name
    from `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*`
    _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %};;
  }


  dimension: land_PK {
    primary_key: yes
    hidden: yes
    type: string
    sql: row_number() over () ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }


  dimension: land_session {
    description: "session_id"
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  #dimension: land_screen {
    #type: string
    #sql: ${TABLE}.Screen_name ;;
  #}

  measure: land_page {
    type: string
    sql: min_by(${TABLE}.Screen_name, ${TABLE}.minTime);;
  }

  filter: select_date_range {
    #view_label: "Datetime (of event)"
    label: "Dated"
    group_label: "Date Filter"
    type: date
    sql: {% condition select_date_range %} timestamp(${date_date}) {% endcondition %} ;;
  }


}
