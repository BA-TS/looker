view: purchase_orders {
  sql_table_name: `toolstation-data-storage.stock.purchaseOrders`
    ;;

  dimension: order_product_site {
    primary_key: yes
    type:  string
    sql: ${order_uid}||'-'||${product_uid}||'-'||${destination_site_uid} ;;
    hidden:  yes
  }

  dimension: accepted {
    group_label: "Flags"
    label: "Is Accepted?"
    type: yesno
    sql: ${TABLE}.accepted = 1 ;;
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
    group_label: "Flags"
    label: "Is Complete?"
    type: yesno
    sql: ${TABLE}.isComplete = 1 ;;
  }

  dimension_group: order_completed {
    label: "Order Completed"
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
    label: "Order Delivered"
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
    label: "Order Expected"
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
    label: "Order Placed"
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


  dimension_group: order_booked {
    label: "Order Booked"
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
    sql: ${TABLE}.orderBooked_in_Date ;;
  }

  dimension: order_status {
    type: string
    sql: ${TABLE}.orderStatus ;;
  }

  dimension: order_uid {
    label: "Order UID"
    type: string
    sql: ${TABLE}.orderUID ;;
  }

  dimension: pack_cost_gbp {
    type: number
    sql: ${TABLE}.packCostGBP ;;
    hidden: yes
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
    hidden: yes
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
    sql: SAFE_DIVIDE(${pack_cost_gbp}, ${pack_quantity}) ;;
    hidden: yes
  }

  measure: total_units_ordered {
    type:  sum
    sql:  ${quantity_ordered} ;;
  }

  measure: total_units_received {
    type:  sum
    sql:  ${quantity_received} ;;
  }

  dimension: department {
    view_label: "Products"
    group_label: "Product Details"
    type:  string
    sql:  ${products.department} ;;
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

  measure: average_pack_cost {
    type: average
    sql: ${pack_cost_gbp} ;;
    value_format_name: gbp
  }

  measure: average_pack_quantity {
    type: average
    sql: ${pack_quantity} ;;
    value_format_name: decimal_0
  }

  measure: average_unit_cost {
    type: average
    sql: ${unit_cost} ;;
    value_format_name: gbp
  }

}
