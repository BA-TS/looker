view: ga_digital_transactions {

   derived_table: {
     sql: SELECT distinct
    row_number() over () as P_K,
    platform,
    date(timestamp_sub(MinTime, interval 1 HOUR)) as date,
    country,
    deviceCategory,
    source,
    channel_Group,
    `toolstation-data-storage.Digital_reporting.channel_grouping`(source, medium, Campaign) as channel_groupingv2,
    Medium,
    Campaign,
    lower(event_name) as event_name,
    lower(key_1) as key_1,
    lower(label_1) as label_1,
    lower(key_2) as key_2,
    lower(label_2) as label_2,
    value,
    error,
    PromoID,
    PromoName,
    creative_name,
    User,
    session_id,
    page_location,
    CASE when regexp_contains(page_location, ".*/c[0-9]*[^0-9a-zA-Z]") then "product-listing-page"
    else Screen_name end as Screen_name,
    --Screen_name,
    transactions.OrderID,
    --transactions.item_id,
    transactions.productUID,
    transactions.customer,
    transactions.salesChannel,
    transactions.paymentType,
    transactions.placed,
    timestamp_sub(MinTime, interval 1 HOUR) as MinTime,
    transactions.Quantity,
    transactions.net_value,
    transactions.gross_value,
    transactions.ga4_revenue,
    transactions.ga4_quantity,
    transactions.MarginIncFunding,
    transactions.MarginExclFunding,
    transactions.NetSalePrice,
    transactions.status,
    aw.item_id,
    item_Category,
    item_Category2,
    item_Category3,
    session_duration,
    events,
    page_views,
    cast(bounces as string) as bounces,
    transactions.transaction
    FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
    where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} (date) {% endcondition %}
and ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.item_id is null))
       ;;
    sql_trigger_value: SELECT format_time("%H:%M",(EXTRACT(time FROM CURRENT_DATEtime()))) = "08:45"
    ;;

    partition_keys: ["date"]
   }

  dimension: P_K {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: platform {
    view_label: "GA4"
    label: "Platform"
    group_label: "User Attributes"
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: country {
    view_label: "GA4"
    label: "country"
    group_label: "User Attributes"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: deviceCategory {
    view_label: "GA4"
    label: "Device Category"
    group_label: "User Attributes"
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: channel_Group {
    view_label: "GA4"
    label: "Channel Group"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.channel_Group ;;
  }

  dimension: channel_Groupv2 {
    view_label: "GA4"
    label: "Channel Groupv2"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.channel_groupingv2 ;;
  }

  dimension: Medium {
    view_label: "GA4"
    label: "Medium"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.Medium ;;
  }
  dimension: source {
    view_label: "GA4"
    label: "Source"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.source ;;
  }
  dimension: Campaign {
    view_label: "GA4"
    label: "Campaign"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.Campaign ;;
  }

  dimension: event_namev2 {
    hidden: yes
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: event_name {
    view_label: "GA4"
    label: "Event Name"
    group_label: "Event"
    type: string
    sql: case
    when ${event_namev2} = "videoly" and ${key_1} = "action" and ${label_1} not in ("videoly_progress") then ${label_1}
    when ${event_namev2} = "videoly" and ${label_1} = "videoly_progress" then concat(${label_1},"-",${label_2},"%")
    when ${event_namev2} = "videoly_videostart" then "videoly_start"
    when ${event_namev2} = "videoly_initialize" then "videoly_box_shown"
    when ${event_namev2} = "videoly_videoclosed" then "videoly_closed"
    when ${event_namev2} = "collection_oos" and ${platform} = "Web" then "out_of_stock"
    when ${event_namev2} = "dual_oos" and ${platform} = "Web" then "out_of_stock"
    when ${event_namev2} = "delivery_oos" and ${platform} = "Web" then "out_of_stock"
    when ${event_namev2} = "out_of_stock" and ${platform} = "Web" then null
    else ${event_namev2}
    end;;
  }

  dimension: key_1 {
    view_label: "GA4"
    label: "1.Event Key"
    group_label: "Event"
    type: string
    sql: case when ${TABLE}.key_1 is null and ${label_1} is not null then "action"
    when ${event_namev2} = "collection_oos" and ${platform} = "Web" then "Collection"
    when ${event_namev2} = "dual_oos" and ${platform} = "Web" then "Dual"
    when ${event_namev2} = "delivery_oos" and ${platform} = "Web" then "Delivery"
    when ${event_namev2} = "out_of_stock" and ${platform} = "Web" then null
    else ${TABLE}.key_1 end;;
  }

  dimension: label_1 {
    view_label: "GA4"
    label: "1.Event Label"
    group_label: "Event"
    type: string
    sql: ${TABLE}.label_1 ;;
  }

  dimension: key_2 {
    view_label: "GA4"
    label: "2.Event Key"
    group_label: "Event"
    type: string
    sql: case when ${TABLE}.key_2 is null and ${label_2} is not null then "action" else ${TABLE}.key_2 end ;;
  }

  dimension: label_2 {
    view_label: "GA4"
    label: "2.Event Label"
    group_label: "Event"
    type: string
    sql: ${TABLE}.label_2 ;;
  }

  measure: value {
    view_label: "GA4"
    group_label: "Total Measures"
    label: "Total Event Value"
    value_format_name: gbp
    type: sum
    sql: ${TABLE}.value ;;
  }

  dimension: error {
    view_label: "GA4"
    label: "Error Message"
    group_label: "Event"
    type: string
    sql: ${TABLE}.error ;;
  }

  dimension: promoID {
    view_label: "GA4"
    label: "Promo ID"
    group_label: "Promo Info"
    type: string
    sql: ${TABLE}.PromoID;;
  }

  dimension: promoNAme {
    view_label: "GA4"
    label: "Promo Name"
    group_label: "Promo Info"
    type: string
    sql: ${TABLE}.PromoName;;
  }

  dimension: creative_name {
    view_label: "GA4"
    label: "Creative Name"
    group_label: "Promo Info"
    type: string
    sql: ${TABLE}.creative_name;;
  }

  dimension: user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.User ;;
  }

  dimension: session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: page_location {
    view_label: "GA4"
    label: "Page"
    group_label: "Screen"
    type: string
    sql: ${TABLE}.page_location ;;
  }

  dimension: Screen_name {
    view_label: "GA4"
    label: "Screen name"
    group_label: "Screen"
    type: string
    sql: ${TABLE}.Screen_name ;;
  }

  dimension: order_id {
    view_label: "Transactional"
    label: "Transaction ID"
    description: "Order ID of order where order was seen in GA4"
    type: string
    sql: ${TABLE}.OrderID ;;
  }

  measure: orders {
    view_label: "Transactional"
    label: "Orders"
    description: "Total orders seen in GA4"
    #group_label: "Measures"
    type: count_distinct
    sql: ${order_id} ;;
  }

  dimension: customer {
    view_label: "Transactional"
    label: "Customer ID"
    group_label: "Transaction"
    hidden: yes
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: customerv2 {
    hidden: yes
    type: string
    sql: coalesce(${customer},${user_id}) ;;
  }

  measure: customers {
    view_label: "Transactional"
    label: "Total customers"
    #group_label: "Measures"
    type: count_distinct
    sql: ${customer} ;;
  }

  dimension: salesChannel {
    view_label: "Transactional"
    label: "Sales Channel"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  dimension: paymentType {
    view_label: "Transactional"
    label: "Payment Type"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.paymentType ;;
  }


  dimension: status_order {
    view_label: "Transactional"
    label: "Status"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.status ;;
  }

  filter: select_date_range {
    label: "GA4 Date Range"
    group_label: "Date Filter"
    view_label: "Datetime (of event)"
    type: date
    datatype: date
    convert_tz: yes
  }

  dimension_group: time{
    group_label: "Time"
    view_label: "Datetime (of event)"
    description: "Min datetime of event"
    label: ""
    type: time
    timeframes: [time_of_day]
    sql: ${TABLE}.minTime ;;
  }

  dimension_group: hour{
    group_label: "Time"
    view_label: "Datetime (of event)"
    description: "Min datetime of event"
    label: ""
    type: time
    timeframes: [hour_of_day]
    sql: ${TABLE}.minTime ;;
  }

  dimension_group: minute{
    group_label: "Time"
    view_label: "Datetime (of event)"
    description: "Min datetime of event"
    hidden: yes
    #label: "Minute"
    type: time
    timeframes: [minute]
    sql: ${TABLE}.minTime ;;
  }

  dimension_group: second{
    group_label: "Time"
    view_label: "Datetime (of event)"
    description: "Min datetime of event"
    hidden: yes
    #label: "Second"
    type: time
    timeframes: [second]
    sql: ${TABLE}.minTime ;;
  }

  dimension_group: placed_date{
    view_label: "Digital Transactions"
    group_label: "Order Placed"
    label: ""
    hidden: yes
    type: time
    timeframes: [date]
    sql: ${TABLE}.placed ;;
    html: {{ rendered_value | date: "%d/%m/%Y" }};;
  }

  dimension_group: placed_time{
    view_label: "Order Placed"
    group_label: "Time"
    #group_label: "Order Placed"
    #hidden: yes
    label: ""
    type: time
    timeframes: [time_of_day]
    sql: ${TABLE}.placed ;;
  }

  dimension_group: placed_week{
    view_label: "Digital Transactions"
    group_label: "Order Placed"
    hidden: yes
    label: ""
    type: time
    timeframes: [week_of_year]
    sql: ${TABLE}.placed ;;
  }

  #dimension_group: transaction_date{
    #view_label: "Digital Transactions"
    #group_label: "Order Completed"
    #hidden: yes
    #label: ""
    #type: time
    #timeframes: [date]
    #sql: ${TABLE}.transaction ;;
    #html: {{ rendered_value | date: "%d/%m/%Y" }};;
  #}

  #dimension_group: transaction_time{
    #view_label: "Order Completed"
    #group_label: "Time"
    #group_label: "Order Completed"
    #label: ""
    #type: time
    #timeframes: [time_of_day]
    #sql: ${TABLE}.transaction ;;
  #}

  measure: transactions_quantity {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Product Quantity"
    type: sum
    sql: ${TABLE}.Quantity ;;
  }

  measure: net_value {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Net Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_value ;;
  }

  measure: gross_value {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Gross Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.gross_value ;;
  }

  measure: MarginIncFunding {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Margin inc Funding"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.MarginIncFunding ;;
  }

  measure: MarginExclFunding {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Margin excl Funding"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.MarginExclFunding ;;
  }

  measure: margin_rate_exc_funding {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Margin Rate (excl funding)"
    value_format: "0.00%;(0.00%)"
    sql: COALESCE(safe_divide(${MarginExclFunding},${net_value}),null) ;;
  }

  measure: margin_rate_inc_funding {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Margin Rate (Inc funding)"
    value_format: "0.00%;(0.00%)"
    sql: COALESCE(safe_divide(${MarginIncFunding},${net_value}),null) ;;
  }

  measure: netSalePrice {
    view_label: "Transactional"
    #group_label: "Measures"
    label: "Net Sale Price"
    type: average
    value_format_name: gbp
    sql: ${TABLE}.NetSalePrice ;;
  }

  measure: ga4_revenue {
    view_label: "GA4"
    group_label: "Ecommerce"
    label: "Revenue"
    hidden: yes
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.ga4_revenue ;;
  }

  measure: ga4_quantity {
    view_label: "GA4"
    group_label: "Ecommerce"
    label: "Purchase Product Quantity"
    hidden: yes
    type: sum
    sql: ${TABLE}.ga4_quantity;;
    filters: [event_name: "Purchase, purchase"]
  }

  measure: ga4_quantity_total {
    view_label: "GA4"
    group_label: "Total Measures"
    label: "Total Product Quantity"
    type: sum
    sql: ${TABLE}.ga4_quantity;;
  }

  measure:  time_hours {
    type: average
    view_label: "GA4"
    label: "Avg Session Duration"
    group_label: "Overall sessions"
    value_format: "h:mm:ss"
    sql: ${TABLE}.session_duration / 86400.0;;
  }

  measure: Users {
    view_label: "GA4"
    group_label: "Overall Users"
    label: "Total Users"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: sessions_total {
    #hidden: yes
    view_label: "GA4"
    group_label: "Overall sessions"
    label: "Total Sessions"
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: session_start {
    view_label: "GA4"
    group_label: "Overall sessions"
    label: "Total Sessions Started"
    type: count_distinct
    filters: [event_namev2: "session_start"]
    sql: ${session_id};;
  }


  measure: events {
    view_label: "GA4"
    group_label: "Total Measures"
    label: "Total Events"
    type: sum
    sql: ${TABLE}.events ;;
  }

  measure: page_views {
    view_label: "GA4"
    group_label: "Total Measures"
    label: "Total Page Views"
    type: sum
    sql: ${TABLE}.page_views ;;
  }

  dimension: bounce_def {
    description: "if session is bounce 0 = no, 1 = yes"
    type: string
    hidden: yes
    sql: ${TABLE}.bounces ;;
  }

  measure: sessions {
    view_label: "GA4"
    label: "Engaged Sessions"
    group_label: "Overall sessions"
    description: "Sessions which were detirmined as engaged"
    type: count_distinct
    filters: [bounce_def: "1"]
    sql: ${session_id};;
  }

  measure: bs {
    view_label: "GA4"
    label: "Bounced sessions"
    group_label: "Overall sessions"
    description: "Sessions where user left site after viewing 1 page"
    type: number
    sql: ${sessions_total}-${sessions} ;;
  }

  measure: bounce_rate {
    view_label: "GA4"
    label: "Bounce rate"
    group_label: "Overall sessions"
    type: number
    description: "rate of total sessions where user left site after viewing 1 page"
    value_format_name: percent_2
    #sql: (${bs}/${session_start}) * 100
    sql: safe_divide(${bs},${sessions_total});;
  }

  measure: New_users {
    view_label: "GA4"
    label: "New Users"
    group_label: "Overall Users"
    description: "users who visted the platform for the first time or accepted cookies"
    type: count_distinct
    filters: [event_name: "first_visit,first_open"]
    sql: ${user_id} ;;
  }

  measure: returning_users {
    view_label: "GA4"
    label: "Returning Users"
    group_label: "Overall Users"
    type: number
    description: "users who visted the platform prior"
    sql: ${Users}-${New_users} ;;
  }

  measure: Active_Users {
    view_label: "GA4"
    label: "Active Users"
    group_label: "Overall Users"
    type: count_distinct
    description: "Users who had an active session"
    filters: [bounce_def: "1"]
    sql: ${user_id};;
  }

  dimension: item_id {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    hidden: yes
    label: "Product Code"
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_Category {
    type: string
    view_label: "Products"
    group_label: "Product Selling Category"
    label: "1.Category"
    sql: ${TABLE}.item_Category ;;
  }

  dimension: item_Category2 {
    type: string
    view_label: "Products"
    group_label: "Product Selling Category"
    label: "2.Sub Category"
    sql: ${TABLE}.item_Category2 ;;
  }

  dimension: item_Category3 {
    type: string
    view_label: "Products"
    group_label: "Product Selling Category"
    label: "3.Sub Sub Category"
    sql: ${TABLE}.item_Category3 ;;
  }

  dimension: productUID {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    hidden: yes
    label: "Product UID"
    sql: ${TABLE}.productUID ;;
  }

  ############# Measures by events#################
  ############### PDP #######################

  measure: PDP_sessions {
    view_label: "GA4"
    group_label: "PDP"
    label: "Sessions (PDP)"
    description: "Sessions where product-detail-page was viewed"
    type: count_distinct
    filters: [event_name: "view_item", Screen_name: "product-detail-page",bounce_def: "1"]
    sql: ${session_id} ;;
  }

  measure: PDP_Users {
    view_label: "GA4"
    group_label: "PDP"
    label: "Users (PDP)"
    description: "Users who viewed a product-detail-page"
    type: count_distinct
    filters: [event_name: "view_item", Screen_name: "product-detail-page"]
    sql: ${user_id} ;;
  }

  measure: PDP_events {
    view_label: "GA4"
    group_label: "PDP"
    label: "Events (PDP)"
    description: "Views to a product-detail-page"
    type: sum
    filters: [event_name: "view_item", Screen_name: "product-detail-page"]
    sql: ${TABLE}.events ;;
  }

  ############### View Item List #######################

  measure: viewItemList_sessions {
    view_label: "GA4"
    group_label: "View Item List"
    label: "Sessions (View Item List)"
    description: "Sessions where an item was viewed in a list page"
    type: count_distinct
    filters: [event_name: "view_item_list",bounce_def: "1"]
    sql: ${session_id} ;;
  }

  measure: viewItemList_Users {
    view_label: "GA4"
    group_label: "View Item List"
    label: "Users (View Item List)"
    description: "Users who viewed a item in a list page"
    type: count_distinct
    filters: [event_name: "view_item_list"]
    sql: ${user_id} ;;
  }

  measure: ViewItemList_events {
    view_label: "GA4"
    group_label: "View Item List"
    label: "Events (View Item List)"
    description: "total times a item was viewed in a list page"
    type: sum
    filters: [event_name: "view_item_list"]
    sql: ${TABLE}.events ;;
  }

  ############### View Cart #######################

  measure: viewCart_sessions {
    view_label: "GA4"
    group_label: "View Cart"
    label: "Sessions (View Cart)"
    description: "Sessions where cart was viewed"
    type: count_distinct
    filters: [event_name: "view_cart",bounce_def: "1"]
    sql: ${session_id} ;;
  }

  measure: viewCart_Users {
    view_label: "GA4"
    group_label: "View Cart"
    label: "Users (View Cart)"
    description: "Users who viewed their cart"
    type: count_distinct
    filters: [event_name: "view_cart"]
    sql: ${user_id} ;;
  }

  measure: ViewCart_events {
    view_label: "GA4"
    group_label: "View Cart"
    label: "Events (View Cart)"
    description: "total times the cart was viewed"
    type: sum
    filters: [event_name: "view_cart"]
    sql: ${TABLE}.events ;;
  }

  measure: ViewCart_Quantity {
    view_label: "GA4"
    group_label: "View Cart"
    label: "Product Quantity (View Cart)"
    description: "Product quantity of cart"
    type: sum
    filters: [event_name: "view_cart"]
    sql: ${TABLE}.ga4_quantity ;;
  }
  measure: ViewCart_Value {
    view_label: "GA4"
    group_label: "View Cart"
    label: "Value (View Cart)"
    description: "Monetary value of cart"
    type: sum
    value_format_name: gbp
    filters: [event_name: "view_cart"]
    sql: ${TABLE}.value ;;
  }

############### Out of Stock #######################

  measure: OOS_sessions {
    view_label: "GA4"
    group_label: "Out of Stock"
    label: "Sessions (OOS)"
    description: "Sessions where an item was shown to be oos"
    type: count_distinct
    filters: [event_name: "out_of_stock",bounce_def: "1"]
    sql: ${session_id} ;;
  }

  measure: OOS_Users {
    view_label: "GA4"
    group_label: "Out of Stock"
    label: "Users (OOS)"
    description: "Users who viewed a item oos"
    type: count_distinct
    filters: [event_name: "out_of_stock"]
    sql: ${user_id} ;;
  }

  measure: OOS_events {
    view_label: "GA4"
    group_label: "Out of Stock"
    label: "Events (OOS)"
    description: "total times a item was shown to be OOS"
    type: sum
    filters: [event_name: "out_of_stock"]
    sql: ${TABLE}.events ;;
  }

    ############### add to Cart #######################

  measure: add_to_cart_sessions {
    view_label: "GA4"
    group_label: "Add to Cart"
    label: "Sessions (ATC)"
    description: "Sessions where an item was added to cart"
    type: count_distinct
    filters: [event_name: "add_to_cart",bounce_def: "1"]
    sql: ${session_id} ;;
  }

  measure: add_to_cart_Users {
    view_label: "GA4"
    group_label: "Add to Cart"
    label: "Users (ATC)"
    description: "Users who added an item to cart"
    type: count_distinct
    filters: [event_name: "add_to_cart"]
    sql: ${user_id} ;;
  }

  measure: add_to_cart_events {
    view_label: "GA4"
    group_label: "Add to Cart"
    label: "Events (ATC)"
    description: "total times an item was added to cart"
    type: sum
    filters: [event_name: "add_to_cart"]
    sql: ${TABLE}.events ;;
  }

  measure: add_to_cart_Quantity {
    view_label: "GA4"
    group_label: "Add to Cart"
    label: "Product Quantity (ATC)"
    description: "Product quantity of items added cart"
    type: sum
    filters: [event_name: "add_to_cart"]
    sql: ${TABLE}.ga4_quantity ;;
  }
  measure: add_to_cart_Value {
    view_label: "GA4"
    group_label: "Add to Cart"
    label: "Value (ATC)"
    description: "Monetary value of items added cart"
    type: sum
    value_format_name: gbp
    filters: [event_name: "add_to_cart"]
    sql: ${TABLE}.value ;;
  }

  measure: atc_conversion_rate {
    view_label: "GA4"
    label: "ATC Conversion rate"
    group_label: "Add to Cart"
    type: number
    value_format_name: percent_2
    description: "rate of total sessions where add to cart event happened"
    #sql: ${Count_transaction_id}/${session_start} * 100
    sql: safe_divide(${add_to_cart_sessions},${sessions_total});;
  }

  #############Purchase###############

  measure: session_purchase {
    view_label: "GA4"
    label: "Sessions (Purchase)"
    group_label: "Purchase"
    description: "Sessions where a purchase event happened"
    #hidden: yes
    type: count_distinct
    filters: [event_name: "Purchase, purchase"]
    sql: ${session_id};;
  }

  measure: conversion_rate {
    view_label: "GA4"
    label: "Purchase Conversion rate"
    group_label: "Purchase"
    type: number
    value_format_name: percent_2
    description: "rate of total sessions where a pucrhase event happened"
    #sql: ${Count_transaction_id}/${session_start} * 100
    sql: safe_divide(${session_purchase},${sessions_total});;
  }

  measure: purchase_Users {
    view_label: "GA4"
    group_label: "Purchase"
    label: "Users (Purchase)"
    description: "Users who Purchased"
    type: count_distinct
    filters: [event_name: "purchase"]
    sql: ${user_id} ;;
  }

  measure: purchase_events {
    view_label: "GA4"
    group_label: "Purchase"
    label: "Events (Purchase)"
    description: "total times an item was added to cart"
    type: sum
    filters: [event_name: "purchase"]
    sql: ${TABLE}.events ;;
  }

  measure: aov {
    view_label: "Transactional"
    label: "AOV"
    type: number
    description: "average order value"
    value_format_name: gbp
    sql: safe_divide(${net_value},${orders}) ;;
  }

}
