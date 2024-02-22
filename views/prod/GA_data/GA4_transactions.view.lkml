view: ga4_transactions {

  #dimension: P_K {
    #primary_key: yes
    #type: string
    #sql: concat(${ga4_rjagdev_test.PK},${item_id}) ;;
  #}

  dimension: OrderID {
    description: "OrderID"
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
  }

  dimension: salesChannel {
    description: "SalesChannel"
    type: string
  }

  dimension_group: placed {
    timeframes: [date,time_of_day]
    type: time
  }

  dimension_group: transaction {
    timeframes: [date,time_of_day]
    type: time
  }

  dimension: NetSalePrice {
    type: number
    value_format_name: gbp
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
    #value_format_name: gbp
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
  }

  dimension: status {
    type: string
  }

  dimension: payment_type {
    type: string
  }

  ##########Measures###############

  measure: Orders {
    label: "Orders"
    type: count_distinct
    sql: ${OrderID} ;;
  }

  measure: Customers {
    label: "Customers"
    type: count_distinct
    sql: ${customer} ;;
  }

  measure: sum_net_value {
    label: "Net Revenue"
    type: sum
    value_format_name: gbp
    sql: case when ${net_value} is null or ${net_value} = 0 then (${ga4_revenue}*0.83333) else ${net_value} end;;
  }

  measure: gross_values {
    label: "Gross Revenue"
    type: sum
    value_format_name: gbp
    sql: case when ${gross_value} is null or ${gross_value} = 0 then ${ga4_revenue} else ${gross_value} end ;;
  }

  measure: Sum_marginIncFund {
    label: "Margin Inc Funding"
    type: sum
    value_format_name: gbp
    sql: ${MarginIncFunding} ;;
  }

  measure: Sum_marginExcFund {
    label: "Margin Excl Funding"
    type: sum
    value_format_name: gbp
    sql: ${MarginExclFunding} ;;
  }

  measure: margin_rate_inc_funding {
    label: "Margin Rate (Inc funding)"
    value_format: "0.00%;(0.00%)"
    sql: COALESCE(safe_divide(${Sum_marginIncFund},${sum_net_value}),null) ;;
  }

  measure: margin_rate_excl_funding {
    label: "Margin Rate (Excl funding)"
    value_format: "0.00%;(0.00%)"
    sql: COALESCE(safe_divide(${Sum_marginExcFund},${sum_net_value}),null) ;;
  }

  measure: Sum_quantity {
    label: "Quantity"
    type: sum
    sql: ${Quantity} ;;
  }

  measure: Sum_GA4quantity {
    label: "GA4 Quantity"
    type: sum
    sql: ${ga4_quantity} ;;
  }


}
