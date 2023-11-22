view: videoly_funnel_ga4 {

  derived_table: {
    sql: with cte as (SELECT distinct
DeviceCategory,
Channel_group,
Medium,
Campaign,
lower(case
    when lower(event_name) = "videoly" and lower(key_1) = "action" and lower(label_1) not in ("videoly_progress") then lower(label_1)
    when lower(event_name) = "videoly" and lower(label_1) = "videoly_progress" then concat(lower(label_1),"-",lower(label_2),"%")
    when lower(event_name) = "videoly_videostart" then "videoly_start"
    when lower(event_name) = "videoly_initialize" then "videoly_box_shown"
    when lower(event_name) = "videoly_videoclosed" then "videoly_closed"
    --when regexp_contains(lower(event_name),"Videoly_progress") then "videoly_progress"
    else lower(event_name)
    end) as event_name,
platform,
session_id,
(MinTime) as MinTime,
events,
(transactions.net_value) * 0.9973 as revenue,
(transactions.OrderID) as orderID,
(transactions.Quantity) as Quantity,
 FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` left join unnest (transactions) as transactions
where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_sub(current_date(), interval 20 day)) and FORMAT_DATE('%Y%m%d', current_date())
and (regexp_contains(event_name, ".*videoly.*") or regexp_contains(event_name, ".*Videoly.*") or event_name in ("add_to_cart", "Purchase", "purchase"))

group by 1,2,3,4,5,6,7,8,9,10,11,12),

Videoly_shown as (
SELECT distinct
DeviceCategory,
Channel_group,
Medium,
Campaign,
eventName,
platform,
session_id,
min(MinTime) as MinTime,
sum(events) as events,
sum(revenue) as revenue
from cte
where eventNAme in ("videoly_box_shown")
group by 1,2,3,4,5,6,7
),

videoly_start as (
SELECT distinct
DeviceCategory,
Channel_group,
Medium,
Campaign,
eventName,
platform,
session_id,
min(MinTime) as MinTime,
sum(events) as events,
sum(revenue) as revenue,

from cte
where eventNAme in ("videoly_start")
group by 1,2,3,4,5,6,7
),

add_to_cart as (
SELECT distinct
DeviceCategory,
Channel_group,
Medium,
Campaign,
eventName,
platform,
session_id,
min(MinTime) as MinTime,
sum(events) as events,
sum(revenue) as revenue
from cte
where eventNAme in ("add_to_cart")
group by 1,2,3,4,5,6,7
),

purchase as (
SELECT distinct
DeviceCategory,
Channel_group,
Medium,
Campaign,
eventName,
platform,
session_id,
orderID,
min(MinTime) as MinTime,
sum(events) as events,
sum(revenue) as revenue,
sum(Quantity) as Quantity
from cte
where eventNAme in ("purchase")
group by 1,2,3,4,5,6,7,8
)

SELECT distinct
row_number() over () as P_K,
a.session_id,
a.platform,
a.DeviceCategory,
a.Channel_group,
a.Medium,
a.Campaign,
d.orderID,
min(a.MinTime) as videoly_shownTime,
min(b.MinTime) as videoly_startedTime,
min(c.MinTime) as Add_to_cartTime,
min(d.MinTime) as purchaseTime,
sum(a.events) as Videoly_shown_events,
sum(b.events) as Videoly_started_events,
sum(c.events) as ATC_events,
sum(d.events) as purchase_events,
sum(d.revenue) as revenue,
sum(d.Quantity) as Quantity,
from videoly_shown as a
left outer join videoly_start as b
on a.session_id = b.session_id
left outer join add_to_cart as c
on a.session_id = c.session_id
left outer join purchase as d
on a.session_id = d.session_id
where (((b.minTime) is null or a.minTime<b.minTime))
and ((c.minTime is null or a.minTime<c.minTime))
and ((d.minTime is null or a.minTime<d.minTime))
group by 2,3,4,5,6,7,8;;
    sql_trigger_value: SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*10)/(60*60*24))
    ;;
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
    sql: ${TABLE}.P_K ;;
   }
  #
   dimension: session_id {
    description: "unique identifier for session"
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
   }
  #
   dimension_group: date {
     type: time
    hidden: yes
     timeframes: [raw,date]
     sql: ${TABLE}.videoly_shownTime ;;
   }

  dimension: DeviceCategory {
    type: string
    hidden: yes
    group_label: "User attributes"
    label: "Device Category"
    description: "Device type used"
    sql: ${TABLE}.DeviceCategory ;;
  }

  dimension: Channel_group {
    type: string
    hidden: yes
    group_label: "Traffic Acquisition"
    label: "Channel Grouping"
    description: "Channel grouping from source"
    sql: ${TABLE}.Channel_group ;;
  }

  dimension: Medium {
    type: string
    hidden: yes
    group_label: "Traffic Acquisition"
    label: "Medium"
    description: "Medium from source"
    sql: ${TABLE}.Medium ;;
  }

  dimension: Campaign {
    type: string
    hidden: yes
    group_label: "Traffic Acquisition"
    label: "Campaign"
    description: "Campaign from source"
    sql: ${TABLE}.Campaign ;;
  }

  dimension_group: videoly_shownTime {
    type: time
    timeframes: [time]
    hidden: yes
    group_label: "Stage 1: Videoly Shown"
    description: "datetime session was first shown videoly"
    label: "Videoly Shown Time"
    sql: ${TABLE}.videoly_shownTime ;;
  }

  dimension: videoly_shownEvents {
    type: number
    hidden: yes
    sql: ${TABLE}.Videoly_shown_events ;;
  }

  measure: videoly_shown_events {
    view_label: "GA4"
    group_label: "Stage 1: Videoly Shown"
    label: "Videoly Shown Events"
    description: "Total Videoly shown events"
    type: sum
    sql: ${videoly_shownEvents} ;;
  }

  measure: videoly_shownSessions {
    view_label: "GA4"
    group_label: "Stage 1: Videoly Shown"
    label: "Videoly Shown sessions"
    description: "Sessions where Videoly was shown"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [videoly_shownEvents: ">=1"]
  }

  dimension_group: videoly_startedTime {
    hidden: yes
    type: time
    timeframes: [time]
    group_label: "Stage 2: Videoly Started"
    description: "datetime session was first started videoly"
    label: "Videoly Started Time"
    sql: ${TABLE}.videoly_startedTime ;;
  }

  dimension: videoly_startedEvents {
    type: number
    hidden: yes
    sql: ${TABLE}.Videoly_started_events ;;

  }

  measure: videoly_started_events {
    view_label: "GA4"
    group_label: "Stage 2: Videoly Started"
    label: "Videoly Started Events"
    description: "Total Videoly started events"
    type: sum
    sql: ${videoly_startedEvents} ;;
  }

  measure: videoly_startedSessions {
    view_label: "GA4"
    group_label: "Stage 2: Videoly Started"
    label: "Videoly started sessions"
    description: "Sessions where Videoly was started"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [videoly_shownEvents: ">=1", videoly_startedEvents: ">=1",]
  }

  dimension_group: Add_to_cartTime {
    hidden: yes
    type: time
    timeframes: [time]
    description: "datetime item was was first added to cart where video was shown and started"
    group_label: "Stage 3: Add to Cart"
    label: "Add to Cart Time"
    sql: ${TABLE}.Add_to_cartTime ;;
  }

  dimension: ATC_events {
    type: number
    hidden: yes
    sql: ${TABLE}.ATC_events ;;

  }

  measure: add_to_cart_events {
    view_label: "GA4"
    group_label: "Stage 3: Add to Cart"
    label: "Add to Cart Events"
    description: "Total Add to Cart events where video was shown and started"
    type: sum
    sql: ${ATC_events} ;;
    filters: [videoly_shownEvents: ">=1", videoly_startedEvents: ">=1", ATC_events: ">=1"]
  }

  measure: ATC_Sessions {
    view_label: "GA4"
    group_label: "Stage 3: Add to Cart"
    label: "Add to cart sessions"
    description: "Sessions where item was added to cart where video was shown and started"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [videoly_shownEvents: ">=1", videoly_startedEvents: ">=1", ATC_events: ">=1"]
  }

  dimension_group: purchase_Time {
    hidden: yes
    type: time
    timeframes: [time]
    description: "datetime purchase first occured in session where video was shown and started"
    group_label: "Stage 4: Purchase"
    label: "Purchase Time"
    sql: ${TABLE}.purchaseTime ;;
  }

  dimension: purchase_events {
    type: number
    hidden: yes
    sql: ${TABLE}.purchase_events ;;

  }

  measure: PurchaseEvents {
    view_label: "GA4"
    group_label: "Stage 4: Purchase"
    label: "Purchase Events"
    description: "Total Purchase events where earlier in the session a video was shown and started"
    type: sum
    sql: ${purchase_events} ;;
  }

  measure: purchase_Sessions {
    view_label: "GA4"
    group_label: "Stage 4: Purchase"
    label: "Purchase sessions"
    description: "Sessions where purchase occured after a video was shown and started"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [videoly_shownEvents: ">=1", videoly_startedEvents: ">=1", ATC_events: ">=1", purchase_events: ">=1" ]
  }

  measure: purchase_transactions {
    view_label: "GA4"
    group_label: "Stage 4: Purchase"
    label: "Transactions"
    description: "Transactions after a video was shown and started"
    type: count_distinct
    sql: ${TABLE}.orderID ;;
    filters: [videoly_shownEvents: ">=1", videoly_startedEvents: ">=1", ATC_events: ">=1", purchase_events: ">=1" ]
  }

  measure: purchase_revenue {
    view_label: "GA4"
    group_label: "Stage 4: Purchase"
    label: "Revenue"
    description: "revenue where purchase occured after a video was shown and started"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.revenue ;;
    filters: [videoly_shownEvents: ">=1", videoly_startedEvents: ">=1", ATC_events: ">=1", purchase_events: ">=1" ]
  }

  measure: purchaseNotStarted_Sessions {
    view_label: "GA4"
    group_label: "Stage 4: Purchase"
    label: "Purchase sessions (Videoly shown not started)"
    description: "Sessions where purchase occured after a video was shown and not started"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [videoly_shownEvents: ">=1", videoly_startedEvents: "0 or NULL", purchase_events: ">=1"  ]
  }

  measure: purchaseNotStarted_revenue {
    view_label: "GA4"
    group_label: "Stage 4: Purchase"
    label: "Revenue (videoly shown not started)"
    description: "revenue where purchase occured after a video was shown and not started"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.revenue ;;
    filters: [videoly_startedEvents: ">=1", videoly_startedEvents: "0 or NULL", purchase_events: ">=1"  ]
  }

}
