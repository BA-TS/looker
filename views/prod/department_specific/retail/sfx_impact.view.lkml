view: sfx_impact {

derived_table: {
  sql:
  select
  *,
   row_number() over () as prim_key
  from
  `toolstation-data-storage.retailReporting.SFX_Impact`
  ;;
}

  dimension: prim_key {
    type: number
    sql: ${TABLE}.prim_key ;;
    hidden: yes
    primary_key: yes
  }


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
