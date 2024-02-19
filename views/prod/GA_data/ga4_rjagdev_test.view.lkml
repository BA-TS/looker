view: ga4_rjagdev_test {
  # # You can specify the table name if it's different from the view name:
   sql_table_name: `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` ;;
  #
  # # Define your dimensions and measures here, like this:
   dimension: P_K {
     description: "sessionID with min Time for P_K"
     type: string
     sql: concat(${TABLE}.session_id,${TABLE}.MinTime) ;;
   }

   dimension_group: date {
     description: "Date of event"
     type: time
    timeframes: [date,raw]
     sql: ${TABLE}.date ;;
   }

  dimension: Platform {
    description: "If user used App or Web"
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: country {
    description: "Country user has been located"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: DeviceCategory {
    description: "Device used"
    type: string
    sql: ${TABLE}.DeviceCategory ;;
  }

  dimension: Channel_group {
    description: "Groupings of traffic sources"
    type: string
    sql: ${TABLE}.Channel_group ;;
  }

  dimension: source {
    description: "traffic source"
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: medium {
    description: "traffic Medium"
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: Campaign {
    description: "traffic Campaign"
    type: string
    sql: ${TABLE}.Campaign ;;
  }

  dimension: event_name {
    description: "event name"
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: key_1 {
    description: "event key 1"
    type: string
    sql: ${TABLE}.key_1 ;;
  }

  dimension: label_1 {
    description: "event label 1"
    type: string
    sql: ${TABLE}.label_1 ;;
  }

  dimension: key_2 {
    description: "event key 2"
    type: string
    sql: ${TABLE}.key_2 ;;
  }

  dimension: label_2 {
    description: "event label 2"
    type: string
    sql: ${TABLE}.label_2 ;;
  }

  dimension: event_value {
    description: "Event Value"
    type: number
    hidden: yes
    sql: ${TABLE}.value ;;
  }

  dimension: error {
    description: "event error"
    type: string
    sql: ${TABLE}.error ;;
  }

  dimension: PromoID {
    description: "PromoID"
    type: string
    sql: ${TABLE}.PromoID ;;
  }

  dimension: PromoName {
    description: "PromoName"
    type: string
    sql: ${TABLE}.PromoName ;;
  }

  dimension: Creative_name {
    description: "creative_name"
    type: string
    sql: ${TABLE}.creative_name ;;
  }

  dimension: Item_id {
    description: "item_id"
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: Item_category {
    description: "item_category"
    type: string
    sql: ${TABLE}.item_category ;;
  }

  dimension: Item_category2 {
    description: "item_category2"
    type: string
    sql: ${TABLE}.item_category2 ;;
  }

  dimension: Item_category3 {
    description: "item_category3"
    type: string
    sql: ${TABLE}.item_category3 ;;
  }

  dimension: User {
    description: "User"
    type: string
    sql: ${TABLE}.User ;;
  }

  dimension: session_id {
    description: "session_id"
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: Page {
    description: "Page"
    type: string
    sql: ${TABLE}.page_location ;;
  }

  dimension: screen {
    description: "screen name"
    type: string
    sql: ${TABLE}.Screen_name ;;
  }

  dimension_group: time{
    description: "Min datetime of event"
    type: time
    timeframes: [time_of_day]
    sql: ${TABLE}.minTime ;;
  }

  measure:  time_hours {
    type: average
    group_label: "Overall sessions"
    value_format: "h:mm:ss"
    sql: ${TABLE}.session_duration / 86400.0;;
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

  dimension: transactions {
    description: "Is used for unnesting the transactions struct, should not be used as a standalone dimension"
    hidden: yes
    sql: ${TABLE}.transactions ;;
  }
}

# view: ga4_rjagdev_test {
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
