view: transactions {
  sql_table_name: `sales.transactions`
    ;;
  drill_fields: [transaction_uid]

  dimension: transaction_uid {
    primary_key: yes
    type: string
    sql: ${TABLE}.transactionUID ;;
  }

  dimension: cogs {
    type: number
    sql: ${TABLE}.COGS ;;
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
  }

  dimension: delivery_address_uid {
    type: string
    sql: ${TABLE}.deliveryAddressUID ;;
  }

  dimension: fulfillment_channel {
    type: string
    sql: ${TABLE}.fulfillmentChannel ;;
  }

  dimension: gross_sale_price {
    type: number
    sql: ${TABLE}.grossSalePrice ;;
  }

  dimension: gross_sales_value {
    type: number
    sql: ${TABLE}.grossSalesValue ;;
  }

  dimension: is_cancelled {
    type: number
    sql: ${TABLE}.isCancelled ;;
  }

  dimension: is_lfl {
    type: number
    sql: ${TABLE}.isLFL ;;
  }

  dimension: is_mature {
    type: number
    sql: ${TABLE}.isMature ;;
  }

  dimension: is_open18_months {
    type: number
    sql: ${TABLE}.isOpen18Months ;;
  }

  dimension: is_originating_lfl {
    type: number
    sql: ${TABLE}.isOriginatingLFL ;;
  }

  dimension: is_originating_mature {
    type: number
    sql: ${TABLE}.isOriginatingMature ;;
  }

  dimension: is_originating_open18_months {
    type: number
    sql: ${TABLE}.isOriginatingOpen18Months ;;
  }

  dimension: line_discount {
    type: number
    sql: ${TABLE}.lineDiscount ;;
  }

  dimension: margin_excl_funding {
    type: number
    sql: ${TABLE}.marginExclFunding ;;
  }

  dimension: margin_incl_funding {
    type: number
    sql: ${TABLE}.marginInclFunding ;;
  }

  dimension: master_customer_uid {
    type: string
    sql: ${TABLE}.masterCustomerUID ;;
  }

  dimension: net_sale_price {
    type: number
    sql: ${TABLE}.netSalePrice ;;
  }

  dimension: net_sales_value {
    type: number
    sql: ${TABLE}.netSalesValue ;;
  }

  dimension: order_reason {
    type: string
    sql: ${TABLE}.orderReason ;;
  }

  dimension: order_special_requests {
    type: string
    sql: ${TABLE}.orderSpecialRequests ;;
  }

  dimension: originating_site_uid {
    type: string
    sql: ${TABLE}.originatingSiteUID ;;
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension_group: placed {
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
    sql: ${TABLE}.placedDate ;;
  }

  dimension: postal_area {
    type: string
    sql: ${TABLE}.postalArea ;;
  }

  dimension: postal_district {
    type: string
    sql: ${TABLE}.postalDistrict ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: row_id {
    type: number
    sql: ${TABLE}.rowID ;;
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension_group: transaction {
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
    sql: ${TABLE}.transactionDate ;;
  }

  dimension: transaction_line_type {
    type: string
    description: "Field is currently under review - please do not use"
    sql: ${TABLE}.transactionLineType ;;
  }

  dimension: unit_funding {
    type: number
    sql: ${TABLE}.unitFunding ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updatedDate ;;
  }

  dimension: user_uid {
    type: string
    sql: ${TABLE}.userUID ;;
  }

  dimension: vat_rate {
    type: number
    sql: ${TABLE}.vatRate ;;
  }

  measure: count {
    type: count
    drill_fields: [transaction_uid]
  }
}
