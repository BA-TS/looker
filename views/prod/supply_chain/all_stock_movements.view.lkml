
view: all_stock_movements {

  sql_table_name: `toolstation-data-storage.stock.allStockMovements`
    ;;
  view_label: "All Stock Movements"

  dimension_group: change_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changeDate ;;
  }



  measure: total_is_closed {
    type: sum
    sql: ${is_closed} ;;
  }

  measure: total_is_pickable {
    type: average
    sql: ${is_pickable} ;;
  }

  measure: total_is_movable {
    type: average
    sql: ${is_movable} ;;
  }

  measure: total_is_virtual {
    type: average
    sql: ${is_virtual} ;;
  }


  dimension: is_closed {
    type: number
    sql: ${TABLE}.isClosed ;;
  }

  dimension: is_movable {
    type: number
    sql: ${TABLE}.isMovable ;;
  }

  dimension: is_pickable {
    type: number
    sql: ${TABLE}.isPickable ;;
  }

  dimension: is_virtual {
    type: number
    sql: ${TABLE}.isVirtual ;;
  }

  dimension: location_name {
    type: string
    sql: ${TABLE}.locationName ;;
  }

  dimension: location_uid {
    type: string
    sql: ${TABLE}.locationUID ;;
  }

  dimension: mandatory_move {
    type: number
    sql: ${TABLE}.mandatoryMove ;;
  }

  dimension: move_note {
    type: string
    sql: ${TABLE}.moveNote ;;
  }

  dimension: move_uid {
    type: string
    sql: ${TABLE}.moveUID ;;
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: quantity_moved {
    type: number
    sql: ${TABLE}.quantityMoved ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: stock_movement_type {
    type: string
    sql: ${TABLE}.stockMovementType ;;
  }

  dimension: virtual_adjustment {
    type: number
    sql: ${TABLE}.virtualAdjustment ;;
  }

  dimension: virtual_adjustment_type {
    type: string
    sql: ${TABLE}.virtualAdjustmentType ;;
  }

  dimension: virtual_adjustment_user {
    type: string
    sql: ${TABLE}.virtualAdjustmentUser ;;
  }


}
