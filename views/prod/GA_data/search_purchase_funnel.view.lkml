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
t.Quantity
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

purchase as (SELECT distinct min(dateTime) as purchase_Time, item_id as purchase_itemID, item_revenue as rev, quantity, session_id as purchase_id from sub1 where event_name in ("purchase") group by all)

select distinct concat("Web",cast(row_number() over () as string)) as PK,"Web" as Platform, search_sessions as search_sessionID, search.search_time as searchTime, search_page, null as search_screenID, search.searchTerm,
atc.atc_sessions, atc_time, atcp as atc_screen, null as atc_screenID,item_id,item_category,

purchase_id as purchase_sessionID, purchase_time, rev as purchase_rev,  quantity from search left join atc on
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
items.quantity
FROM `toolstation-data-storage.analytics_265133009.events_*` left join unnest(items) as items
where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 10 daY)) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 1 daY)) and (event_name in ("add_to_cart", "purchase", "search"))
group by all),

search as (Select distinct min(dateTime) as searchTime, event_name, screen as search_screen, screen_id as search_screenID, query, session_id as Search_sessionID from sub1 where regexp_contains(event_name, "^search")
group by all),

atc as (Select distinct dateTime as atc_Time, event_name, screen as atc_screen, screen_id as atc_screenID, session_id as atc_sessionID, item_id, item_category from sub1 where event_name in ("add_to_cart")),

purchase as (Select distinct dateTime as purchase_Time, session_id as purchase_sessionID, item_id as purchase_id, item_revenue as purchase_rev, quantity from sub1 where event_name in ("purchase"))

  SELECT distinct concat("APP",cast(row_number() over () as string)) as PK, "App" as Platform, search_sessionID, searchTime, search_screen as search_page, search_screenID,  query as searchTerm,

 atc.atc_sessionID, atc_time, atc.atc_screen, atc.atc_screenID, atc.item_id, item_category,

purchase.purchase_sessionID,purchase.purchase_time, purchase.purchase_rev, quantity

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
    type: string
    sql: ${TABLE}.search_page ;;
  }

  dimension: atc_page {
    description: "ATC page"
    type: string
    sql: ${TABLE}.atc_page ;;
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
    type: sum
    value_format_name: gbp
    sql:${Quantity};;
  }

  dimension: item_id {
    description: "item_id"
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_category {
    description: "Item Category"
    type: string
    sql: ${TABLE}.item_category ;;
  }

  measure: Search_sessions {
    type: count_distinct
    sql: ${search_sessionID} ;;
  }

  measure: ATC_sessions {
    type: count_distinct
    sql: ${ATC_sessionID} ;;
  }

  measure: purchase_sessions {
    type: count_distinct
    sql: ${Purchase_sessionID} ;;
  }

 }
