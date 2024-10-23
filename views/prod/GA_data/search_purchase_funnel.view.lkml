view: search_purchase_funnel {
  derived_table: {
    sql: with sub1 as (SELECT distinct dense_rank() over (partition by session_id order by minTime asc) as rowNum , platform, event_name, key_1, page_location, item_id, item_category, tra.productCode, session_id, minTime, sum(tra.ga4_quantity) as quantity, sum(value) as value , sum(tra.ga4_revenue) as ga4_value, sum(tra.net_value) as netValue, coalesce(case when regexp_contains(label_1,"^c[0-9]*$") then null else label_1 end,
regexp_replace(regexp_extract(page_location, ".*q\\=(.*)$"), "\\+", " ")) as searchTerm, tra.ORderID
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as tra
where _TABLE_SUFFIX Between FORMAT_DATE('%Y%m%d', date_sub(current_date(), interval 50 day)) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), interval 1 day))

and event_name in ("search", "search_actions", "view_item_list", "add_to_cart","purchase")
and platform in ("Web")
group by all),

search as (SELECT distinct rowNum, platform, event_name,key_1,page_location, session_id, minTime, searchTerm from sub1
where event_name in ("search_actions") and key_1 in ("Searched Term", "search_term")),

VIT as (SELECT distinct rowNum, event_name,key_1,page_location, session_id, minTime, item_id, productCode, quantity from sub1
where event_name in ("view_item_list")),

ATC as (SELECT distinct rowNum, event_name,key_1,page_location, session_id, minTime, item_id, item_category, productCode, quantity from sub1
where event_name in ("add_to_cart")),

purchase as (SELECT distinct event_name, session_id, minTime, ORderID, item_id, productCode, quantity, ga4_value, sub1.netValue from sub1
where event_name in ("purchase"))

SELECT distinct concat( cast(row_number() over() as string), Platform) as PK, searchTime, platform, searchTerm, searchSessionID as searchSession, VITSession as VITSessions, string_agg(ATCitemID) as item_id, string_agg(item_category) as item_category, string_agg(ATCSessions) as ATCSessions, string_agg(purchaseSession) as purchaseSessions,
string_Agg(OrderID) as ORders, sum(ga4_value) as GA4Value, sum(netValue) as netValue, sum(purchaseQuant) as productQuant from

(SELECT distinct

SearchTime,
platform,
searchSessionID,
searchTerm,
VITSession,
ATCSessions,
ATCitemID,
item_category,
ATCQuant,
purchaseSession,
OrderID,
PurchaseITemID,
purchaseQuant,
ga4_value,
netValue

from

(

SELECT distinct search.platform, search.session_id as searchSessionID, date(datetime_add(Search.minTime, interval 1 hour)) as SearchTime, search.page_location as searchPage, search.searchTerm, VIT.session_id as VITSession,
ATC.session_id as ATCSessions,
ATC.minTime as ATCTIME,
ATC.item_id as ATCitemID,
ATC.item_category,
ATC.quantity as ATCQuant,
ATC.page_location as ATCPage, ATC.rowNum as ATCRowNum,
purchase.session_id as purchaseSession, purchase.OrderID, purchase.item_id as PurchaseITemID, purchase.quantity as purchaseQuant, purchase.ga4_value, purchase.netValue, purchase.minTime as PurchaseTime
from search
left join VIT on search.session_id = VIT.session_id and search.page_location = VIT.page_location
LEFT join ATC on VIT.session_id = ATC.session_id and VIT.item_id = ATC.item_id and VIT.minTime < ATC.MinTime and search.rowNum = (ATC.rowNum -1)
left join purchase on search.session_id = purchase.session_id and ATC.item_id = purchase.item_id and ATC.minTime < purchase.MinTime

)
group by all)

