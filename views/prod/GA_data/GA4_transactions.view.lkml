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
    value_format_name: gbp
  }

  dimension: gross_value {
    type: number
    value_format_name: gbp
  }

  dimension: ga4_revenue {
    type: number
    value_format_name: gbp
  }

  dimension: MarginIncFunding {
    type: number
    value_format_name: gbp
  }

  dimension: MarginExclFunding {
    type: number
    value_format_name: gbp
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

  measure: Orders {
    label: "Orders"
    type: count_distinct
    sql: ${OrderID} ;;
  }


}
