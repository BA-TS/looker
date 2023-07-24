view: videoly_funnel_ga4 {

  derived_table: {
    sql: with sub1 as (with Videoly_shown as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
case when regexp_contains(ep.value.string_value, "videoly_box_shown") then "videoly_box_shown"
end as event_info,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
FROM `toolstation-data-storage.analytics_265133009.events_*`, unnest(event_params) as ep
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and event_name in ("videoly") and ep.key in ("action") and (regexp_contains(ep.value.string_value, "videoly_box_shown")
)
GROUP BY 1,2,3,4,5
UNION DISTINCT
SELECT distinct
"Web" as USERUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
TIMESTAMP_seconds(visitStartTime + hits.time) as timestamp,
(concat(fullVisitorID,visitStartTime))  as session_id,
hits.eventInfo.EventAction,
count(distinct concat (fullVisitorID,hits.time)) as events
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and hits.eventInfo.EventCategory = "Videoly" and hits.eventInfo.EventAction in ("VideolyboxShown")
group by 1,2,3,4,5),

Videoly_started as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
case when regexp_contains(ep.value.string_value, "videoly_start") then "videoly started" end as event_info,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
FROM `toolstation-data-storage.analytics_265133009.events_*`, unnest(event_params) as ep
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and event_name in ("videoly") and ep.key in ("action") and (regexp_contains(ep.value.string_value, "videoly_start")
)
GROUP BY 1,2,3,4,5
UNION DISTINCT
SELECT distinct
"Web" as USERUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
TIMESTAMP_seconds(visitStartTime + hits.time) as timestamp,
(concat(fullVisitorID,visitStartTime))  as session_id,
hits.eventInfo.EventAction,
count(distinct concat (fullVisitorID,hits.time)) as events
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and hits.eventInfo.EventCategory = "Videoly" and hits.eventInfo.EventAction in ("watched")
group by 1,2,3,4,5),

add_to_cart as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
event_name as event_info,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
FROM `toolstation-data-storage.analytics_265133009.events_*`
WHERE event_name in ("add_to_cart") and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
GROUP BY 1,2,3,4,5

union distinct

SELECT distinct
"Web" as USERUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
TIMESTAMP_seconds(visitStartTime + hits.time) as timestamp,
(concat(fullVisitorID,visitStartTime))  as session_id,
hits.eventInfo.EventAction,
count(distinct concat (fullVisitorID,hits.time)) as events
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and hits.eventInfo.EventAction in ("Add to Cart")
group by 1,2,3,4,5),


purchase as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
event_name as event_info,
sum(ecommerce.purchase_revenue) as revenue,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
FROM `toolstation-data-storage.analytics_265133009.events_*`
WHERE event_name in ("purchase") and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
GROUP BY 1,2,3,4,5

union distinct

SELECT distinct
"Web" as USERUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
TIMESTAMP_seconds(visitStartTime + hits.time) as timestamp,
(concat(fullVisitorID,visitStartTime))  as session_id,
hits.eventInfo.EventAction,
sum(safe_divide(transaction.transactionRevenue,1000000)) as revenue,
count(distinct concat (fullVisitorID,hits.time)) as events
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and hits.eventInfo.EventAction in ("Purchase")
group by 1,2,3,4,5),

total_sessions_PDP_Views as (SELECT distinct
"App" as UserUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp,
event_name,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id
FROM `toolstation-data-storage.analytics_265133009.events_*`, unnest (event_params) as ep
WHERE event_name in ("screen_view") and ep.key in ("firebase_screen") and ep.value.string_value in ("product-detail-page") and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
union distinct
SELECT distinct
"Web" as UserUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
TIMESTAMP_seconds(visitStartTime + hits.time) as timestamp,
hits.page.pagePath,
(concat(fullVisitorID,visitStartTime))  as session_id,
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
and regexp_contains(hits.page.pagePath, ".*/p[0-9]*$") and hits.type = "PAGE"),

