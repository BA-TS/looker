view: sfx_impact {

  sql_table_name:`toolstation-data-storage.retailReporting.SFX_Impact` ;;

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension_group: sfx {
    label: "SFX Impact"
    type: time
    timeframes: [date, month,year, raw]
    sql: ${TABLE}.date ;;
  }

  dimension: sfx_flag {
    group_label: "Flags"
    label: "SFX"
    type: yesno
    sql: ${site_uid} is not null ;;
  }
}
