view: srs_mandatory_moves {

  derived_table: {
    sql:
    select
    *,
    row_number () over () as prim_key
    from `toolstation-data-storage.supplyChainReporting.srs_mandatory_moves`
    ;;
  }

  dimension: prim_key{
    type: number
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: site_uid{
    type: string
    sql: ${TABLE}.site ;;
    hidden: yes
  }

  dimension_group: srs_moves{
    type: time
    timeframes: [date, month, year]
    datatype: date
    sql: ${TABLE}.date ;;
    # hidden: yes
  }

  dimension: scanned_units {
    type: number
    sql: ${TABLE}.scanned_units ;;
  }

  dimension: scanned_lines {
    type: number
    sql: ${TABLE}.scanned_lines ;;
  }
}
