view: page_type_to_purchase_funnel {
  derived_table: {
    sql:
    with sub1 as (SELECT distinct min(timestamp_sub(MinTime, interval 1 HOUR)) as minTime, session_id, event_name,
#page_location,
case
when Screen_name in ("product-detail-page") and event_name in ("view_item") and platform in ("Web") then "PDP"
when Screen_name in ("product-detail-page") and event_name in ("view_item") and platform in ("App") then "PDP"
end as screen,
platform,
aw.item_id as item_id,
transactions.net_value as rev,
transactions.Quantity as Qu,
transactions.OrderID
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` as aw left join unnest (transactions) as transactions
where event_name in ("page_view","view_item", "screen_view","purchase", "Purchase", "add_to_cart")
and bounces = 1
and _table_suffix between format_date("%Y%m%d", date_sub(current_date(), INTERVAL 20 day)) and format_date("%Y%m%d", date_sub(current_date(), INTERVAL 1 day))
and
      ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.
      item_id is null))
group by 2,3,4,5,6,7,8,9),

#products as (select distinct productStartDate,activeTo,productCode from `toolstation-data-storage.range.products_current`),


PDP as (select distinct platform, session_id as PDP_session_id, item_id,min(MinTime) as PDP_time
from sub1 where screen in ("PDP") and event_name in ("view_item") group by 1,2,3),

ATC as (select distinct session_id as atc_session_id, item_id,min(MinTime) as atc_time from sub1 where event_name in ("add_to_cart") group by 1,2),

purchase as (select distinct session_id as purchase_session_id,item_id, min(MinTime) as purchase_time, rev, Qu, OrderID from sub1 where event_name in ("purchase", "Purchase") group by 1,2,4,5,6)


SELECT distinct
row_number() over () as P_K,
extract(date from coalesce(pdp.pdp_time,ATC.atc_time,purchase.purchase_time)) as date,
platform,
PDP.item_id,
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
purchase.ORderID as OrderID
from PDP
left join ATC on PDP.PDP_session_id = ATC.atc_session_id and PDP.item_id = ATC.item_id
left join purchase on PDP.PDP_session_id = purchase.purchase_session_id and PDP.item_id = purchase.item_id
;;

sql_trigger_value: SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*10)/(60*60*24))
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
    sql: ${TABLE}.date ;;
  }

  dimension: platform {
    type: string
    view_label: "PDP to Purchase Funnel"
    label: "Web/App"
    sql: ${TABLE}.platform ;;
  }

  dimension: item_id {
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
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

  dimension: Quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.Quantity;;
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
    sql: ${PDP_to_atc_sessions}/${pdp_sessions} ;;
  }

  measure: PDP_purchase_perc {
    view_label: "PDP to Purchase Funnel"
    label: "Purchase Conv Rate"
    type: number
    value_format_name: percent_2
    sql: ${PDP_to_purchase_sessions}/${pdp_sessions} ;;
  }

  measure: funnel_drop_off {
    view_label: "PDP to Purchase Funnel"
    label: "ATC to Purchase Drop Off"
    type: number
    value_format_name: percent_2
    sql: ${PDP_to_atc_sessions} - ${PDP_to_purchase_sessions} ;;
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


}
