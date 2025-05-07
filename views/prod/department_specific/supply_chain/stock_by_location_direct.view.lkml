view: stock_by_location_direct {

derived_table: {
  sql:
    select *,
    row_number() over () as prim_key,
    from
    `toolstation-data-storage.supplyChainReporting.stockByLocationDirect`;;
}

  dimension: prim_key {
  sql:${TABLE}.prim_key;;
  primary_key: yes
  type: number
  }

  dimension: siteUID {
    sql: ${TABLE}.siteUID ;;
    type: string
  }

}
