view: videoly_funnel_ga4 {

  derived_table: {
    sql: select distinct * from `toolstation-data-storage.Digital_reporting.videoly_funnel_ga4`;;
#datagroup_trigger: ts_googleanalytics_datagroup
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
  #
   dimension: session_id {
    description: "unique identifier for session"
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
   }
  #
   dimension_group: date {
     type: time
    hidden: yes
     timeframes: [raw,date]
     sql: ${TABLE}.videoly_shownTime ;;
   }

  dimension: DeviceCategory {
    type: string
    group_label: "User attributes"
    label: "Device Category"
    description: "Device type used"
    sql: ${TABLE}.DeviceCategory ;;
  }

  dimension: Channel_group {
    type: string
    group_label: "Traffic Acquisition"
    label: "Channel Grouping"
    description: "Channel grouping from source"
    sql: ${TABLE}.Channel_group ;;
  }

  dimension: Medium {
    type: string
    group_label: "Traffic Acquisition"
    label: "Medium"
    description: "Medium from source"
    sql: ${TABLE}.Medium ;;
  }

  dimension: Campaign {
    type: string
    group_label: "Traffic Acquisition"
    label: "Campaign"
    description: "Campaign from source"
    sql: ${TABLE}.Campaign ;;
  }

  dimension_group: videoly_shownTime {
    type: time
    timeframes: [time]
    description: "datetime session was first shown videoly"
    label: "Videoly Shown Time"
    sql: ${TABLE}.videoly_shownTime ;;
  }

  dimension: videoly_shownEvents {
    type: number
    hidden: yes
    sql: ${TABLE}.Videoly_shown_events ;;
  }

  measure: videoly_shown_events {
    label: "Videoly Shown Events"
    description: "Total Videoly shown events"
    type: sum
    sql: ${videoly_shownEvents} ;;
  }

  measure: videoly_shownSessions {
    label: "Videoly Shown sessions"
    description: "Sessions where Videoly was shown"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [videoly_shownEvents: ">=1"]
  }

  dimension_group: videoly_startedTime {
    type: time
    timeframes: [time]
    description: "datetime session was first started videoly"
    label: "Videoly Started Time"
    sql: ${TABLE}.videoly_startedTime ;;
  }

  dimension: videoly_startedEvents {
    type: number
    hidden: yes
    sql: ${TABLE}.Videoly_started_events ;;

  }

  measure: videoly_started_events {
    label: "Videoly Started Events"
    description: "Total Videoly started events"
    type: sum
    sql: ${videoly_startedEvents} ;;
  }

  measure: videoly_startedSessions {
    label: "Videoly started sessions"
    description: "Sessions where Videoly was shown"
    type: count_distinct
    sql: ${session_id} ;;
    filters: [videoly_startedEvents: ">=1"]
  }

}
