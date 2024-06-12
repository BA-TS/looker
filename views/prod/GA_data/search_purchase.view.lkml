view: search_purchase {
  derived_table: {
    sql: with sub1 as (SELECT distinct platform, event_name, session_id, min(case when date(minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(minTime, interval 1 HOUR)) else (timestamp_add(minTime, interval 1 HOUR)) end) as Time1
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*`
where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 12 week)) and FORMAT_DATE('%Y%m%d',current_date())
and (regexp_contains(event_name, "search") or event_name in ("purchase", "Purchase") ) and event_name not in ("blank_search")
group by 1,2,3)

select distinct row_number() over() as PK,Platform,session_id as search_ID, date(min(Time1)) as search_date, min(Time1) as search_time, purchase_ID,purchase_date, purchase_time, timestamp_diff(purchase_time, min(Time1), second) as search_purch_diff
from sub1 left join (
  select distinct session_id as purchase_ID, date(min(Time1)) as purchase_date,  min(Time1) as purchase_time
from sub1
where event_name in ("purchase", "Purchase")
group by 1
) on session_id = purchase_ID
where regexp_contains(event_name, "search") and event_name not in ("blank_search")
group by 2,3,6,7,8
;;

sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 11;;
}

  dimension: PK {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.PK ;;
  }

  dimension: search_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.search_ID ;;
  }

  dimension_group: search_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.search_date ;;
  }

  dimension: purchase_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.purchase_ID ;;
  }

  dimension: search_purch_diff {
    hidden: yes
    type: number
    sql: ${TABLE}.search_purch_diff ;;
  }

  measure: search_sessions {
    #view_label: "GA4"
    group_label: "Search to purchase"
    label: "Search Sessions"
    type: count_distinct
    sql: ${search_ID} ;;
  }

  measure: purchase_sessions {
    #view_label: "GA4"
    group_label: "Search to purchase"
    label: "Search to Purchase Sessions"
    type: count_distinct
    sql: ${purchase_ID} ;;
    filters: [search_purch_diff: "NULL, >0"]
  }

  measure: search_purchase_rate {
    #view_label: "GA4"
    group_label: "Search to purchase"
    label: "Search to Purchase Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions}, ${search_sessions}) ;;
  }





 }
