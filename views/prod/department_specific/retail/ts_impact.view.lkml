view: ts_impact {

  sql_table_name:`toolstation-data-storage.retailReporting.TS_Impact` ;;

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension_group: ts {
    label: "TS Impact"
    sql: ${TABLE}.date ;;
    type: time
    timeframes: [date, month,year, raw]
  }

  dimension: ts_flag {
    group_label: "Flags"
    label: "TS"
    type: yesno
    sql: ${site_uid} is not null ;;
  }
}
