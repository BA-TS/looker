view: videoly_conversion {

  derived_table: {
    sql:with Videoly as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp_value,
#user_pseudo_id as user,
#(select distinct case when ep.key in ("ga_session_id") then concat(user_pseudo_id,cast(ep.value.int_value as string)) end) as session_id,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
case when regexp_contains(ep.value.string_value, "videoly_box_shown") then "videoly_box_shown"
when regexp_contains(ep.value.string_value, "videoly_start") then "videoly started" end as event_info,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
FROM `toolstation-data-storage.analytics_265133009.events_*`, unnest(event_params) as ep
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
and event_name in ("videoly") and ep.key in ("action") and (regexp_contains(ep.value.string_value, "videoly_box_shown") or regexp_contains(ep.value.string_value, "videoly_start"))
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
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
and hits.eventInfo.EventCategory = "Videoly" and hits.eventInfo.EventAction in ("VideolyboxShown","watched")
group by 1,2,3,4,5),

add_to_cart as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp_value,
#user_pseudo_id as user,
#(select distinct case when ep.key in ("ga_session_id") then concat(user_pseudo_id,cast(ep.value.int_value as string)) end) as session_id,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
event_name as event_info,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
FROM `toolstation-data-storage.analytics_265133009.events_*`
#, unnest(event_params) as ep
WHERE event_name in ("add_to_cart") and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
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
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
and hits.eventInfo.EventAction in ("Add to Cart")
group by 1,2,3,4,5),


purchase as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp_value,
#user_pseudo_id as user,
#(select distinct case when ep.key in ("ga_session_id") then concat(user_pseudo_id,cast(ep.value.int_value as string)) end) as session_id,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
event_name as event_info,
sum(ecommerce.purchase_revenue) as revenue,
COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
FROM `toolstation-data-storage.analytics_265133009.events_*`
#, unnest(event_params) as ep
WHERE event_name in ("purchase") and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
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
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
and hits.eventInfo.EventAction in ("Purchase")
group by 1,2,3,4,5),

total_sessions_PDP_Views as (SELECT distinct
"App" as UserUID,
PARSE_DATE('%Y%m%d', event_date) as date,
TIMESTAMP_MICROS(event_timestamp) AS timestamp_value,
event_name,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id
FROM `toolstation-data-storage.analytics_265133009.events_*`, unnest (event_params) as ep
WHERE event_name in ("screen_view") and ep.key in ("firebase_screen") and ep.value.string_value in ("product-detail-page") and PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
union distinct
SELECT distinct
"Web" as UserUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
TIMESTAMP_seconds(visitStartTime + hits.time) as timestamp,
hits.page.pagePath,
(concat(fullVisitorID,visitStartTime))  as session_id,
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
and regexp_contains(hits.page.pagePath, ".*/p[0-9]*$") and hits.type = "PAGE"),

bounces as (SELECT distinct
"App" as USERUID,
PARSE_DATE('%Y%m%d', event_date) as date,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))  as session_id,
case when (select distinct cast(value.int_value as string) from unnest(event_params) where key = 'engaged_session_event') = '1' then "0" else "1" end as bounces
FROM `toolstation-data-storage.analytics_265133009.events_*`
WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
union distinct
SELECT distinct
"Web" as USERUID,
date(PARSE_DATE('%Y%m%d', date)) as date,
(concat(fullVisitorID,visitStartTime))  as session_id,
case when totals.bounces = 1 then "1" else "0" end as bounces
FROM `toolstation-data-storage.4783980.ga_sessions_*`
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500 and PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %},

sub1 as (SELECT distinct coalesce(total_sessions_PDP_Views.UserUID,Videoly.UserUID,add_to_cart.UserUID,purchase.USERUID) as USERUID,
coalesce(total_sessions_PDP_Views.date,Videoly.date,add_to_cart.date,purchase.date) as date,
Videoly.event_info,
total_sessions_PDP_Views.session_id as total_sessions_PDP_Views,
Videoly.session_id as Videoly_sesions,
add_to_cart.session_id as add_to_cart_sesions,
purchase.session_id as purchase_sessions,
purchase.revenue as revenue
from total_sessions_PDP_Views
full outer join Videoly on total_sessions_PDP_Views.session_id = Videoly.session_id
full outer join add_to_cart on total_sessions_PDP_Views.session_id = add_to_cart.session_id
full outer join purchase on purchase.session_id = add_to_cart.session_id
where (total_sessions_PDP_Views.timestamp_value < Videoly.timestamp_value or total_sessions_PDP_Views.timestamp_value is null or Videoly.timestamp_value is null)
and (Videoly.timestamp_value < add_to_cart.timestamp_value or Videoly.timestamp_value is null or add_to_cart.timestamp_value is null)
and (add_to_cart.timestamp_value < purchase.timestamp_value or purchase.timestamp_value is null or add_to_cart.timestamp_value is null))

SELECT distinct row_number() over () as row_number, coalesce(sub1.USERUID,bounces.USERUID) as userUID,timestamp(coalesce(sub1.date,bounces.date)) as date,sub1.* except (UserUID,date), bounces.session_id, bounces.bounces from sub1 full outer join bounces on coalesce(total_sessions_PDP_Views,Videoly_sesions,add_to_cart_sesions,purchase_sessions) = bounces.session_id ;;
datagroup_trigger: ts_googleanalytics_datagroup
    }
   dimension: P_K {
    description: "PrimaryKey"
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.row_number ;;
   }

  dimension: App_Web {
    description: "App-Web"
    label: "App/Web"
    type: string
    sql: ${TABLE}.UserUID ;;
  }

  dimension_group: date {
    description: "date"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: event_info {
    description: "event_info"
    label: "Event Action"
    type: string
    sql: ${TABLE}.event_info ;;
  }

  dimension: total_sessions_PDP_Views {
    description: "sessions with PDP Views"
    label: "PDP view sessions"
    type: string
    sql: ${TABLE}.total_sessions_PDP_Views
 ;;
  }

  measure: Sessions_with_PDP_views {
    description: "total sessions with PDP views "
    type: count_distinct
    sql: ${TABLE}.total_sessions_PDP_Views ;;
  }

  dimension: Videoly_sesions {
    description: "Videoly_sesions"
    label: "Videoly sessions"
    type: string
    sql: ${TABLE}.Videoly_sesions
      ;;
  }

  dimension: purchase_sessions {
    description: "purchase_sessions"
    label: "purchase sessions"
    type: string
    sql: ${TABLE}.purchase_sessions
      ;;
  }

  measure: Video_started{
    description: "total where the videoly was started"
    type: count_distinct
    filters: [event_info: "watched,videoly started"]
    sql: ${TABLE}.Videoly_sesions ;;
  }

  measure: Videoly_box_shown{
    description: "total sessions where the videoly box was shown "
    type: count_distinct
    filters: [event_info: "VideolyboxShown,videoly_box_shown"]
    sql: ${TABLE}.Videoly_sesions ;;
  }

  measure: Videoly_box_shown_then_purchase{
    description: "total sessions where the videoly box was shown "
    type: count_distinct
    filters: [event_info: "VideolyboxShown,videoly_box_shown",purchase_sessions: "-NULL"]
    sql: ${TABLE}.Videoly_sesions ;;
  }


  filter: select_date_range {
    label: "Total Session Date Rangev2"
    group_label: "Date Filter"
    view_label: "Date"
    type: date
    datatype: date
    hidden: yes
    convert_tz: yes
  }

  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: videoly_conversion {
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
