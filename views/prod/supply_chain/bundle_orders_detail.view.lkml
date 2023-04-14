view: bundle_orders_detail {
   sql_table_name: `toolstation-data-storage.looker_mart.bundle_orders_detail`;;

  dimension_group: bundle {
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
    sql: ${TABLE}.bundle_date ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundleID ;;
  }

  dimension: bundle_order_size {
    type: number
    sql: ${TABLE}.bundle_order_size ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.siteName ;;
  }

  measure: total_bundle_order_size {
    type: sum
    sql: ${bundle_order_size} ;;
  }

  measure: average_bundle_order_size {
    type: average
    sql: ${bundle_order_size} ;;
  }

  measure: count {
    type: count
    drill_fields: [site_name]
  }
}