group by all
union distinct
(with sub1 as (SELECT distinct
row_number() over (partition by session_id order by minTime asc) as rowNum,
MinTime as dateTime,
platform,
event_name,
session_id,
screen_name,
page_location,
coalesce(case when event_name in ("search") and key_1 in ("search_term") then label_1 else null end, case when event_name in ("search") then item_id else null end
) as searchTerm,
item_id,
item_category,
t.ga4_revenue as ga4_value,
t.net_value as netValue,
coalesce(t.Quantity, t.ga4_quantity) as Quantity,
t.OrderId
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` a left join unnest(transactions) as t
 where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 50 day)) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 1 day)) and
 event_name in ("add_to_cart", "search", "purchase", "search_product_tapped", "view_item", "product_image_viewed")
 and platform in ("App")
 group by all),

search as (

 Select distinct min(dateTime) as searchTime, platform, rowNum, event_name, screen_name as search_screen, page_location as search_screenID, searchTerm as query, session_id as Search_sessionID from sub1 where event_name in ("search")
group by all),

PCS as (Select distinct min(dateTime) as productSTime, rowNum,event_name, screen_name as productS_screen, page_location as productS_screenID, item_id as itemIDv2, session_id as productSID from sub1 where screen_name in ("search-page") and event_name in ("search_product_tapped", "view_item", "product_image_viewed")
group by all),

atc as (Select distinct dateTime as atc_Time, rowNum,event_name, screen_name as atc_screen, page_location as atc_screenID, session_id as atc_sessionID, item_id, item_category from sub1 where event_name in ("add_to_cart")),

purchase as (Select distinct dateTime as purchase_Time, rowNum,session_id as purchase_sessionID, item_id as purchase_id, ga4_value,netValue, quantity, OrderID from sub1 where event_name in ("purchase"))

SELECT distinct
concat( cast(row_number() over() as string), Platform) as PK,
date(datetime_add(SearchTime, interval 1 hour)) as searchDate,

platform,
searchTerm,
search_sessionID as searcSessions,
productSID as ProsearcSessions,
item_id,
category,
atc_sessionID as ATCsessions,
purchase_sessionID as purchaseSessions,
OrderID as ORders,
sum(ga4_value) as ga4Value,
sum(netValue) as netValue,
sum(quantity) as quantity
from

(

SELECT distinct concat("APP",cast(row_number() over () as string)) as PK, Platform, search_sessionID, searchTime, search_screen as search_page, cast(search_screenID as int64) as screenID,   query as searchTerm,
PCS.event_name,PCS.productS_screen, PCS.productSID, pcs.productSTime,itemIDv2,
coalesce(atc.atc_sessionID,atc2.atc_sessionID) as ATC_sessionID, coalesce(atc.atc_time,atc2.atc_time) as ATC_Time, coalesce(atc.atc_screen,atc2.atc_screen) as ATC_screen, coalesce(cast(atc.atc_screenID as int64),cast(atc2.atc_screenID as int64)) as atcScreenID, coalesce(atc.item_id,atc2.item_id) as item_id, coalesce(atc.item_category,atc2.item_category) as category,

purchase.purchase_sessionID, OrderID,purchase.purchase_time, purchase.purchase_id, ga4_value,netValue, quantity

from search
left join PCS on search.Search_sessionID = PCS.productSID and PCS.productS_screenID = search.search_screenID
left join atc on PCS.productSID = atc.atc_sessionID and  atc_time > PCS.productSTime and PCS.itemIDv2 = atc.item_id
left join atc as atc2  on search.Search_sessionID =atc2.atc_sessionID and cast(search.search_screenID as int64) = (cast(atc2.atc_screenID as int64) - 1) and atc2.atc_time > searchTime and search.rowNum = (atc2.rowNum - 1)
left join purchase on coalesce(atc.atc_sessionID,atc2.atc_sessionID) = purchase.purchase_sessionID and coalesce(atc.item_id,atc2.item_id) = purchase.purchase_id and purchase_time > coalesce(atc.atc_time,atc2.atc_time)
order by OrderID desc

)
group by all)
;;

sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 13;;
}


  dimension: P_K {
    description: "PK"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK ;;
  }

  dimension: Platform {
    description: "Platform used App/Web"
    group_label: "Non Blank Search"
    label: "Platform"
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension_group: search_date {
    description: "Date of search_event"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.searchTime ;;
  }

  dimension: search_sessionID {
    description: "search session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.searchSession ;;
  }

  dimension: ATC_sessionID {
    description: "ATC session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.ATCSessions ;;
  }

  dimension: Purchase_sessionID {
    description: "Purchase session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.purchaseSessions ;;
  }

  #dimension_group: atcTime {
    #description: "Date of ATC_event"
    #type: time
    #hidden: yes
    #timeframes: [raw,date]
    #sql: ${TABLE}.atc_Time ;;
  #}

  #dimension_group: PurchaseTime {
    #description: "Date of purchase time"
    #type: time
    #hidden: yes
    #timeframes: [raw,date]
    #sql: ${TABLE}.purchase_time ;;
  #}

  #dimension: search_page {
    #description: "search page"
    #group_label: "Non Blank Search"
    #label: "Search Page"
    #hidden: yes
    #type: string
    #sql: ${TABLE}.search_page ;;
  #}

  #dimension: atc_page {
    #description: "ATC page"
    #group_label: "Non Blank Search"
    #label: "ATC Page"
    #hidden: yes
    #type: string
    #sql: ${TABLE}.atc_screen ;;
  #}

  #dimension: search_screenID {
    #description: "search screen ID (App Only)"
    #type: string
    #hidden: yes
    #sql: ${TABLE}.search_screenID ;;
  #}

  #dimension: atc_screenID {
    #description: "atc screen ID (App Only)"
    #type: string
    #hidden: yes
    #sql: ${TABLE}.atc_screenID ;;
  #}

  dimension: search_term {
    description: "search term"
    group_label: "Non Blank Search"
    label: "Search Term"
    type: string
    sql: ${TABLE}.searchTerm ;;
  }

  dimension: Rev {
    description: "Purchase Rev"
    hidden: yes
    type: number
    sql: ${TABLE}.netValue ;;
  }

  measure: purchase_rev {
    group_label: "Non Blank Search"
    label: "Item Revenue"
    type: sum
    value_format_name: gbp
    sql:${Rev};;
  }

  dimension: Quantity {
    description: "Purchase Quantity"
    hidden: yes
    type: number
    sql: ${TABLE}.productQuant ;;
  }

  measure: purchase_Quant {
    group_label: "Non Blank Search"
    label: "Units"
    type: sum
    sql:${Quantity};;
  }

  dimension: item_id {
    group_label: "Non Blank Search"
    label: "Item ID"
    description: "item_id"
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_category {
    group_label: "Non Blank Search"
    label: "Item Category"
    description: "Item Category"
    hidden: yes
    type: string
    sql: ${TABLE}.item_category ;;
  }

  measure: Search_sessions {
    group_label: "Non Blank Search"
    label: "Search Sessions"
    type: count_distinct
    sql: ${search_sessionID} ;;
  }

  measure: ATC_sessions {
    group_label: "Non Blank Search"
    label: "Search to ATC sessions"
    type: count_distinct
    sql: ${ATC_sessionID} ;;
  }

  measure: purchase_sessions {
    group_label: "Non Blank Search"
    label: "Search to Purchase sessions"
    type: count_distinct
    sql: ${Purchase_sessionID} ;;
  }

  measure: atc_conversion {
    group_label: "Non Blank Search"
    label: "Search to ATC rate %"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${ATC_sessions}, ${Search_sessions}) ;;
  }

  measure: purchase_conversion {
    group_label: "Non Blank Search"
    label: "Search to Purchase rate %"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions}, ${Search_sessions}) ;;
  }

  dimension: OrderID {
    hidden: yes
    label: "Order ID"
    description: "Order ID"
    type: string
    sql: ${TABLE}.Orders ;;
  }

  measure: Orders {
    group_label: "Non Blank Search"
    label: "Orders"
    description: "Orders where user added to cart from search page"
    type: count_distinct
    sql: ${OrderID} ;;
  }

  measure: units_per_order {
    group_label: "Non Blank Search"
    label: "Units per Order"
    type: number
    value_format_name: decimal_2
    sql: safe_divide(${purchase_Quant}, ${Orders}) ;;
  }

 }

view: blank_search_purchase_funnel {
  derived_table: {
    sql: with sub1 as (SELECT distinct P_K, session_id,minTime, event_name,

coalesce(case when event_name in ("search_actions") and key_1 in ("Searched Term") then label_1 else null end,
case when regexp_contains(page_location, "\\&") then
regexp_replace(regexp_extract(page_location, ".*q\\=(.*)\\&.*"), "\\+", " ") else regexp_replace(regexp_extract(page_location, ".*q\\=(.*)$"), "\\+", " ") end) as searchTerm,
label_1,
a.item_id,
t.productCode, t.Net_value, t.Quantity, t.ORderID
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` as a left join unnest(transactions) as t
where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 10 daY)) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 1 daY))
 and ((a.item_id=t.productCode) or (a.item_id is not null and t.productCode is null) or (a.item_id is null and t.productCode is null))
 and event_name in ("blank_search", "purchase", "add_to_cart")),

 search as (select distinct minTime as searchTime, searchTerm, session_id as Search_session from sub1 where event_name in ("blank_search")
 group by all),

 atc as (select distinct minTime as atc_Time, item_id, session_id as atc_session from sub1 where event_name in ("add_to_cart")
 group by all),

