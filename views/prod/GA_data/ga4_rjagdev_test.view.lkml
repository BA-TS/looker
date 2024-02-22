view: ga4_rjagdev_test {
  # # You can specify the table name if it's different from the view name:
   sql_table_name: `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` ;;
  #
  # # Define your dimensions and measures here, like this:

  dimension: PK {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K;;
  }

   dimension_group: date {
     description: "Date of event"
     type: time
    timeframes: [date,raw]
     sql: case when date(${TABLE}.minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(${TABLE}.minTime, interval 1 HOUR)) else (${TABLE}.minTime) end ;;
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
    sql: case
    when ${TABLE}.event_name = "videoly" and ${key_1} = "action" and ${label_1} not in ("videoly_progress") then ${label_1}
    when ${TABLE}.event_name = "videoly" and ${label_1} = "videoly_progress" then concat(${label_1},"-",${label_2},"%")
    when ${TABLE}.event_name = "videoly_videostart" then "videoly_start"
    when ${TABLE}.event_name = "videoly_initialize" then "videoly_box_shown"
    when ${TABLE}.event_name = "videoly_videoclosed" then "videoly_closed"
    when ${TABLE}.event_name = "collection_oos" and ${Platform} = "Web" then "out_of_stock"
    when ${TABLE}.event_name = "dual_oos" and ${Platform} = "Web" then "out_of_stock"
    when ${TABLE}.event_name = "delivery_oos" and ${Platform} = "Web" then "out_of_stock"
    when ${TABLE}.event_name = "out_of_stock" and ${Platform} = "Web" then null
    else ${TABLE}.event_name
    end;;
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
    hidden: yes
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
    sql: case when date(${TABLE}.minTime) Between date("2023-10-29") and ("2024-02-15") then (timestamp_sub(${TABLE}.minTime, interval 1 HOUR)) else (${TABLE}.minTime) end ;;
  }

  dimension:  session_duration {
    hidden: yes
    type: number
    sql: ${TABLE}.session_duration ;;
  }

  measure: time_hours {
    type: average
    group_label: "Overall sessions"
    value_format: "h:mm:ss"
    sql: ${session_duration}/86400.0;;
  }

  dimension: events {
    type: number
    hidden: yes
    sql: ${TABLE}.events  ;;
  }

  measure: total_events {
    group_label: "Total Measures"
    label: "Total Events"
    type: sum
    sql: ${events} ;;
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.page_views ;;
  }

  measure: total_page_views {
    label: "Page Views"
    type: sum
    sql: ${page_views} ;;
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
    filters: [event_name: "session_start"]
    sql: ${session_id};;
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

  #filter: select_date_range {
    #label: "GA4 Date Range"
    #group_label: "Date Filter"
    #view_label: "Date"
    #type: date
    #datatype: date
    #convert_tz: yes
  #}

}