bounces as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
case when (select distinct cast(value.int_value as string) from unnest(event_params) where key = 'engaged_session_event') = '1' then "1" else "0" end as bounces
FROM `toolstation-data-storage.analytics_265133009.events_*`
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', event_date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', event_date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
union distinct
SELECT distinct
"Web" as USERUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
(concat(fullVisitorID,visitStartTime))  as session_id,
case when totals.bounces = 1 then "0" else "1" end as bounces
FROM `toolstation-data-storage.4783980.ga_sessions_*`
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( date(PARSE_DATE('%Y%m%d', date)) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( date(PARSE_DATE('%Y%m%d', date)) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))),

sub1 as (SELECT distinct coalesce(total_sessions_PDP_Views.UserUID,Videoly_shown.UserUID,Videoly_started.UserUID,add_to_cart.UserUID,purchase.USERUID) as USERUID,
coalesce(total_sessions_PDP_Views.date,Videoly_shown.date,Videoly_started.date,add_to_cart.date,purchase.date) as date,
Videoly_shown.event_info as Videoly_shown_info,
Videoly_started.event_info as Videoly_started_info,
total_sessions_PDP_Views.session_id as PDP_View_session_id,
Videoly_shown.session_id as Videoly_shown_session_id,
Videoly_started.session_id as Videoly_started_session_id,
add_to_cart.session_id as add_to_cart_session_id,
purchase.session_id as purchase_session_id,
purchase.revenue as revenue
from total_sessions_PDP_Views
full outer join Videoly_shown on total_sessions_PDP_Views.session_id = Videoly_shown.session_id
full outer join Videoly_started on total_sessions_PDP_Views.session_id = Videoly_started.session_id
full outer join add_to_cart on total_sessions_PDP_Views.session_id = add_to_cart.session_id
full outer join purchase on purchase.session_id = add_to_cart.session_id)

SELECT coalesce(sub1.USERUID,bounces.USERUID) as userUID,timestamp(coalesce(sub1.date,bounces.date)) as date,sub1.* except (UserUID,date), bounces.session_id, bounces.bounces from sub1 full outer join bounces on coalesce(PDP_View_session_id,Videoly_shown_session_id,Videoly_started_session_id,add_to_cart_session_id,purchase_session_id) = bounces.session_id
)

