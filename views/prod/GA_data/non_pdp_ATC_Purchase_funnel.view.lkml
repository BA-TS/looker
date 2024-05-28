view: non_pdp_atc_purchase_funnel {
  derived_table: {
    sql:

    with sub1 as (SELECT distinct min(timestamp_sub(MinTime, interval 1 HOUR)) as minTime, session_id, case when event_name in ("screen_view") then "page_view" else event_name end as event_name,
case when page_location is null then #concat
#(case
#when Screen_name like "%| Search |%" then "search-page"
#else screen_name
#end
#, aw.item_id
#)
Screen_name else page_location end as page_location,
case when Screen_name like "%| Search |%" then "search-page"
when regexp_contains(page_location,"search\\?q") then "search-page"
when regexp_contains(page_location,"trade\\-credit.*apply") then "Trade credit application"
when regexp_contains(page_location,"club.*apply") and Screen_name in ("Toolstation") then "Join The Toolstation Club | Toolstation"
when not regexp_contains(page_location,"club.*apply") and regexp_contains(page_location,"register") and screen_name in ("Toolstation") then "Create my account"
when regexp_contains(page_location,"account\\/trade\\-account") and screen_name in ("Toolstation") then "Manage my account"

when regexp_contains(page_location,"checkout\\/review") then "Review & Pay"
when regexp_contains(page_location,"\\/checkout\\/confirmation\\/") then "Confirmation"
when regexp_contains(page_location,"\\/trolley") then "Trolley"
else screen_name
end as screen,
platform,
transactions.net_value as rev,
transactions.Quantity as Qu,
transactions.OrderID,
aw.item_id
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` as aw left join unnest (transactions) as transactions
where
#event_name in ("page_view","view_item", "screen_view","purchase", "Purchase", "add_to_cart") and
bounces = 1
and _table_suffix between format_date("%Y%m%d", date_sub(current_date(), INTERVAL 30 day)) and format_date("%Y%m%d", date_sub(current_date(), INTERVAL 1 day))
and
      ((aw.item_id = transactions.productCode) or (aw.item_id is not null and transactions.productCode is null) or (aw.item_id is null and transactions.
      productCode is null))
group by 2,3,4,5,6,7,8,9,10),

Page as (select distinct session_id as page_session_id,screen,page_location as Page_page, case when item_id is null then null else item_id end as item_id,min(MinTime) as page_time
from sub1 inner join
(
    with suba as (SELECT distinct
event_name,
screen,
count(distinct  session_id) as sessions
FROM sub1
group by 1,2),

subb as (select distinct *, row_number() over (partition by screen order by sessions desc) as rw
from suba)

SELECT distinct Screen as top_screem, event_name as top_event, sum(sessions) as sessions from subb where rw = 1
group by 1,2
) on screen = top_screem and event_name=top_event group by 1,2,3,4),

ATC as (select distinct session_id as atc_session_id, screen,item_id,page_location as ATC_page, min(MinTime) as atc_time from sub1 where event_name in ("add_to_cart") group by 1,2,3,4),

purchase as (select distinct session_id as purchase_session_id, min(MinTime) as purchase_time, sum(rev) as net_rev, sum(Qu) as purchase_quantity, item_id, OrderID from sub1 where event_name in ("purchase", "Purchase") group by 1,5,6),


sub2 as (SELECT distinct
extract(date from coalesce(page.page_time,ATC.atc_time)) as date,
page.screen,
page.page_page,
page.item_id as pageItem_id,
ATC.item_id as item_id,
ATC.ATC_page as ATC_page,
page.page_session_id,
page.page_time as page_time,
ATC.atc_session_id,
atc.atc_time,
purchase.purchase_session_id,
purchase.purchase_time,
timestamp_diff(ATC.atc_time,page.page_time,second) as page_ATC,
timestamp_diff(purchase.purchase_time,ATC.atc_time,second) as ATC_purchase,
timestamp_diff(purchase.purchase_time,page.page_time,millisecond) as page_purchase,
purchase.net_rev as Revenue,
purchase.purchase_quantity as Quantity,
purchase.ORderID as OrderID,
from Page
left join ATC on page.page_session_id = ATC.atc_session_id and page.page_page=ATC.ATC_page
left join purchase on ATC.ATC_session_id = purchase.purchase_session_id and page.page_session_id = purchase.purchase_session_id and ATC.item_id = purchase.item_id
)
select distinct row_number() over () as P_K, * from sub2
where ((pageItem_ID=item_id) or (pageItem_ID is null) or (item_id is null))
  ;;


  sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 8
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

  dimension: screen {
    view_label: "Page to Purchase Funnel"
    label: "Screen type"
    type: string
    sql: ${TABLE}.Screen ;;
  }

  dimension: page_location {
    view_label: "Page to Purchase Funnel"
    label: "Page"
    type: string
    sql: ${TABLE}.page_page ;;
  }

  dimension: page_session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.page_session_id ;;
  }

  dimension: atc_session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.atc_session_id ;;
  }

  dimension: purchase_session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.purchase_session_id ;;
  }

  dimension: page_ATC_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.page_ATC;;
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

  dimension: OrderID {
    hidden: yes
    type: string
    sql: ${TABLE}.OrderID ;;
  }

  dimension: Page_item_id {
    hidden: yes
    type: string
    sql: ${TABLE}.pageItem_id ;;
  }

  dimension: ATC_item_id {
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_id {
    hidden: yes
    type: string
    sql: coalesce(${Page_item_id},${ATC_item_id}) ;;
  }

  measure: page_sessions {
    view_label: "Page to Purchase Funnel"
    label: "Unique Page Views"
    type: count_distinct
    sql: ${page_session_id};;
  }

  measure: Page_to_atc_sessions {
    view_label: "Page to Purchase Funnel"
    label: "Page to ATC sessions"
    type: count_distinct
    sql:${atc_session_id};;
    filters: [page_session_id: "-NULL", page_ATC_seconds: ">0"]
  }

  measure: Page_to_purchase_sessions {
    view_label: "Page to Purchase Funnel"
    label: "Page to Purchase sessions"
    type: count_distinct
    sql: ${purchase_session_id};;
    filters: [page_session_id: "-NULL", atc_session_id: "-NULL",page_ATC_seconds: ">0", ATC_purchase_seconds: ">0"]
  }

  measure: Page_ATC_perc {
    view_label: "Page to Purchase Funnel"
    label: "Add to Cart Rate"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${Page_to_atc_sessions},${page_sessions}) ;;
  }

  measure: Page_purchase_perc {
    view_label: "Page to Purchase Funnel"
    label: "Purchase Conv Rate"
    type: number
    value_format_name: percent_2
    sql: SAFE_DIVIDE(${Page_to_purchase_sessions},${page_sessions}) ;;
  }

  measure: funnel_drop_off {
    view_label: "Page to Purchase Funnel"
    label: "ATC to Purchase Drop Off"
    type: number
    value_format_name: percent_2
    sql: ${Page_ATC_perc} - ${Page_purchase_perc} ;;
  }

  measure: Revenue_funnel {
    view_label: "Page to Purchase Funnel"
    label: "Funnel Revenue"
    type: sum
    sql: ${Revenue};;
    value_format_name: gbp
    filters: [page_session_id: "-NULL", atc_session_id: "-NULL",page_ATC_seconds: ">0", ATC_purchase_seconds: ">0"]
  }

  measure: quantity_funnel {
    view_label: "Page to Purchase Funnel"
    label: "Funnel Purchase Quantity"
    type: sum
    sql: ${Quantity};;
    filters: [page_session_id: "-NULL", atc_session_id: "-NULL",page_ATC_seconds: ">0", ATC_purchase_seconds: ">0"]
  }

  measure: Page_purchase_orders {
    view_label: "Page to Purchase Funnel"
    label: "Orders Funnel"
    type: count_distinct
    sql: ${OrderID};;
  }

}
