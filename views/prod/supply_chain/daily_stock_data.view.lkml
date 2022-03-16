
view: bq_daily_stock_data_history {

  label: "Name TBC"

  sql_table_name: `toolstation-data-storage.supplyChainReporting.BQ_DAILY_STOCK_DATA_HISTORY` ;;

  fields_hidden_by_default: yes

  # DATE #

  dimension_group: reportdate {
    view_label: "Stock"
    label: "Report"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.reportdate ;;
    hidden: no
  }




  # PRODUCT #

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;; # use for join only
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

  # dimension: product_default_supplier {
  #   type: string
  #   sql: ${TABLE}.productDefaultSupplier ;;
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

  # dimension_group: product_start {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.productStartDate ;;
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

  # dimension: buyer_name {
  #   type: string
  #   sql: ${TABLE}.buyerName ;; #products
  # }

  # dimension: buying_manager {
  #   type: string
  #   sql: ${TABLE}.buyingManager ;;  #products
  # }

  # dimension: end_of_life {
  #   type: string
  #   sql: ${TABLE}.endOfLife ;;
  # }

  # dimension: is_active {
  #   type: number
  #   sql: ${TABLE}.isActive ;;
  # }

  # dimension: manufacturer {
  #   type: string
  #   sql: ${TABLE}.manufacturer ;;
  # }

  # dimension: manufacturer_id {
  #   type: string
  #   sql: ${TABLE}.manufacturerID ;;
  # }

  # dimension: supplier_name {
  #   type: string
  #   sql: ${TABLE}.supplierName ;;
  # }

  # dimension: supplier_part_number {
  #   type: string
  #   sql: ${TABLE}.supplierPartNumber ;;
  # }

  # dimension: suspended {
  #   type: number
  #   sql: ${TABLE}.suspended ;;
  # }


  # dimension: warranty_years {
  #   type: number
  #   sql: ${TABLE}.warrantyYears ;;
  # }

  # dimension: stock_shop_replen_delay {
  #   type: string
  #   sql: ${TABLE}.stockShopReplenDelay ;;
  # }
























  dimension_group: active_from {
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
    sql: ${TABLE}.activeFrom ;;
    hidden: no
  }

  dimension_group: active_to {
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
    sql: ${TABLE}.activeTo ;;
    hidden: no
  }

  # dimension: average_cost_price {
  #   type: number
  #   sql: ${TABLE}.AverageCostPrice ;; # aac
  # }




  dimension: scmatrix {
    type: string
    sql: ${TABLE}.SCMatrix ;; # what is this?
  }










































  dimension: bridgwater_branch_stock {
    type: number
    sql: ${TABLE}.BridgwaterBranchStock ;;
    hidden: yes
  }

  measure: total_bridgwater_branch_stock {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Stock"
    type: sum
    sql: ${bridgwater_branch_stock} ;;
    hidden: no
  }


  dimension: bridgwater_branch_target {
    type: number
    sql: ${TABLE}.BridgwaterBranchTarget ;;
    hidden: yes
  }

  measure: total_bridgwater_branch_target {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Target"
    type: sum
    sql: ${bridgwater_branch_target} ;;
    hidden: no
  }

  dimension: bridgwater_branchreplen {
    type: number
    sql: ${TABLE}.BridgwaterBranchreplen ;;
    hidden: yes
  }

  measure: total_bridgwater_branchreplen {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Replenishment"
    type: sum
    sql: ${bridgwater_branchreplen} ;;
    hidden: no
  }

  dimension: bridgwater_dcstock {
    type: number
    sql: ${TABLE}.BridgwaterDCStock ;;
    hidden: yes
  }

  measure: total_bridgwater_dcstock {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "DC Stock"
    type: sum
    sql: ${bridgwater_dcstock} ;;
    hidden: no
  }

  dimension: bridgwater_on_order {
    type: number
    sql: ${TABLE}.bridgwaterOnOrder ;;
    hidden: yes
  }

  measure: total_bridgwater_on_order {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "On Order"
    type: sum
    sql: ${bridgwater_on_order} ;;
    hidden: no
  }

  dimension: bridgwater_po {
    type: string
    sql: ${TABLE}.BridgwaterPO ;;
    hidden: yes
  }


  dimension: bridgwater_usage {
    type: number
    sql: ${TABLE}.BridgwaterUsage ;;
    hidden: yes
  }

  measure: total_bridgwater_usage {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Usage"
    type: sum
    sql: ${bridgwater_usage} ;;
    hidden: no
  }

  dimension: bridgwaterbranchoos {
    type: number
    sql: ${TABLE}.bridgwaterbranchoos ;;
    hidden: yes
  }

  measure: total_bridgwaterbranchoos {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch OOS"
    type: sum
    sql: ${bridgwaterbranchoos} ;;
    hidden: no
  }

  dimension: bridgwaterbranchtrait {
    type: number
    sql: ${TABLE}.bridgwaterbranchtrait ;;
    hidden: yes
  }

  measure: total_bridgwaterbranchtrait {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Trait"
    type: sum
    sql: ${bridgwaterbranchtrait} ;;
    hidden: no
  }

  dimension: bridgwaterbranchusage {
    type: number
    sql: ${TABLE}.bridgwaterbranchusage ;;
    hidden: yes
  }

  measure: total_bridgwaterbranchusage {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Usage"
    type: sum
    sql: ${bridgwaterbranchusage} ;;
    hidden: no
  }

  dimension_group: bridgwaterexpected {
    view_label: "Stock"
    label: "Expected"
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
    sql: ${TABLE}.Bridgwaterexpected ;;
    hidden: no
  }



















  dimension: daventry_branch_stock {
    type: number
    sql: ${TABLE}.DaventryBranchStock ;;
    hidden: yes
  }
  measure: total_daventry_branch_stock {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Stock"
    type: sum
    sql: ${daventry_branch_stock} ;;
    hidden: no
  }


  dimension: daventry_branch_target {
    type: number
    sql: ${TABLE}.DaventryBranchTarget ;;
    hidden: yes
  }
  measure: total_daventry_branch_target {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Target"
    type: sum
    sql: ${daventry_branch_target} ;;
    hidden: no
  }


  dimension: daventry_branchreplen {
    type: number
    sql: ${TABLE}.DaventryBranchreplen ;;
    hidden: yes
  }
  measure: total_daventry_branchreplen {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Replenishment"
    type: sum
    sql: ${daventry_branchreplen} ;;
    hidden: no
  }


  dimension: daventry_dcstock {
    type: number
    sql: ${TABLE}.DaventryDCStock ;;
    hidden: yes
  }
  measure: total_daventry_dcstock {
    view_label: "Stock"
    group_label: "Daventry"
    label: "DC Stock"
    type: sum
    sql: ${daventry_dcstock} ;;
    hidden: no
  }


  dimension: daventry_on_order {
    type: number
    sql: ${TABLE}.daventryOnOrder ;;
    hidden: yes
  }
  measure: total_daventry_on_order {
    view_label: "Stock"
    group_label: "Daventry"
    label: "On Order"
    type: sum
    sql: ${daventry_on_order} ;;
    hidden: no
  }


  dimension: daventry_po {
    type: string
    sql: ${TABLE}.DaventryPO ;;
  }

  dimension: daventry_usage {
    type: number
    sql: ${TABLE}.DaventryUsage ;;
    hidden: yes
  }
  measure: total_daventry_usage {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Usage"
    type: sum
    sql: ${daventry_usage} ;;
    hidden: no
  }


  dimension: daventrybranch_oos {
    type: number
    sql: ${TABLE}.DaventrybranchOOS ;;
    hidden: yes
  }
  measure: total_daventrybranch_oos {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch OOS"
    type: sum
    sql: ${daventrybranch_oos} ;;
    hidden: no
  }


  dimension: daventrybranchtrait {
    type: number
    sql: ${TABLE}.Daventrybranchtrait ;;
    hidden: yes
  }
  measure: total_daventrybranchtrait {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Trait"
    type: sum
    sql: ${daventrybranchtrait} ;;
    hidden: no
  }


  dimension: daventrybranchusage {
    type: number
    sql: ${TABLE}.Daventrybranchusage ;;
    hidden: yes
  }
  measure: total_daventrybranchusage {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Usage"
    type: sum
    sql: ${daventrybranchusage} ;;
    hidden: no
  }


  dimension_group: daventryexpected {
    view_label: "Stock"
    label: "Expected"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Daventryexpected ;;
    hidden: no
  }





















  dimension: middleton_branch_target {
    type: number
    sql: ${TABLE}.MiddletonBranchTarget ;;
    hidden: yes
  }
  measure: total_middleton_branch_target {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Target"
    type: sum
    sql: ${middleton_branch_target} ;;
    hidden: no
  }


  dimension: middleton_branchreplen {
    type: number
    sql: ${TABLE}.MiddletonBranchreplen ;;
    hidden: yes
  }
  measure: total_middleton_branchreplen {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Replenishment"
    type: sum
    sql: ${middleton_branchreplen} ;;
    hidden: no
  }


  dimension: middleton_dcstock {
    type: number
    sql: ${TABLE}.MiddletonDCStock ;;
    hidden: yes
  }
  measure: total_middleton_dcstock {
    view_label: "Stock"
    group_label: "Middleton"
    label: "DC Stock"
    type: sum
    sql: ${middleton_dcstock} ;;
    hidden: no
  }


  dimension: middleton_on_order {
    type: number
    sql: ${TABLE}.middletonOnOrder ;;
    hidden: yes
  }
  measure: total_middleton_on_order {
    view_label: "Stock"
    group_label: "Middleton"
    label: "On Order"
    type: sum
    sql: ${middleton_on_order} ;;
    hidden: no
  }


  dimension: middleton_po {
    type: string
    sql: ${TABLE}.MiddletonPO ;;
  }



  dimension: middleton_usage {
    type: number
    sql: ${TABLE}.MiddletonUsage ;;
    hidden: yes
  }
  measure: total_middleton_usage {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Usage"
    type: sum
    sql: ${middleton_usage} ;;
    hidden: no
  }


  dimension: middletonbranch_oos {
    type: number
    sql: ${TABLE}.middletonbranchOOS ;;
    hidden: yes
  }
  measure: total_middletonbranch_oos {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch OOS"
    type: sum
    sql: ${middletonbranch_oos} ;;
    hidden: no
  }


  dimension: middletonbranchstock {
    type: number
    sql: ${TABLE}.middletonbranchstock ;;
    hidden: yes
  }
  measure: total_middletonbranchstock {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Stock"
    type: sum
    sql: ${middletonbranchstock} ;;
    hidden: no
  }


  dimension: middletonbranchtrait {
    type: number
    sql: ${TABLE}.middletonbranchtrait ;;
    hidden: yes
  }
  measure: total_middletonbranchtrait {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Trait"
    type: sum
    sql: ${middletonbranchtrait} ;;
    hidden: no
  }


  dimension: middletonbranchusage {
    type: number
    sql: ${TABLE}.middletonbranchusage ;;
    hidden: yes
  }
  measure: total_middletonbranchusage {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Usage"
    type: sum
    sql: ${middletonbranchusage} ;;
    hidden: no
  }


  dimension_group: middletonexpected {
    view_label: "Stock"
    label: "Expected"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Middletonexpected ;;
    hidden: no
  }




















  dimension: rdcdownstreamneed {
    type: number
    sql: ${TABLE}.RDCDownstreamneed ;;
  }

  dimension: rdcstock {
    type: number
    sql: ${TABLE}.RDCStock ;;
  }

  dimension: rec_replen_multiple {
    type: number
    sql: ${TABLE}.recReplenMultiple ;;
  }



















  dimension: redditch_branch_stock {
    type: number
    sql: ${TABLE}.RedditchBranchStock ;;
    hidden: yes
  }
  measure: total_redditch_branch_stock {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Stock"
    type: sum
    sql: ${redditch_branch_stock} ;;
    hidden: no
  }

  dimension: redditch_branch_target {
    type: number
    sql: ${TABLE}.RedditchBranchTarget ;;
    hidden: yes
  }
  measure: total_redditch_branch_target {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Target"
    type: sum
    sql: ${redditch_branch_target} ;;
    hidden: no
  }

  dimension: redditch_branchreplen {
    type: number
    sql: ${TABLE}.RedditchBranchreplen ;;
    hidden: yes
  }
  measure: total_redditch_branchreplen {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Replenishment"
    type: sum
    sql: ${redditch_branchreplen} ;;
    hidden: no
  }

  dimension: redditch_dcstock {
    type: number
    sql: ${TABLE}.RedditchDCStock ;;
    hidden: yes
  }
  measure: total_redditch_dcstock {
    view_label: "Stock"
    group_label: "Redditch"
    label: "DC Stock"
    type: sum
    sql: ${redditch_dcstock} ;;
    hidden: no
  }

  dimension: redditch_on_order {
    type: number
    sql: ${TABLE}.redditchOnOrder ;;
    hidden: yes
  }
  measure: total_redditch_on_order {
    view_label: "Stock"
    group_label: "Redditch"
    label: "On Order"
    type: sum
    sql: ${redditch_on_order} ;;
    hidden: no
  }

  dimension: redditch_po {
    type: string
    sql: ${TABLE}.RedditchPO ;;
    hidden: yes
  }


  dimension: redditch_usage {
    type: number
    sql: ${TABLE}.RedditchUsage ;;
    hidden: yes
  }
  measure: total_redditch_usage {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Usage"
    type: sum
    sql: ${redditch_usage} ;;
    hidden: no
  }

  dimension: redditchbranch_oos {
    type: number
    sql: ${TABLE}.RedditchbranchOOS ;;
    hidden: yes
  }
  measure: total_redditchbranch_oos {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch OOS"
    type: sum
    sql: ${redditchbranch_oos} ;;
    hidden: no
  }

  dimension: redditchbranch_trait {
    type: number
    sql: ${TABLE}.RedditchbranchTrait ;;
    hidden: yes
  }
  measure: total_redditchbranch_trait {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Trait"
    type: sum
    sql: ${redditchbranch_trait} ;;
    hidden: no
  }

  dimension: redditchbranchusage {
    type: number
    sql: ${TABLE}.Redditchbranchusage ;;
    hidden: yes
  }
  measure: total_redditchbranchusage {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Usage"
    type: sum
    sql: ${redditchbranchusage} ;;
    hidden: no
  }

  dimension_group: redditchexpected {
    view_label: "Stock"
    label: "Expected"
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
    sql: ${TABLE}.Redditchexpected ;;
    hidden: no
  }




















  dimension: on_order_total {
    type: number
    sql: ${TABLE}.totalOnOrder ;;
    hidden: yes
  }

  measure: total_on_order {
    view_label: "Stock"
    group_label: "Total"
    label: "On Order"
    type: sum
    sql: ${on_order_total} ;;
    hidden: no
  }

  dimension: total_rdc_stock_vs_downstream_need {
    type: number
    sql: ${TABLE}.Total_RDC_Stock_Vs_Downstream_Need ;;
    hidden: yes
  }

  measure: total_rdc_stock_vs_downstream {
    view_label: "Stock"
    group_label: "Total"
    label: "Stock"
    type: sum
    sql: ${total_rdc_stock_vs_downstream_need} ;;
    hidden: no
  }



























  dimension: tpldcstock {
    type: number
    sql: ${TABLE}.TPLDCStock ;;
    hidden: yes
  }

  measure: total_tpldcstock {
    view_label: "Stock"
    group_label: "TPL"
    label: "Stock"
    type: sum
    sql: ${tpldcstock} ;;
    hidden: no
  }

  dimension: tplusage {
    type: number
    sql: ${TABLE}.TPLUsage ;;
    hidden: yes
  }

  measure: total_tplusage {
    view_label: "Stock"
    group_label: "TPL"
    label: "Usage"
    type: sum
    sql: ${tplusage} ;;
    hidden: no
  }








}
