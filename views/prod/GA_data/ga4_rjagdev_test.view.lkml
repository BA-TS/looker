view: ga4_rjagdev_test {
  # # You can specify the table name if it's different from the view name:
   sql_table_name: `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` ;;
  #
  # # Define your dimensions and measures here, like this:

  dimension: PK {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${TABLE}.P_K,coalesce(${ga4_transactions.P_K},"NONE"),coalesce(${itemid},"NONE"), coalesce(${Mintime},"NONE"));;
  }

   dimension_group: date {
     description: "Date of event"
    hidden: yes
     type: time
    timeframes: [date,raw]
     sql: case when date(${TABLE}.minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(${TABLE}.minTime, interval 1 HOUR)) else (timestamp_add(${TABLE}.minTime, interval 1 HOUR)) end ;;
   }


  dimension: Mintime{
    hidden: yes
    type: string
    sql: cast(${TABLE}.minTime as string) ;;
  }

  dimension_group: time{
    group_label: "Time"
    view_label: "Datetime (of event)"
    description: "Min datetime of event"
    label: ""
    type: time
    timeframes: [time_of_day]
    sql: case when date(${TABLE}.minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(${TABLE}.minTime, interval 1 HOUR)) else (timestamp_add(${TABLE}.minTime, interval 1 HOUR)) end ;;
  }

  dimension_group: hour{
    group_label: "Time"
    view_label: "Datetime (of event)"
    description: "Min datetime of event"
    label: ""
    type: time
    timeframes: [hour_of_day]
    sql: case when date(${TABLE}.minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(${TABLE}.minTime, interval 1 HOUR)) else (timestamp_add(${TABLE}.minTime, interval 1 HOUR)) end ;;
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

  dimension: channel_Group {
    view_label: "GA4"
    label: "Channel Group"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.channel_Group ;;
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

  dimension: event_name {
    description: "event name"
    view_label: "GA4"
    label: "Event Name"
    group_label: "Event"
    type: string
    sql: case
    when ${TABLE}.event_name = "videoly" and ${TABLE}.key_1 = "action" and ${label_1} not in ("videoly_progress") then ${label_1}
    when ${TABLE}.event_name = "videoly" and ${label_1} = "videoly_progress" then concat(${label_1},"-",${label_2},"%")
    when ${TABLE}.event_name = "videoly_videostart" then "videoly_start"
    when ${TABLE}.event_name = "videoly_initialize" then "videoly_box_shown"
    when ${TABLE}.event_name = "videoly_videoclosed" then "videoly_closed"
    when ${TABLE}.event_name = "collection_OOS" and ${platform} = "Web" then "out_of_stock"
    when ${TABLE}.event_name = "dual_OOS" and ${platform} = "Web" then "out_of_stock"
    when ${TABLE}.event_name = "Delivery_OOS" and ${platform} = "Web" then "out_of_stock"
    when ${TABLE}.event_name = "out_of_stock" and ${platform} = "Web" then null
    else ${TABLE}.event_name
    end;;
  }

  dimension: key_1 {
    view_label: "GA4"
    label: "1.Event Key"
    group_label: "Event"
    type: string
    sql: case
          when ${TABLE}.event_name = "collection_OOS" and ${platform} = "Web" then "Collection"
          when ${TABLE}.event_name = "dual_OOS" and ${platform} = "Web" then "Dual"
          when ${TABLE}.event_name = "Delivery_OOS" and ${platform} = "Web" then "Delivery"
          when ${TABLE}.event_name = "out_of_stock" and ${platform} = "Web" then null
          when ${TABLE}.key_1 is null and ${label_1} is not null then "action"
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

  dimension: itemid {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    hidden: yes
    label: "Product Code"
    sql: case when ${TABLE}.item_id in ('44842') then 'null' else ${TABLE}.item_id end;;
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

  dimension: User {
    hidden: yes
    description: "User"
    type: string
    sql: ${TABLE}.User ;;
  }

  dimension: session_id {
    description: "session_id"
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

  measure: session_duration {
    type: average
    view_label: "GA4"
    label: "Avg Session Duration"
    group_label: "Sessions"
    value_format: "h:mm:ss"
    sql: ${TABLE}.session_duration / 86400.0;;
  }

 # measure: time_hours {
    #type: average
    #group_label: "Overall sessions"
    #value_format: "h:mm:ss"
    #sql: ${session_duration}/86400.0;;
  #}

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

  dimension: transactions {
    description: "Is used for unnesting the transactions struct, should not be used as a standalone dimension"
    hidden: yes
    sql: ${TABLE}.transactions ;;
  }
##########Measures##########################
############Users#########################
  measure: Users {
    label: "Total Users"
    group_label: "Users"
    type: count_distinct
    sql: ${User} ;;
  }

  measure: New_users {
    label: "New Users"
    group_label: "Users"
    description: "users who visted the platform for the first time or accepted cookies"
    type: count_distinct
    filters: [event_name: "first_visit,first_open"]
    sql: ${User} ;;
  }

  measure: returning_users {
    label: "Returning Users"
    group_label: "Users"
    type: number
    description: "users who visted the platform prior"
    sql: ${Users}-${New_users} ;;
  }

  measure: Active_Users {
    label: "Active Users"
    group_label: "Users"
    type: count_distinct
    description: "Users who had an active session"
    filters: [bounce_def: "1"]
    sql: ${User};;
  }

  #################Sessions########################

  measure: sessions_total {
    #hidden: yes
    view_label: "GA4"
    group_label: "Sessions"
    label: "Total Sessions"
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: session_start {
    view_label: "GA4"
    group_label: "Sessions"
    label: "Total Sessions Started"
    type: count_distinct
    filters: [event_name: "session_start"]
    sql: ${session_id};;
  }

  measure: sessions {
    view_label: "GA4"
    label: "Engaged Sessions"
    group_label: "Sessions"
    description: "Sessions which were detirmined as engaged"
    type: count_distinct
    filters: [bounce_def: "1"]
    sql: ${session_id};;
  }

  measure: bs {
    view_label: "GA4"
    label: "Bounced sessions"
    group_label: "Sessions"
    description: "Sessions where user left site after viewing 1 page"
    type: number
    sql: ${sessions_total}-${sessions} ;;
  }

  measure: bounce_rate {
    view_label: "GA4"
    label: "Bounce rate"
    group_label: "Sessions"
    type: number
    description: "rate of total sessions where user left site after viewing 1 page"
    value_format_name: percent_2
    #sql: (${bs}/${session_start}) * 100
    sql: safe_divide(${bs},${sessions_total});;
  }

  ############# Measures by events#################
  ############### PDP #######################

  measure: PDP_sessions {
    view_label: "GA4"
    group_label: "PDP"
    label: "Sessions (PDP)"
    description: "Sessions where product-detail-page was viewed"
    type: count_distinct
    filters: [event_name: "view_item", Screen_name: "product-detail-page"]
    sql: ${session_id} ;;
  }

  measure: PDP_Users {
    view_label: "GA4"
    group_label: "PDP"
    label: "Users (PDP)"
    description: "Users who viewed a product-detail-page"
    type: count_distinct
    filters: [event_name: "view_item", Screen_name: "product-detail-page"]
    sql: ${User} ;;
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
    filters: [event_name: "view_item_list"]
    sql: ${session_id} ;;
  }

  measure: viewItemList_Users {
    view_label: "GA4"
    group_label: "View Item List"
    label: "Users (View Item List)"
    description: "Users who viewed a item in a list page"
    type: count_distinct
    filters: [event_name: "view_item_list"]
    sql: ${User} ;;
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
    sql: ${User} ;;
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
    sql: ${ga4_transactions.ga4_quantity} ;;
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
    filters: [event_name: "out_of_stock"]
    sql: ${session_id} ;;
  }

  measure: OOS_Users {
    view_label: "GA4"
    group_label: "Out of Stock"
    label: "Users (OOS)"
    description: "Users who viewed a item oos"
    type: count_distinct
    filters: [event_name: "out_of_stock"]
    sql: ${User} ;;
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
    filters: [event_name: "add_to_cart"]
    sql: ${session_id} ;;
  }

  measure: add_to_cart_Users {
    view_label: "GA4"
    group_label: "Add to Cart"
    label: "Users (ATC)"
    description: "Users who added an item to cart"
    type: count_distinct
    filters: [event_name: "add_to_cart"]
    sql: ${User} ;;
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
    sql: ${ga4_transactions.ga4_quantity} ;;
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
    filters: [event_name: "Purchase, purchase", Screen_name: "-Already Registered?"]
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
    filters: [event_name: "purchase", Screen_name: "-Already Registered?"]
    sql: ${User} ;;
  }

  measure: purchase_events {
    view_label: "GA4"
    group_label: "Purchase"
    label: "Events (Purchase)"
    description: "total times an item was added to cart"
    type: sum
    filters: [event_name: "purchase", Screen_name: "-Already Registered?"]
    sql: ${TABLE}.events ;;
  }

  ##############################Landing Page################

  #dimension: landingPage {
    #view_label: "GA4"
    #label: "Landing Screen name"
    #group_label: "Screen"
    #type: string
    #sql: min_by(${Screen_name}, ${Mintime}) ;;
  #}


}
