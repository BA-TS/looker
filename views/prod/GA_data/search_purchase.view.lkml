view: search_purchase {
  derived_table: {
    sql: with sub1 as (SELECT distinct platform, event_name, key_1, case when session_id is null then cast(user_first_touch_timestamp as string) else session_id end as session_id, cookie_consent, min(case when date(minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(minTime, interval 1 HOUR)) else (timestamp_add(minTime, interval 1 HOUR)) end) as Time1
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*`
where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_sub(current_date(), INTERVAL 12 week)) and FORMAT_DATE('%Y%m%d',current_date())
and (regexp_contains(event_name, "search") or event_name in ("purchase", "Purchase") ) and event_name not in ("blank_search")
group by all)

select distinct row_number() over() as PK,Platform,session_id as search_ID, cookie_consent, date(min(Time1)) as search_date, min(Time1) as search_time, purchase_ID,purchase_date, purchase_time, timestamp_diff(purchase_time, min(Time1), second) as search_purch_diff
from sub1 left join (
  select distinct session_id as purchase_ID, date(min(Time1)) as purchase_date,  min(Time1) as purchase_time
from sub1
where event_name in ("purchase", "Purchase")
group by 1
) on session_id = purchase_ID
where regexp_contains(event_name, "search") and event_name not in ("blank_search") and key_1 in ("Searched Term", "search_term", "Search_term")
group by all
;;

sql_trigger_value: SELECT EXTRACT(dayofweek FROM CURRENT_DATEtime()) between 2 and 6 and extract(hour from current_datetime()) = 13
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 7 and extract(hour from current_datetime()) = 16
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 1 and extract(hour from current_datetime()) = 16;;
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

  dimension: cookie_consent {
    group_label: "Search to purchase"
    type: yesno
    sql: case when ${TABLE}.cookie_consent in ("session id") then true else false end;;
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

  #measure: search_session_pop {
    #group_label: "Search to purchase"
    #label: "Search Sessions POP"
    #type: period_over_period
    #based_on: search_sessions.count_distinct
    #based_on_time: search_date_date
    #period: week
    #kind: previous
  #}

 }

view: bulksave_atc_purchase {
  derived_table: {
    sql: with sub1 as (select distinct timestamp_add(minTime, interval 1 hour) as minTime, event_name, session_id as session, item_id, item_category, item_category2, item_category3, t.quantity, t.ga4_quantity from
`toolstation-data-storage.Digital_reporting.GAClientSide_DigitalTransactions_*` left join unnest(transactions) as t
where
_TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date("2025-04-20")) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), interval 1 day))
#_TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date("2025-03-01")) and FORMAT_DATE('%Y%m%d', date_sub(current_date(), interval 1 day))
and event_name in ("add_to_cart", "purchase", "view_item")
and platform in ("Web")
and ga4_quantity is not null
-- union distinct
-- select distinct timestamp_add(minTime, interval 1 hour) as minTime, event_name, session_id as session, item_id, item_category, item_category2, item_category3, t.quantity, t.ga4_quantity from
-- `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` left join unnest(transactions) as t
-- WHERE _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_trunc(current_date(), year)) and FORMAT_DATE('%Y%m%d', date("2025-02-28"))
-- and event_name in ("add_to_cart", "purchase", "view_item")
-- and platform in ("Web")
-- and ga4_quantity is not null

),

view_item as (select distinct min(minTime) as minTime, session, item_id, item_category, item_category2, item_category3, sum(ga4_quantity) as ga4_quantity from sub1 where event_name in ("view_item") group by all),

atc as (select distinct min(minTime) as minTime, session, item_id, item_category, item_category2, item_category3, sum(ga4_quantity) as ga4_quantity from sub1 where event_name in ("add_to_cart") group by all),
purchase as (select distinct min(minTime) as minTime, session, item_id, sum(ga4_quantity) as ga4_quantity from sub1 where event_name in ("purchase") group by all)

select distinct
row_number() over () as PK,
date, fiscalYearWeek, dayInWeek,
item_id,
item_category,
item_category2,
item_category3,
bulk,
view_item_sessions,
lag(view_item_sessions) over (partition by item_category,item_category2, item_category3, bulk, dayInWeek order by fiscalYearWeek asc) as view_item_sessions_LW,
atc_sessions,
lag(atc_sessions) over (partition by item_category,item_category2, item_category3,bulk, dayInWeek order by fiscalYearWeek asc) as atc_sessions_LW,
-- atc_rate,
-- lag(atc_rate) over (partition by item_category,item_category2,bulk, dayInWeek order by fiscalYearWeek asc) as atc_rate_LW,
atc_quantity,
lag(atc_quantity) over (partition by item_category,item_category2, item_category3,bulk, dayInWeek order by fiscalYearWeek asc) as atc_quantity_LW,
-- avgATCBAsket,
-- lag(avgATCBAsket) over (partition by item_category,item_category2,bulk, dayInWeek order by fiscalYearWeek asc) as avg_atc_basket_LW,
purchase_sessions,
lag(purchase_sessions) over (partition by item_category,item_category2,item_category3,bulk, dayInWeek order by fiscalYearWeek asc) as purchase_sess_LW,
-- purchase_rate,
-- lag(purchase_rate) over (partition by item_category,item_category2,bulk, dayInWeek order by fiscalYearWeek asc) as purchase_rate_LW,
purchase_quantity,
lag(purchase_quantity) over (partition by item_category,item_category2,item_category3,bulk, dayInWeek order by fiscalYearWeek asc) as purchase_quantity_LW,
-- avgPurchaseBAsket,
-- lag(avgPurchaseBAsket) over (partition by item_category,item_category2,bulk, dayInWeek order by fiscalYearWeek asc) as avg_purchase_basket_LW

 from

(
  select distinct date, fiscalYearWeek, dayInWeek,
item_id,
 item_category, item_category2,
item_category3,
 count(distinct  view_item_session) as view_item_sessions,
count(distinct atc_session_id) as atc_sessions,
--safe_divide(count(distinct atc_session_id), count(distinct  view_item_session)) as atc_rate,
sum(atc_quantity) as atc_quantity,
--safe_divide(sum(atc_quantity),count(distinct atc_session_id) ) as avgATCBAsket,
count(distinct purchase_session) as purchase_sessions,
--safe_divide(count(distinct purchase_session), count(distinct  view_item_session)) as purchase_rate,
sum(purchase_quantity) as purchase_quantity,
--safe_divide(sum(purchase_quantity),count(distinct  purchase_session) ) as avgPurchaseBAsket,
case when attributeValue is null then "non bulksave" else attributeValue end as bulk

from

(select distinct date(view_item.minTime) as date, view_item.session as view_item_session, view_item.item_id as item_id, view_item.item_category, view_item.item_category2, view_item.item_category3, atc.session as atc_session_id,sum(atc.ga4_quantity) as atc_quantity, min(atc.minTime) as atc_time, purchase.session as purchase_session, sum(purchase.ga4_quantity) as purchase_quantity
from view_item left join atc  on view_item.session = atc.session and view_item.item_id = atc.item_id left join purchase on atc.session = purchase.session and atc.item_id = purchase.item_id and atc.minTime < purchase.minTime
group by all)
left join (SELECT distinct pc.productCode, pa.attribute, pa.attributeValue FROM `toolstation-data-storage.range.productAttributes` as pa
left join `range.products_current` as pc on pa.productUID = pc.productUID
where attribute in ("Web Image Overlay (Top Right)") and attributeValue in ("bulksave")) on item_id = productCode
left join (select distinct fullDate, fiscalYearWeek, dayInWeek from `ts_finance.dim_date`) as dd on date = fullDate
--where item_id in ("11042")

group by all)
where view_item_sessions > 0 ;;

sql_trigger_value: SELECT EXTRACT(dayofweek FROM CURRENT_DATEtime()) between 2 and 6 and extract(hour from current_datetime()) = 13
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 7 and extract(hour from current_datetime()) = 16
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 1 and extract(hour from current_datetime()) = 16 ;;

  }

  dimension: PK {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.PK ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: fiscalYearWeek {
    hidden: yes
    type: string
    sql: ${TABLE}.fiscalYearWeek ;;
  }

  dimension: dayInWeek {
    hidden: yes
    type: string
    sql: ${TABLE}.dayInWeek ;;
  }

  dimension: item_id {
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_category {
    #hidden: yes
    view_label: "Products"
    group_label: "Bulk save Category"
    label: "1.Category"
    type: string
    sql: ${TABLE}.item_category ;;
  }

  dimension: item_category2{
    view_label: "Products"
    group_label: "Bulk save Category"
    label: "2.Sub Category"
    type: string
    sql: ${TABLE}.item_category2 ;;
  }

  dimension: item_category3{
    view_label: "Products"
    group_label: "Bulk save Category"
    label: "3.Sub Sub Category"
    type: string
    sql: ${TABLE}.item_category3 ;;
  }

  dimension: bulksave_available {
    #hidden: yes
    type: yesno
    sql: case when ${TABLE}.bulk in ("bulksave") then true else false end  ;;
  }

  measure: view_item_sessions {
    type: sum
    label: "View Item Sessions"
    sql: ${TABLE}.view_item_sessions ;;
  }

  measure: view_item_sessions_LW {
    type: sum
    label: "View Item Sessions LW"
    sql: ${TABLE}.view_item_sessions_LW ;;
  }

  measure: atc_sessions {
    type: sum
    label: "atc Sessions"
    sql: ${TABLE}.atc_sessions ;;
  }

  measure: atc_sessions_LW {
    type: sum
    label: "atc Sessions LW"
    sql: ${TABLE}.atc_sessions_LW ;;
  }

  measure: atc_rate {
    type: number
    label: "ATC rate"
    sql: SAFE_DIVIDE(${atc_sessions},${view_item_sessions}) ;;

  }

  measure: atc_rate_LW {
    type: number
    label: "ATC rate LW"
    sql: SAFE_DIVIDE(${atc_sessions_LW}, ${view_item_sessions_LW}) ;;

  }

  measure: atc_quantity {
    type: sum
    label: "atc quantity"
    sql: ${TABLE}.atc_quantity ;;
  }

  measure: atc_quantity_LW {
    type: sum
    label: "atc quantity LW"
    sql: ${TABLE}.atc_quantity_LW ;;
  }

  measure: atc_avg_basket{
    type: number
    label: "ATC avg basket"
    sql: SAFE_DIVIDE(${atc_quantity},${atc_sessions}) ;;

  }

  measure: atc_avg_basket_LW {
    type: number
    label: "ATC avg basket LW"
    sql: SAFE_DIVIDE(${atc_quantity_LW},${atc_sessions_LW}) ;;

  }


  ###########################

  measure: purchase_sessions {
    type: sum
    label: "Purchase Sessions"
    sql: ${TABLE}.purchase_sessions ;;
  }

  measure: purchase_sessions_LW {
    type: sum
    label: "purchase Sessions LW"
    sql: ${TABLE}.purchase_sessions_LW ;;
  }

  measure: purchase_rate {
    type: number
    label: "Purchase rate"
    sql: SAFE_DIVIDE(${purchase_sessions},${view_item_sessions}) ;;

  }

  measure: Purchase_rate_LW {
    type: number
    label: "Purchase rate LW"
    sql: SAFE_DIVIDE(${purchase_sessions_LW},${view_item_sessions_LW}) ;;

  }

  measure: purchase_quantity {
    type: sum
    label: "purchase quantity"
    sql: ${TABLE}.purchase_quantity ;;
  }

  measure: purchase_quantity_LW {
    type: sum
    label: "purchase quantity LW"
    sql: ${TABLE}.purchase_quantity_LW ;;
  }

  measure: purchase_avg_basket{
    type: number
    label: "Purchase avg basket"
    sql: SAFE_DIVIDE(${purchase_quantity}, ${purchase_sessions}) ;;

  }

  measure: purchase_avg_basket_LW {
    type: number
    label: "Purchase avg basket LW"
    sql: SAFE_DIVIDE(${purchase_quantity_LW},${purchase_sessions_LW}) ;;

  }



}
