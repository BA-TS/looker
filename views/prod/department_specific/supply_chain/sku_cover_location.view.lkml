view: sku_cover_location {
  sql_table_name: `toolstation-data-storage.financeReporting.DS_DAILY_STOCK_REPORTING_SKU_COVER_LOCATION`;;

  dimension_group: report {
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
    sql: ${TABLE}.reportDate ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: product_subdepartment {
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: buying_status {
    type: string
    sql: ${TABLE}.buyingStatus ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: end_of_life_route {
    type: string
    sql: ${TABLE}.endOfLifeRoute ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: planner {
    type: string
    sql: ${TABLE}.planner ;;
  }

  dimension: supplier_name {
    type: string
    sql: ${TABLE}.supplierName ;;
  }

  dimension: supplier_uid {
    type: string
    sql: ${TABLE}.supplierUID ;;
  }

  dimension: sc_matrix {
    type: string
    sql: ${TABLE}.scMatrix ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.Action ;;
  }

  dimension: action_age {
    type: number
    sql: ${TABLE}.actionAge ;;
  }

  dimension: stock_classification {
    type: string
    sql: ${TABLE}.stockClassification ;;
  }

  dimension: weekly_units {
    type: number
    sql: ${TABLE}.weeklyUnits ;;
  }

  dimension: weekly_cogs {
    type: number
    sql: ${TABLE}.weeklyCOGS ;;
  }

  dimension: total_stock_units {
    type: number
    sql: ${TABLE}.totalStockUnits ;;
  }

  dimension: total_stock_value {
    type: number
    sql: ${TABLE}.totalStockValue ;;
  }

  dimension: promo_stock_units {
    type: number
    sql: ${TABLE}.promoStockUnits ;;
  }

  dimension: promo_stock_value {
    type: number
    sql: ${TABLE}.promoStockValue ;;
  }

  dimension: new_stock_units {
    type: number
    sql: ${TABLE}.newStockUnits ;;
  }

  dimension: new_stock_value {
    type: number
    sql: ${TABLE}.newStockValue ;;
  }

  dimension: discontinued_stock_units {
    type: number
    sql: ${TABLE}.discontinuedStockUnits ;;
  }

  dimension: discontinued_stock_value {
    type: number
    sql: ${TABLE}.discontinuedStockValue ;;
  }

  dimension: dsv_stock_units {
    type: number
    sql: ${TABLE}.dsvStockUnits ;;
  }

  dimension: dsv_stock_value {
    type: number
    sql: ${TABLE}.dsvStockValue ;;
  }

  dimension: cover8_units {
    type: number
    sql: ${TABLE}.cover8Units ;;
  }

  dimension: cover8_value {
    type: number
    sql: ${TABLE}.cover8Value ;;
  }

  dimension: cover26_units {
    type: number
    sql: ${TABLE}.cover26Units ;;
  }

  dimension: cover26_value {
    type: number
    sql: ${TABLE}.cover26Value ;;
  }

  dimension: cover52_units {
    type: number
    sql: ${TABLE}.cover52Units ;;
  }

  dimension: cover52_value {
    type: number
    sql: ${TABLE}.cover52Value ;;
  }

  dimension: cover_over52_units {
    type: number
    sql: ${TABLE}.coverOver52Units ;;
  }

  dimension: cover_over52_value {
    type: number
    sql: ${TABLE}.coverOver52Value ;;
  }

  dimension: other_stock_units {
    type: number
    sql: ${TABLE}.otherStockUnits ;;
  }

  dimension: other_stock_value {
    type: number
    sql: ${TABLE}.otherStockValue ;;
  }

  dimension: bridgwater_chepstow {
    type: number
    sql: ${TABLE}.Bridgwater_Chepstow ;;
  }

  dimension: bridgwater_chepstow_value {
    type: number
    sql: ${TABLE}.Bridgwater_ChepstowValue ;;
  }

  dimension: bridgwater_in_transport_stock_units {
    type: number
    sql: ${TABLE}.bridgwaterInTransportStockUnits ;;
  }

  dimension: bridgwater_in_transport_stock_value {
    type: number
    sql: ${TABLE}.bridgwaterInTransportStockValue ;;
  }

  dimension: bridgwater_offsite_stock_units {
    type: number
    sql: ${TABLE}.bridgwaterOffsiteStockUnits ;;
  }

  dimension: bridgwater_offsite_stock_value {
    type: number
    sql: ${TABLE}.bridgwaterOffsiteStockValue ;;
  }

  dimension: bridgwater_stock_units {
    type: number
    sql: ${TABLE}.bridgwaterStockUnits ;;
  }

  dimension: bridgwater_stock_value {
    type: number
    sql: ${TABLE}.bridgwaterStockValue ;;
  }

  dimension: clearance_corner {
    type: number
    sql: ${TABLE}.ClearanceCorner ;;
  }

  dimension: clearance_corner_value {
    type: number
    sql: ${TABLE}.ClearanceCornerValue ;;
  }

  dimension: daventry_offsite_stock_units {
    type: number
    sql: ${TABLE}.daventryOffsiteStockUnits ;;
  }

  dimension: daventry_offsite_stock_value {
    type: number
    sql: ${TABLE}.daventryOffsiteStockValue ;;
  }

  dimension: daventry_stock_units {
    type: number
    sql: ${TABLE}.daventryStockUnits ;;
  }

  dimension: daventry_stock_value {
    type: number
    sql: ${TABLE}.daventryStockValue ;;
  }

  dimension: existing_branches_stock_units {
    type: number
    sql: ${TABLE}.existingBranchesStockUnits ;;
  }

  dimension: existing_branches_stock_value {
    type: number
    sql: ${TABLE}.existingBranchesStockValue ;;
  }

  dimension: i_force_stock_units {
    type: number
    sql: ${TABLE}.iForceStockUnits ;;
  }

  dimension: i_force_stock_value {
    type: number
    sql: ${TABLE}.iForceStockValue ;;
  }

  dimension: kinexia {
    type: number
    sql: ${TABLE}.Kinexia ;;
  }

  dimension: kinexia_value {
    type: number
    sql: ${TABLE}.KinexiaValue ;;
  }

  dimension: middleton_offsite_stock_units {
    type: number
    sql: ${TABLE}.middletonOffsiteStockUnits ;;
  }

  dimension: middleton_offsite_stock_value {
    type: number
    sql: ${TABLE}.middletonOffsiteStockValue ;;
  }

  dimension: middleton_stock_units {
    type: number
    sql: ${TABLE}.middletonStockUnits ;;
  }

  dimension: middleton_stock_value {
    type: number
    sql: ${TABLE}.middletonStockValue ;;
  }

  dimension: new_branches_stock_units {
    type: number
    sql: ${TABLE}.newBranchesStockUnits ;;
  }

  dimension: new_branches_stock_value {
    type: number
    sql: ${TABLE}.newBranchesStockValue ;;
  }

  dimension: redditch_offsite_stock_units {
    type: number
    sql: ${TABLE}.redditchOffsiteStockUnits ;;
  }

  dimension: redditch_offsite_stock_value {
    type: number
    sql: ${TABLE}.redditchOffsiteStockValue ;;
  }

  dimension: redditch_stock_units {
    type: number
    sql: ${TABLE}.redditchStockUnits ;;
  }

  dimension: redditch_stock_value {
    type: number
    sql: ${TABLE}.redditchStockValue ;;
  }

  dimension: returns_stock_units {
    type: number
    sql: ${TABLE}.returnsStockUnits ;;
  }

  dimension: returns_stock_value {
    type: number
    sql: ${TABLE}.returnsStockValue ;;
  }

  dimension: rtv_stock_units {
    type: number
    description: "Stock in V2 SiteUID"
    sql: ${TABLE}.rtvStockUnits ;;
  }

  dimension: rtv_stock_value {
    type: number
    description: "Stock in V2 SiteUID"
    sql: ${TABLE}.rtvStockValue ;;
  }

  dimension: trojan_stock_units {
    type: number
    sql: ${TABLE}.trojanStockUnits ;;
  }

  dimension: trojan_stock_value {
    type: number
    sql: ${TABLE}.trojanStockValue ;;
  }

  dimension: uniserve_rads {
    type: number
    sql: ${TABLE}.Uniserve_Rads ;;
  }

  dimension: uniserve_rads_value {
    type: number
    sql: ${TABLE}.Uniserve_RadsValue ;;
  }
}
