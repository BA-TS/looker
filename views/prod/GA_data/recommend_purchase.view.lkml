view: recommend_purchase {
  derived_table: {
    sql:
with sub1 as (SELECT distinct platform, event_name, session_id, item_id,t.productCode,t.orderID, min(case when date(minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(minTime, interval 1 HOUR)) else (timestamp_add(minTime, interval 1 HOUR)) end) as Time1, round(sum(net_value),2) as net, round(sum(ga4_quantity),2) as Q
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` a left join unnest(transactions) as t
where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 12 week)) and FORMAT_DATE('%Y%m%d',current_date())
and ((a.item_id=t.productCode) or (a.item_id is not null and t.productCode is null) or (a.item_id is null and t.productCode is null))
and event_name in ("purchase", "Purchase", "suggested_item_click", "recommended_item_tapped")
group by all),

-- purchase_ID, Porder,purchase_date, purchase_time, timestamp_diff(purchase_time, min(Time1), second) as recommend_purch_diff, purchase_net, purchase_q

rec as (select distinct Platform,session_id as recommend_ID, date(min(Time1)) as recommend_date, min(Time1) as recommend_time, item_id
from sub1
where event_name in ("suggested_item_click", "recommended_item_tapped")
group by all),

purchase as (select distinct min(Time1) as purchase_time, session_id as purchase_id, item_id, productCode, orderID, net, Q from sub1 where event_name in ("purchase", "Purchase")
group by all)

SELECT distinct row_number() over() as PK, rec.recommend_ID, coalesce(recommend_time,purchase.purchase_time, all_purch.purchase_time) as date, coalesce(lpad(rec.item_id,5,"0"),purchase.productCode,all_purch.item_id, all_purch.productCode, purchase.item_id) as itemid, purchase.purchase_time as rec_purchaseTime, timestamp_diff( purchase.purchase_time, recommend_time, second) as recommend_purch_diff, purchase.purchase_id as Rec_purchaseID,  purchase.OrderID as rec_purchaseOrderID, purchase.net as rec_purchaseNet, purchase.Q as rec_purchaseQ, all_purch.purchase_id as all_purchaseID,  all_purch.OrderID as allPurchOrdrID, all_purch.net as allPurch_net, all_purch.Q as allPurchQ
from rec
left join purchase on rec.recommend_ID = purchase.purchase_id and rec.item_id = purchase.item_id and rec.recommend_time < purchase.purchase_time
full outer join purchase as all_purch on purchase.purchase_id = all_purch.purchase_id and purchase.item_id=all_purch.item_id ;;

sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 13;;
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
    sql: ${TABLE}.date ;;
  }

  dimension: purchase_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.Rec_purchaseID ;;
  }

  dimension: recommend_purch_diff {
    hidden: yes
    type: number
    sql: ${TABLE}.recommend_purch_diff ;;
  }

  dimension: item_id {
    hidden: yes
    type: string
    sql: ${TABLE}.itemid ;;
  }

  dimension: Allpurchase_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.all_purchaseID ;;
  }

  dimension: Allpurchase_net {
    hidden: yes
    type: number
    sql: ${TABLE}.allPurch_net ;;
  }


  dimension: Allpurchase_Q {
    hidden: yes
    type: number
    sql: ${TABLE}.allPurchQ ;;
  }



  measure: net_rev {
    value_format_name: gbp
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "(Recommend) Net Revenue"
    type: sum
    sql: ${TABLE}.rec_purchaseNet ;;
    filters: [recommend_purch_diff: "NULL, >0"]
  }

  measure: nonrec_net_rev {
    value_format_name: gbp
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "(Not Recommend) Net Revenue"
    type: sum
    sql: ${Allpurchase_net} ;;
    filters: [purchase_ID: "NULL"]
  }

  measure: Quantity {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "(Recommend) Quantity"
    type: sum
    sql: ${TABLE}.rec_purchaseQ ;;
    filters: [recommend_purch_diff: "NULL, >0"]
  }

  measure: nonRecQuantity {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "(Not Recommend) Quantity"
    type: sum
    sql: ${Allpurchase_Q} ;;
    filters: [purchase_ID: "NULL"]
  }

  measure: recommend_sessions {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "Recommend Sessions"
    type: count_distinct
    sql: ${recommend_ID} ;;
  }

  measure: recommend_Orders {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "(Recommend) Orders"
    type: count_distinct
    sql: ${TABLE}.rec_purchaseOrderID ;;
  }

  measure: notrecommend_Orders {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "(Not Recommend) Orders"
    type: count_distinct
    sql: ${TABLE}.allPurchOrdrID ;;
    filters: [purchase_ID: "NULL"]
  }

  measure: purchase_sessions {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "Recommend to Purchase Sessions"
    type: count_distinct
    sql: ${purchase_ID} ;;
    filters: [recommend_purch_diff: "NULL, >0"]
  }

  measure: nonRecpurchase_sessions {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "Not Recommend to Purchase Sessions"
    type: count_distinct
    sql: ${Allpurchase_ID} ;;
    filters: [purchase_ID: "NULL"]
  }

  measure: recommend_purchase_rate {
    #view_label: "GA4"
    group_label: "Recommend to purchase"
    label: "Recommend to Purchase Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions}, ${recommend_sessions}) ;;
  }

  measure:  rec_basket_size {
    group_label: "Recommend to purchase"
    label: "Recommend Avg Basket Size"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( ${Quantity}, ${recommend_Orders}) ;;
  }

  measure:  nonrec_basket_size {
    group_label: "Recommend to purchase"
    label: "Non Recommend Avg Basket Size"
    type: number
    value_format_name: decimal_2
    sql: safe_divide(${nonRecQuantity}, ${notrecommend_Orders}) ;;
  }





}
