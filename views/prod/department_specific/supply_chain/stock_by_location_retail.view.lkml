view: stock_by_location_retail {

  derived_table: {
    sql:
    select *,
    row_number() over () as prim_key,
    from
    `toolstation-data-storage.supplyChainReporting.stockByLocationRetail`;;
  }

  dimension: prim_key {
    sql:${TABLE}.prim_key;;
    primary_key: yes
    type: number
  }

  dimension: site_uid {
    sql: ${TABLE}.siteUID ;;
    type: string
    hidden: yes
  }

  dimension: retail_flag {
    sql: ${site_uid} is not null ;;
    type: yesno
  }

}
