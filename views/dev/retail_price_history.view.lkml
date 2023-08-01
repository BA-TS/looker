view: retail_price_history {
 sql_table_name: `toolstation-data-storage.range.retailPriceHistory`;;

  dimension: price_uid {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.priceUID ;;
  }

  dimension: product_uid {
    type: string
    hidden: yes
    sql: ${TABLE}.productUID ;;
  }

  dimension: cert {
    type: number
    label: "Cert"
    group_label: "Retail Price History"
    sql: ${TABLE}.cert ;;
  }

  dimension_group: price_end {
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
    hidden: yes
    sql: ${TABLE}.priceEnd ;;
  }

  dimension: price_quantity {
    type: number
    hidden: yes
    sql: ${TABLE}.priceQuantity ;;
  }

  dimension_group: price_start {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.priceStart ;;
  }

  dimension: price_type {
    type: string
    label: "Price Type"
    group_label: "Retail Price History"
    sql: ${TABLE}.priceType ;;
  }

  #dimension: price_uid {
    #type: string
    #sql: ${TABLE}.priceUID ;;
  #}

  dimension: retail_price {
    type: number
    label: "Price"
    group_label: "Retail Price History"
    value_format_name: gbp
    sql: ${TABLE}.retailPrice ;;
  }

  dimension: last_retail_price {
    type: number
    hidden: yes
    label: "Last Price"
    group_label: "Retail Price History"
    value_format_name: gbp
    sql: max_by(${TABLE}.retailPrice,${price_start_date}) ;;
  }

  dimension: vat_rate {
    type: number
    label: "Vat Rate"
    group_label: "Retail Price History"
    sql: ${TABLE}.vatRate ;;
  }

  dimension: currentPrice {
    type: number
    label: "current price"
    sql: ${currentRetailPrice.retailBasePrice} ;;
  }

  measure: total_price_quantity {
    hidden: yes
    type: sum
    sql: ${price_quantity} ;;
  }

  measure: average_price_quantity {
    type: average
    hidden: yes
    sql: ${price_quantity} ;;
  }


  measure: average_retail_price {
    type: average
    label: "Avg Retail Price"
    group_label: "Retail Price History"
    value_format_name: gbp
    sql: ${retail_price} ;;
  }

  measure: var_retail_price {
    type: number
    label: "Var Retail Price"
    group_label: "Retail Price History"
    value_format: "0.####"
    sql: variance(${TABLE}.retailPrice) ;;
  }

  measure: variance_current_history_price{
    type: number
    label: "Variance Retail Price"
    group_label: "Retail Price History"
    sql:  ${currentPrice} - ${last_retail_price};;
  }

}
