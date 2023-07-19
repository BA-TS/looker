view: retail_price_history {
 sql_table_name: `toolstation-data-storage.range.retailPriceHistory`;;

  dimension: price_uid {
    type: string
    primary_key: yes
    #hidden: yes
    sql: ${TABLE}.priceUID ;;
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: cert {
    type: number
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
    sql: ${TABLE}.priceEnd ;;
  }

  dimension: price_quantity {
    type: number
    sql: ${TABLE}.priceQuantity ;;
  }

  dimension_group: price_start {
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
    sql: ${TABLE}.priceStart ;;
  }

  dimension: price_type {
    type: string
    sql: ${TABLE}.priceType ;;
  }

  #dimension: price_uid {
    #type: string
    #sql: ${TABLE}.priceUID ;;
  #}

  dimension: retail_price {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.retailPrice ;;
  }

  dimension: vat_rate {
    type: number
    sql: ${TABLE}.vatRate ;;
  }

  measure: total_price_quantity {
    type: sum
    sql: ${price_quantity} ;;
  }

  measure: average_price_quantity {
    type: average
    sql: ${price_quantity} ;;
  }

  measure: average_retail_price {
    type: average
    sql: ${retail_price} ;;
  }

  measure: var_retail_price {
    type: number
    value_format: "0.####"
    sql: variance(${TABLE}.retailPrice) ;;
  }
}
