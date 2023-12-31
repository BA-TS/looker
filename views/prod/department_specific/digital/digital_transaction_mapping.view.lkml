view: digital_transaction_mapping {
  sql_table_name: `toolstation-data-storage.looker_persistent_tables.digital_transaction_mapping`;;

  dimension: channel_grouping {
    view_label: "Digital"
    # group_label: "Digital Mapping"
    label: "Channel Grouping"
    type: string
    sql: ${TABLE}.channelGrouping ;;
    # required_access_grants: [is_developer]
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date
    ]
    datatype: date
    sql: ${TABLE}.date ;;
    hidden: yes
  }

  dimension: transaction_uid {
    type: string
    sql: ${TABLE}.transactionUID ;;
    hidden: yes
  }

  dimension: user_device {
    view_label: "Digital"
    # group_label: "Digital Mapping"
    label: "Device"
    type: string
    sql: ${TABLE}.userDevice ;;
    # required_access_grants: [is_developer]
  }

  dimension: is_digital_purchase {
    view_label: "Digital"
    # group_label: "Digital Mapping"
    label: "Is Digital Purchase?"
    type: yesno
    sql:${channel_grouping} IS NOT NULL;;
    # required_access_grants: [is_developer]
  }

  # dimension: transaction_revenue {
  #   type: number
  #   sql: ${TABLE}.transactionRevenue ;;
  # }
}
