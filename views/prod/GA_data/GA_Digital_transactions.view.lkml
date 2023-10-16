view: ga_digital_transactions {

   derived_table: {
     sql: SELECT distinct
    row_number() over () as P_K,
    platform,
    date,
    country,
    deviceCategory,
    channel_Group,
    Medium,
    Campaign,
    event_name,
    key_1,
    label_1,
    key_2,
    label_2,
    value,
    error,
    PromoID,
    PromoName,
    creative_name,
    User,
    session_id,
    page_location,
    Screen_name,
    transactions.OrderID,
    transactions.customer,
    transactions.salesChannel,
    transactions.placed,
    MinTime,
    transactions.Quantity,
    transactions.net_value,
    transactions.gross_value,
    transactions.ga4_revenue,
    transactions.ga4_quantity,
    transactions.MarginIncFunding,
    transactions.MarginExclFunding,
    transactions.NetSalePrice,
    transactions.status,
    products.item_id,
    products.productUID,
    products.Price,
    products.RegularPrice,
    products.buyerName,
    products.buyingmanager,
    products.productBuyingStatus,
    products.endOfLife,
    products.productChannel,
    products.isactive,
    products.productBrand,
    products.productDepartment,
    products.productDescription,
    products.productName,
    products.productNameType,
    products.productStatus,
    products.productType,
    products.productSubdepartment,
    products.warrantyYears,
    products.manufacturerID,
    products.supplierPartNumber,
    products.Promo.promoPrice,
    products.Promo.type,
    session_duration,
    events,
    page_views,
    cast(bounces as string) as bounces,
    transactions.transaction
    FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` left join unnest(transactions) as transactions left join unnest (products) as products
    where (transactions.item_id = products.item_id or transactions.item_id is null or products.item_id is null)
    and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} (date) {% endcondition %}
       ;;
    datagroup_trigger: ts_googleanalytics_datagroup
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

  dimension: Medium {
    view_label: "GA4"
    label: "Medium"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: Campaign {
    view_label: "GA4"
    label: "Campaign"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.Campaign ;;
  }

  dimension: event_name {
    view_label: "GA4"
    label: "Event Name"
    group_label: "Event"
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: key_1 {
    view_label: "GA4"
    label: "1.Event Key"
    group_label: "Event"
    type: string
    sql: case when ${TABLE}.key_1 is null and ${label_1} is not null then "action" else ${TABLE}.key_1 end;;
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
    label: "Event Value"
    group_label: "Measures"
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
    view_label: "Digital Transactions"
    label: "Transaction ID"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.OrderID ;;
  }

  measure: orders {
    view_label: "Digital Transactions"
    label: "Orders"
    group_label: "Measures"
    type: count_distinct
    sql: ${order_id} ;;
  }

  dimension: customer {
    view_label: "Digital Transactions"
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
    view_label: "Digital Transactions"
    label: "customer"
    group_label: "Measures"
    type: count_distinct
    sql: ${customer} ;;
  }

  dimension: salesChannel {
    view_label: "Digital Transactions"
    label: "Sales Channel"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  dimension: status_order {
    view_label: "Digital Transactions"
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

  dimension_group: transaction_date{
    view_label: "Digital Transactions"
    group_label: "Order Completed"
    hidden: yes
    label: ""
    type: time
    timeframes: [date]
    sql: ${TABLE}.transaction ;;
    html: {{ rendered_value | date: "%d/%m/%Y" }};;
  }

  dimension_group: transaction_time{
    view_label: "Order Completed"
    group_label: "Time"
    #group_label: "Order Completed"
    label: ""
    type: time
    timeframes: [time_of_day]
    sql: ${TABLE}.transaction ;;
  }

  measure: transactions_quantity {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Product Quantity"
    type: sum
    sql: ${TABLE}.Quantity ;;
  }

  measure: net_value {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Net Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_value ;;
  }

  measure: gross_value {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Gross Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.gross_value ;;
  }

  measure: MarginIncFunding {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Margin inc Funding"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.MarginIncFunding ;;
  }

  measure: MarginExclFunding {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Margin excl Funding"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.MarginExclFunding ;;
  }

  measure: margin_rate_exc_funding {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Margin Rate (excl funding)"
    value_format: "0.00%;(0.00%)"
    sql: COALESCE(safe_divide(${MarginExclFunding},${net_value}),null) ;;
  }

  measure: margin_rate_inc_funding {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Margin Rate (Inc funding)"
    value_format: "0.00%;(0.00%)"
    sql: COALESCE(safe_divide(${MarginIncFunding},${net_value}),null) ;;
  }

  measure: netSalePrice {
    view_label: "Digital Transactions"
    group_label: "Measures"
    label: "Net Sale Price"
    type: average
    value_format_name: gbp
    sql: ${TABLE}.NetSalePrice ;;
  }

  measure: ga4_revenue {
    view_label: "GA4"
    group_label: "Ecommerce"
    label: "Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.ga4_revenue ;;
  }

  measure: ga4_quantity {
    view_label: "GA4"
    group_label: "Ecommerce"
    label: "Purchase Product Quantity"
    type: sum
    sql: ${TABLE}.ga4_quantity;;
    filters: [event_name: "Purchase, purchase"]
  }

  measure: ga4_quantity_total {
    view_label: "GA4"
    group_label: "Measures"
    label: "Product Quantity"
    type: sum
    sql: ${TABLE}.ga4_quantity;;
  }

  measure:  time_hours {
    type: average
    hidden: yes
    view_label: "GA4"
    label: "Avg Session Duration"
    group_label: "Measures"
    value_format: "h:mm:ss"
    sql: ${TABLE}.session_duration / 86400.0;;
  }

  measure: Users {
    view_label: "GA4"
    group_label: "Measures"
    label: "Users"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: sessions {
    view_label: "GA4"
    group_label: "Measures"
    label: "Sessions"
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: session_start {
    hidden: yes
    type: count_distinct
    filters: [event_name: "session_start"]
    sql: ${session_id};;
  }

  measure: session_purchase {
    view_label: "GA4"
    label: "Purchase sessions"
    group_label: "Ecommerce"
    description: "Sessions where a purchase event happened"
    #hidden: yes
    type: count_distinct
    filters: [event_name: "Purchase, purchase"]
    sql: ${session_id};;
  }

  measure: conversion_rate {
    view_label: "GA4"
    label: "Purchase Conversion rate"
    group_label: "Ecommerce"
    type: number
    value_format_name: percent_2
    description: "rate of total sessions where a pucrhase event happened"
    #sql: ${Count_transaction_id}/${session_start} * 100
    sql: safe_divide(${session_purchase},${session_start});;
  }

  measure: events {
    view_label: "GA4"
    group_label: "Measures"
    label: "Events"
    type: sum
    sql: ${TABLE}.events ;;
  }

  measure: page_views {
    view_label: "GA4"
    group_label: "Measures"
    label: "Page Views"
    type: sum
    sql: ${TABLE}.page_views ;;
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
    filters: [bounce_def: "1"]
    sql: ${session_id};;
  }

  measure: bs {
    view_label: "GA4"
    label: "Bounced sessions"
    group_label: "Measures"
    description: "Sessions where user left site after viewing 1 page"
    sql: ${sessions}-${bounces} ;;
  }

  measure: bounce_rate {
    view_label: "GA4"
    label: "Bounce rate"
    group_label: "Measures"
    type: number
    description: "rate of total sessions where user left site after viewing 1 page"
    value_format_name: percent_2
    #sql: (${bs}/${session_start}) * 100
    sql: safe_divide(${bs},${sessions});;
  }

  measure: New_users {
    view_label: "GA4"
    label: "New Users"
    group_label: "Measures"
    description: "users who visted the platform for the first time or accepted cookies"
    type: count_distinct
    filters: [event_name: "first_visit,first_open"]
    sql: ${user_id} ;;
  }

  measure: returning_users {
    view_label: "GA4"
    label: "Returning Users"
    group_label: "Measures"
    type: number
    description: "users who visted the platform prior"
    sql: ${Users}-${New_users} ;;
  }

  measure: Active_Users {
    view_label: "GA4"
    label: "Active Users"
    group_label: "Measures"
    type: count_distinct
    description: "Users who had an active session"
    filters: [bounce_def: "1"]
    sql: ${user_id};;
  }

  dimension: item_id {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Product Code"
    sql: ${TABLE}.item_id ;;
  }

  dimension: productUID {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Product UID"
    sql: ${TABLE}.productUID ;;
  }

  dimension: productName {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Product Name"
    sql: ${TABLE}.productName ;;
  }

  dimension: productNameType {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Product Name Type"
    sql: ${TABLE}.productNameType ;;
  }

  dimension: productBrand {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Product Brand"
    sql: ${TABLE}.productBrand ;;
  }

  dimension: productDepartment {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Product Department"
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: productSubDepartment {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Product SubDepartment"
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: warrantyYears {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    label: "Warranty Years"
    sql: ${TABLE}.warrantyYears ;;
  }

  dimension: buyerName {
    type: string
    view_label: "Products"
    group_label: "Commercial Details"
    label: "Buyer Name"
    sql: ${TABLE}.buyerName ;;
  }

  dimension: buyingmanager {
    type: string
    view_label: "Products"
    group_label: "Commercial Details"
    label: "Buying Manager"
    sql: ${TABLE}.buyingmanager ;;
  }

  dimension: productBuyingStatus {
    type: string
    view_label: "Products"
    group_label: "Commercial Details"
    label: "Buying Status"
    sql: ${TABLE}.productBuyingStatus ;;
  }

  dimension: endOfLife {
    type: string
    view_label: "Products"
    group_label: "Commercial Details"
    label: "End of Life"
    sql: ${TABLE}.endOfLife ;;
  }

  dimension: productChannel {
    type: string
    view_label: "Products"
    group_label: "Commercial Details"
    label: "Product Channel"
    sql: ${TABLE}.productChannel ;;
  }

  dimension: isActive {
    view_label: "Products"
    label: "isActive"
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isActive = 1 ;;
  }

  dimension: price {
    value_format_name: gbp
    view_label: "Products"
    group_label: "Pricing"
    label: "Current Price"
    sql: ${TABLE}.price ;;
  }

  dimension: regular_price {
    value_format_name: gbp
    view_label: "Products"
    group_label: "Pricing"
    label: "Regular Price"
    sql: ${TABLE}.RegularPrice ;;
  }

  dimension: promo_price {
    value_format_name: gbp
    view_label: "Products"
    group_label: "Pricing"
    label: "Promo Price"
    sql: ${TABLE}.PromoPrice ;;
  }

  dimension: promo_type {
    type: string
    view_label: "Products"
    group_label: "Pricing"
    label: "Promo Type"
    sql: ${TABLE}.type ;;
  }

  dimension: manufacturer {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.manufacturer ;;
    hidden: yes
  }

  dimension: supplier_part_number {
    view_label: "Products"
    group_label: "Supply Chain"
    label: "Supplier Part Number"
    type: string
    sql: ${TABLE}.supplierPartNumber ;;
  }
}

#products.,
