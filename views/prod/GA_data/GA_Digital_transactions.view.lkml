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
    transactions.transaction,
    products.item_id,
    products.productUID,
    products.Price,
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
    bounces
    FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` left join unnest(transactions) as transactions left join unnest (products) as products
    where (transactions.item_id = products.item_id or transactions.item_id is null or products.item_id is null)
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
    label: "Platform"
    group_label: "User Attributes"
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: country {
    label: "country"
    group_label: "User Attributes"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: deviceCategory {
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
    label: "Channel Group"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.channel_Group ;;
  }

  dimension: Medium {
    label: "Medium"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: Campaign {
    label: "Campaign"
    group_label: "Traffic Source"
    type: string
    sql: ${TABLE}.Campaign ;;
  }

  dimension: event_name {
    label: "Event Name"
    group_label: "Event"
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: key_1 {
    label: "1.Event Key"
    group_label: "Event"
    type: string
    sql: case when ${TABLE}.key_1 is null and ${label_1} is not null then "action" else ${TABLE}.key_1 end;;
  }

  dimension: label_1 {
    label: "1.Event Label"
    group_label: "Event"
    type: string
    sql: ${TABLE}.label_1 ;;
  }

  dimension: key_2 {
    label: "2.Event Key"
    group_label: "Event"
    type: string
    sql: case when ${TABLE}.key_2 is null and ${label_2} is not null then "action" else ${TABLE}.key_2 end ;;
  }

  dimension: label_2 {
    label: "2.Event Label"
    group_label: "Event"
    type: string
    sql: ${TABLE}.label_2 ;;
  }

  dimension: value {
    label: "Event Value"
    group_label: "Event"
    value_format_name: gbp
    sql: ${TABLE}.value ;;
  }

  dimension: error {
    label: "Error Message"
    group_label: "Event"
    type: string
    sql: ${TABLE}.error ;;
  }

  dimension: promoID {
    label: "Promo ID"
    group_label: "Promo Info"
    type: string
    sql: ${TABLE}.PromoID;;
  }

  dimension: promoNAme {
    label: "Promo Name"
    group_label: "Promo Info"
    type: string
    sql: ${TABLE}.PromoName;;
  }

  dimension: creative_name {
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
    label: "Page"
    group_label: "Screen"
    type: string
    sql: ${TABLE}.page_location ;;
  }

  dimension: Screen_name {
    label: "Screen name"
    group_label: "Screen"
    type: string
    sql: ${TABLE}.Screen_name ;;
  }

  dimension: order_id {
    label: "Transaction ID"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.OrderID ;;
  }

  dimension: customer {
    label: "Customer ID"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: salesChannel {
    label: "Sales Channel"
    group_label: "Transaction"
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  filter: select_date_range {
    label: "GA4 Date Range"
    group_label: "Date Filter"
    view_label: "Date"
    type: date
    datatype: date
    convert_tz: yes
  }

  dimension_group: time{
    group_label: "Time"
    view_label: "Date"
    type: time
    timeframes: [time_of_day,hour_of_day,minute, second]
    sql: ${TABLE}.minTime ;;
  }

  dimension_group: placed_time{
    view_label: "Date"
    group_label: "Time"
    label: "Placed Date"
    type: time
    timeframes: [time_of_day,date]
    sql: ${TABLE}.placed ;;
  }

  dimension_group: transaction_time{
    view_label: "Date"
    group_label: "Time"
    label: "Transaction Date"
    type: time
    timeframes: [time_of_day,date]
    sql: ${TABLE}.transaction ;;
  }

  measure: transactions_quantity {
    view_label: "Digital Transactions"
    label: "Quantity"
    type: sum
    sql: ${TABLE}.Quantity ;;
  }

  measure: net_value {
    view_label: "Digital Transactions"
    label: "Net Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_value ;;
  }

  measure: gross_value {
    view_label: "Digital Transactions"
    label: "Gross Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.gross_value ;;
  }

  measure: MarginIncFunding {
    view_label: "Digital Transactions"
    label: "Margin inc Funding"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.MarginIncFunding ;;
  }

  measure: MarginExclFunding {
    view_label: "Digital Transactions"
    label: "Margin excl Funding"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.MarginExclFunding ;;
  }

  measure: netSalePrice {
    view_label: "Digital Transactions"
    label: "Net Sale Price"
    type: average
    value_format_name: gbp
    sql: ${TABLE}.NetSalePrice ;;
  }

  measure: ga4_revenue {
    group_label: "Transactions"
    label: "Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.ga4_revenue ;;
  }

  measure: ga4_quantity {
    group_label: "Transactions"
    label: "Quantity"
    type: sum
    sql: ${TABLE}.ga4_quantity ;;
  }

  measure:  time_hours {
    type: average
    hidden: yes
    label: "Avg Session Duration"
    group_label: "Measures"
    value_format: "h:mm:ss"
    sql: ${TABLE}.session_duration / 86400.0;;
  }

  measure: Users {
    label: "Users"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: sessions {
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
    label: "Purchase sessions"
    group_label: "Ecommerce"
    description: "Sessions where a purchase event happened"
    #hidden: yes
    type: count_distinct
    filters: [event_name: "Purchase, purchase"]
    sql: ${session_id};;
  }

  measure: conversion_rate {
    label: "Purchase Conversion rate"
    group_label: "Ecommerce"
    type: number
    value_format_name: percent_2
    description: "rate of total sessions where a pucrhase event happened"
    #sql: ${Count_transaction_id}/${session_start} * 100
    sql: safe_divide(${session_purchase},${session_start});;
  }

  measure: events {
    label: "Events"
    type: sum
    sql: ${TABLE}.events ;;
  }

  measure: page_views {
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
    label: "Bounced sessions"
    group_label: "Measures"
    description: "Sessions where user left site after viewing 1 page"
    sql: ${sessions}-${bounces} ;;
  }

  measure: bounce_rate {
    label: "Bounce rate"
    group_label: "Measures"
    type: number
    description: "rate of total sessions where user left site after viewing 1 page"
    value_format_name: percent_2
    #sql: (${bs}/${session_start}) * 100
    sql: safe_divide(${bs},${sessions});;
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