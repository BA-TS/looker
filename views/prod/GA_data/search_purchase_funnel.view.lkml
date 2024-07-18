view: search_purchase_funnel {
  derived_table: {
    sql: (with sub1 as (SELECT distinct
MinTime as dateTime,
event_name,
case when regexp_contains(page_location, "\\&") then regexp_extract(page_location, "(.*)\\&.*") else page_location end as page_location,
case when event_name in ("search_actions") then key_1 else null end as contentT,
coalesce(case when event_name in ("search_actions") and key_1 in ("Searched Term") then label_1 else null end,
case when regexp_contains(page_location, "\\&") then
regexp_replace(regexp_extract(page_location, ".*q\\=(.*)\\&.*"), "\\+", " ") else regexp_replace(regexp_extract(page_location, ".*q\\=(.*)$"), "\\+", " ") end) as searchTerm,
item_id,
item_category,
session_id,
t.net_value as item_revenue,
t.Quantity,
t.OrderId
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` a left join unnest(transactions) as t
 #, unnest(event_params) as ep left join unnest(items) as items
 where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 10 daY)) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 1 daY)) and
 event_name in ("add_to_cart", "search_actions", "purchase")
 and ((a.item_id=t.productCode) or (a.item_id is not null and t.productCode is null) or (a.item_id is null and t.productCode is null))
 and platform in ("Web")
 group by all),

 search as (SELECT distinct min(dateTime) as search_Time,
page_location as search_page,
searchTerm,

session_id as search_sessions from sub1 where event_name in ("search_actions") and

regexp_contains(page_location, "search\\?") and contentT in ("Searched Term") group by all ),

atc as (SELECT distinct min(dateTime) as atc_Time,
 page_location as atcP,
searchTerm,
item_id,
item_category,
session_id as atc_sessions from sub1 where event_name in ("add_to_cart") and

regexp_contains(page_location, "search\\?") group by all ),

purchase as (SELECT distinct min(dateTime) as purchase_Time, item_id as purchase_itemID, item_revenue as rev, quantity, session_id as purchase_id, OrderID from sub1 where event_name in ("purchase") group by all)

select distinct concat("Web",cast(row_number() over () as string)) as PK,"Web" as Platform, search_sessions as search_sessionID, search.search_time as searchTime, search_page, null as search_screenID, search.searchTerm,
atc.atc_sessions, atc_time, atcp as atc_screen, null as atc_screenID,item_id,item_category,

purchase_id as purchase_sessionID, OrderID, purchase_time, rev as purchase_rev,  quantity from search left join atc on
search.search_sessions = atc.atc_sessions and search.search_page = atc.atcP
left join purchase on search.search_sessions = purchase.purchase_id and atc.item_id = purchase.purchase_itemID
where (atc_time > search_time or atc_time is null)
and (purchase_time > atc_time or purchase_time is null or atc_time is null))
union distinct
(with sub1 as (SELECT distinct min(timestamp_micros(event_timestamp)) as dateTime, event_name,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) as session_id,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') as screen,
(SELECT distinct (value.int_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen_id') as screen_id,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key in ("search_term", "query", "product_code", "category_id")) as query,
items.item_id,
items.item_category,
items.item_revenue,
items.quantity,
ecommerce.transaction_id as ORderID
FROM `toolstation-data-storage.analytics_265133009.events_*` left join unnest(items) as items
where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 10 daY)) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 1 daY)) and (event_name in ("add_to_cart", "purchase", "search"))
group by all),

search as (Select distinct min(dateTime) as searchTime, event_name, screen as search_screen, screen_id as search_screenID, query, session_id as Search_sessionID from sub1 where regexp_contains(event_name, "^search")
group by all),

atc as (Select distinct dateTime as atc_Time, event_name, screen as atc_screen, screen_id as atc_screenID, session_id as atc_sessionID, item_id, item_category from sub1 where event_name in ("add_to_cart")),

purchase as (Select distinct dateTime as purchase_Time, session_id as purchase_sessionID, item_id as purchase_id, item_revenue as purchase_rev, quantity, OrderID from sub1 where event_name in ("purchase"))

  SELECT distinct concat("APP",cast(row_number() over () as string)) as PK, "App" as Platform, search_sessionID, searchTime, search_screen as search_page, search_screenID,   query as searchTerm,

 atc.atc_sessionID, atc_time, atc.atc_screen, atc.atc_screenID, atc.item_id, item_category,

purchase.purchase_sessionID, OrderID,purchase.purchase_time, purchase.purchase_rev, quantity

from search
left join atc on search.Search_sessionID = atc.atc_sessionID and search.search_screenID = (atc.atc_screenID - 1)
left join purchase on atc.atc_sessionID = purchase.purchase_sessionID and atc.item_id = purchase.purchase_id
where (atc_time > searchTime or atc_time is null)
and (purchase_time > atc_time or purchase_time is null or atc_time is null))
;;

sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 11;;
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
    sql: ${TABLE}.Platform ;;
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
    sql: ${TABLE}.search_sessionID ;;
  }

  dimension: ATC_sessionID {
    description: "ATC session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.atc_sessions ;;
  }

  dimension: Purchase_sessionID {
    description: "Purchase session ID"
    type: string
    hidden: yes
    sql: ${TABLE}.purchase_sessionID ;;
  }

  dimension_group: atcTime {
    description: "Date of ATC_event"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.atc_Time ;;
  }

  dimension_group: PurchaseTime {
    description: "Date of purchase time"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.purchase_time ;;
  }

  dimension: search_page {
    description: "search page"
    group_label: "Non Blank Search"
    label: "Search Page"
    hidden: yes
    type: string
    sql: ${TABLE}.search_page ;;
  }

  dimension: atc_page {
    description: "ATC page"
    group_label: "Non Blank Search"
    label: "ATC Page"
    hidden: yes
    type: string
    sql: ${TABLE}.atc_screen ;;
  }

  dimension: search_screenID {
    description: "search screen ID (App Only)"
    type: string
    hidden: yes
    sql: ${TABLE}.search_screenID ;;
  }

  dimension: atc_screenID {
    description: "atc screen ID (App Only)"
    type: string
    hidden: yes
    sql: ${TABLE}.atc_screenID ;;
  }

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
    sql: ${TABLE}.purchase_rev ;;
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
    sql: ${TABLE}.quantity ;;
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
    sql: ${TABLE}.OrderID ;;
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

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 11;;
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
