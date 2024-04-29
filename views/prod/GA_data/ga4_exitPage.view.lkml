view: ga4_exitpage {
  derived_table: {
    sql:  select distinct date, session_id, minTime,screen_name, page_location, row_number() over (partition by session_id order by minTime desc) as exit
       from
       (SELECT distinct
      date(case when date(minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(minTime, interval 1 HOUR)) else (timestamp_add(minTime, interval 1 HOUR)) end) as date,
          session_id, minTime, Screen_name, page_location
          from `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*`
          where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start calendar.filter_on_field_to_hide %}) and FORMAT_DATE('%Y%m%d', {% date_end calendar.filter_on_field_to_hide %}));;
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


  dimension: exit_session {
    description: "session_id"
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  #dimension: land_screen {
  #type: string
  #sql: ${TABLE}.Screen_name ;;
  #}

  dimension: exit_screen {
    view_label: "GA4"
    label: "Exit Screen Name"
    group_label: "Screen"
    type: string
    sql: ${TABLE}.Screen_name;;
  }

  dimension: exit_page {
    view_label: "GA4"
    label: "Exit Page"
    group_label: "Screen"
    #hidden: yes
    type: string
    sql: ${TABLE}.page_location;;
  }

  filter: select_date_range {
    hidden: yes
    #view_label: "Datetime (of event)"
    label: "Dated"
    group_label: "Date Filter"
    type: date
    sql: {{ calendar.filter_on_field_to_hide._value }} ;;
  }

  dimension: LastE {
    hidden: yes
    type: number
    sql: ${TABLE}.exit;;
  }

  dimension: Exitscreen_type {
    view_label: "GA4"
    label: "Exit Screen Type"
    group_label: "Screen"
    type: string
    sql: CASE when regexp_contains(${exit_page},".*/p([0-9]*)$") then "product-detail-page"
      when regexp_contains(${exit_page}, ".*/p[0-9]*[^0-9a-zA-Z]") then "product-detail-page"
      when regexp_contains(${exit_page},".*/c([0-9]*)$") then "product-listing-page"
      when regexp_contains(${exit_page}, ".*/c[0-9]*[^0-9a-zA-Z]") then "product-listing-page"
      else ${exit_screen} end ;;

    }


}
