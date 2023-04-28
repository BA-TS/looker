view: stock_work_in_progress {
  sql_table_name: `toolstation-data-storage.financeReporting.DS_DAILY_WIP_HISTORY` ;;

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: product_description {
    type: string
    sql: ${TABLE}.productDescription ;;
  }

  dimension: replen_delay {
    type: string
    sql: ${TABLE}.replenDelay ;;
  }

  dimension: product_channel {
    type: string
    sql: ${TABLE}.productChannel ;;
  }

  dimension: product_status {
    type: string
    sql: ${TABLE}.productStatus ;;
  }

  dimension: buying_status {
    type: string
    sql: ${TABLE}.buyingStatus ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: subdepartment {
    type: string
    sql: ${TABLE}.subdepartment ;;
  }

  dimension: supplier_name {
    type: string
    sql: ${TABLE}.supplierName ;;
  }

  dimension: current_cost_price {
    type: number
    sql: ${TABLE}.currentCostPrice ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: daventry_in_transit {
    type: number
    sql: ${TABLE}.DaventryInTransit ;;
  }

  dimension: daventry_pickable_dcstock {
    type: number
    sql: ${TABLE}.DaventryPickableDCStock ;;
    hidden: yes
  }

  dimension: daventry_replen_qty_incl_in_transit {
    type: number
    sql: ${TABLE}.DaventryReplenQtyInclInTransit ;;
    hidden: yes
  }

  dimension: daventry_replen_qty_required {
    type: number
    sql: ${TABLE}.DaventryReplenQtyRequired ;;
    hidden: yes
  }

  dimension: daventry_stores_in_replen {
    type: number
    sql: ${TABLE}.DaventryStoresInReplen ;;
    hidden: yes
  }

  dimension: middleton_dcstock {
    type: number
    sql: ${TABLE}.MiddletonDCStock ;;
  }

  dimension: middleton_in_transit {
    type: number
    sql: ${TABLE}.MiddletonInTransit ;;
  }

  dimension: middleton_pickable_dcstock {
    type: number
    sql: ${TABLE}.MiddletonPickableDCStock ;;
  }

  dimension: middleton_replen_qty_incl_in_transit {
    type: number
    sql: ${TABLE}.MiddletonReplenQtyInclInTransit ;;
  }

  dimension: middleton_replen_qty_required {
    type: number
    sql: ${TABLE}.MiddletonReplenQtyRequired ;;
  }

  dimension: middleton_stores_in_replen {
    type: number
    sql: ${TABLE}.MiddletonStoresInReplen ;;
  }

  dimension: redditch_dcstock {
    type: number
    sql: ${TABLE}.RedditchDCStock ;;
  }

  dimension: redditch_in_transit {
    type: number
    sql: ${TABLE}.RedditchInTransit ;;
  }

  dimension: redditch_pickable_dcstock {
    type: number
    sql: ${TABLE}.RedditchPickableDCStock ;;
  }

  dimension: redditch_replen_qty_incl_in_transit {
    type: number
    sql: ${TABLE}.RedditchReplenQtyInclInTransit ;;
  }

  dimension: redditch_replen_qty_required {
    type: number
    sql: ${TABLE}.RedditchReplenQtyRequired ;;
  }

  dimension: redditch_stores_in_replen {
    type: number
    sql: ${TABLE}.RedditchStoresInReplen ;;
  }

  dimension: scmatrix {
    type: string
    sql: ${TABLE}.SCMatrix ;;
  }

  dimension: total_pickable_dav {
    type: number
    sql: ${TABLE}.totalPickableDav ;;
  }

  dimension: total_pickable_mid {
    type: number
    value_format_name: id
    sql: ${TABLE}.totalPickableMid ;;
  }

  dimension: total_pickable_red {
    type: number
    sql: ${TABLE}.totalPickableRed ;;
  }

  dimension: tpldcstock {
    type: number
    sql: ${TABLE}.TPLDCStock ;;
  }

  dimension: tplpickable_dcstock {
    type: number
    sql: ${TABLE}.TPLPickableDCStock ;;
  }

  measure: total_daventry_in_transit {
    view_label: "Daventry"
    label: "In Transit (Daventry)"
    type: sum
    sql: ${daventry_in_transit} ;;
  }

  measure: total_daventry_pickable_dcstock {
    view_label: "Daventry"
    label: "Pickable Stock (Daventry)"
    type: sum
    sql: ${daventry_pickable_dcstock} ;;
  }

  measure: total_daventry_replen_qty_incl_in_transit {
    view_label: "Daventry"
    label: "Replenishment Quantity Inc. In Transit (Daventry)"
    type: sum
    sql: ${daventry_replen_qty_incl_in_transit} ;;
  }

  measure: total_daventry_replen_qty_required {
    view_label: "Daventry"
    label: "Replenishment Quantity Required (Daventry)"
    type: sum
    sql: ${daventry_replen_qty_required} ;;
  }

  measure: total_daventry_stores_in_replen {
    view_label: "Daventry"
    label: "Stores In Replenishment (Daventry)"
    type: sum
    sql: ${daventry_stores_in_replen} ;;
  }

  measure: total_middleton_in_transit {
    view_label: "Middleton"
    label: "In Transit (Middleton)"
    type: sum
    sql: ${middleton_in_transit} ;;
  }

  measure: total_middleton_pickable_dcstock {
    view_label: "Middleton"
    label: "Pickable Stock (Middleton)"
    type: sum
    sql: ${middleton_pickable_dcstock} ;;
  }

  measure: total_middleton_replen_qty_incl_in_transit {
    view_label: "Middleton"
    label: "Replenishment Quantity Inc. In Transit (Middleton)"
    type: sum
    sql: ${middleton_replen_qty_incl_in_transit} ;;
  }

  measure: total_middleton_replen_qty_required {
    view_label: "Middleton"
    label: "Replenishment Quantity Required (Middleton)"
    type: sum
    sql: ${middleton_replen_qty_required} ;;
  }

  measure: total_middleton_stores_in_replen {
    view_label: "Middleton"
    label: "Stores In Replenishment (Middleton)"
    type: sum
    sql: ${middleton_stores_in_replen} ;;
  }

  measure: total_redditch_in_transit {
    view_label: "Redditch"
    label: "In Transit (Redditch)"
    type: sum
    sql: ${redditch_in_transit} ;;
  }

  measure: total_redditch_pickable_dcstock {
    view_label: "Redditch"
    label: "Pickable Stock (Redditch)"
    type: sum
    sql: ${redditch_pickable_dcstock} ;;
  }

  measure: total_redditch_replen_qty_incl_in_transit {
    view_label: "Redditch"
    label: "Replenishment Quantity Inc. In Transit (Redditch)"
    type: sum
    sql: ${redditch_replen_qty_incl_in_transit} ;;
  }

  measure: total_redditch_replen_qty_required {
    view_label: "Redditch"
    label: "Replenishment Quantity Required (Redditch)"
    type: sum
    sql: ${redditch_replen_qty_required} ;;
  }

  measure: total_redditch_stores_in_replen {
    view_label: "Redditch"
    label: "Stores In Replenishment (Redditch)"
    type: sum
    sql: ${redditch_stores_in_replen} ;;
  }
}
