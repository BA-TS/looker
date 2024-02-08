view: non_pdp_atc_purchase_funnel {
  derived_table: {
    sql:    with sub1 as (SELECT distinct min(timestamp_sub(MinTime, interval 1 HOUR)) as minTime, session_id, event_name,
case
when Screen_name in ("product-detail-page") and event_name in ("view_item") and platform in ("Web") then "PDP"
when Screen_name in ("product-detail-page") and event_name in ("view_item") and platform in ("App") then "PDP"
when Screen_name like "%| Search |%" then "search-page"
else screen_name
end as screen,
platform,
transactions.net_value as rev,
transactions.Quantity as Qu,
transactions.OrderID
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` as aw left join unnest (transactions) as transactions
where event_name in ("page_view","view_item", "screen_view","purchase", "Purchase", "add_to_cart")
and bounces = 1
and _table_suffix between format_date("%Y%m%d", date_sub(current_date(), INTERVAL 30 day)) and format_date("%Y%m%d", date_sub(current_date(), INTERVAL 1 day))
and
      ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.
      item_id is null))
group by 2,3,4,5,6,7,8),

Page as (select distinct platform, session_id as page_session_id,screen, min(MinTime) as page_time
from sub1 where (screen in ("PDP") and event_name in ("view_item")) or (screen not in ('product-detail-page') and event_name in ("page_view", "screen_view")) group by 1,2,3),

ATC as (select distinct session_id as atc_session_id, screen,min(MinTime) as atc_time from sub1 where event_name in ("add_to_cart") group by 1,2),

purchase as (select distinct session_id as purchase_session_id, min(MinTime) as purchase_time, sum(rev) as net_rev, sum(Qu) as purchase_quantity, OrderID from sub1 where event_name in ("purchase", "Purchase") group by 1,5),

sub2 as (SELECT distinct
extract(date from coalesce(page.page_time,ATC.atc_time,purchase.purchase_time)) as date,
page.screen,
page.page_session_id,
page.page_time,
ATC.atc_session_id,
atc.atc_time,
purchase.purchase_session_id,
purchase.purchase_time,
timestamp_diff(ATC.atc_time,page.page_time,second) as page_ATC,
timestamp_diff(purchase.purchase_time,ATC.atc_time,second) as ATC_purchase,
purchase.net_rev as Revenue,
purchase.purchase_quantity as Quantity,
purchase.ORderID as OrderID,
from Page
left join ATC on page.page_session_id = ATC.atc_session_id and page.screen = (case when ATC.screen in ("product-detail-page") then "PDP" else ATC.screen end)
left join purchase on ATC.ATC_session_id = purchase.purchase_session_id
where extract(date from coalesce(page.page_time,ATC.atc_time,purchase.purchase_time)) is not null)

select distinct row_number() over () as P_K, * from sub2
  ;;


  sql_trigger_value: SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*9)/(60*60*24))
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
    sql: ${atc_session_id};;
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
    sql: ${OrderID} ;;
  }

}
