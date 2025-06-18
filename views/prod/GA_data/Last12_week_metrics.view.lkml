view: last12_week_metrics {

  derived_table: {
    sql:

with sub1 as (
select distinct
"Current Year" as year,
date(timestamp_add(minTime, INTERVAL 1 hour)) as date,
minTime,
platform,
deviceCategory,
channel_group,
customer,
session_id,
cookie_consent,
page_location,
screen_name,
screen_Type,
event_name,
key1,
label_1,
key_2,
label_2,
filter_key,
filter_label,
productCode,
item_id,
OrderID,
net,
gross,
ga4_rev,
Quantity,
--events,
row_number () over (partition by session_id order by minTime asc) as landingP,
row_number () over (partition by session_id order by minTime desc) as exitP



from
(SELECT distinct date, minTime, platform, deviceCategory,
channel_group,
case when session_id is null then cast(user_first_touch_timestamp as string) else session_id end as session_id,
case when transactions.customer is null then user else transactions.customer end as customer,
cookie_consent,
 page_location,
case when regexp_contains(page_location,"checkout\\/confirmation") then "Checkout Confirmation" else screen_name end as screen_name,

CASE when regexp_contains(page_location,".*/p[0-9]{5}$|.*/p[0-9]{5}[^0-9a-zA-Z]|.*/p[A-Z]{2}[0-9]{3}$|.*/p[A-Z]{2}[0-9]{3}[^0-9a-zA-Z]") then "product-detail-page"
else (case when regexp_contains(page_location,".*/c([0-9]*)$|.*/c[0-9]*[^0-9a-zA-Z]") then "product-listing-page"
else screen_name end) end as screen_Type,

case
when event_name = "videoly" and key_1 = "action" and label_1 not in ("videoly_progress") then label_1
when event_name = "videoly" and label_1 = "videoly_progress" then concat(label_1,"-",label_2,"%")
when event_name = "videoly_videostart" then "videoly_start"
when event_name = "videoly_initialize" then "videoly_box_shown"
when event_name = "videoly_videoclosed" then "videoly_closed"
when event_name = "collection_OOS" and platform = "Web" then "out_of_stock"
when event_name = "dual_OOS" and platform = "Web" then "out_of_stock"
when event_name = "Delivery_OOS" and platform = "Web" then "out_of_stock"
when event_name = "outOfStock" and platform = "Web" then "out_of_stock"
when event_name = "out_of_stock" and platform = "Web" then null
else event_name
end as event_name,

case
when event_name in ("collection_OOS", "dual_OOS", "Delivery_OOS") and platform = "Web" then "Channel"
when event_name = "out_of_stock" and platform = "Web" then null
when event_name = "out_of_stock" and platform = "App" then "Channel"
when event_name in ("MegaMenu") then label_2
--and platform in ("Web") then key_2
when key_1 is null and label_1 is not null then "action"
else key_1 end key1,
item_id,

INITCAP(Ltrim(
case when event_name in ("search", "search_actions", "blank_search") then coalesce(label_1,regexp_replace(regexp_extract(page_location, ".*q\\=(.*)$"), "\\+", " ")) else
(case when event_name in ("add_to_cart") and platform in ("Web") then regexp_extract(label_1, "^.*\\-(.*)$") else
(case when event_name = "collection_OOS" and platform = "Web" then "Collection" else
(case when event_name = "dual_OOS" and platform = "Web" then "Dual" else
(case when event_name = "Delivery_OOS" and platform = "Web" then "Delivery" else
(case when event_name in ("add_to_cart") and platform in ("App") and key_1 in ("page") then channel else (case when event_name in ("navigation") then coalesce(key_2,label_1) else label_1 end) end) end) end) end) end) end)) as label_1,

case when key_2 is null and label_2 is not null then "action" else
(case when event_name in ("navigation") and label_1 is null and key_2 is not null then null else key_2 end) end as key_2,

case when event_name in ("add_to_cart") and platform in ("Web") then regexp_extract(label_2, "^.*\\-(.*)$") else label_2 end as label_2,
    regexp_extract(fu, "(.*)\\:.*") as filter_key,
    regexp_extract(fu, ".*\\:(.*)") as filter_label,
      transactions.productCode,
      transactions.OrderID,
      #Filters_used,
      sum(transactions.net_value) as net,
      sum(transactions.gross_value) as gross,
      sum(transactions.ga4_revenue) as ga4_rev,
      sum(transactions.Quantity) as Quantity,
      --count(distinct events) as events,
      FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
      left join unnest(SPLIT(filters_used, ",")) as fu WITH OFFSET as test2
      where
      --((aw.item_id = transactions.productCode) or (aw.item_id is not null and transactions.productCode is null) or (aw.item_id is null and transactions.productCode is null)) and

       _TABLE_SUFFIX between format_date("%Y%m%d",date_trunc(date_sub(current_date(), interval 12 week), week(sunday))) and format_date("%Y%m%d",current_date())

and date(timestamp_add(minTime, interval 1 hour)) between date_trunc(date_sub(current_date(), interval 12 week), week(sunday)) and date(current_date())



      group by all)
      where not regexp_contains(productCode, "^0.*") or productCode is null

),

  landing_P as (select distinct session_id as landing_session, page_location as landingPage, screen_name as landingScreen, screen_Type as LandingScreenType
      from sub1 where landingP = 1),

      exit_P as (select distinct session_id as exit_session, page_location as exitPage, screen_name as exitScreen, screen_Type as exitScreenType
      from sub1 where exitP = 1),

      purchase as (select distinct customer, session_id as purchase_session, min(minTime) as purchase_time,  sum(net) as net, sum(gross) as gross, sum(ga4_rev) as ga4_rev, sum(Quantity) as quantity, OrderID, platform as purchase_platform, year as purchase_year,
      from sub1 where event_name in ("purchase", "Purchase")
      group by all),

      purchasePC as (select distinct customer, session_id as purchase_session, min(minTime) as purchase_time, productCode, sum(net) as net, sum(gross) as gross, sum(ga4_rev) as ga4_rev, sum(Quantity) as quantity, OrderID, platform as purchase_platform, year as purchase_year,
      from sub1 where event_name in ("purchase", "Purchase")
      group by all),

      search as (select distinct session_id as search_session, min(minTime) as search_time
      from sub1 where (platform in ("Web", "web") and event_name in ("search_actions") and key1 in ("Searched Term", "search_term", "Search_term"))
      or (platform in ("App", "app") and event_name in ("search"))
      group by all),

      blank_search as (select distinct session_id as blanksearch_session
      from sub1 where event_name in ("blank_search")
      group by all),

      filters_used as (select distinct session_id as filter_session from sub1
      where event_name in ("filter_applied", "filter_removed") or filter_label is not null),

      PDP as (select distinct session_id as PDP_session from sub1
      where event_name in ("view_item") and screen_Type in ("product-detail-page") ),

      megamenu as (select distinct session_id as megamenu_session from sub1
      where event_name in ("MegaMenu", "navigation") ),

      ATC as (select distinct session_id as atc_session from sub1
      where event_name in ("add_to_cart") ),

      page_not_found as (select distinct session_id as session_404 from sub1
      where event_name in ("404_page_not_found") ),

      rec as (select distinct min(minTime) as recTime, item_id, session_id as recSession from sub1
      where event_name in ("suggested_item_click", "recommended_item_tapped") group by all),

      sub2 as (select distinct
      coalesce(sub1.date, date(purchase.purchase_Time)) as date,
      coalesce(sub1.year, purchase.purchase_year) as yearType,
      coalesce(platform,purchase.purchase_platform) as platform,
      sub1.channel_group,
      deviceCategory,
      sub1.cookie_consent,
      coalesce(purchase.customer, sub1.customer) as customer,
      sub1.session_id as all_sessions,
      count(distinct case when screen_name not in ("Trolley | Toolstation", "trolley-page", "Review & Pay","Checkout Confirmation", "checkout-page", "payment-page", "order-confirmation-page") then screen_name else null end) over (partition by sub1.session_id) pages_in_session,
      --page_location, screen_name,
    --case when screen_type in ("product-detail-page") and landingScreen not in ("product-detail-page") then "Get_to_PDP" else "Other" end as screen_type_grouped,
      --landingPage,landingScreen,
      LandingScreenType,
      --exitPage,exitScreen,
      --exitScreenType,
      PDP_session,
      search.search_session as search_session,
      search.search_time as search_time,
      blanksearch_session as blank_search,
      purchase.purchase_session,
      purchase.purchase_time as purchase_time,
      purchase.net as purchase_net,
      purchase.gross as purchase_gross,
      purchase.ga4_rev as ga4_rev,
      purchase.quantity as purchase_quantity,
      purchase.OrderID as Orders,
      filters_used.filter_session,
      megamenu_session,
      atc_session,
      session_404,
      rec.recSession,
      purchasePC.purchase_session as rec_purchase_session,
      purchasePC.net as rec_purchase_net,
      purchasePC.gross as rec_purchase_gross,
      purchasePC.ga4_rev as rec_ga4_rev,
      purchasePC.quantity as rec_purchase_quantity,
      purchasePC.OrderID as rec_Orders,
      ----search to purchase-------
      -- searchPurchase.purchase_session as search_purchase_session,
      -- searchPurchase.net as search_purchase_net,
      -- searchPurchase.gross as search_purchase_gross,
      -- searchPurchase.ga4_rev as search_ga4_rev,
      -- searchPurchase.quantity as search_purchase_quantity,
      -- searchPurchase.OrderID as search_Orders,

      from sub1
      inner join landing_P on session_id=landing_session
      inner join exit_p on session_id=exit_session
      left join search on session_id=search_session
      full outer join purchase on session_id=purchase_session
      left join blank_search on session_id = blanksearch_session
      left join filters_used on session_id=filter_session
      left join PDP on session_id=PDP_session
      left join megamenu on session_id=megamenu_session
      left join ATC on session_id=atc_session
      left join page_not_found on session_id=session_404
      left join rec on session_id = rec.recSession
      left join purchasePC on rec.recSession = purchasePC.purchase_session and rec.item_id = purchasePC.productCode and rec.recTime < purchasePC.purchase_time
      -- left join purchasePC as searchPurchase on search.search_session = searchPurchase.purchase_session and search.search_Time < searchPurchase.purchase_time
      group by 1,2,3,4,5,6,7,8,screen_name,10,11,12,13,14,15,16,17,18,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32)

select distinct concat(cast(row_number() over () as string), all_sessions) as PK,  date,
yearType,
platform,
deviceCategory,
channel_group,
cust.customerUID,
guestCheckout,
case when loyalty_club_member is null then false else loyalty_club_member end as loyalty_club_member,
Trade_Type,
Trade_Flag,
all_sessions,
cookie_consent,
pages_in_session,
PDP_Session as get_to_product,
LandingScreenType,
search_session,
search_time,
blank_search,
purchase_session,
purchase_time,
purchase_net,
purchase_gross,
ga4_rev,
purchase_quantity,
Orders,
filter_session,
megamenu_session,
atc_session,
session_404,
recSession,
rec_purchase_session,
rec_purchase_net,
rec_purchase_gross,
rec_ga4_rev,
rec_purchase_quantity,
rec_Orders,
-- search_purchase_session,
-- search_purchase_net,
-- search_purchase_gross,
-- search_ga4_rev,
-- search_purchase_quantity,
-- search_Orders,
from sub2 left join (SELECT distinct cust.customerUID, cust.flags.guestCheckout, cust.loyalty.loyalty_club_member, Trade_Type, Trade_Flag
FROM `toolstation-data-storage.customer.allCustomers` as cust
left join `toolstation-data-storage.customer.dbs_trade_customers` as dbc on cust.customerUID = dbc.customer_number) as cust on sub2.customer = cust.customerUID
union distinct
(with sub1 as (
select distinct
"Last Year" as year,
date(timestamp_add(minTime, INTERVAL 1 hour)) as date,
minTime,
platform,
deviceCategory,
channel_group,
customer,
session_id,
cookie_consent,
page_location,
screen_name,
screen_Type,
event_name,
key1,
label_1,
key_2,
label_2,
filter_key,
filter_label,
productCode,
item_id,
OrderID,
net,
gross,
ga4_rev,
Quantity,
--events,
row_number () over (partition by session_id order by minTime asc) as landingP,
row_number () over (partition by session_id order by minTime desc) as exitP



from
(SELECT distinct date, minTime, platform, deviceCategory,
channel_group,
case when session_id is null then cast(user_first_touch_timestamp as string) else session_id end as session_id,
case when transactions.customer is null then user else transactions.customer end as customer,
cookie_consent,
 page_location,
case when regexp_contains(page_location,"checkout\\/confirmation") then "Checkout Confirmation" else screen_name end as screen_name,

CASE when regexp_contains(page_location,".*/p[0-9]{5}$|.*/p[0-9]{5}[^0-9a-zA-Z]|.*/p[A-Z]{2}[0-9]{3}$|.*/p[A-Z]{2}[0-9]{3}[^0-9a-zA-Z]") then "product-detail-page"
else (case when regexp_contains(page_location,".*/c([0-9]*)$|.*/c[0-9]*[^0-9a-zA-Z]") then "product-listing-page"
else screen_name end) end as screen_Type,

case
when event_name = "videoly" and key_1 = "action" and label_1 not in ("videoly_progress") then label_1
when event_name = "videoly" and label_1 = "videoly_progress" then concat(label_1,"-",label_2,"%")
when event_name = "videoly_videostart" then "videoly_start"
when event_name = "videoly_initialize" then "videoly_box_shown"
when event_name = "videoly_videoclosed" then "videoly_closed"
when event_name = "collection_OOS" and platform = "Web" then "out_of_stock"
when event_name = "dual_OOS" and platform = "Web" then "out_of_stock"
when event_name = "Delivery_OOS" and platform = "Web" then "out_of_stock"
when event_name = "outOfStock" and platform = "Web" then "out_of_stock"
when event_name = "out_of_stock" and platform = "Web" then null
else event_name
end as event_name,

case
when event_name in ("collection_OOS", "dual_OOS", "Delivery_OOS") and platform = "Web" then "Channel"
when event_name = "out_of_stock" and platform = "Web" then null
when event_name = "out_of_stock" and platform = "App" then "Channel"
when event_name in ("MegaMenu") then label_2
--and platform in ("Web") then key_2
when key_1 is null and label_1 is not null then "action"
else key_1 end key1,
item_id,

INITCAP(Ltrim(
case when event_name in ("search", "search_actions", "blank_search") then coalesce(label_1,regexp_replace(regexp_extract(page_location, ".*q\\=(.*)$"), "\\+", " ")) else
(case when event_name in ("add_to_cart") and platform in ("Web") then regexp_extract(label_1, "^.*\\-(.*)$") else
(case when event_name = "collection_OOS" and platform = "Web" then "Collection" else
(case when event_name = "dual_OOS" and platform = "Web" then "Dual" else
(case when event_name = "Delivery_OOS" and platform = "Web" then "Delivery" else
(case when event_name in ("add_to_cart") and platform in ("App") and key_1 in ("page") then channel else (case when event_name in ("navigation") then coalesce(key_2,label_1) else label_1 end) end) end) end) end) end) end)) as label_1,

case when key_2 is null and label_2 is not null then "action" else
(case when event_name in ("navigation") and label_1 is null and key_2 is not null then null else key_2 end) end as key_2,

case when event_name in ("add_to_cart") and platform in ("Web") then regexp_extract(label_2, "^.*\\-(.*)$") else label_2 end as label_2,
    regexp_extract(fu, "(.*)\\:.*") as filter_key,
    regexp_extract(fu, ".*\\:(.*)") as filter_label,
      transactions.productCode,
      transactions.OrderID,
      #Filters_used,
      sum(transactions.net_value) as net,
      sum(transactions.gross_value) as gross,
      sum(transactions.ga4_revenue) as ga4_rev,
      sum(transactions.Quantity) as Quantity,
      --count(distinct events) as events,
      FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
      left join unnest(SPLIT(filters_used, ",")) as fu WITH OFFSET as test2
      where
      --((aw.item_id = transactions.productCode) or (aw.item_id is not null and transactions.productCode is null) or (aw.item_id is null and transactions.productCode is null)) and

       _TABLE_SUFFIX between format_date("%Y%m%d",date_trunc(date_sub(date_sub(current_date(), interval 4 week), interval 52 week), week(sunday))) and format_date("%Y%m%d",date_sub(current_date(), interval 52 week))

and date(timestamp_add(minTime, interval 1 hour)) between date_trunc(date_sub(date_sub(current_date(), interval 4 week), interval 52 week), week(sunday)) and date(date_sub(current_date(), interval 52 week))



      group by all)
      where not regexp_contains(productCode, "^0.*") or productCode is null

),

  landing_P as (select distinct session_id as landing_session, page_location as landingPage, screen_name as landingScreen, screen_Type as LandingScreenType
      from sub1 where landingP = 1),

      exit_P as (select distinct session_id as exit_session, page_location as exitPage, screen_name as exitScreen, screen_Type as exitScreenType
      from sub1 where exitP = 1),

      purchase as (select distinct customer, session_id as purchase_session, min(minTime) as purchase_time,  sum(net) as net, sum(gross) as gross, sum(ga4_rev) as ga4_rev, sum(Quantity) as quantity, OrderID, platform as purchase_platform, year as purchase_year,
      from sub1 where event_name in ("purchase", "Purchase")
      group by all),

      purchasePC as (select distinct customer, session_id as purchase_session, min(minTime) as purchase_time, productCode, sum(net) as net, sum(gross) as gross, sum(ga4_rev) as ga4_rev, sum(Quantity) as quantity, OrderID, platform as purchase_platform, year as purchase_year,
      from sub1 where event_name in ("purchase", "Purchase")
      group by all),

      search as (select distinct session_id as search_session, min(minTime) as search_time
      from sub1 where regexp_contains(event_name, "search") and event_name not in ("blank_search")
      group by all),

      blank_search as (select distinct session_id as blanksearch_session
      from sub1 where event_name in ("blank_search")
      group by all),

      filters_used as (select distinct session_id as filter_session from sub1
      where event_name in ("filter_applied", "filter_removed") or filter_label is not null),

      PDP as (select distinct session_id as PDP_session from sub1
      where event_name in ("view_item") and screen_Type in ("product-detail-page") ),

      megamenu as (select distinct session_id as megamenu_session from sub1
      where event_name in ("MegaMenu", "navigation") ),

      ATC as (select distinct session_id as atc_session from sub1
      where event_name in ("add_to_cart") ),

      page_not_found as (select distinct session_id as session_404 from sub1
      where event_name in ("404_page_not_found") ),

      rec as (select distinct min(minTime) as recTime, item_id, session_id as recSession from sub1
      where event_name in ("suggested_item_click", "recommended_item_tapped") group by all),

      sub2 as (select distinct
      coalesce(sub1.date, date(purchase.purchase_Time)) as date,
      coalesce(sub1.year, purchase.purchase_year) as yearType,
      coalesce(platform,purchase.purchase_platform) as platform,
      sub1.channel_group,
      deviceCategory,
      sub1.cookie_consent,
      coalesce(purchase.customer, sub1.customer) as customer,
      sub1.session_id as all_sessions,
      count(distinct case when screen_name not in ("Trolley | Toolstation", "trolley-page", "Review & Pay","Checkout Confirmation", "checkout-page", "payment-page", "order-confirmation-page") then screen_name else null end) over (partition by sub1.session_id) pages_in_session,
      --page_location, screen_name,
    --case when screen_type in ("product-detail-page") and landingScreen not in ("product-detail-page") then "Get_to_PDP" else "Other" end as screen_type_grouped,
      --landingPage,landingScreen,
      LandingScreenType,
      --exitPage,exitScreen,
      --exitScreenType,
      PDP_session,
      search.search_session as search_session,
      search.search_time as search_time,
      blanksearch_session as blank_search,
      purchase.purchase_session,
      purchase.purchase_time as purchase_time,
      purchase.net as purchase_net,
      purchase.gross as purchase_gross,
      purchase.ga4_rev as ga4_rev,
      purchase.quantity as purchase_quantity,
      purchase.OrderID as Orders,
      filters_used.filter_session,
      megamenu_session,
      atc_session,
      session_404,
      rec.recSession,
      purchasePC.purchase_session as rec_purchase_session,
      purchasePC.net as rec_purchase_net,
      purchasePC.gross as rec_purchase_gross,
      purchasePC.ga4_rev as rec_ga4_rev,
      purchasePC.quantity as rec_purchase_quantity,
      purchasePC.OrderID as rec_Orders,
      ----search to purchase-------
      -- searchPurchase.purchase_session as search_purchase_session,
      -- searchPurchase.net as search_purchase_net,
      -- searchPurchase.gross as search_purchase_gross,
      -- searchPurchase.ga4_rev as search_ga4_rev,
      -- searchPurchase.quantity as search_purchase_quantity,
      -- searchPurchase.OrderID as search_Orders,

      from sub1
      inner join landing_P on session_id=landing_session
      inner join exit_p on session_id=exit_session
      left join search on session_id=search_session
      full outer join purchase on session_id=purchase_session
      left join blank_search on session_id = blanksearch_session
      left join filters_used on session_id=filter_session
      left join PDP on session_id=PDP_session
      left join megamenu on session_id=megamenu_session
      left join ATC on session_id=atc_session
      left join page_not_found on session_id=session_404
      left join rec on session_id = rec.recSession
      left join purchasePC on rec.recSession = purchasePC.purchase_session and rec.item_id = purchasePC.productCode and rec.recTime < purchasePC.purchase_time
      -- left join purchasePC as searchPurchase on search.search_session = searchPurchase.purchase_session and search.search_Time < searchPurchase.purchase_time
      group by 1,2,3,4,5,6,7,8,screen_name,10,11,12,13,14,15,16,17,18,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32)

select distinct concat(cast(row_number() over () as string), all_sessions) as PK,  date,
yearType,
platform,
deviceCategory,
channel_group,
cust.customerUID,
guestCheckout,
case when loyalty_club_member is null then false else loyalty_club_member end as loyalty_club_member,
Trade_Type,
Trade_Flag,
all_sessions,
cookie_consent,
pages_in_session,
PDP_Session as get_to_product,
LandingScreenType,
search_session,
search_time,
blank_search,
purchase_session,
purchase_time,
purchase_net,
purchase_gross,
ga4_rev,
purchase_quantity,
Orders,
filter_session,
megamenu_session,
atc_session,
session_404,
recSession,
rec_purchase_session,
rec_purchase_net,
rec_purchase_gross,
rec_ga4_rev,
rec_purchase_quantity,
rec_Orders,
-- search_purchase_session,
-- search_purchase_net,
-- search_purchase_gross,
-- search_ga4_rev,
-- search_purchase_quantity,
-- search_Orders,
from sub2 left join (SELECT distinct cust.customerUID, cust.flags.guestCheckout, cust.loyalty.loyalty_club_member, Trade_Type, Trade_Flag
FROM `toolstation-data-storage.customer.allCustomers` as cust
left join `toolstation-data-storage.customer.dbs_trade_customers` as dbc on cust.customerUID = dbc.customer_number) as cust on sub2.customer = cust.customerUID)
      ;;

    sql_trigger_value: SELECT EXTRACT(dayofweek FROM CURRENT_DATEtime()) between 2 and 6 and extract(hour from current_datetime()) = 13
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 7 and extract(hour from current_datetime()) = 16
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 1 and extract(hour from current_datetime()) = 16;;
  }

  dimension: PK {
    primary_key: yes
    hidden: yes
    type: string
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

  dimension: channel_group {
    type: string
    group_label: "Last 12 Weeks"
    label: "Channel Group"
    sql: ${TABLE}.channel_group;;
  }

  dimension: all_sessions {
    hidden: yes
    type: string
    sql: ${TABLE}.all_sessions;;
  }

  dimension: user_logged_in {
    group_label: "Last 12 Weeks"
    label: "User Logged In"
    type: yesno
    sql: case when ${TABLE}.customerUID is not null then true else false end;;
  }

  dimension: customerUID {
    hidden: yes
    type: string
    sql: ${TABLE}.customerUID;;
  }

  dimension: guest_checkout {
    group_label: "Last 12 Weeks"
    label: "Guest Checkout"
    type: string
    sql: case when ${customerUID} is not null then (case when ${TABLE}.guestCheckout is true then "true" else "false" end) else "No User" end;;
  }


  dimension: loyalty_club_member {
    group_label: "Last 12 Weeks"
    label: "Loyalty Club Member"
    type: string
    sql: case when ${customerUID} is not null then (case when ${TABLE}.guestCheckout is true then "true" else "false" end) else "No User" end;;
  }

  dimension: trade_type{
    group_label: "Last 12 Weeks"
    label: "Trade Type"
    type: string
    sql: ${TABLE}.Trade_Type;;
  }

  dimension: trade_flag{
    group_label: "Last 12 Weeks"
    label: "Trade Flag"
    type: string
    sql: case when ${TABLE}.Trade_Flag is null then "No Trade" else ${TABLE}.Trade_Flag end;;
  }

  dimension: cookie_consent {
    group_label: "Last 12 Weeks"
    label: "Accepted Cookies"
    description: "if session_id is populated then user did not accept cookies"
    type: yesno
    sql: case when ${TABLE}.cookie_consent in ("session id") or  ${date_date} <= date("2025-03-01") then true else false end;;
  }

  dimension: yearType {
    group_label: "Last 12 Weeks"
    type: string
    sql:  ${TABLE}.yearType ;;
  }

  dimension: pagesSessions {
    hidden: yes
    type: number
    sql: ${TABLE}.pages_in_session;;
  }

  dimension: get_to_product {
    hidden: yes
    type: string
    sql: ${TABLE}.get_to_product;;
  }

  dimension: LandingScreenType {
    group_label: "Last 12 Weeks"
    hidden: yes
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

  dimension: megamenu_session {
    hidden: yes
    type: string
    sql: ${TABLE}.megamenu_session;;
  }

  dimension: atc_session {
    hidden: yes
    type: string
    sql: ${TABLE}.atc_session;;
  }

  dimension: session_404 {
    hidden: yes
    type: string
    sql: ${TABLE}.session_404;;
  }

  dimension: purchase_net {
    hidden: yes
    type: number
    sql: ${TABLE}.purchase_net;;
  }

  dimension: purchase_gross {
    hidden: yes
    type: number
    sql: ${TABLE}.purchase_gross;;
  }

  dimension: ga4_rev {
    hidden: yes
    type: number
    sql: ${TABLE}.ga4_rev;;
  }

  dimension: purchase_quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.purchase_quantity;;
  }

  dimension: orders {
    hidden: yes
    type: string
    sql: ${TABLE}.Orders;;
  }


  dimension_group: purchase_time {
    hidden: yes
    type: time
    timeframes: [raw, date]
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
    label: "Total Net Revenue"
    type: sum
    value_format_name: gbp
    sql: case when date_diff(date(${purchase_time_date}), ${date_date}, day) between 0 and 1 then ${purchase_net} else 0 end;;
  }

  measure: total_gross_rev {
    group_label: "Last 12 Weeks"
    label: "Total Gross Revenue"
    type: sum
    value_format_name: gbp
    sql: case when date_diff(date(${purchase_time_date}), ${date_date}, day) between 0 and 1 then ${purchase_gross} else 0 end;;
  }

  measure: total_ga4_rev {
    group_label: "Last 12 Weeks"
    label: "Total ga4 Revenue"
    type: sum
    value_format_name: gbp
    sql: case when date_diff(date(${purchase_time_date}), ${date_date}, day) between 0 and 1 then ${ga4_rev} else 0 end ;;
  }

  measure: get_to_PDP {
    group_label: "Last 12 Weeks"
    label: "Get to PDP"
    type: count_distinct
    sql: ${get_to_product} ;;
    filters: [LandingScreenType: "-product-detail-page"]
  }

  measure: PDP_notLanding {
    hidden: yes
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [LandingScreenType: "-product-detail-page"]
  }

  measure: get_to_PDP_rate {
    group_label: "Last 12 Weeks"
    label: "Get to PDP Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${get_to_PDP},${PDP_notLanding}) ;;
  }

  measure: page_nav {
    group_label: "Last 12 Weeks"
    label: "Navigation Usage"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [search_sessions: "NULL", pagesSessions: ">1"]
  }

  measure: page_nav_purchase {
    group_label: "Last 12 Weeks"
    label: "Navigation Usage Purchase"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [search_sessions: "NULL", pagesSessions: ">1", purchase_session: "-NULL"]
  }

  measure: nav_purchase_rate {
    group_label: "Last 12 Weeks"
    label: "Nav to Purchase Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${page_nav_purchase},${page_nav}) ;;
  }


  measure: filter_sessions {
    group_label: "Last 12 Weeks"
    label: "Filter Usage"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [filter_session: "-NULL"]
  }

  measure: 404_sessions {
    group_label: "Last 12 Weeks"
    label: "Page not found 404"
    type: count_distinct
    sql: ${session_404} ;;
  }

  measure: filter_usage_rate {
    group_label: "Last 12 Weeks"
    label: "Filter Usage Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${filter_sessions},${total_sessions}) ;;
  }

  measure: 404_rate {
    group_label: "Last 12 Weeks"
    label: "404 Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${404_sessions},${total_sessions}) ;;
  }

  measure: sumsearch_sessions {
    group_label: "Last 12 Weeks"
    label: "Search Sessions"
    type: count_distinct
    sql: case when ${search_sessions} is not null or ${blank_search} is not null then ${all_sessions} else null end ;;
    #filters: [search_sessions: "-NULL"]
  }

  measure: Blanksearch_sessions {
    group_label: "Last 12 Weeks"
    label: "Blank Searches"
    type: count_distinct
    sql: ${all_sessions};;
    filters: [blank_search: "-NULL"]
  }

  measure: blank_search_rate {
    group_label: "Last 12 Weeks"
    label: "Blank Search Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${Blanksearch_sessions},${sumsearch_sessions}) ;;
  }


  measure: megamenu_sessions {
    group_label: "Last 12 Weeks"
    label: "Megamenu Usage"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [megamenu_session: "-NULL"]
  }

  measure: megamenu_usage_rate {
    group_label: "Last 12 Weeks"
    label: "Megamenu Usage Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${megamenu_sessions},${total_sessions}) ;;
  }

  measure: atc_sessions {
    type: count_distinct
    hidden: yes
    sql: ${all_sessions} ;;
    filters: [atc_session: "-NULL"]
  }

  measure: atc_conv_rate {
    group_label: "Last 12 Weeks"
    label: "Add to Cart Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${atc_sessions},${total_sessions}) ;;
  }

  measure: Desktop_Web_sessions {
    group_label: "Last 12 Weeks"
    label: "Desktop Web Sessions"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [platform: "Web", deviceCategory: "desktop"]
  }

  measure: mobile_Web_sessions {
    group_label: "Last 12 Weeks"
    label: "Desktop Mobile Sessions"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [platform: "Web", deviceCategory: "mobile"]
  }

  measure: mobile_App_sessions {
    group_label: "Last 12 Weeks"
    label: "App Mobile Sessions"
    type: count_distinct
    sql: ${all_sessions} ;;
    filters: [platform: "App", deviceCategory: "mobile"]
  }

  measure: purchase_sessions {
    hidden: yes
    type: count_distinct
    sql: case when date_diff(date(${purchase_time_date}), ${date_date}, day) between 0 and 1 then ${all_sessions} else null end ;;
    filters: [purchase_session: "-NULL"]
  }

  measure: purchase_conv_rate {
    group_label: "Last 12 Weeks"
    label: "Purchase Conv Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${purchase_sessions},${total_sessions}) ;;
  }

  measure: total_quantity {
    hidden: yes
    type: sum
    sql: case when date_diff(date(${purchase_time_date}), ${date_date}, day) between 0 and 1 then ${purchase_quantity} else 0 end ;;
  }

  measure: total_orders {
    group_label: "Last 12 Weeks"
    label: "Orders"
    type: count_distinct
    sql: case when date_diff(date(${purchase_time_date}), ${date_date}, day) between 0 and 1 then ${orders} else null end ;;
  }

  measure: avg_basket_size {
    type: number
    group_label: "Last 12 Weeks"
    label: "Avg Basket Size"
    value_format_name: decimal_2
    sql: SAFE_DIVIDE(${total_quantity}, ${total_orders}) ;;
  }

  measure: aov_net {
    type: number
    group_label: "Last 12 Weeks"
    label: "AOV (net)"
    value_format_name: gbp
    sql: SAFE_DIVIDE(${total_net_rev}, ${total_orders}) ;;
  }

  ########recommend to purchase ######

  measure: recommend_sessions {
    type: count_distinct
    group_label: "Last 12 Weeks"
    label: "Recommend Session"
    sql: ${TABLE}.recSession ;;
  }

  measure: rec_rate {
    type: number
    group_label: "Last 12 Weeks"
    label: "Recommend Rate"
    sql: safe_divide(${recommend_sessions} ,${total_sessions}) ;;
    value_format_name: percent_2
  }

  measure: recommend_purchase {
    type: count_distinct
    hidden: yes
    sql: ${TABLE}.rec_purchase_session ;;
  }

  dimension: recommend_purchase_sess {
    type: string
    hidden: yes
    sql: ${TABLE}.rec_purchase_session ;;
  }

  measure: rec_purchase_rate {
    type: number
    group_label: "Last 12 Weeks"
    label: "Recommend to purchase Rate"
    sql: safe_divide(${recommend_purchase} ,${recommend_sessions}) ;;
    value_format_name: percent_2
  }

  measure: rec_net_rev {
    type: sum
    group_label: "Last 12 Weeks"
    label: "Recommend to purchase Net Rev"
    sql:  ${TABLE}.rec_purchase_net ;;
    value_format_name: gbp
  }

  measure: rec_purch_quantity {
    type: sum
    group_label: "Last 12 Weeks"
    label: "Recommend to purchase Quantity"
    sql:  ${TABLE}.rec_purchase_quantity ;;
  }

  measure: rec_order {
    type: count_distinct
    group_label: "Last 12 Weeks"
    label: "Recommend to purchase Orders"
    sql: ${TABLE}.rec_orders ;;
  }

  measure: rec_aov {
    type: number
    group_label: "Last 12 Weeks"
    label: "Recommend to purchase AOV"
    value_format_name: gbp
    sql: safe_divide(${rec_net_rev}, ${rec_order}) ;;
  }

  measure: rec_avg_basket_size {
    type: number
    group_label: "Last 12 Weeks"
    label: "Recommend to purchase Avg Basket Size"
    value_format_name: decimal_2
    sql: SAFE_DIVIDE(${rec_purch_quantity}, ${rec_order}) ;;
  }

  #######excluding rec#######

  measure: non_rec_purchase_conv_rate {
    group_label: "Last 12 Weeks"
    label: "Non Rec Purchase Conv Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(count(distinct case when ${recommend_purchase_sess} is null then ${purchase_session} else null end),count(distinct case when ${recommend_purchase_sess} is null then ${all_sessions} else null end)) ;;
  }


  measure: non_rec_avg_basket_size {
    type: number
    group_label: "Last 12 Weeks"
    label: "Non Rec Avg Basket Size"
    value_format_name: decimal_2
    sql: safe_divide(sum(case when ${recommend_purchase_sess} is null then ${purchase_quantity} else null end),count(distinct case when ${recommend_purchase_sess} is null then ${orders} else null end)) ;;
  }

  measure: non_rec_aov_net {
    type: number
    group_label: "Last 12 Weeks"
    label: "non Rec AOV (net)"
    value_format_name: gbp
    sql: safe_divide(sum(case when ${recommend_purchase_sess} is null then ${purchase_net} else null end),count(distinct case when ${recommend_purchase_sess} is null then ${orders} else null end)) ;;
  }




}
