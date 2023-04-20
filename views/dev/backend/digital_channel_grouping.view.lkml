view: backend_digital_channel_grouping {
  fields_hidden_by_default: yes

  derived_table: {
    sql:
    SELECT DISTINCT
      channelGrouping AS channelGrouping

    FROM
      `toolstation-data-storage.4783980.ga_sessions_*`

    WHERE
      _TABLE_SUFFIX = FORMAT_DATE("%Y%m%d",CURRENT_DATE() - 1)
      ;;

    datagroup_trigger: ts_daily_datagroup
  }

  dimension: channel_grouping {
    type: string
    sql: ${TABLE}.channelGrouping ;;
  }
}
