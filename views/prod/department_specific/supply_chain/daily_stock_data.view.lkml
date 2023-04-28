view: daily_stock_data {
  sql_table_name: `toolstation-data-storage.supplyChainReporting.BQ_DAILY_STOCK_DATA_HISTORY` ;;

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
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

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
  }

  dimension: scmatrix {
    type: string
    sql: ${TABLE}.SCMatrix ;;
  }

  dimension: bridgwater_branch_stock {
    type: number
    sql: ${TABLE}.BridgwaterBranchStock ;;
    hidden: yes
  }

  dimension: bridgwater_branch_target {
    type: number
    sql: ${TABLE}.BridgwaterBranchTarget ;;
    hidden: yes
  }

  dimension: bridgwater_branchreplen {
    type: number
    sql: ${TABLE}.BridgwaterBranchreplen ;;
    hidden: yes
  }

  dimension: bridgwater_dcstock {
    type: number
    sql: ${TABLE}.BridgwaterDCStock ;;
    hidden: yes
  }

  dimension: bridgwater_on_order {
    type: number
    sql: ${TABLE}.bridgwaterOnOrder ;;
    hidden: yes
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

  dimension: bridgwaterbranchoos {
    type: number
    sql: ${TABLE}.bridgwaterbranchoos ;;
    hidden: yes
  }

  dimension: bridgwaterbranchtrait {
    type: number
    sql: ${TABLE}.bridgwaterbranchtrait ;;
    hidden: yes
  }

  dimension: bridgwaterbranchusage {
    type: number
    sql: ${TABLE}.bridgwaterbranchusage ;;
    hidden: yes
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
  }

  dimension: daventry_branch_stock {
    type: number
    sql: ${TABLE}.DaventryBranchStock ;;
    hidden: yes
  }

  dimension: daventry_branch_target {
    type: number
    sql: ${TABLE}.DaventryBranchTarget ;;
    hidden: yes
  }

  dimension: daventry_branchreplen {
    type: number
    sql: ${TABLE}.DaventryBranchreplen ;;
    hidden: yes
  }

  dimension: daventry_dcstock {
    type: number
    sql: ${TABLE}.DaventryDCStock ;;
    hidden: yes
  }

  dimension: daventry_on_order {
    type: number
    sql: ${TABLE}.daventryOnOrder ;;
    hidden: yes
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

  dimension: daventrybranch_oos {
    type: number
    sql: ${TABLE}.DaventrybranchOOS ;;
    hidden: yes
  }


  dimension: daventrybranchtrait {
    type: number
    sql: ${TABLE}.Daventrybranchtrait ;;
    hidden: yes
  }

  dimension: daventrybranchusage {
    type: number
    sql: ${TABLE}.Daventrybranchusage ;;
    hidden: yes
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
  }

  dimension: middleton_branch_target {
    type: number
    sql: ${TABLE}.MiddletonBranchTarget ;;
    hidden: yes
  }

  dimension: middleton_branchreplen {
    type: number
    sql: ${TABLE}.MiddletonBranchreplen ;;
    hidden: yes
  }

  dimension: middleton_dcstock {
    type: number
    sql: ${TABLE}.MiddletonDCStock ;;
    hidden: yes
  }

  dimension: middleton_on_order {
    type: number
    sql: ${TABLE}.middletonOnOrder ;;
    hidden: yes
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

  dimension: middletonbranch_oos {
    type: number
    sql: ${TABLE}.middletonbranchOOS ;;
    hidden: yes
  }

  dimension: middletonbranchstock {
    type: number
    sql: ${TABLE}.middletonbranchstock ;;
    hidden: yes
  }

  dimension: middletonbranchtrait {
    type: number
    sql: ${TABLE}.middletonbranchtrait ;;
    hidden: yes
  }

  dimension: middletonbranchusage {
    type: number
    sql: ${TABLE}.middletonbranchusage ;;
    hidden: yes
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

  dimension: redditch_branch_target {
    type: number
    sql: ${TABLE}.RedditchBranchTarget ;;
    hidden: yes
  }

  dimension: redditch_branchreplen {
    type: number
    sql: ${TABLE}.RedditchBranchreplen ;;
    hidden: yes
  }

  dimension: redditch_dcstock {
    type: number
    sql: ${TABLE}.RedditchDCStock ;;
    hidden: yes
  }

  dimension: redditch_on_order {
    type: number
    sql: ${TABLE}.redditchOnOrder ;;
    hidden: yes
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

  dimension: redditchbranch_oos {
    type: number
    sql: ${TABLE}.RedditchbranchOOS ;;
    hidden: yes
  }

  dimension: redditchbranch_trait {
    type: number
    sql: ${TABLE}.RedditchbranchTrait ;;
    hidden: yes
  }

  dimension: redditchbranchusage {
    type: number
    sql: ${TABLE}.Redditchbranchusage ;;
    hidden: yes
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
  }

  dimension: on_order_total {
    type: number
    sql: ${TABLE}.totalOnOrder ;;
    hidden: yes
  }

  dimension: total_rdc_stock_vs_downstream_need {
    type: number
    sql: ${TABLE}.Total_RDC_Stock_Vs_Downstream_Need ;;
    hidden: yes
  }

  dimension: tpldcstock {
    type: number
    sql: ${TABLE}.TPLDCStock ;;
    hidden: yes
  }

  dimension: tplusage {
    type: number
    sql: ${TABLE}.TPLUsage ;;
    hidden: yes
  }

  measure: total_bridgwater_branch_stock {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Stock"
    type: sum
    sql: ${bridgwater_branch_stock} ;;
  }

  measure: total_bridgwater_branch_target {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Target"
    type: sum
    sql: ${bridgwater_branch_target} ;;
  }


  measure: total_bridgwater_branchreplen {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Replenishment"
    type: sum
    sql: ${bridgwater_branchreplen} ;;
  }

  measure: total_bridgwater_dcstock {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "DC Stock"
    type: sum
    sql: ${bridgwater_dcstock} ;;
  }

  measure: total_bridgwater_on_order {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "On Order"
    type: sum
    sql: ${bridgwater_on_order} ;;
  }

  measure: total_bridgwater_usage {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Usage"
    type: sum
    sql: ${bridgwater_usage} ;;
  }


  measure: total_bridgwaterbranchoos {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch OOS"
    type: sum
    sql: ${bridgwaterbranchoos} ;;
  }

  measure: total_bridgwaterbranchtrait {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Trait"
    type: sum
    sql: ${bridgwaterbranchtrait} ;;
  }

  measure: total_bridgwaterbranchusage {
    view_label: "Stock"
    group_label: "Bridgwater"
    label: "Branch Usage"
    type: sum
    sql: ${bridgwaterbranchusage} ;;
  }

  measure: total_daventry_branchreplen {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Replenishment"
    type: sum
    sql: ${daventry_branchreplen} ;;
  }

  measure: total_daventry_branch_target {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Target"
    type: sum
    sql: ${daventry_branch_target} ;;
  }

  measure: total_daventry_branch_stock {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Stock"
    type: sum
    sql: ${daventry_branch_stock} ;;
  }

  measure: total_daventry_dcstock {
    view_label: "Stock"
    group_label: "Daventry"
    label: "DC Stock"
    type: sum
    sql: ${daventry_dcstock} ;;
  }

  measure: total_daventry_on_order {
    view_label: "Stock"
    group_label: "Daventry"
    label: "On Order"
    type: sum
    sql: ${daventry_on_order} ;;
  }

  measure: total_daventry_usage {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Usage"
    type: sum
    sql: ${daventry_usage} ;;
  }

  measure: total_daventrybranch_oos {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch OOS"
    type: sum
    sql: ${daventrybranch_oos} ;;
  }

  measure: total_daventrybranchtrait {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Trait"
    type: sum
    sql: ${daventrybranchtrait} ;;
  }

  measure: total_daventrybranchusage {
    view_label: "Stock"
    group_label: "Daventry"
    label: "Branch Usage"
    type: sum
    sql: ${daventrybranchusage} ;;
  }

  measure: total_middleton_branch_target {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Target"
    type: sum
    sql: ${middleton_branch_target} ;;
  }

  measure: total_middleton_branchreplen {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Replenishment"
    type: sum
    sql: ${middleton_branchreplen} ;;
  }

  measure: total_middleton_dcstock {
    view_label: "Stock"
    group_label: "Middleton"
    label: "DC Stock"
    type: sum
    sql: ${middleton_dcstock} ;;
  }

  measure: total_middleton_on_order {
    view_label: "Stock"
    group_label: "Middleton"
    label: "On Order"
    type: sum
    sql: ${middleton_on_order} ;;
  }

  measure: total_middleton_usage {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Usage"
    type: sum
    sql: ${middleton_usage} ;;
  }

  measure: total_middletonbranch_oos {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch OOS"
    type: sum
    sql: ${middletonbranch_oos} ;;
  }

  measure: total_middletonbranchstock {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Stock"
    type: sum
    sql: ${middletonbranchstock} ;;
  }

  measure: total_middletonbranchtrait {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Trait"
    type: sum
    sql: ${middletonbranchtrait} ;;
  }

  measure: total_middletonbranchusage {
    view_label: "Stock"
    group_label: "Middleton"
    label: "Branch Usage"
    type: sum
    sql: ${middletonbranchusage} ;;
  }

  measure: total_redditch_branch_stock {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Stock"
    type: sum
    sql: ${redditch_branch_stock} ;;
  }

  measure: total_redditch_branch_target {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Target"
    type: sum
    sql: ${redditch_branch_target} ;;
  }

  measure: total_redditch_branchreplen {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Replenishment"
    type: sum
    sql: ${redditch_branchreplen} ;;
  }

  measure: total_redditch_dcstock {
    view_label: "Stock"
    group_label: "Redditch"
    label: "DC Stock"
    type: sum
    sql: ${redditch_dcstock} ;;
  }

  measure: total_redditch_on_order {
    view_label: "Stock"
    group_label: "Redditch"
    label: "On Order"
    type: sum
    sql: ${redditch_on_order} ;;
  }

  measure: total_redditch_usage {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Usage"
    type: sum
    sql: ${redditch_usage} ;;
  }

  measure: total_redditchbranch_oos {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch OOS"
    type: sum
    sql: ${redditchbranch_oos} ;;
  }

  measure: total_redditchbranch_trait {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Trait"
    type: sum
    sql: ${redditchbranch_trait} ;;
  }

  measure: total_redditchbranchusage {
    view_label: "Stock"
    group_label: "Redditch"
    label: "Branch Usage"
    type: sum
    sql: ${redditchbranchusage} ;;
  }

  measure: total_on_order {
    view_label: "Stock"
    group_label: "Total"
    label: "On Order"
    type: sum
    sql: ${on_order_total} ;;
  }

  measure: total_rdc_stock_vs_downstream {
    view_label: "Stock"
    group_label: "Total"
    label: "Stock"
    type: sum
    sql: ${total_rdc_stock_vs_downstream_need} ;;
  }

  measure: total_tpldcstock {
    view_label: "Stock"
    group_label: "TPL"
    label: "Stock"
    type: sum
    sql: ${tpldcstock} ;;
  }

  measure: total_tplusage {
    view_label: "Stock"
    group_label: "TPL"
    label: "Usage"
    type: sum
    sql: ${tplusage} ;;
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
}
