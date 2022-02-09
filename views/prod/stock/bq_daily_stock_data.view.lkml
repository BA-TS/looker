view: bq_daily_stock_data {

  fields_hidden_by_default: yes

  sql_table_name: `toolstation-data-storage.supplyChainReporting.BQ_DAILY_STOCK_DATA`
    ;;


  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }
  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}.productName ;;
    hidden: yes
  }
  dimension: product_name_type {
    type: string
    sql: ${TABLE}.productNameType ;;
    hidden: yes
  }
  dimension: product_name_quantity {
    type: string
    sql: ${TABLE}.productNameQuantity ;;
    hidden: yes
  }
  dimension: product_description {
    type: string
    sql: ${TABLE}.productDescription ;;
    hidden: yes
  }
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

  dimension: product_type {
    type: string
    sql: ${TABLE}.productType ;;
  }
  dimension: product_status {
    type: string
    sql: ${TABLE}.productStatus ;;
    hidden: yes # check this
  }
  dimension: product_buying_status {
    type: string
    sql: ${TABLE}.productBuyingStatus ;;
    hidden: yes # check this
  }
  dimension: product_channel {
    type: string
    sql: ${TABLE}.productChannel ;;
    hidden: yes # check this
  }
  dimension: stock_shop_replen_delay {
    type: string
    sql: ${TABLE}.stockShopReplenDelay ;;
  }
  dimension: rec_replen_multiple {
    type: number
    sql: ${TABLE}.recReplenMultiple ;;
  }
  dimension: end_of_life {
    type: string
    sql: ${TABLE}.endOfLife ;;
    hidden: yes # check this
  }
  dimension: product_department_uid {
    type: number
    value_format_name: id
    sql: ${TABLE}.productDepartmentUID ;;
    hidden: yes
  }
  dimension: product_department {
    type: string
    sql: ${TABLE}.productDepartment ;;
    hidden: yes
  }
  dimension: product_subdepartment_uid {
    type: number
    value_format_name: id
    sql: ${TABLE}.productSubdepartmentUID ;;
    hidden: yes
  }
  dimension: product_subdepartment {
    type: string
    sql: ${TABLE}.productSubdepartment ;;
    hidden: yes
  }
  dimension: product_brand {
    type: string
    sql: ${TABLE}.productBrand ;;
    hidden: yes # check this
  }
  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
    hidden: yes # check this
  }
  dimension: manufacturer_id {
    type: string
    sql: ${TABLE}.manufacturerID ;;
    hidden: yes
  }
  dimension: warranty_years {
    type: number
    sql: ${TABLE}.warrantyYears ;;
    hidden: yes # check this
  }
  dimension: suspended {
    type: number
    sql: ${TABLE}.suspended ;;
    hidden: yes # check this
  }
  dimension: product_default_supplier {
    type: string
    sql: ${TABLE}.productDefaultSupplier ;;
    hidden: yes
  }
  dimension: supplier_part_number {
    type: string
    sql: ${TABLE}.supplierPartNumber ;;
    hidden: yes # check this
  }
  dimension: buyer_name {
    type: string
    sql: ${TABLE}.buyerName ;;
    hidden: yes
  }
  dimension: buying_manager {
    type: string
    sql: ${TABLE}.buyingManager ;;
    hidden: yes
  }


  # dimension_group: active_from {
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
  #   sql: ${TABLE}.activeFrom ;;
  # }

  # dimension_group: active_to {
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
  #   sql: ${TABLE}.activeTo ;;
  # }




  dimension: is_active {
    type: number
    sql: ${TABLE}.isActive ;;
    hidden: yes # check this
  }
  dimension: scmatrix {
    type: string
    sql: ${TABLE}.SCMatrix ;;
  }

  dimension: supplier_name {
    type: string
    sql: ${TABLE}.supplierName ;;
    hidden: yes
  }









  dimension: average_cost_price {
    type: number
    sql: ${TABLE}.AverageCostPrice ;;
    hidden: yes
  }


  measure: total_bridgwater_dc_stock {
    label: "Total DC Stock (Bridgwater)"
    group_item_label: "Bridgwater DC"
    type: sum
    sql: ${bridgwater_dc_stock} ;;
  }
  measure: total_daventry_dc_stock {
    label: "Total DC Stock (Daventry)"
    group_item_label: "Daventry DC"
    type: sum
    sql: ${daventry_dc_stock} ;;
  }
  measure: total_middleton_dc_stock {
    label: "Total DC Stock (Middleton)"
    group_item_label: "Middleton DC"
    type: sum
    sql: ${middleton_dc_stock} ;;
  }
  measure: total_redditch_dc_stock {
    label: "Total DC Stock (Redditch)"
    group_item_label: "Redditch DC"
    type: sum
    sql: ${redditch_dc_stock} ;;
  }
  measure: total_tpl_dc_stock {
    label: "Total DC Stock (TPL)"
    group_item_label: "TPL DC"
    type: sum
    sql: ${tpl_dc_stock} ;;
  }
  measure: total_r_dc_stock {
    label: "Total DC Stock (R)"
    group_item_label: "R DC"
    type: sum
    sql: ${r_dc_stock} ;;
  }




  measure: total_bridgwater_usage {
    label: "Total Usage (Bridgwater)"
    group_item_label: "Bridgwater DC"
    type: sum
    sql: ${bridgwater_usage} ;;
  }
  measure: total_daventry_usage {
    label: "Total Usage (Daventry)"
    group_item_label: "Daventry DC"
    type: sum
    sql: ${daventry_usage} ;;
  }
  measure: total_middleton_usage {
    label: "Total Usage (Middleton)"
    group_item_label: "Middleton DC"
    type: sum
    sql: ${middleton_usage} ;;
  }
  measure: total_redditch_usage {
    label: "Total Usage (Redditch)"
    group_item_label: "Redditch DC"
    type: sum
    sql: ${redditch_usage} ;;
  }
  measure: total_tpl_usage {
    label: "Total Usage (TPL)"
    group_item_label: "TPL DC"
    type: sum
    sql: ${tpl_usage} ;;
  }


  measure: total_bridgwater_branch_stock {
    label: "Total Usage (Bridgwater)"
    group_item_label: "Bridgwater DC"
    type: sum
    sql: ${bridgwater_branch_stock} ;;
  }
  measure: total_daventry_branch_stock {
    label: "Total Usage (Daventry)"
    group_item_label: "Daventry DC"
    type: sum
    sql: ${daventry_branch_stock} ;;
  }
  measure: total_middleton_branch_stock {
    label: "Total Usage (Middleton)"
    group_item_label: "Middleton DC"
    type: sum
    sql: ${middleton_branch_stock} ;;
  }
  measure: total_redditch_branch_stock {
    label: "Total Usage (Redditch)"
    group_item_label: "Redditch DC"
    type: sum
    sql: ${redditch_branch_stock} ;;
  }





  measure: total_bridgwater_branch_target {
    label: "Total Target (Bridgwater)"
    group_item_label: "Bridgwater DC"
    type: sum
    sql: ${bridgwater_branch_target} ;;
  }
  measure: total_daventry_branch_target {
    label: "Total Target (Daventry)"
    group_item_label: "Daventry DC"
    type: sum
    sql: ${daventry_branch_target} ;;
  }
  measure: total_middleton_branch_target {
    label: "Total Target (Middleton)"
    group_item_label: "Middleton DC"
    type: sum
    sql: ${middleton_branch_target} ;;
  }
  measure: total_redditch_branch_target {
    label: "Total Target (Redditch)"
    group_item_label: "Redditch DC"
    type: sum
    sql: ${redditch_branch_target} ;;
  }





  measure: total_bridgwater_branch_replen {
    label: "Total Replenishment (Bridgwater)"
    group_item_label: "Bridgwater DC"
    type: sum
    sql: ${bridgwater_branch_target} ;;
  }
  measure: total_daventry_branch_replen {
    label: "Total Replenishment (Daventry)"
    group_item_label: "Daventry DC"
    type: sum
    sql: ${daventry_branch_target} ;;
  }
  measure: total_middleton_branch_replen {
    label: "Total Replenishment (Middleton)"
    group_item_label: "Middleton DC"
    type: sum
    sql: ${middleton_branch_target} ;;
  }
  measure: total_redditch_branch_replen {
    label: "Total Replenishment (Redditch)"
    group_item_label: "Redditch DC"
    type: sum
    sql: ${redditch_branch_target} ;;
  }















  dimension: bridgwater_dc_stock {
    type: number
    sql: ${TABLE}.BridgwaterDCStock ;;
    hidden: yes
  }
  dimension: daventry_dc_stock {
    type: number
    sql: ${TABLE}.DaventryDCStock ;;
    hidden: yes
  }
  dimension: middleton_dc_stock {
    type: number
    sql: ${TABLE}.MiddletonDCStock ;;
    hidden: yes
  }
  dimension: redditch_dc_stock {
    type: number
    sql: ${TABLE}.RedditchDCStock ;;
    hidden: yes
  }
  dimension: tpl_dc_stock {
    type: number
    sql: ${TABLE}.TPLDCStock ;;
    hidden: yes
  }
  dimension: r_dc_stock {
    type: number
    sql: ${TABLE}.RDCStock ;;
    hidden: yes
  }

  dimension: bridgwater_usage {
    type: number
    sql: ${TABLE}.BridgwaterUsage ;;
    hidden: yes
  }
  dimension: daventry_usage {
    type: number
    sql: ${TABLE}.DaventryUsage ;;
    hidden: yes
  }
  dimension: middleton_usage {
    type: number
    sql: ${TABLE}.MiddletonUsage ;;
    hidden: yes
  }

  dimension: redditch_usage {
    type: number
    sql: ${TABLE}.RedditchUsage ;;
    hidden: yes
  }

  dimension: tpl_usage {
    type: number
    sql: ${TABLE}.TPLUsage ;;
    hidden: yes
  }



















  dimension: bridgwater_branch_stock {
    type: number
    sql: ${TABLE}.BridgwaterBranchStock ;;
    hidden: yes
  }

  dimension: daventry_branch_stock {
    type: number
    sql: ${TABLE}.DaventryBranchStock ;;
    hidden: yes
  }

  dimension: middleton_branch_stock {
    type: number
    sql: ${TABLE}.middletonbranchstock ;;
    hidden: yes
  }

  dimension: redditch_branch_stock {
    type: number
    sql: ${TABLE}.RedditchBranchStock ;;
    hidden: yes
  }


  dimension: bridgwater_branch_target {
    type: number
    sql: ${TABLE}.BridgwaterBranchTarget ;;
  }
  dimension: daventry_branch_target {
    type: number
    sql: ${TABLE}.DaventryBranchTarget ;;
  }
  dimension: middleton_branch_target {
    type: number
    sql: ${TABLE}.MiddletonBranchTarget ;;
  }

  dimension: redditch_branch_target {
    type: number
    sql: ${TABLE}.RedditchBranchTarget ;;
  }



  dimension: bridgwater_branch_replen {
    type: number
    sql: ${TABLE}.BridgwaterBranchreplen ;;
  }
  dimension: daventry_branch_replen {
    type: number
    sql: ${TABLE}.DaventryBranchreplen ;;
  }
  dimension: middleton_branch_replen {
    type: number
    sql: ${TABLE}.MiddletonBranchreplen ;;
  }
  dimension: redditch_branch_replen {
    type: number
    sql: ${TABLE}.RedditchBranchreplen ;;
  }




  dimension: rdcdownstreamneed {
    type: number
    sql: ${TABLE}.RDCDownstreamneed ;;
  }


  dimension: bridgwaterbranchusage {
    type: number
    sql: ${TABLE}.bridgwaterbranchusage ;;
  }

  dimension: daventrybranchusage {
    type: number
    sql: ${TABLE}.Daventrybranchusage ;;
  }
  dimension: middletonbranchusage {
    type: number
    sql: ${TABLE}.middletonbranchusage ;;
  }
  dimension: redditchbranchusage {
    type: number
    sql: ${TABLE}.Redditchbranchusage ;;
  }



  dimension: bridgwaterbranchoos {
    type: number
    sql: ${TABLE}.bridgwaterbranchoos ;;
  }
  dimension: daventrybranch_oos {
    type: number
    sql: ${TABLE}.DaventrybranchOOS ;;
  }
  dimension: middletonbranch_oos {
    type: number
    sql: ${TABLE}.middletonbranchOOS ;;
  }
  dimension: redditchbranch_oos {
    type: number
    sql: ${TABLE}.RedditchbranchOOS ;;
  }



  dimension: bridgwaterbranchtrait {
    type: number
    sql: ${TABLE}.bridgwaterbranchtrait ;;
  }
  dimension: daventrybranchtrait {
    type: number
    sql: ${TABLE}.Daventrybranchtrait ;;
  }
  dimension: middletonbranchtrait {
    type: number
    sql: ${TABLE}.middletonbranchtrait ;;
  }
  dimension: redditchbranch_trait {
    type: number
    sql: ${TABLE}.RedditchbranchTrait ;;
  }


  dimension: bridgwater_po {
    type: string
    sql: ${TABLE}.BridgwaterPO ;;
  }
  dimension: daventry_po {
    type: string
    sql: ${TABLE}.DaventryPO ;;
  }
  dimension: middleton_po {
    type: string
    sql: ${TABLE}.MiddletonPO ;;
  }
  dimension: redditch_po {
    type: string
    sql: ${TABLE}.RedditchPO ;;
  }




  # dimension_group: bridgwaterexpected {
  #   type: time
  #   timeframes: [
  #     raw,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.Bridgwaterexpected ;;
  # }

  # dimension_group: daventryexpected {
  #   type: time
  #   timeframes: [
  #     raw,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.Daventryexpected ;;
  # }

  # dimension_group: middletonexpected {
  #   type: time
  #   timeframes: [
  #     raw,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.Middletonexpected ;;
  # }

  # dimension_group: redditchexpected {
  #   type: time
  #   timeframes: [
  #     raw,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.Redditchexpected ;;
  # }




  dimension: bridgwater_on_order {
    type: number
    sql: ${TABLE}.bridgwaterOnOrder ;;
  }
  dimension: daventry_on_order {
    type: number
    sql: ${TABLE}.daventryOnOrder ;;
  }
  dimension: middleton_on_order {
    type: number
    sql: ${TABLE}.middletonOnOrder ;;
  }
  dimension: redditch_on_order {
    type: number
    sql: ${TABLE}.redditchOnOrder ;;
  }



  dimension: total_on_order {
    type: number
    sql: ${TABLE}.totalOnOrder ;;
  }

  dimension: total_rdc_stock_vs_downstream_need {
    type: number
    sql: ${TABLE}.Total_RDC_Stock_Vs_Downstream_Need ;;
  }















}
