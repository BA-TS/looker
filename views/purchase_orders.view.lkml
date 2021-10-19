view: stock_intake {
  sql_table_name: `toolstation-data-storage.stock.purchaseOrders`
    ;;

  dimension: order_product_site {
    primary_key: yes
    type:  string
    sql: ${order_uid}||'-'||${product_uid}||'-'||${destination_site_uid} ;;
    hidden:  yes
  }

  dimension: accepted {
    type: number
    sql: ${TABLE}.accepted ;;
  }

  dimension: destination_address_uid {
    type: string
    sql: ${TABLE}.destinationAddressUID ;;
    hidden: yes
  }

  dimension: destination_site_uid {
    label: "Destination Site UID"
    type: string
    sql: ${TABLE}.destinationSiteUID ;;
  }

  dimension: is_complete {
    type: number
    sql: ${TABLE}.isComplete ;;
  }

  dimension_group: order_completed {
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
    sql: ${TABLE}.orderCompletedDate ;;
  }

  dimension_group: order_delivered {
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
    sql: ${TABLE}.orderDeliveredDate ;;
  }

  dimension_group: order_expected {
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
    sql: ${TABLE}.orderExpectedDate ;;
  }

  dimension_group: order_placed {
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
    sql: ${TABLE}.orderPlacedDate ;;
  }

  dimension: order_status {
    type: string
    sql: ${TABLE}.orderStatus ;;
  }

  dimension: order_uid {
    type: string
    sql: ${TABLE}.orderUID ;;
  }

  dimension: pack_cost_gbp {
    type: number
    sql: ${TABLE}.packCostGBP ;;
  }

  dimension: pack_quantity {
    type: number
    sql: ${TABLE}.packQuantity ;;
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: quantity_ordered {
    type: number
    sql: ${TABLE}.quantityOrdered ;;
  }

  dimension: quantity_received {
    type: number
    sql: ${TABLE}.quantityReceived ;;
  }

  dimension: received_quantity_tally {
    type: number
    hidden:  yes
    sql: ${TABLE}.receivedQuantityTally ;;
  }

  dimension: supplier_address_uid {
    type: string
    hidden:  yes
    sql: ${TABLE}.supplierAddressUID ;;
  }

  dimension: supplier_uid {
    type: string
    sql: ${TABLE}.supplierUID ;;
    hidden: yes
  }

  dimension: unit_cost {
    type:  number
    sql: ${pack_cost_gbp}/${pack_quantity} ;;
  }

  measure: total_units_ordered {
    type:  sum
    sql:  ${quantity_ordered} ;;
  }

  measure: total_units_received {
    type:  sum
    sql:  ${quantity_received} ;;
  }

  measure: total_value_ordered {
    type:  number
    sql: sum(${quantity_ordered}*(safe_divide(${pack_cost_gbp},${pack_quantity}))) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: total_value_received {
    type:  number
    sql: sum(${quantity_received}*(safe_divide(${pack_cost_gbp},${pack_quantity}))) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

}
