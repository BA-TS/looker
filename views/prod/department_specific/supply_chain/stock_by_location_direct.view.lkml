view: stock_by_location_direct {

  derived_table: {
    sql:
      select *,
      row_number() over () as prim_key,
      from
      `toolstation-data-storage.supplyChainReporting.stockByLocationDirectLooker`;;
  }

  dimension: prim_key {
  sql:${TABLE}.prim_key;;
  primary_key: yes
  type: number
  hidden:yes
  }

  dimension: site_uid {
    sql: ${TABLE}.siteUID ;;
    type: string
    hidden:yes
  }

  dimension: direct_flag {
    sql: ${site_uid} is not null ;;
    type: yesno
  }

}
