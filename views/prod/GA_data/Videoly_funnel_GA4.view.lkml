view: videoly_funnel_ga4 {

  derived_table: {
    sql: with cte as (SELECT distinct
session_id,
(MinTime) as MinTime,
aw.item_id,
lower(case
    when lower(event_name) = "videoly" and lower(key_1) = "action" and lower(label_1) not in ("videoly_progress") then lower(label_1)
    when lower(event_name) = "videoly" and lower(label_1) = "videoly_progress" then concat(lower(label_1),"-",lower(label_2),"%")
    when lower(event_name) = "videoly_videostart" then "videoly_start"
    when lower(event_name) = "videoly_initialize" then "videoly_box_shown"
    when lower(event_name) = "videoly_videoclosed" then "videoly_closed"
    --when regexp_contains(lower(event_name),"Videoly_progress") then "videoly_progress"
    else lower(event_name)
    end) as event_name,
events,
(transactions.net_value) * 0.9973 as revenue,
(transactions.OrderID) as orderID,
(transactions.Quantity) as Quantity,
 FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest (transactions) as transactions
where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_sub(current_date(), interval 10 day)) and FORMAT_DATE('%Y%m%d', current_date())
and (regexp_contains(event_name, ".*videoly.*") or regexp_contains(event_name, ".*Videoly.*") or event_name in ("add_to_cart", "Purchase", "purchase"))

group by 1,2,3,4,5,6,7,8),

Videoly_shown as (
SELECT distinct
event_name,
session_id,
item_id,
min(MinTime) as MinTime,
#sum(events) as events,
sum(revenue) as revenue
from cte
where event_name in ("videoly_box_shown")
group by 1,2,3
),

videoly_start as (
SELECT distinct
event_name,
session_id,
item_id,
min(MinTime) as MinTime,
#sum(events) as events,
sum(revenue) as revenue,

from cte
where event_name in ("videoly_start")
group by 1,2,3
),

add_to_cart as (
SELECT distinct
event_name,
session_id,
item_id,
min(MinTime) as MinTime,
#sum(events) as events,
sum(revenue) as revenue
from cte
where event_name in ("add_to_cart")
group by 1,2,3
),

purchase as (
SELECT distinct
event_name,
session_id,
item_id,
orderID,
min(MinTime) as MinTime,
#sum(events) as events,
sum(revenue) as revenue,
sum(Quantity) as Quantity
from cte
where event_name in ("purchase")
group by 1,2,3,4
)

SELECT distinct
row_number() over () as P_K,

a.item_id,
#a.DeviceCategory,
#a.Channel_group,
#a.Medium,
#a.Campaign,
d.orderID,
a.session_id as videolyShown_sessionID,
min(a.MinTime) as videoly_shownTime,
b.session_id as videolyStart_sessionID,
min(b.MinTime) as videoly_startedTime,
c.session_id as addToCart_sessionID,
min(c.MinTime) as Add_to_cartTime,
d.session_id as purchase_sessionID,
min(d.MinTime) as purchaseTime,
#sum(a.events) as Videoly_shown_events,
#sum(b.events) as Videoly_started_events,
#sum(c.events) as ATC_events,
#sum(d.events) as purchase_events,
sum(d.revenue) as revenue,
sum(d.Quantity) as Quantity,
from videoly_shown as a
left outer join videoly_start as b
on a.session_id = b.session_id and a.item_id = b.item_id
left outer join add_to_cart as c
on a.session_id = c.session_id and a.item_id = c.item_id
left outer join purchase as d
on a.session_id = d.session_id and a.item_id = d.item_id
where (((b.minTime) is null or a.minTime<b.minTime))
and ((c.minTime is null or a.minTime<c.minTime))
and ((d.minTime is null or a.minTime<d.minTime))
group by 2,3,4,6,8,10;;
    sql_trigger_value: SELECT EXTRACT(dayofweek FROM CURRENT_DATEtime()) between 2 and 6 and extract(hour from current_datetime()) = 13
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 7 and extract(hour from current_datetime()) = 16
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 1 and extract(hour from current_datetime()) = 16
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

  dimension: item_id {
    description: "item_id join to product code"
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
  }

   dimension: videolyShown_sessionID {
    description: "Videoly Shown session ID"
    hidden: yes
    type: string
    sql: ${TABLE}.videolyShown_sessionID ;;
   }

  dimension: videolyStart_sessionID {
    description: "Videoly Start session ID"
    hidden: yes
    type: string
    sql: ${TABLE}.videolyStart_sessionID ;;
  }

  dimension: ATC_sessionID {
    description: "Videoly Start session ID"
    hidden: yes
    type: string
    sql: ${TABLE}.addToCart_sessionID ;;
  }

  dimension: purchase_sessionID {
    description: "Videoly Start session ID"
    hidden: yes
    type: string
    sql: ${TABLE}.purchase_sessionID ;;
  }

   dimension_group: date {
     type: time
    hidden: yes
     timeframes: [raw,date]
     sql: ${TABLE}.videoly_shownTime ;;
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

  measure: videoly_shownSessions {
    view_label: "Videoly Funnel"
    group_label: "Stage 1: Videoly Shown"
    label: "Videoly Shown sessions"
    description: "Sessions where Videoly was shown"
    type: count_distinct
    sql: ${videolyShown_sessionID} ;;
    filters: [videolyShown_sessionID: "-NULL"]
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


  measure: videoly_startedSessions {
    view_label: "Videoly Funnel"
    group_label: "Stage 2: Videoly Started"
    label: "Videoly started sessions"
    description: "Sessions where Videoly was started"
    type: count_distinct
    sql: ${videolyStart_sessionID} ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "-NULL"]
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

  measure: ATC_Sessions {
    view_label: "Videoly Funnel"
    group_label: "Stage 3: Add to Cart"
    label: "Add to cart sessions"
    description: "Sessions where item was added to cart where video was shown and started"
    type: count_distinct
    sql: ${ATC_sessionID} ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "-NULL", ATC_sessionID: "-NULL"]
  }


  measure: purchase_Sessions {
    view_label: "Videoly Funnel"
    group_label: "Stage 4: Purchase"
    label: "Purchase sessions"
    description: "Sessions where purchase occured after a video was shown and started"
    type: count_distinct
    sql: ${purchase_sessionID} ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "-NULL", ATC_sessionID: "-NULL", purchase_sessionID: "-NULL"]
  }

  measure: purchase_transactions {
    view_label: "Videoly Funnel"
    group_label: "Stage 4: Purchase"
    label: "Transactions"
    description: "Transactions after a video was shown and started"
    type: count_distinct
    sql: ${TABLE}.orderID ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "-NULL", ATC_sessionID: "-NULL", purchase_sessionID: "-NULL"]
  }

  measure: purchase_productQuant {
    view_label: "Videoly Funnel"
    group_label: "Stage 4: Purchase"
    label: "Quantity"
    description: "product quantity purchased after a video was shown and started"
    type: sum
    sql: ${TABLE}.Quantity ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "-NULL", ATC_sessionID: "-NULL", purchase_sessionID: "-NULL"]
  }

  measure: purchase_revenue {
    view_label: "Videoly Funnel"
    group_label: "Stage 4: Purchase"
    label: "Net Revenue"
    description: "revenue where purchase occured after a video was shown and started"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.revenue ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "-NULL", ATC_sessionID: "-NULL", purchase_sessionID: "-NULL"]
  }

  measure: purchaseNotStarted_Sessions {
    view_label: "Videoly Funnel"
    group_label: "Stage 4: Purchase"
    label: "Purchase sessions (Videoly shown not started)"
    description: "Sessions where purchase occured after a video was shown and not started"
    type: count_distinct
    sql: ${purchase_sessionID} ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "NULL", ATC_sessionID: "-NULL", purchase_sessionID: "-NULL"]
  }

  measure: purchaseNotStarted_revenue {
    view_label: "Videoly Funnel"
    group_label: "Stage 4: Purchase"
    label: "Revenue (videoly shown not started)"
    description: "revenue where purchase occured after a video was shown and not started"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.revenue ;;
    filters: [videolyShown_sessionID: "-NULL", videolyStart_sessionID: "NULL", ATC_sessionID: "-NULL", purchase_sessionID: "-NULL"]
  }

}
