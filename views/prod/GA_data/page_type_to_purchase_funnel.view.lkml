view: page_type_to_purchase_funnel {
  derived_table: {
    sql:
    with sub1 as (SELECT distinct min(timestamp_sub(MinTime, interval 1 HOUR)) as minTime, session_id, event_name,
#page_location,
case
when page_location in ("https://www.toolstation.com/") and event_name in ("page_view") then "homepage"
when regexp_contains(page_location, r"toolstation\.com\/\?") and event_name in ("page_view") then "homepage"
when screen_name in ("home-page") and event_name in ("screen_view") then "homepage"
when regexp_contains(page_location, ".*search?.*=.*") and event_name in ("page_view") then "Search"
when screen_name in ("search-page") and event_name in ("screen_view") then "Search"
when Screen_name in ("product-detail-page") and event_name in ("view_item") and platform in ("Web") then "PDP"
when Screen_name in ("product-detail-page") and event_name in ("view_item") and platform in ("App") then "PDP"
when REGEXP_CONTAINS(page_location, r'^.*\/([a-z,\-\d]+\/){1}(c(\d){1,4}).*') THEN "Category"
when regexp_contains(screen_name,r"department-page-[0-9]*") and event_name in ("screen_view") then "Category"
when screen_name in ("product-listing-page") and event_name in ("screen_view") then "Category"
end as screen,
item_id,
platform
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*`
where event_name in ("page_view","view_item", "screen_view","purchase", "Purchase")
and _table_suffix between format_date("%Y%m%d", date_sub(current_date(), INTERVAL 20 day)) and format_date("%Y%m%d", date_sub(current_date(), INTERVAL 1 day))
group by 2,3,4,5,6),

homepage as (select distinct session_id as homepage_session_id, min(MinTime) as homepage_time from sub1 where screen in ("homepage") and event_name in ("page_view","screen_view") group by 1),

Search as (select distinct session_id as search_session_id, min(MinTime) as search_time from sub1 where screen in ("Search") and event_name in ("page_view","screen_view") group by 1),

PDP as (select distinct session_id as PDP_session_id, min(MinTime) as PDP_time from sub1 where screen in ("PDP") and event_name in ("view_item") and item_id is not null and item_id not in ("(not set)") group by 1),

Category as (select distinct session_id as Category_session_id, min(MinTime) as category_time from sub1 where screen in ("Category") and event_name in ("page_view", "screen_view") group by 1),

purchase as (select distinct session_id as purchase_session_id, min(MinTime) as purchase_time from sub1 where event_name in ("purchase", "Purchase") and item_id is not null and item_id not in ("(not set)") group by 1)


SELECT distinct
row_number() over () as P_K,
extract(date from coalesce(homepage.homepage_time,search.search_time,pdp.pdp_time,Category.Category_time,purchase.purchase_time)) as date,
session_id as all_session_id,
platform,
homepage.homepage_session_id, homepage.homepage_time,
search.search_session_id, search.search_time,
PDP.pdp_session_id, pdp.pdp_time,
Category.Category_session_id, Category.Category_time,
purchase.purchase_session_id, purchase.purchase_time,
timestamp_diff(purchase.purchase_time,homepage.homepage_time,second) as home_purchase,
timestamp_diff(purchase.purchase_time,search.search_time,second) as search_purchase,
timestamp_diff(purchase.purchase_time,pdp.pdp_time,second) as pdp_purchase,
timestamp_diff(purchase.purchase_time,Category.Category_time,second) as category_purchase,
from sub1 left join homepage on sub1.session_id = homepage.homepage_session_id
left join Search on sub1.session_id = Search.search_session_id
left join PDP on sub1.session_id = PDP.PDP_session_id
left join Category on sub1.session_id = Category.Category_session_id
left join purchase on sub1.session_id = purchase.purchase_session_id;;

sql_trigger_value: SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*10)/(60*60*24))
    ;;

}

  dimension: P_K {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: all_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.all_session_id ;;
  }

  dimension: homepage_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.homepage_session_id ;;
  }

  dimension: search_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.search_session_id ;;
  }

  dimension: pdp_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.pdp_session_id ;;
  }

  dimension: Category_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.Category_session_id ;;
  }

  dimension: purchase_sessionID {
    hidden: yes
    type: string
    sql: ${TABLE}.purchase_session_id ;;
  }

  dimension: home_purchase_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.home_purchase;;
  }

  dimension: search_purchase_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.search_purchase;;
  }

  dimension: pdp_purchase_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.pdp_purchase;;
  }

  dimension: category_purchase_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.category_purchase;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  measure: home_sessions {
    group_label: "Page Type to Purchase"
    label: "Homepage sessions"
    type: count_distinct
    sql: ${homepage_sessionID};;
  }

  measure: search_sessions {
    group_label: "Page Type to Purchase"
    label: "Search sessions"
    type: count_distinct
    sql: ${search_sessionID};;
  }

  measure: pdp_sessions {
    group_label: "Page Type to Purchase"
    label: "PDP sessions"
    type: count_distinct
    sql: ${pdp_sessionID};;
  }

  measure: category_sessions {
    group_label: "Page Type to Purchase"
    label: "Category sessions"
    type: count_distinct
    sql: ${Category_sessionID};;
  }

  measure: home_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "Home to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [homepage_sessionID: "-NULL", home_purchase_seconds: ">0"]
  }

  measure: only_home_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "Only Home to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [homepage_sessionID: "-NULL", search_sessionID: "NULL", pdp_sessionID: "NULL",Category_sessionID: "NULL",home_purchase_seconds: ">0"]
  }

  measure: only_home_sessions {
    group_label: "Page Type to Purchase"
    label: "Only Home sessions"
    type: count_distinct
    sql: ${homepage_sessionID};;
    filters: [search_sessionID: "NULL", pdp_sessionID: "NULL",Category_sessionID: "NULL"]
  }

  measure: search_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "search to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [search_sessionID: "-NULL", search_purchase_seconds: ">0"]
  }

  measure: only_search_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "Only Search to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [search_sessionID: "-NULL", homepage_sessionID: "NULL", pdp_sessionID: "NULL",Category_sessionID: "NULL",search_purchase_seconds: ">0"]
  }

  measure: only_search_sessions {
    group_label: "Page Type to Purchase"
    label: "Only Search sessions"
    type: count_distinct
    sql: ${search_sessionID};;
    filters: [homepage_sessionID: "NULL", pdp_sessionID: "NULL",Category_sessionID: "NULL"]
  }

  measure: PDP_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "PDP to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [pdp_sessionID: "-NULL", pdp_purchase_seconds: ">0"]
  }

  measure: only_pdp_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "Only PDP to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [pdp_sessionID: "-NULL", search_sessionID: "NULL", homepage_sessionID: "NULL",Category_sessionID: "NULL",pdp_purchase_seconds: ">0"]
  }

  measure: only_pdp_sessions {
    group_label: "Page Type to Purchase"
    label: "Only PDP sessions"
    type: count_distinct
    sql: ${pdp_sessionID};;
    filters: [homepage_sessionID: "NULL", search_sessionID: "NULL",Category_sessionID: "NULL"]
  }

  measure: Category_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "Category to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [Category_sessionID: "-NULL", category_purchase_seconds: ">0"]
  }

  measure: only_category_to_purchase_sessions {
    group_label: "Page Type to Purchase"
    label: "Only category to Purchase sessions"
    type: count_distinct
    sql: ${purchase_sessionID};;
    filters: [Category_sessionID: "-NULL", search_sessionID: "NULL", homepage_sessionID: "NULL",pdp_sessionID: "NULL",category_purchase_seconds: ">0"]
  }

  measure: only_category_sessions {
    group_label: "Page Type to Purchase"
    label: "Only Category sessions"
    type: count_distinct
    sql: ${Category_sessionID};;
    filters: [homepage_sessionID: "NULL", search_sessionID: "NULL",pdp_sessionID: "NULL"]
  }

}
