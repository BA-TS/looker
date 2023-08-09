view: search_plp_to_pdp_funnel {
  derived_table: {
    sql: with sub0 as (SELECT distinct
"Web" as UserUID,
PARSE_DATE('%Y%m%d', event_date) as date,
min(TIMESTAMP_MICROS(event_timestamp)) as timestamp,
#COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
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
and event_name in ("search_actions", "page_view")
and concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) is not null
group by 1,2,4,5,6
union distinct
SELECT distinct
"App" as UserUID,
PARSE_DATE('%Y%m%d', event_date) as date,
min(TIMESTAMP_MICROS(event_timestamp)) as timestamp,
#COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
event_name,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') as screen,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id
FROM `toolstation-data-storage.analytics_265133009.events_*`
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and event_name in ("search", "screen_view")
and concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) is not null
group by 1,2,4,5,6)
,
search_events as (SELECT distinct UserUID, date, event_name, session_id,min(timestamp) as timestamp
from sub0 where event_name in ("search", "search_actions")
group by 1,2,3,4),

PLP as (SELECT distinct UserUID, date, event_name, screen_name, session_id,min(timestamp) as timestamp  from sub0
where event_name in ("page_view", "screen_view") and screen_name in ("product-listing-page")
group by 1,2,3,4,5),

PDP as (SELECT distinct UserUID, date, event_name, screen_name, session_id,min(timestamp) as timestamp from sub0
where event_name in ("page_view", "screen_view") and screen_name in ("product-detail-page")
group by 1,2,3,4,5),

all_1 as (SELECT distinct UserUID, date, session_id from search_events
union distinct
SELECT distinct UserUID, date, session_id from PLP),

pop as (select distinct all_1.*,
search_events.event_name as Search_event, search_events.session_id as Search_sessionID,search_events.timestamp as Search_timestamp,
PLP.event_name as PLP_event, PLP.screen_name as PLP_screen, PLP.session_id as PLP_sessionID,PLP.timestamp as PLP_timestamp,
PDP.event_name as PDP_event, PDP.screen_name as PDP_screen, PDP.session_id as PDP_sessionID,PDP.timestamp as PDP_timestamp,
timestamp_diff(PDP.timestamp,search_events.timestamp,MILLISECOND) as Search_PDP,
timestamp_diff(PDP.timestamp,PLP.timestamp,MILLISECOND) as PLP_PDP
from all_1 left join search_events on all_1.session_id = search_events.session_id
left join PLP on all_1.session_id = PLP.session_id
left join PDP on all_1.session_id = PDP.session_id)

SELECT distinct row_number() over () as P_K, pop.*
from pop ;;
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
    description: "web or App"
    label: "Web/App"
    type: string
    sql: ${TABLE}.UserUID;;
  }
  #
   dimension_group: date {
    description: "The date of session"
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
   }

  dimension: Search_PLPsessionID {
    label: "SessionID Search/PLP Event"
    description: "Session ID of Search/PLP event"
    hidden: yes
    type: string
    sql: ${TABLE}.sessionID ;;
  }
  measure: Sessions_PLPSearchEvent {
    description: "Sessions with Search/PLP events"
    label: "Sessions Search/PLP Events"
    type: count_distinct
    sql: ${Search_PLPsessionID} ;;
  }

  dimension: Search_sessionID {
    label: "SessionID Search Event"
    description: "Session ID of Search event"
    hidden: yes
    type: string
    sql: ${TABLE}.Search_sessionID ;;
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
    sql: ${TABLE}.PLP_sessionID ;;
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
    sql: ${TABLE}.PDP_sessionID ;;
  }

  dimension: Search_PDP_TIME {
    label: "Millis time Search and PDP"
    description: "time in milliseconds between Search event and PDP view"
    hidden: yes
    type: number
    sql: ${TABLE}.Search_PDP ;;
  }

  dimension: PLP_PDP_TIME {
    label: "Millis time PLP and PDP"
    description: "time in milliseconds between PLP view and PDP view"
    hidden: yes
    type: number
    sql: ${TABLE}.PLP_PDP ;;
  }

  measure: Sessions_PDP {
    description: "Sessions with PDP"
    hidden: yes
    label: "Sessions PDP"
    type: count_distinct
    sql: ${PDP_sessionID} ;;
  }

  measure: Sessions_PLP_then_PDP {
    description: "Sessions with PLP then PDP"
    label: "Sessions PLP then PDP"
    type: count_distinct
    filters: [PLP_PDP_TIME: ">0"]
    sql: ${PLP_sessionID} ;;
  }

  measure: Sessions_Search_then_PDP {
    description: "Sessions with Search then PDP"
    label: "Sessions Search then PDP"
    type: count_distinct
    filters: [Search_PDP_TIME: ">0"]
    sql: ${Search_sessionID} ;;
  }

  measure: Sessions_SearchPLP_then_PDP {
    description: "Sessions with Search/PLP then PDP"
    label: "Sessions Search/PLP then PDP"
    type: number
    sql:  COUNT(DISTINCT CASE WHEN (${Search_PDP_TIME}  > 0) or (${PLP_PDP_TIME} > 0) THEN ${Search_PLPsessionID}  ELSE NULL END) ;;
  }

}