SELECT distinct row_number () over () as ROW_NUM, sub1.* from sub1;;
datagroup_trigger: ts_googleanalytics_datagroup
  }
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
   dimension: P_K {
    description: "primary key"
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ROW_NUM ;;
   }
  #
   dimension: userUID {
    description: "userUID"
    label: "Web/App"
    type: string
    sql: ${TABLE}.userUID ;;
   }
  #
   dimension_group: date {
     type: time
    hidden: yes
     timeframes: [raw,date]
     sql: ${TABLE}.date ;;
   }

  dimension: Videoly_shown_info {
    description: "Videoly_shown_info"
    label: "Videoly_shown"
    type: string
    sql: ${TABLE}.Videoly_shown_info ;;
  }

  dimension: Videoly_started {
    description: "Videoly_started_info"
    label: "Videoly_started"
    type: string
    sql: ${TABLE}.Videoly_started_info ;;
  }

  dimension: PDP_View_session_id{
    type: string
    hidden: yes
    sql: ${TABLE}.PDP_View_session_id ;;
  }

  dimension: Videoly_shown_session_id{
    type: string
    hidden: yes
    sql: ${TABLE}.Videoly_shown_session_id ;;
  }

  dimension: Videoly_started_session_id{
    type: string
    hidden: yes
    sql: ${TABLE}.Videoly_started_session_id ;;
  }

  dimension: add_to_cart_session_id{
    type: string
    hidden: yes
    sql: ${TABLE}.add_to_cart_session_id ;;
  }

  dimension: purchase_session_id{
    type: string
    hidden: yes
    sql: ${TABLE}.purchase_session_id ;;
  }

  dimension: session_id{
    type: string
    hidden: yes
    sql: ${TABLE}.session_id ;;
  }
  measure: sessions_with_PDP_views {
    description: "sessions with PDP views"
    label: "sessions with PDP"
    group_label: "Sessions"
    type: count_distinct
    sql: ${TABLE}.PDP_View_session_id ;;
  }

  measure: sessions_with_videoly_shown {
    description: "Videoly Shown sessions"
    label: "Videoly Shown sessions"
    group_label: "Sessions"
    type: count_distinct
    sql: ${TABLE}.Videoly_shown_session_id ;;
  }

  measure: sessions_with_videoly_shown_not_started {
    description: "Videoly Shown sessions not started"
    label: "Videoly Shown not started sessions"
    group_label: "Sessions"
    type: count_distinct
    filters: [Videoly_started_session_id: "NULL"]
    sql: ${TABLE}.Videoly_shown_session_id ;;
  }

  measure: transactional_sessions_with_videoly_shown_not_started {
    description: "Transactional Videoly Shown sessions not started"
    label: "Transactional Videoly Shown not started sessions"
    group_label: "Sessions"
    type: count_distinct
    filters: [Videoly_started_session_id: "NULL", purchase_session_id: "-NULL"]
    sql: ${TABLE}.Videoly_shown_session_id ;;
  }

  measure: Videoly_started_sesions {
    description: "Videoly started sessions"
    label: "Videoly started sessions"
    group_label: "Sessions"
    type: count_distinct
    sql: ${TABLE}.Videoly_started_session_id ;;
  }

  measure: Videoly_started_and_purchase_sesions {
    description: "Videoly started then Purchase sessions"
    label: "Transactional Videoly started sessions"
    group_label: "Sessions"
    type: count_distinct
    filters: [purchase_session_id: "-NULL"]
    sql: ${TABLE}.Videoly_started_session_id ;;
  }

  measure: add_to_cart_sesions {
    description: "Add to Cart sessions"
    label: "Add to Cart sessions"
    group_label: "Sessions"
    type: count_distinct
    sql: ${TABLE}.add_to_cart_session_id ;;
  }

  measure: purchase_sessions {
    description: "Purchase sessions"
    label: "Purchase sessions"
    group_label: "Sessions"
    type: count_distinct
    sql: ${TABLE}.purchase_session_id ;;
  }

  measure: all_sessions {
    description: "All sessions"
    label: "All sessions"
    group_label: "Sessions"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
  }

  measure: revenue {
    description: "revenue from purchase events"
    label: "Total Revenue"
    group_label: "Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.revenue ;;
  }

  measure: Videoly_transactional {
    description: "revenue from purchase events"
    label: "Revenue from Videoly viewed"
    group_label: "Revenue"
    type: sum
    value_format_name: gbp
    filters: [purchase_session_id: "-NULL", Videoly_started_session_id: "-NULL"]
    sql: ${TABLE}.revenue ;;
  }

  measure: revenue_videoly_shown_not_started {
    description: "revenue Videoly Shown sessions not started"
    label: "Revenue Videoly Shown not started"
    group_label: "Revenue"
    value_format_name: gbp
    type: sum
    filters: [Videoly_shown_session_id: "-NULL", Videoly_started_session_id: "NULL", purchase_session_id: "-NULL"]
    sql: ${TABLE}.revenue ;;
  }

  dimension: bounce_def {
    description: "if session is bounce 0 = no, 1 = yes"
    type: string
    hidden: yes
    sql: ${TABLE}.bounces ;;
  }

  measure: bounces {
    label: "bounces"
    group_label: "Measures"
    hidden: yes
    type: count_distinct
    filters: [bounce_def: "0"]
    sql: ${TABLE}.session_id;;
  }

  measure: bs {
    label: "Bounced sessions"
    hidden: yes
    group_label: "Measures"
    sql: ${all_sessions}-${bounces} ;;

  }

  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: videoly_funnel_ga4 {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
