view: search_plp_to_pdp_funnel {
  derived_table: {
    sql: with sub0 as (with all_events as (SELECT distinct
"Web" as UserUID,
PARSE_DATE('%Y%m%d', event_date) as date,
min(TIMESTAMP_MICROS(event_timestamp)) as timestamp,
event_name,
CASE when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/p([0-9]*)$") then "product-detail-page"
      when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'), ".*/p[0-9]*[^0-9a-zA-Z]") then "product-detail-page"
      when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/c([0-9]*)$") then "product-listing-page"
      else  (SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') end as Screen_name,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id
FROM `toolstation-data-storage.analytics_251803804.events_*`
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and event_name in ("page_view", "search_actions")
and concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) is not null
group by 1,2,4,5,6
union distinct
SELECT distinct
"App" as UserUID,
PARSE_DATE('%Y%m%d', event_date) as date,
min(TIMESTAMP_MICROS(event_timestamp)) as timestamp,
event_name,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') as screen,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id
FROM `toolstation-data-storage.analytics_265133009.events_*`
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and event_name in ("screen_view", "search")
and concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) is not null
group by 1,2,4,5,6),

search as (SELECT distinct * from all_events where event_name in ("search", "search_actions")),
PLP as (SELECT distinct * from all_events where event_name in ("screen_view", "page_view") and screen_name in ("product-listing-page")),
PDP as (SELECT distinct * from all_events where event_name in ("screen_view", "page_view") and screen_name in ("product-detail-page")),
total as (SELECT distinct UserUID, date, session_id from search
union distinct SELECT distinct UserUID, date, session_id from PLP
union distinct
SELECT distinct UserUID, date, session_id from PDP)

SELECT DISTINCT total.UserUID, total.date, total.session_id,
search.session_id as Search_sessionID, search.timestamp as Search_timestamp, search.event_name as search_eventName, search.Screen_name as search_ScreenName,
PLP.session_id as PLPSessionID, PLP.timestamp as PLP_timestamp, PLP.event_name as PLP_eventName, PLP.Screen_name as PLP_ScreenName,
PDP.session_id as PDPSessionID, PDP.timestamp as PDP_timestamp, PDP.event_name as PDP_eventName, PDP.Screen_name as PDP_ScreenName
from total
left join search on total.session_id = search.session_id
left join PLP on total.session_id = PLP.session_id
left join PDP on total.session_id = PDP.session_id
WHERE (PDP.timestamp > coalesce(search.timestamp,PLP.timestamp) or PDP.timestamp is null))

SELECT distinct row_number() over () as P_K, * from sub0 ;;
  }
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  dimension: P_K{
    description: "Primary Key"
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.P_K;;
    }
  #
  dimension: UserUID{
    description: "Primary Key"
    type: string
    sql: ${TABLE}.UserUID;;
  }
  #
   dimension_group: date {
    description: "The date when each user last ordered"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
   }

  dimension: Search_sessionID {
    label: "SessionID Search Event"
    description: "Session ID of Search event"
    hidden: yes
    type: string
    sql: ${TABLE}.Search_sessionID ;;
  }
  dimension: Search_Screen {
    label: "Search Event Screen"
    description: "Session ID of Search event"
    type: string
    sql: ${TABLE}.search_ScreenName ;;
  }
   measure: Sessions_SearchEvent {
    description: "Sessions with Search events"
    label: "Sessions Search Events"
    type: count_distinct
    sql: ${Search_sessionID} ;;
   }

  dimension: PLP_sessionID {
    label: "SessionID PLP"
    description: "Session ID of PLP page view"
    hidden: yes
    type: string
    sql: ${TABLE}.PLPSessionID ;;
  }

  measure: Sessions_PLP {
    description: "Sessions with PLP"
    label: "Sessions PLP"
    type: count_distinct
    sql: ${PLP_sessionID} ;;
  }

  dimension: PDP_sessionID {
    label: "SessionID PDP"
    description: "Session ID of PDP page view"
    hidden: yes
    type: string
    sql: ${TABLE}.PDPSessionID ;;
  }

  measure: Sessions_PDP {
    description: "Sessions with PDP"
    label: "Sessions PDP"
    type: count_distinct
    sql: ${PDP_sessionID} ;;
  }

  measure: Sessions_PLP_then_PDP {
    description: "Sessions with PLP then PDP"
    label: "Sessions PLP then PDP"
    type: count_distinct
    filters: [PDP_sessionID: "-NULL"]
    sql: ${PLP_sessionID} ;;
  }
}
