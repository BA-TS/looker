view: ga4 {

    derived_table: {
      sql: with sub0 as (SELECT distinct
        "Web" as UserUID,
        date(PARSE_DATE('%Y%m%d', event_date)) as date,
        device.category as DeviceCategory,
        `toolstation-data-storage.analytics_251803804.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
        case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
        case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
        event_name,
        (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'action') as action,
        ecommerce.transaction_id,
        user_id,
        "null" as Screen_name,
        case when items.item_id is null then
        (SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'event_label') else items.item_id end as item_id,
        items.price,
        sum(items.item_revenue) as item_revenue,
        sum(items.quantity) as item_quantity,
        COUNT(DISTINCT concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))) AS sessions,
        COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events
        FROM `toolstation-data-storage.analytics_251803804.events_*` left join unnest (items) as items
        WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
        and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
        AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
        and event_name in ("view_item", "out_of_stock", "purchase", "add_to_cart", "videoly")
        GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13
        UNION DISTINCT
        SELECT distinct
        'App' as UserUID,
        PARSE_DATE('%Y%m%d', event_date) as date,
        device.category,
        `toolstation-data-storage.analytics_265133009.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
        case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
        case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
        event_name,
        (SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'action') as action,
        ecommerce.transaction_id,
        user_id,
        case when (SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') = "product-detail-page" then "Product Detail Page" else "Other Page" end as screen,
        items.item_id as item_id,
        items.price as Item_Price,
        round(sum(items.item_revenue),2) as item_revenue,
        sum(items.quantity) as itemQ,
        COUNT(DISTINCT concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id'))) AS sessions,
        COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
        FROM `toolstation-data-storage.analytics_265133009.events_*` left join unnest(items) as items
        WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
        and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
        AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
        and event_name in ('purchase', 'add_to_cart', 'out_of_stock', "screen_view", "videoly")
        GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13
        Order by 2 desc)
              select distinct row_number() over () as P_K, * from sub0;;
      datagroup_trigger: ts_googleanalytics_datagroup
    }

    dimension: P_K {
      description: "Primary key"
      type: number
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.P_K ;;
    }

    dimension: app_web_sessions {
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
      description: "Medium"
      type: string
      sql: ${TABLE}.Medium ;;
    }

    dimension: Campaign_name {
      description: "Campaign_name"
      type: string
      sql: ${TABLE}.Campaign_name ;;
    }

    dimension: channelGrouping {
      description: "channelGrouping"
      type: string
      sql: ${TABLE}.channel_grouping ;;
    }

    dimension: deviceCategory {
      description: "deviceCategory"
      type: string
      sql: ${TABLE}.deviceCategory ;;
    }


    dimension: event_name {
      description: "event_name"
      type: string
      sql: ${TABLE}.event_name;;
    }

    dimension: action {
      description: "action"
      type: string
      sql: ${TABLE}.action;;
    }

    dimension: transaction_id {
      description: "transaction_id"
      type: string
      sql: ${TABLE}.transaction_id;;
    }

  dimension: user_id {
    description: "user_id"
    type: string
    sql: ${TABLE}.user_id;;
  }

    dimension: screen {
      description: "screen"
      type: string
      sql: ${TABLE}.screen_name;;
    }

    dimension: product_Sku{
      description: "product code"
      type: string
      sql: ${TABLE}.item_id;;
    }

    dimension: Item_price {
      description: "Item_price"
      type: number
      value_format_name: gbp
      sql: ${TABLE}.price ;;
    }

    dimension: item_revenue {
      description: "item_revenue"
      type: number
      value_format_name: gbp
      sql: ${TABLE}.item_revenue ;;
    }

    dimension: Item_Quantity {
      description: "Item_Quantity"
      type: number
      sql: ${TABLE}.item_quantity ;;
    }

    dimension: sessions {
      description: "number of sessions with event"
      type: number
      sql: ${TABLE}.sessions;;
    }

    measure: sumSessions {
      type: sum
      sql: ${TABLE}.sessions;;
    }

    dimension: Events {
      description: "number of sessions with event"
      type: number
      sql: ${TABLE}.events;;
    }

    measure: sumEvents {
      type: sum
      sql: ${TABLE}.events;;
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
