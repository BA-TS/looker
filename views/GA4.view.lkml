view: ga4 {

    derived_table: {
      sql: with sub0 as (SELECT distinct
        "Web" as UserUID,
        date(PARSE_DATE('%Y%m%d', event_date)) as date,
        geo.country as country,
        device.category as DeviceCategory,
        `toolstation-data-storage.analytics_251803804.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
        case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
        case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
        event_name,
        (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'event_label')  event_label,
        (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'action') as action,
        (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'content_type') as event_attribute,
        ecommerce.transaction_id,
        user_id,
        CASE when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/p([0-9]*)$") then "product-detail-page"
        when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'), ".*/p[0-9]*[^0-9a-zA-Z]") then "product-detail-page"
        when regexp_contains((SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_location'),".*/c([0-9]*)$") then "product-listing-page"
        else  (SELECT distinct value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') end as Screen_name,
        case when items.item_id is null then
        (SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'event_label') else items.item_id end as item_id,
        items.price,
        sum(items.item_revenue) as item_revenue,
        sum(items.quantity) as item_quantity,
        concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions,
        COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
        case when (select value.string_value from unnest(event_params) where key = 'session_engaged') = '1' then "1" else "0" end as bounces
        FROM `toolstation-data-storage.analytics_251803804.events_*` left join unnest (items) as items
        WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
        and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
        AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
        GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,19,21
        UNION DISTINCT
        SELECT distinct
        'App' as UserUID,
        PARSE_DATE('%Y%m%d', event_date) as date,
        geo.country as country,
        device.category,
        `toolstation-data-storage.analytics_265133009.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
        case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
        case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
        event_name,
        (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params)WHERE key in ('search_term', 'query', 'category_id', 'product_code')) as event_label,
        (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'action') as action,
        (SELECT distinct key FROM UNNEST(event_params) WHERE key in ('search_term', 'query', 'category_id', 'product_code')) as event_attribute,
        ecommerce.transaction_id,
        user_id,
        (SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') as screen,
        items.item_id as item_id,
        items.price as Item_Price,
        round(sum(items.item_revenue),2) as item_revenue,
        sum(items.quantity) as itemQ,
        concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS sessions,
        COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
        case when (select distinct cast(value.int_value as string) from unnest(event_params) where key = 'engaged_session_event') = '1' then "1" else "0" end as bounces
        FROM `toolstation-data-storage.analytics_265133009.events_*` left join unnest(items) as items
        WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
        and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
        AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
        GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,19,21)
        select distinct row_number() over () as P_K, * from sub0;;
      datagroup_trigger: ts_googleanalytics_datagroup
    }
    #Event names for Web
    #and event_name in ("view_item", "out_of_stock", "purchase", "add_to_cart", "videoly", "session_start", "search_actions")
    #Event names for App
    # and event_name in ("search","search_suggestion_tapped","search_category_viewed", "search_recent_tapped", "search_product_tapped", "search_category_tapped",'purchase', 'add_to_cart', 'out_of_stock', "screen_view", "videoly")

    dimension: P_K {
      description: "Primary key"
      type: number
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.P_K ;;
    }

    dimension: app_web_sessions {
      label: "Web/App"
      description: "Web or App sessions"
      type: string
      sql: ${TABLE}.UserUID ;;
    }

    dimension_group: date {
      description: "Date of sessions"
      type: time
      hidden: yes
      timeframes: [raw,date]
      sql: ${TABLE}.date ;;
    }

    dimension: Medium {
      label: "Medium"
      group_label: "Traffic Source"
      description: "Medium"
      type: string
      sql: ${TABLE}.Medium ;;
    }

  dimension: Country {
    label: "Country"
    group_label: "User Attributes"
    description: "country"
    type: string
    sql: ${TABLE}.country ;;
  }

    dimension: Campaign_name {
      label: "Campaign Name"
      group_label: "Traffic Source"
      description: "Campaign_name"
      type: string
      sql: ${TABLE}.Campaign_name ;;
    }

    dimension: channelGrouping {
      description: "channelGrouping"
      label: "Channel Grouping"
      group_label: "Traffic Source"
      type: string
      sql: ${TABLE}.channel_grouping ;;
    }

    dimension: deviceCategory {
      label: "Device Category"
      group_label: "User Attributes"
      description: "deviceCategory"
      type: string
      sql: ${TABLE}.deviceCategory ;;
    }


    dimension: event_name {
      label: "Event Name"
      group_label: "Event"
      description: "event_name"
      type: string
      sql: ${TABLE}.event_name;;
    }

    dimension: action {
      label: "Event Action"
      group_label: "Event"
      description: "action"
      type: string
      sql: ${TABLE}.action;;
    }

  dimension: event_label {
    label: "Event Label"
    group_label: "Event"
    description: "action"
    type: string
    sql: ${TABLE}.event_label;;
  }


  dimension: event_attribute {
    label: "Event info"
    group_label: "Event"
    description: "event_attribute"
    type: string
    sql: ${TABLE}.event_attribute;;
  }

    dimension: transaction_id {
      label: "Transaction ID"
      group_label: "Ecommerce"
      description: "transaction_id"
      type: string
      sql: ${TABLE}.transaction_id;;
    }

  dimension: user_id {
    label: "User ID"
    group_label: "User Attributes"
    description: "user_id"
    type: string
    sql: ${TABLE}.user_id;;
  }

    dimension: screen {
      label: "Screen"
      group_label: "Page"
      description: "screen"
      type: string
      sql: ${TABLE}.screen_name;;
    }

    dimension: product_Sku{
      description: "product code"
      label: "Product SKU"
      group_label: "Product Info"
      type: string
      sql: ${TABLE}.item_id;;
    }

    dimension: Item_price {
      label: "Product Price"
      group_label: "Product Info"
      description: "Item_price"
      type: number
      value_format_name: gbp
      sql: ${TABLE}.price ;;
    }

    dimension: item_revenue {
      label: "Product revenue"
      group_label: "Ecommerce"
      description: "item_revenue"
      type: number
      value_format_name: gbp
      sql: ${TABLE}.item_revenue ;;
    }

    dimension: Item_Quantity {
      label: "Product Quantity"
      group_label: "Product Info"
      description: "Item_Quantity"
      type: number
      sql: ${TABLE}.item_quantity ;;
    }

  dimension: bounce_def {
    description: "if session is bounce 0 = no, 1 = yes"
    type: string
    hidden: yes
    sql: ${TABLE}.bounces ;;
  }

    dimension: sessions {
      description: "number of sessions with event"
      type: string
      hidden:  yes
      sql: ${TABLE}.sessions;;
    }

    measure: Sessions {
      label: "Sessions"
      group_label: "Measures"
      type: count_distinct
      sql: ${TABLE}.sessions;;
    }

    dimension: Events {
      label: "Events"
      group_label: "Event"
      description: "number of events"
      hidden: yes
      type: number
      sql: ${TABLE}.events;;
    }

    measure: sumEvents {
      label: "Events"
      group_label: "Measures"
      type: sum
      sql: ${TABLE}.events;;
    }

  measure: bounces {
    label: "bounces"
    group_label: "Measures"
    hidden: yes
    type: count_distinct
    filters: [bounce_def: "1"]
    sql: ${TABLE}.sessions;;
  }

  measure: session_start {
    label: "Distinct Sessions"
    group_label: "Measures"
    #hidden: yes
    type: count_distinct
    filters: [event_name: "session_start"]
    sql: ${TABLE}.sessions;;
  }

  measure: bs {
    label: "Bounced sessions"
    group_label: "Measures"
    sql: ${Sessions}-${bounces} ;;

  }

  measure: bounce_rate {
    label: "Bounce rate"
    group_label: "Measures"
    value_format: "0.00\%"
    sql: ${bs}/${session_start} ;;
  }


  measure: conversion_rate {
    label: "Conversion rate"
    group_label: "Measures"
    value_format: "0.00\%"
    sql: ${transaction_id}/${session_start} ;;
  }

    filter: select_date_range {
      label: "GA4 Date Range"
      group_label: "Date Filter"
      view_label: "Date"
      type: date
      datatype: date
      convert_tz: yes
    }
  }