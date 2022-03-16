
view: bq_daily_supply_chain_master_data_history {

  sql_table_name: `toolstation-data-storage.supplyChainReporting.BQ_DAILY_SUPPLY_CHAIN_MASTER_DATA_HISTORY`
    ;;

  fields_hidden_by_default: yes













  # PRODUCTS #

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  # dimension: product_brand {
  #   type: string
  #   sql: ${TABLE}.productBrand ;;
  # }

  # dimension: product_buying_status {
  #   type: string
  #   sql: ${TABLE}.productBuyingStatus ;;
  # }

  # dimension: product_channel {
  #   type: string
  #   sql: ${TABLE}.productChannel ;;
  # }

  # dimension: product_code {
  #   type: string
  #   sql: ${TABLE}.productCode ;;
  # }

  # dimension: product_department {
  #   type: string
  #   sql: ${TABLE}.productDepartment ;;
  # }

  # dimension: product_department_uid {
  #   type: number
  #   value_format_name: id
  #   sql: ${TABLE}.productDepartmentUID ;;
  # }

  # dimension: product_description {
  #   type: string
  #   sql: ${TABLE}.productDescription ;;
  # }

  # dimension: product_name {
  #   type: string
  #   sql: ${TABLE}.productName ;;
  # }

  # dimension: product_name_quantity {
  #   type: string
  #   sql: ${TABLE}.productNameQuantity ;;
  # }

  # dimension: product_name_type {
  #   type: string
  #   sql: ${TABLE}.productNameType ;;
  # }

  # dimension: product_status {
  #   type: string
  #   sql: ${TABLE}.productStatus ;;
  # }

  # dimension: product_subdepartment {
  #   type: string
  #   sql: ${TABLE}.productSubdepartment ;;
  # }

  # dimension: product_subdepartment_uid {
  #   type: number
  #   value_format_name: id
  #   sql: ${TABLE}.productSubdepartmentUID ;;
  # }

  # dimension: product_type {
  #   type: string
  #   sql: ${TABLE}.productType ;;
  # }















































  dimension: aac {
    type: number
    sql: ${TABLE}.aac ;;
  }

  dimension: bridgwater_existing_store_downstream_need {
    type: number
    sql: ${TABLE}.bridgwaterExistingStoreDownstreamNeed ;;
  }

  dimension: bridgwater_existing_store_downstream_stock {
    type: number
    sql: ${TABLE}.bridgwaterExistingStoreDownstreamStock ;;
  }

  dimension: bridgwater_existing_store_downstream_usage {
    type: number
    sql: ${TABLE}.bridgwaterExistingStoreDownstreamUsage ;;
  }

  dimension: bridgwater_new_store_downstream_need {
    type: number
    sql: ${TABLE}.bridgwaterNewStoreDownstreamNeed ;;
  }

  dimension: bridgwater_new_store_downstream_stock {
    type: number
    sql: ${TABLE}.bridgwaterNewStoreDownstreamStock ;;
  }

  dimension: bridgwater_new_store_downstream_usage {
    type: number
    sql: ${TABLE}.bridgwaterNewStoreDownstreamUsage ;;
  }

  dimension: bridgwater_on_order {
    type: number
    sql: ${TABLE}.bridgwaterOnOrder ;;
  }

  dimension: bridgwater_stock_units {
    type: number
    sql: ${TABLE}.bridgwaterStockUnits ;;
  }

  dimension: bridgwater_total_downstream_need {
    type: number
    sql: ${TABLE}.bridgwaterTotalDownstreamNeed ;;
  }

  dimension: bridgwater_total_downstream_stock {
    type: number
    sql: ${TABLE}.bridgwaterTotalDownstreamStock ;;
  }

  dimension: bridgwater_total_downstream_usage {
    type: number
    sql: ${TABLE}.bridgwaterTotalDownstreamUsage ;;
  }

  dimension: current_retail_price {
    type: number
    sql: ${TABLE}.currentRetailPrice ;;
  }


  dimension: daventry_existing_store_downstream_need {
    type: number
    sql: ${TABLE}.daventryExistingStoreDownstreamNeed ;;
  }

  dimension: daventry_existing_store_downstream_stock {
    type: number
    sql: ${TABLE}.daventryExistingStoreDownstreamStock ;;
  }

  dimension: daventry_existing_store_downstream_usage {
    type: number
    sql: ${TABLE}.daventryExistingStoreDownstreamUsage ;;
  }

  dimension: daventry_new_store_downstream_need {
    type: number
    sql: ${TABLE}.daventryNewStoreDownstreamNeed ;;
  }

  dimension: daventry_new_store_downstream_stock {
    type: number
    sql: ${TABLE}.daventryNewStoreDownstreamStock ;;
  }

  dimension: daventry_new_store_downstream_usage {
    type: number
    sql: ${TABLE}.daventryNewStoreDownstreamUsage ;;
  }

  dimension: daventry_on_order {
    type: number
    sql: ${TABLE}.daventryOnOrder ;;
  }

  dimension: daventry_stock_units {
    type: number
    sql: ${TABLE}.daventryStockUnits ;;
  }

  dimension: daventry_total_downstream_need {
    type: number
    sql: ${TABLE}.daventryTotalDownstreamNeed ;;
  }

  dimension: daventry_total_downstream_stock {
    type: number
    sql: ${TABLE}.daventryTotalDownstreamStock ;;
  }

  dimension: daventry_total_downstream_usage {
    type: number
    sql: ${TABLE}.daventryTotalDownstreamUsage ;;
  }

  dimension: days_stock {
    type: number
    sql: ${TABLE}.daysStock ;;
  }

  dimension: end_of_life {
    type: string
    sql: ${TABLE}.endOfLife ;;
  }

  dimension: intrastat {
    type: string
    sql: ${TABLE}.intrastat ;;
  }

  dimension: kinexiastockunits {
    type: number
    sql: ${TABLE}.kinexiastockunits ;;
  }

  dimension: middleton_existing_store_downstream_need {
    type: number
    sql: ${TABLE}.middletonExistingStoreDownstreamNeed ;;
  }

  dimension: middleton_existing_store_downstream_stock {
    type: number
    sql: ${TABLE}.middletonExistingStoreDownstreamStock ;;
  }

  dimension: middleton_existing_store_downstream_usage {
    type: number
    sql: ${TABLE}.middletonExistingStoreDownstreamUsage ;;
  }

  dimension: middleton_new_store_downstream_need {
    type: number
    sql: ${TABLE}.middletonNewStoreDownstreamNeed ;;
  }

  dimension: middleton_new_store_downstream_stock {
    type: number
    sql: ${TABLE}.middletonNewStoreDownstreamStock ;;
  }

  dimension: middleton_new_store_downstream_usage {
    type: number
    sql: ${TABLE}.middletonNewStoreDownstreamUsage ;;
  }

  dimension: middleton_on_order {
    type: number
    sql: ${TABLE}.middletonOnOrder ;;
  }

  dimension: middleton_stock_units {
    type: number
    sql: ${TABLE}.middletonStockUnits ;;
  }

  dimension: middleton_total_downstream_need {
    type: number
    sql: ${TABLE}.middletonTotalDownstreamNeed ;;
  }

  dimension: middleton_total_downstream_stock {
    type: number
    sql: ${TABLE}.middletonTotalDownstreamStock ;;
  }

  dimension: middleton_total_downstream_usage {
    type: number
    sql: ${TABLE}.middletonTotalDownstreamUsage ;;
  }

  dimension: native_price_currency {
    type: string
    sql: ${TABLE}.nativePriceCurrency ;;
  }

  dimension: other_stock_bridgwater_dc {
    type: number
    sql: ${TABLE}.otherStockBridgwaterDC ;;
  }

  dimension: other_stock_daventry_dc {
    type: number
    sql: ${TABLE}.otherStockDaventryDC ;;
  }

  dimension: other_stock_middleton_dc {
    type: number
    sql: ${TABLE}.otherStockMiddletonDC ;;
  }

  dimension: other_stock_tpl {
    type: number
    sql: ${TABLE}.otherStockTPL ;;
  }

  dimension: other_stockredditch_dc {
    type: number
    sql: ${TABLE}.otherStockredditchDC ;;
  }

  dimension: pack_cost {
    type: number
    sql: ${TABLE}.packCost ;;
  }

  dimension: pack_cost_native {
    type: number
    sql: ${TABLE}.packCostNative ;;
  }

  dimension: pack_quantity {
    type: number
    sql: ${TABLE}.packQuantity ;;
  }
  dimension: redditch_existing_store_downstream_need {
    type: number
    sql: ${TABLE}.redditchExistingStoreDownstreamNeed ;;
  }

  dimension: redditch_existing_store_downstream_stock {
    type: number
    sql: ${TABLE}.redditchExistingStoreDownstreamStock ;;
  }

  dimension: redditch_existing_store_downstream_usage {
    type: number
    sql: ${TABLE}.redditchExistingStoreDownstreamUsage ;;
  }

  dimension: redditch_new_store_downstream_need {
    type: number
    sql: ${TABLE}.redditchNewStoreDownstreamNeed ;;
  }

  dimension: redditch_new_store_downstream_stock {
    type: number
    sql: ${TABLE}.redditchNewStoreDownstreamStock ;;
  }

  dimension: redditch_new_store_downstream_usage {
    type: number
    sql: ${TABLE}.redditchNewStoreDownstreamUsage ;;
  }

  dimension: redditch_on_order {
    type: number
    sql: ${TABLE}.redditchOnOrder ;;
  }

  dimension: redditch_stock_units {
    type: number
    sql: ${TABLE}.redditchStockUnits ;;
  }

  dimension: redditch_total_downstream_need {
    type: number
    sql: ${TABLE}.redditchTotalDownstreamNeed ;;
  }

  dimension: redditch_total_downstream_stock {
    type: number
    sql: ${TABLE}.redditchTotalDownstreamStock ;;
  }

  dimension: redditch_total_downstream_usage {
    type: number
    sql: ${TABLE}.redditchTotalDownstreamUsage ;;
  }

  dimension_group: reportdate {
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
    sql: ${TABLE}.reportdate ;;
  }

  dimension: stock_in_transit_bridgwater_dc {
    type: number
    sql: ${TABLE}.stockInTransitBridgwaterDC ;;
  }

  dimension: stock_in_transit_daventry_dc {
    type: number
    sql: ${TABLE}.stockInTransitDaventryDC ;;
  }

  dimension: stock_in_transit_middleton_dc {
    type: number
    sql: ${TABLE}.stockInTransitMiddletonDC ;;
  }

  dimension: stock_in_transit_redditch_dc {
    type: number
    sql: ${TABLE}.stockInTransitRedditchDC ;;
  }

  dimension: stock_in_transit_tpldc {
    type: number
    sql: ${TABLE}.stockInTransitTPLDC ;;
  }

  dimension: stock_replen_multiple {
    type: number
    sql: ${TABLE}.stockReplenMultiple ;;
  }

  dimension: supplier_lead_time {
    type: number
    sql: ${TABLE}.supplierLeadTime ;;
  }

  dimension: supplier_name {
    type: string
    sql: ${TABLE}.supplierName ;;
  }

  dimension: supplier_part_lead_time {
    type: number
    sql: ${TABLE}.supplierPartLeadTime ;;
  }

  dimension: supplier_part_number {
    type: string
    sql: ${TABLE}.supplierPartNumber ;;
  }

  dimension: total_dcother_stock {
    type: number
    sql: ${TABLE}.totalDCOtherStock ;;
  }

  dimension: total_dcstock {
    type: number
    sql: ${TABLE}.totalDCStock ;;
  }

  dimension: total_downstream_need {
    type: number
    sql: ${TABLE}.totalDownstreamNeed ;;
  }

  dimension: total_downstream_stock {
    type: number
    sql: ${TABLE}.totalDownstreamStock ;;
  }

  dimension: total_downstream_usage {
    type: number
    sql: ${TABLE}.totalDownstreamUsage ;;
  }

  dimension: total_existing_store_downstream_need {
    type: number
    sql: ${TABLE}.totalExistingStoreDownstreamNeed ;;
  }

  dimension: total_existing_store_downstream_stock {
    type: number
    sql: ${TABLE}.totalExistingStoreDownstreamStock ;;
  }

  dimension: total_existing_store_downstream_usage {
    type: number
    sql: ${TABLE}.totalExistingStoreDownstreamUsage ;;
  }

  dimension: total_in_transit_to_dc {
    type: number
    sql: ${TABLE}.totalInTransitToDC ;;
  }

  dimension: total_new_store_downstream_need {
    type: number
    sql: ${TABLE}.totalNewStoreDownstreamNeed ;;
  }

  dimension: total_new_store_downstream_stock {
    type: number
    sql: ${TABLE}.totalNewStoreDownstreamStock ;;
  }

  dimension: total_new_store_downstream_usage {
    type: number
    sql: ${TABLE}.totalNewStoreDownstreamUsage ;;
  }

  dimension: total_on_order {
    type: number
    sql: ${TABLE}.totalOnOrder ;;
  }

  dimension: total_returns_trojan_stock {
    type: number
    sql: ${TABLE}.totalReturnsTrojanStock ;;
  }

  dimension: total_stock_in_transit_to_stores {
    type: number
    sql: ${TABLE}.totalStockInTransitToStores ;;
  }

  dimension: total_stock_units_excl_returns {
    type: number
    sql: ${TABLE}.totalStockUnitsExclReturns ;;
  }

  dimension: total_store_other_stock {
    type: number
    sql: ${TABLE}.totalStoreOtherStock ;;
  }

  dimension: total_store_stock {
    type: number
    sql: ${TABLE}.totalStoreStock ;;
  }

  dimension: tplstock_units {
    type: number
    sql: ${TABLE}.TPLstockUnits ;;
  }

  dimension: tplstock_units_exc_kinexia {
    type: number
    sql: ${TABLE}.TPLstockUnits_exc_Kinexia ;;
  }

}
