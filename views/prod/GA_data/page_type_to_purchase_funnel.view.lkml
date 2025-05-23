view: page_type_to_purchase_funnel {
  derived_table: {
    sql:
with sub1 as (SELECT distinct min(MinTime) as minTime, session_id, event_name,
#page_location,
case
when event_name in ("view_item") and (Screen_name in ("product-detail-page") or regexp_contains(page_location,".*/p[0-9]{5}$|.*/p[0-9]{5}[^0-9a-zA-Z]|.*/p[A-Z]{2}[0-9]{3}$|.*/p[A-Z]{2}[0-9]{3}[^0-9a-zA-Z]") ) then "PDP"
end as screen,
platform,
aw.item_id as item_id,
aw.item_category as item_category,
aw.item_category2 as item_category2,
aw.item_category3 as item_category3,
transactions.net_value as rev,
transactions.Quantity as Qu,
transactions.OrderID
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` as aw left join unnest (transactions) as transactions
where event_name in ("page_view","view_item", "screen_view","purchase", "Purchase", "add_to_cart")
and _table_suffix between format_date("%Y%m%d", date_sub(current_date(), INTERVAL 30 day)) and format_date("%Y%m%d", date_sub(current_date(), INTERVAL 1 day))
and
      ((aw.item_id = transactions.productCode) or (aw.item_id is not null and transactions.productCode is null) or (aw.item_id is null and transactions.
      productCode is null))
group by all),

#products as (select distinct productStartDate,activeTo,productCode from `toolstation-data-storage.range.products_current`),


PDP as (select distinct platform, session_id as PDP_session_id, item_category,
item_category2,
item_category3, item_id,min(MinTime) as PDP_time
from sub1 where screen in ("PDP") and event_name in ("view_item") group by all),

ATC as (select distinct session_id as atc_session_id, item_id,min(MinTime) as atc_time from sub1 where event_name in ("add_to_cart") group by 1,2),

purchase as (select distinct session_id as purchase_session_id,item_id, min(MinTime) as purchase_time, rev, Qu, OrderID from sub1 where event_name in ("purchase", "Purchase") group by all),

#3276858
sub2 as (SELECT distinct
#row_number() over () as P_K,
coalesce(pdp.pdp_time,ATC.atc_time,purchase.purchase_time, all_purchase.purchase_time) as date,
sub1.platform,
sub1.session_id as total_sessionID,
sub1.item_id as total_item_id,
PDP.item_category,
PDP.item_category2,
PDP.item_category3,

#PDP.item_id,
PDP.pdp_session_id,
pdp.pdp_time,
ATC.atc_session_id,
atc.atc_time,
purchase.purchase_session_id,
purchase.purchase_time,
timestamp_diff(ATC.atc_time,pdp.pdp_time,second) as pdp_ATC,
timestamp_diff(purchase.purchase_time,ATC.atc_time,second) as ATC_purchase,
purchase.rev as Revenue,
purchase.Qu as Quantity,
purchase.ORderID as OrderID,
all_purchase.purchase_session_id as all_purchase_session_id,
all_purchase.rev as total_Revenue,
all_purchase.Qu as total_Quantity,
all_purchase.ORderID as total_OrderID
from Sub1
left join PDP on sub1.session_id = PDP.PDP_session_id and sub1.item_id = PDP.item_id
left join ATC on PDP.PDP_session_id = ATC.atc_session_id and PDP.item_id = ATC.item_id
left join purchase on PDP.PDP_session_id = purchase.purchase_session_id and PDP.item_id = purchase.item_id and sub1.OrderID = purchase.OrderID
left join purchase as all_purchase on sub1.session_id = all_purchase.purchase_session_id and sub1.item_id = all_purchase.item_id and sub1.OrderID = all_purchase.OrderID
where extract(date from coalesce(pdp.pdp_time,ATC.atc_time,purchase.purchase_time, all_purchase.purchase_time)) is not null)
select distinct row_number() over () as P_K, * from sub2
;;

    sql_trigger_value: SELECT EXTRACT(dayofweek FROM CURRENT_DATEtime()) between 2 and 6 and extract(hour from current_datetime()) = 13
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 7 and extract(hour from current_datetime()) = 16
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 1 and extract(hour from current_datetime()) = 16
;;
}

  dimension: P_K {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: case when date(${TABLE}.date) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(${TABLE}.date, interval 1 HOUR)) else (timestamp_add(${TABLE}.date, interval 1 HOUR)) end ;;
  }

  dimension: platform {
    type: string
    view_label: "PDP to Purchase Funnel"
    label: "Web/App"
    sql: ${TABLE}.platform ;;
  }

  dimension: itemCategory {
    type: string
    view_label: "PDP to Purchase Funnel"
    label: "1. Item Category"
    sql: ${TABLE}.item_category;;
  }

  dimension: itemCategory2 {
    type: string
    view_label: "PDP to Purchase Funnel"
    label: "2.Item Sub Category"
    sql: ${TABLE}.item_category2;;
  }

  dimension: itemCategory3 {
    type: string
    view_label: "PDP to Purchase Funnel"
    label: "3.Item Sub Sub Category"
    sql: ${TABLE}.item_category3;;
  }


  dimension: item_id {
    hidden: yes
    type: string
    sql: ${TABLE}.total_item_id ;;
  }

  dimension: pdp_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.pdp_session_id ;;
  }

  dimension: atc_session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.atc_session_id ;;
  }

  dimension: purchase_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.purchase_session_id ;;
  }

  dimension: all_purchase_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.all_purchase_session_id ;;
  }

  dimension: pdp_ATC_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.pdp_ATC;;
  }

  dimension: ATC_purchase_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.ATC_purchase;;
  }

  dimension: Revenue {
    hidden: yes
    type: number
    sql: ${TABLE}.Revenue;;
  }

  dimension: total_Revenue {
    hidden: yes
    type: number
    sql: ${TABLE}.total_Revenue;;
  }

  dimension: Quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.Quantity;;
  }

  dimension: total_Quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.total_Quantity;;
  }

  measure: pdp_sessions {
    view_label: "PDP to Purchase Funnel"
    label: "PDP sessions"
    type: count_distinct
    sql: ${pdp_sessionID};;
  }


  measure: PDP_to_atc_sessions {
    view_label: "PDP to Purchase Funnel"
    label: "PDP to ATC sessions"
    type: count_distinct
    sql: ${atc_session_id};;
    filters: [pdp_sessionID: "-NULL", pdp_ATC_seconds: ">0"]
  }

  measure: PDP_to_purchase_sessions {
    view_label: "PDP to Purchase Funnel"
    label: "ATC to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [pdp_sessionID: "-NULL", atc_session_id: "-NULL",pdp_ATC_seconds: ">0", ATC_purchase_seconds: ">0"]
  }

  measure: PDP_ATC_perc {
    view_label: "PDP to Purchase Funnel"
    label: "Add to Cart Rate"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${PDP_to_atc_sessions},${pdp_sessions}) ;;
  }

  measure: PDP_purchase_perc {
    view_label: "PDP to Purchase Funnel"
    label: "Purchase Conv Rate"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${PDP_to_purchase_sessions},${pdp_sessions}) ;;
  }

  measure: funnel_drop_off {
    view_label: "PDP to Purchase Funnel"
    label: "ATC to Purchase Drop Off"
    type: number
    value_format_name: percent_2
    sql: ${PDP_ATC_perc} - ${PDP_purchase_perc} ;;
  }

  measure: Revenue_funnel {
    view_label: "PDP to Purchase Funnel"
    label: "PDP-ATC-Purchase Revenue"
    type: sum
    sql: ${Revenue};;
    value_format_name: gbp
    filters: [pdp_sessionID: "-NULL", atc_session_id: "-NULL",pdp_ATC_seconds: ">0", ATC_purchase_seconds: ">0"]
  }

  measure: quantity_funnel {
    view_label: "PDP to Purchase Funnel"
    label: "PDP-ATC-Purchase Quantity"
    type: sum
    sql: ${Quantity};;
    filters: [pdp_sessionID: "-NULL", atc_session_id: "-NULL",pdp_ATC_seconds: ">0", ATC_purchase_seconds: ">0"]
  }

  measure: total_purchase_sessions {
    view_label: "PDP to Purchase Funnel"
    label: "Total Purchase Sessions"
    type: count_distinct
    sql: ${all_purchase_sessionID} ;;
  }

  measure: total_revenue {
    view_label: "PDP to Purchase Funnel"
    label: "Total Revenue"
    type: sum
    value_format_name: gbp
    sql: ${total_Revenue} ;;
  }

  measure: total_quantity {
    view_label: "PDP to Purchase Funnel"
    label: "Total Purchase Quantity"
    type: sum
    sql: ${total_Quantity} ;;
  }

  measure: PDP_purchase_orders {
    view_label: "PDP to Purchase Funnel"
    label: "Orders Funnel"
    type: count_distinct
    sql: ${TABLE}.OrderID ;;
  }


}