purchase as (select distinct minTime as PurchaseTime, productCode, Net_value,Quantity, OrderID, session_id as purchase_session from sub1 where event_name in ("purchase")
 group by all)

 select distinct row_number() over () as PK, search_session, searchTime, searchTerm,
 atc_session, atc_time, item_id,
 purchase_session, purchaseTime, productCode, Net_value,Quantity, OrderID
 from search left join atc on search_session = atc_Session and searchTime < atc_Time
 left join purchase on atc_session = purchase_session and atc_time < purchaseTime and item_id = productCode ;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 13;;
  }

  dimension: P_K {
    description: "PK"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK ;;
  }

  dimension_group: Blanksearch_date {
    description: "Date of search_event"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.searchTime ;;
  }

  dimension: blank_sessionID {
    description: "Blank search session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.search_session ;;
  }

  dimension: blank_searchTerm {
    description: "Blank search Term"
    group_label: "Blank Search"
    label: "Search Term"
    type: string
    sql: ${TABLE}.searchTerm ;;
  }

  dimension: ATC_sessionID {
    description: "ATC session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.atc_session ;;
  }

  dimension_group: atcTime {
    description: "Date of ATC_event"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.atc_Time ;;
  }

  dimension: item_id {
    hidden: yes
    description: "item_id"
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: purchase_sessionID {
    description: "purchase session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.purchase_session ;;
  }

  dimension_group: purchaseTime {
    description: "Date of purchase_event"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.purchaseTime ;;
  }

  dimension: productCode {
    hidden: yes
    description: "productCode"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: netValue_ {
    hidden: yes
    type: number
    sql: ${TABLE}.Net_value ;;
  }

  measure: NetValue {
    description: "Net value of items after blank search"
    group_label: "Blank Search"
    label: "Net Value"
    type: sum
    value_format_name: gbp
    sql: ${netValue_} ;;
  }

  dimension: quant_ {
    hidden: yes
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  measure: Units {
    description: "Net value of items after blank search"
    group_label: "Blank Search"
    label: "Units"
    type: sum
    sql: ${quant_} ;;
  }

  dimension: OrderID {
    label: "Order ID"
    description: "Order ID"
    hidden: yes
    type: string
    sql: ${TABLE}.OrderID ;;
  }

  measure: Orders {
    group_label: "Blank Search"
    label: "Orders"
    description: "Orders where user added to cart from search page"
    type: count_distinct
    sql: ${OrderID} ;;
  }

  measure: units_per_order {
    group_label: "Blank Search"
    label: "Units per Order"
    type: number
    value_format_name: decimal_2
    sql: safe_divide(${Units}, ${Orders}) ;;
  }

  measure: BlankSearch_sessions {
    group_label: "Blank Search"
    label: "Blank Search Sessions"
    type: count_distinct
    sql: ${blank_sessionID} ;;
  }

  measure: ATC_sessions {
    group_label: "Blank Search"
    label: "Blank Search to ATC Sessions"
    type: count_distinct
    sql: ${ATC_sessionID} ;;
  }

  measure: ATC_rate {
    group_label: "Blank Search"
    label: "Blank Search to ATC Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${ATC_sessions}, ${BlankSearch_sessions}) ;;
  }

  measure: purchase_sessions {
    group_label: "Blank Search"
    label: "Blank Search to Purchase Sessions"
    type: count_distinct
    sql: ${purchase_sessionID} ;;
  }

  measure: purchase_rate {
    group_label: "Blank Search"
    label: "Blank Search to Purchase Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions}, ${BlankSearch_sessions}) ;;
  }
}
