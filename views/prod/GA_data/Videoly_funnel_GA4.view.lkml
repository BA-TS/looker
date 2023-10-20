view: videoly_funnel_ga4 {

  derived_table: {
    sql: with cte as (SELECT distinct
DeviceCategory,
Channel_group,
Medium,
Campaign,
case when regexp_contains(event_name, "Videoly_progress") then "videoly_progress"
when regexp_contains(event_name, "Videoly_videoStart") then "videoly_start"
when regexp_contains(event_name, "Videoly_initialize") then "videoly_box_shown"
when regexp_contains(event_name, "Videoly_videoClosed") then "videoly_closed"
when regexp_contains(event_name, "add_to_cart") then "add_to_cart"
when regexp_contains(event_name, "purchase") then "purchase"
when regexp_contains(event_name, "Purchase") then "Purchase"
else label_1 end as eventName,
platform,
session_id,
MinTime,
events,
(transactions.ga4_revenue) as revenue
 FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` left join unnest (transactions) as transactions
where regexp_contains(event_name, ".*videoly.*") or regexp_contains(event_name, ".*Videoly.*") or event_name in ("add_to_cart", "Purchase", "purchase")
 and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK)) and FORMAT_DATE('%Y%m%d', DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK))
AND ((( (date) ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK))) AND ( (date) ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY)), INTERVAL -1 WEEK), INTERVAL 1 WEEK)))))
group by 1,2,3,4,5,6,7,8,9,10
order by 1 desc),

Videoly_shown as (
  SELECT distinct * from cte where eventNAme in ("videoly_box_shown")
),

videoly_start as (
  SELECT distinct * from cte where eventNAme in ("videoly_start")
),

add_to_cart as (
  SELECT distinct * from cte where eventNAme in ("add_to_cart")
),

purchase as (
  SELECT distinct * from cte where eventNAme in ("purchase")
)

SELECT distinct
row_number() over () as P_K,
a.session_id,
a.platform,
a.DeviceCategory,
a.Channel_group,
a.Medium,
a.Campaign,
a.MinTime as videoly_shownTime,
b.MinTime as videoly_startedTime,
c.MinTime as Add_to_cartTime,
d.MinTime as purchaseTime,
sum(a.events) as Videoly_shown_events,
sum(b.events) as Videoly_started_events,
sum(c.events) as ATC_events,
sum(d.events) as purchase_events,
sum(d.revenue) as revenue,
from videoly_shown as a
left outer join videoly_start as b
on a.session_id = b.session_id
left outer join add_to_cart as c
on a.session_id = c.session_id
left outer join purchase as d
on a.session_id = d.session_id
where ((b.minTime is null or a.minTime<b.minTime))
and ((c.minTime is null or a.minTime<c.minTime))
and ((d.minTime is null or a.minTime<d.minTime))
group by 2,3,4,5,6,7,8,9,10,11;;
#datagroup_trigger: ts_googleanalytics_datagroup
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
