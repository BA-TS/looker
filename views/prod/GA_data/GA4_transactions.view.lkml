view: ga4_transactions {

  dimension: P_K {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${OrderID},${customer},${ProductUID},${placed_date},${placed_time_of_day}) ;;
  }
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
  }

  dimension: ga4_quantity {
    type: number
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

  measure: net_value_hidden {
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


}
