view: stock_soq {

  sql_table_name: `toolstation-data-storage.stock.SOQ`;;

  dimension: actual_stock_holding {
    type: number
    sql: ${TABLE}.actualStockHolding ;;
  }

  dimension_group: date_key {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dateKey ;;
  }

  dimension: ignore_sleep {
    type: number
    sql: ${TABLE}.ignoreSleep ;;
  }

  dimension_group: last_sale {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.lastSaleDate ;;
  }

  dimension: min_stock_holding {
    type: number
    sql: ${TABLE}.minStockHolding ;;
  }

  dimension_group: prod_start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.prodStartDate ;;
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: replen_quantity {
    type: number
    sql: ${TABLE}.replenQuantity ;;
  }

  dimension_group: site_opened {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.siteOpened ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: target_stock_holding {
    type: number
    sql: ${TABLE}.targetStockHolding ;;
  }

  dimension: trigger {
    type: number
    sql: ${TABLE}.trigger ;;
  }
}
