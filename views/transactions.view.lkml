view: transactions {
  sql_table_name: `sales.transactions`
    ;;
  drill_fields: [transaction_uid]

  dimension: order_line_key {
    primary_key:  yes
    type:  string
    sql: concat(${parent_order_uid},${product_uid},${transaction_line_type}) ;;
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: transaction_uid {
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

  measure:  total_net_sales {
    type:  sum
    sql: ${net_sales_value} ;;
    value_format: "\£#,##0.00;(\£\#,##0.00)"
  }

  measure:  total_gross_sales {
    type:  sum
    sql: ${gross_sales_value} ;;
    value_format: "\£#,##0.00;(\£\#,##0.00)"

  }

  measure:  total_cogs {
    type:  sum
    sql: ${cogs} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure:  total_margin_excl_funding {
    type:  sum
    sql: ${margin_excl_funding} ;;
    value_format: "\£#,##0.00;(\£\#,##0.00)"

  }

  measure:  total_margin_incl_funding {
    type:  sum
    sql: ${margin_incl_funding} ;;
    value_format: "\£#,##0.00;(\£\#,##0.00)"

  }

  measure:  total_unit_funding {
    type:  sum
    sql: ${unit_funding} ;;
    value_format: "\£#,##0.00;(\£\#,##0.00)"

  }

  measure:  total_units {
    type:  sum
    sql: case when ${product_code} like '0%' then 0 else ${quantity} end ;;
    value_format: "#,##0;(#,##0)"
  }

  measure:  total_units_incl_system_codes {
    type:  sum
    sql: ${quantity} ;;
    value_format: "#,##0;(#,##0)"
  }
}
