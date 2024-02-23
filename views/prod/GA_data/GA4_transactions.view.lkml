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
    sql: concat(${OrderID},${item_id},${ga4_rjagdev_test.PK},${ga4_quantity}, cast(${offset} as string)) ;;
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
  }

  dimension: customer {
    description: "customer"
    hidden: yes
    type: string
  }

  dimension: ProductUID {
    description: "ProductUID"
    type: string
    hidden: yes
  }

  dimension: salesChannel {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Sales Channel"
    description: "SalesChannel"
    type: string
  }

  dimension_group: placed {
    view_label: "GA4"
    group_label: "Order Placed"
    label: ""
    timeframes: [date]
    type: time
  }

  dimension_group: placed_time{
    view_label: "GA4"
    group_label: "Order Placed"
    label: ""
    type: time
    timeframes: [time_of_day]
    sql: ${TABLE}.placed ;;
  }

  dimension_group: transaction {
    hidden: yes
    timeframes: [date,time_of_day]
    type: time
  }

  dimension: NetSalePrice {
    type: number
    value_format_name: gbp
    hidden: yes
  }

  dimension: net_value {
    type: number
    hidden: yes
    #value_format_name: gbp
  }

  dimension: gross_value {
    type: number
    hidden: yes
    #value_format_name: gbp
  }

  dimension: ga4_revenue {
    type: number
    hidden: yes
    value_format_name: gbp
  }

  dimension: MarginIncFunding {
    type: number
    hidden: yes
    #value_format_name: gbp
  }

  dimension: MarginExclFunding {
    type: number
    hidden: yes
    #value_format_name: gbp
  }

  dimension: Quantity {
    type: number
    hidden: yes
  }

  dimension: ga4_quantity {
    type: number
    hidden: yes
  }

  dimension: item_id {
    type: string
    hidden: yes
  }

  dimension: status {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Order Status"
    type: string
  }

  dimension: paymentType {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Payment Type"
    type: string
  }

  ##########Measures###############

  measure: Orders {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Orders"
    description: "Total orders seen in GA4"
    type: count_distinct
    sql: ${OrderID} ;;
  }

  measure: customers {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Total customers"
    #group_label: "Measures"
    type: count_distinct
    sql: coalesce(${customer},${ga4_rjagdev_test.User}) ;;
  }

  measure: sum_net_value {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Net Revenue"
    type: sum
    value_format_name: gbp
    sql: case when ${net_value} is null or ${net_value} = 0 then (${ga4_revenue}*0.83333) else ${net_value} end;;
  }

  measure: ga4_rev {
    view_label: "GA4"
    group_label: "Transactional"
    label: "GA4 Revenue"
    type: sum
    value_format_name: gbp
    sql: ${ga4_revenue};;
  }

  measure: gross_values {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Gross Revenue"
    type: sum
    value_format_name: gbp
    sql: case when ${gross_value} is null or ${gross_value} = 0 then ${ga4_revenue} else ${gross_value} end ;;
  }

  measure: Sum_marginIncFund {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Inc Funding"
    type: sum
    value_format_name: gbp
    sql: ${MarginIncFunding} ;;
  }

  measure: Sum_marginExcFund {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Excl Funding"
    type: sum
    value_format_name: gbp
    sql: ${MarginExclFunding} ;;
  }

  measure: margin_rate_inc_funding {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Rate (Inc funding)"
    #value_format: "0.00%;(0.00%)"
    value_format_name: percent_2
    sql: COALESCE(safe_divide(${Sum_marginIncFund},${sum_net_value}),null) ;;
  }

  measure: margin_rate_excl_funding {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Margin Rate (Excl funding)"
    #value_format: "0.00%;(0.00%)"
    value_format_name: percent_2
    sql: COALESCE(safe_divide(${Sum_marginExcFund},${sum_net_value}),null) ;;
  }

  measure: Sum_quantity {
    view_label: "GA4"
    group_label: "Transactional"
    label: "Product Quantity"
    type: sum
    sql: ${Quantity} ;;
  }

  measure: Sum_GA4quantity {
    view_label: "GA4"
    group_label: "Total Measures"
    label: "Total Product Quantity"
    type: sum
    sql: ${ga4_quantity} ;;
  }


  measure: avg_netSalePrice {
    view_label: "GA4"
    group_label: "Transactional"
    #group_label: "Measures"
    label: "Net Sale Price"
    type: average
    value_format_name: gbp
    sql: ${NetSalePrice} ;;
  }

  measure: aov_net_rev {
    view_label: "GA4"
    group_label: "Transactional"
    #group_label: "Measures"
    label: "AOV (Net Rev)"
    value_format_name: gbp
    sql: SAFE_DIVIDE(${sum_net_value},${Orders}) ;;
  }

  measure: aov_gross_rev {
    view_label: "GA4"
    group_label: "Transactional"
    #group_label: "Measures"
    label: "AOV (Gross Rev)"
    value_format_name: gbp
    sql: SAFE_DIVIDE(${gross_values},${Orders}) ;;
  }




}
