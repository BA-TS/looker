view: last12_week_metrics {

  derived_table: {
    sql:

    with sub1 as (SELECT distinct date, minTime, platform, deviceCategory, session_id, page_location, screen_name,

      CASE when regexp_contains(page_location,".*/p([0-9]*)$") then "product-detail-page"
      when regexp_contains(page_location, ".*/p[0-9]*[^0-9a-zA-Z]") then "product-detail-page"
      when regexp_contains(page_location,".*/c([0-9]*)$") then "product-listing-page"
      when regexp_contains(page_location, ".*/c[0-9]*[^0-9a-zA-Z]") then "product-listing-page"
      else screen_name end as screen_Type,
      event_name,
      case
      when event_name = "collection_OOS" and platform = "Web" then "Collection"
      when event_name = "dual_OOS" and platform = "Web" then "Dual"
      when event_name = "Delivery_OOS" and platform = "Web" then "Delivery"
      when event_name = "out_of_stock" and platform = "Web" then null
      when event_name in ("MegaMenu") then label_2
      when key_1 is null and label_1 is not null then "action"
      else key_1 end as key1,
      label_1,
      case when event_name in ("MegaMenu") then null else label_2 end as label_2,
      case when key_2 is null and label_2 is not null then "action"
      when event_name in ("MegaMenu") then null
      else key_2 end as key_2,
      sum(transactions.net_value) as net,
      sum(transactions.Quantity) as Quantity,
      sum(events) as events,
      row_number () over (partition by session_id order by minTime asc) as landingP,
      row_number () over (partition by session_id order by minTime desc) as exitP
      FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
      where ((aw.item_id = transactions.productCode) or (aw.item_id is not null and transactions.productCode is null) or (aw.item_id is null and transactions.productCode is null))

      and _TABLE_Suffix between format_date("%Y%m%d", date_sub(current_date(), interval 2 week)) and format_date("%Y%m%d", date_sub(current_date(), interval 1 day))
      group by all),

      landing_P as (select distinct session_id as landing_session, page_location as landingPage, screen_name as landingScreen, screen_Type as LandingScreenType
      from sub1 where landingP = 1),

      exit_P as (select distinct session_id as exit_session, page_location as exitPage, screen_name as exitScreen, screen_Type as exitScreenType
      from sub1 where exitP = 1),

      purchase as (select distinct session_id as purchase_session, min(minTime) as purchase_time,  sum(net) as net, sum(Quantity) as quantity
      from sub1 where event_name in ("purchase", "Purchase")
      group by all),

      search as (select distinct session_id as search_session, min(minTime) as search_time
      from sub1 where regexp_contains(event_name, "search") and event_name not in ("blank_search")
      group by all),

      blank_search as (select distinct session_id as blanksearch_session
      from sub1 where event_name in ("blank_search")
      group by all),

      filters_used as (select distinct session_id as filter_session from sub1
      where (event_name in ("search_actions") and key1 in ("Add Filter")) or (event_name in ("Filter_Used")) or (event_name in ("bloomreach_search_unknown_attribute") and screen_name in ("filters_page")) ),

      sub2 as (select distinct sub1.date as date, platform, deviceCategory,sub1.session_id as all_sessions,
      count(distinct screen_name) over (partition by sub1.session_id) pages_in_session,
      #page_location, screen_name,
    case when screen_type in ("product-detail-page") and landingScreen not in ("product-detail-page") then "Get_to_PDP" else "Other" end as screen_type_grouped,
      #landingPage,landingScreen,
      LandingScreenType,
      #exitPage,exitScreen,
      #exitScreenType,
      search.search_session as search_session,
      search.search_time as search_time,
      blanksearch_session as blank_search,
      purchase_session,
      purchase.purchase_time as purchase_time,
      purchase.net as purchase_net,
      purchase.quantity as purchase_quantity,
      filters_used.filter_session
      from sub1
      inner join landing_P on session_id=landing_session
      inner join exit_p on session_id=exit_session
      left join search on session_id=search_session
      left join purchase on session_id=purchase_session
      left join blank_search on session_id = blanksearch_session
      left join filters_used on session_id=filter_session
      group by 1,2,3,4,screen_name,6,7,8,9,10,11,12,13,14,15)

select distinct row_number() over () as PK,  date,
platform,
deviceCategory,
all_sessions,
pages_in_session,
string_agg(screen_type_grouped) as get_to_product,
LandingScreenType,
search_session,
search_time,
blank_search
purchase_session,
purchase_time,
purchase_net,
purchase_quantity,
filter_session
from sub2
group by all
      ;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 7;;
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

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform;;
  }

  dimension: deviceCategory {
    hidden: yes
    type: string
    sql: ${TABLE}.deviceCategory;;
  }

  dimension: all_sessions {
    hidden: yes
    type: string
    sql: ${TABLE}.all_sessions;;
  }

  dimension: pagesSessions {
    hidden: yes
    type: number
    sql: ${TABLE}.pages_in_session;;
  }

  dimension: get_to_product {
    group_label: "Last 12 Weeks"
    #hidden: yes
    type: string
    sql: ${TABLE}.get_to_product;;
  }

  dimension: LandingScreenType {
    group_label: "Last 12 Weeks"
    #hidden: yes
    type: string
    sql: ${TABLE}.LandingScreenType;;
  }

  dimension: search_sessions {
    hidden: yes
    type: string
    sql: ${TABLE}.search_session;;
  }

  dimension: blank_search {
    hidden: yes
    type: string
    sql: ${TABLE}.blank_search;;
  }

  dimension: purchase_session {
    hidden: yes
    type: string
    sql: ${TABLE}.purchase_session;;
  }

  dimension: filter_session {
    hidden: yes
    type: string
    sql: ${TABLE}.filter_session;;
  }

  dimension: purchase_net {
    hidden: yes
    type: number
    sql: ${TABLE}.purchase_net;;
  }

  dimension: purchase_quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.purchase_quantity;;
  }


  dimension_group: purchase_time {
    hidden: yes
    type: time
    timeframes: [raw]
    sql: ${TABLE}.purchase_time ;;
  }

  dimension_group: search_time {
    hidden: yes
    type: time
    timeframes: [raw]
    sql: ${TABLE}.search_time ;;
  }

  measure: total_sessions {
    group_label: "Last 12 Weeks"
    label: "Total Sessions"
    type: count_distinct
    sql: ${all_sessions} ;;
  }

  measure: total_net_rev {
    group_label: "Last 12 Weeks"
    label: "Total Net Revenu"
    type: sum
    value_format_name: gbp
    sql: ${purchase_net} ;;
  }

  measure: get_to_PDP {
    group_label: "Last 12 Weeks"
    label: "Get to PDP"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [get_to_product: "%Get_to_PDP%"]
  }

}
