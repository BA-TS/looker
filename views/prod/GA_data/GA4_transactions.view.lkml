view: ga4_transactions {

  #dimension: P_K {
    #primary_key: yes
    #type: string
    #hidden: yes
    #sql: coalesce(concat(${OrderID},${ProductUID},${item_id},${TABLE}.Placed,${MarginIncFunding},${status},${ga4_rjagdev_test.PK}, cast(${offset} as string)),concat(${OrderID},${item_id},${ga4_rjagdev_test.PK},${ga4_quantity}, cast(${offset} as string))) ;;
  #}

    dimension: P_K {
    primary_key: yes
    type: string
    hidden: yes
    sql: concat(transaction_PK, coalesce(${ga4_rjagdev_test.session_id},"NONE"), coalesce(${ga4_rjagdev_test.Mintime},"NONE"),cast(${offset} as string)) ;;
  }

  dimension: offset {
    hidden: yes
    type: number
    sql: test1;;
  }

  dimension: OrderID {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Transaction ID"
    description: "Order ID of order where order was seen in GA4"
    type: string
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.OrderID end;;
  }

  dimension: customer {
    description: "customer"
    hidden: yes
    type: string
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.customer end;;
  }

  dimension: ProductUID {
    description: "ProductUID"
    type: string
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.ProductUID end;;
  }

  dimension: salesChannel {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Sales Channel"
    description: "SalesChannel"
    type: string
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.salesChannel end;;
  }

  dimension_group: placed {
    hidden: yes
    timeframes: [date]
    type: time
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.placed end ;;
  }

  dimension_group: placed_time{
    view_label: "Order Placed"
    group_label: "Time"
    label: ""
    type: time
    timeframes: [time_of_day]
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.placed end;;
  }

  dimension_group: placed_hour{
    view_label: "Order Placed"
    group_label: "Time"
    label: ""
    type: time
    timeframes: [hour_of_day]
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.placed end ;;
  }

  #dimension_group: transaction {
    #hidden: yes
    #timeframes: [date,time_of_day]
    #type: time
  #}

  dimension: NetSalePrice {
    type: number
    value_format_name: gbp
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.NetSalePrice end;;
  }

  dimension: net_value {
    type: number
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.net_value end ;;
  }

  dimension: gross_value {
    type: number
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.gross_value end;;
    #value_format_name: gbp
  }

  dimension: ga4_revenue {
    type: number
    hidden: yes
    value_format_name: gbp
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.ga4_revenue end;;
  }

  dimension: MarginIncFunding {
    type: number
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.MarginIncFunding end;;
    #value_format_name: gbp
  }

  dimension: MarginExclFunding {
    type: number
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.MarginExclFunding end;;
    #value_format_name: gbp
  }

  dimension: Quantity {
    type: number
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.Quantity end;;
  }

  dimension: ga4_quantity {
    type: number
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.ga4_quantity end;;
  }

  dimension: productCode {
    type: string
    hidden: yes
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.productCode end;;
  }

  dimension: status {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Order Status"
    type: string
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.status end;;
  }

  dimension: paymentType {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Payment Type"
    type: string
    sql: case when ${ga4_rjagdev_test.platform} in ("Web") and ${ga4_rjagdev_test.Screen_name} not in ("Review & Pay") then null else ${TABLE}.paymentType end;;
  }

  ##########Measures###############

  measure: Orders {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Orders"
    description: "Total orders seen in GA4"
    type: count_distinct
    sql: ${OrderID} ;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }

  measure: customers {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Total customers"
    #group_label: "Measures"
    type: count_distinct
    sql: coalesce(${customer},${ga4_rjagdev_test.User}) ;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }

  measure: sum_net_value {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Net Revenue"
    type: sum
    value_format_name: gbp
    sql: case when ${net_value} = 0 or ${net_value} is null then safe_divide(${ga4_revenue},1.2) else ${net_value} end;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }

  measure: ga4_rev {
    view_label: "GA4"
    group_label: "Transactional"
    label: "GA4 Revenue"
    type: sum
    value_format_name: gbp
    sql: ${ga4_revenue};;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }


  measure: gross_values {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Gross Revenue"
    type: sum
    value_format_name: gbp
    sql: case when ${gross_value} = 0 or ${gross_value} is null then ${ga4_revenue} else ${gross_value} end;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }

  measure: Sum_marginIncFund {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Inc Funding"
    type: sum
    value_format_name: gbp
    sql: ${MarginIncFunding} ;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }

  measure: Sum_marginExcFund {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Excl Funding"
    type: sum
    value_format_name: gbp
    sql: ${MarginExclFunding} ;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }

  measure: margin_rate_inc_funding {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Rate (Inc funding)"
    type: number
    value_format_name: percent_2
    sql: COALESCE(safe_divide(${Sum_marginIncFund},${sum_net_value}),null) ;;
  }

  measure: margin_rate_excl_funding {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Rate (Excl funding)"
    type: number
    value_format_name: percent_2
    sql: COALESCE(safe_divide(${Sum_marginExcFund},${sum_net_value}),null) ;;
  }

  measure: Sum_quantity {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Product Quantity"
    type: sum
    sql: ${Quantity} ;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?", productCode: "-00021"]
  }

  measure: Sum_GA4quantity {
    view_label: "GA4"
    group_label: "Total Measures"
    label: "Total Product Quantity"
    type: sum
    sql: ${ga4_quantity} ;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }


  measure: avg_netSalePrice {
    view_label: "GA4"
    group_label: "Transactional"
    #type: number
    label: "Net Sale Price"
    type: average
    value_format_name: gbp
    sql: ${NetSalePrice} ;;
    #filters: [ga4_rjagdev_test.Screen_name: "-Already Registered?"]
  }

  measure: aov_net_rev {
    view_label: "GA4"
    group_label: "Transactional"
    type: number
    label: "AOV (Net Rev)"
    value_format_name: gbp
    sql: SAFE_DIVIDE(${sum_net_value},${Orders}) ;;
  }

  measure: aov_gross_rev {
    view_label: "GA4"
    group_label: "Transactional"
    type: number
    label: "AOV (Gross Rev)"
    value_format_name: gbp
    sql: SAFE_DIVIDE(${gross_values},${Orders}) ;;
  }

  measure: avg_basket_size {
    view_label: "GA4"
    group_label: "Transactional"
    type: number
    label: "Avg Basket Size"
    value_format_name: decimal_2
    sql: SAFE_DIVIDE(${Sum_quantity},${Orders}) ;;
  }

  measure: collection_orders {
    view_label: "GA4"
    group_label: "Transactional"
    type: count_distinct
    label: "Collection Orders"
    sql: ${OrderID} ;;
    filters: [productCode: "00006, 00037"]
  }







}
