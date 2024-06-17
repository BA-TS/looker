view: recommend_purchase {
  derived_table: {
    sql:
with sub1 as (SELECT distinct platform, event_name, session_id, item_id,t.productCode,t.orderID, min(case when date(minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(minTime, interval 1 HOUR)) else (timestamp_add(minTime, interval 1 HOUR)) end) as Time1, round(sum(net_value),2) as net
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` a left join unnest(transactions) as t
where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 12 week)) and FORMAT_DATE('%Y%m%d',current_date())
and ((a.item_id=t.productCode) or (a.item_id is not null and t.productCode is null) or (a.item_id is null and t.productCode is null))
and event_name in ("purchase", "Purchase", "suggested_item_click", "recommended_item_tapped")
group by 1,2,3,4,5,6)


select distinct row_number() over() as PK,Platform,session_id as recommend_ID, date(min(Time1)) as recommend_date, min(Time1) as recommend_time, item_id, purchase_ID,purchase_date, purchase_time, timestamp_diff(purchase_time, min(Time1), second) as recommend_purch_diff, purchase_net
from sub1 left join (
  select distinct session_id as purchase_ID, productCode as purchasePC, date(min(Time1)) as purchase_date,  min(Time1) as purchase_time, round(sum(net),2) as purchase_net
from sub1
where event_name in ("purchase", "Purchase")
group by 1,2
) on session_id = purchase_ID and item_id = purchasePC
where event_name in ("suggested_item_click", "recommended_item_tapped")
group by 2,3,6,7,8,9,11 ;;

sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 10;;
}


  dimension: PK {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.PK ;;
  }

  dimension: recommend_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.recommend_ID ;;
  }

  dimension_group: recommend_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.recommend_date ;;
  }

  dimension: purchase_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.purchase_ID ;;
  }

  dimension: recommend_purch_diff {
    hidden: yes
    type: number
    sql: ${TABLE}.recommend_purch_diff ;;
  }

  dimension: item_id {
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
  }

  measure: net_rev {
    value_format_name: gbp
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "(Recommend) Net Revenue"
    type: sum
    sql: ${TABLE}.purchase_net ;;
    filters: [recommend_purch_diff: "NULL, >0"]
  }

  measure: recommend_sessions {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "Recommend Sessions"
    type: count_distinct
    sql: ${recommend_ID} ;;
  }

  measure: purchase_sessions {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "Recommend to Purchase Sessions"
    type: count_distinct
    sql: ${purchase_ID} ;;
    filters: [recommend_purch_diff: "NULL, >0"]
  }

  measure: recommend_purchase_rate {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "Recommend to Purchase Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions}, ${recommend_sessions}) ;;
  }





}
