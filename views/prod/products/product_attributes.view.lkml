view: product_attributes {
  sql_table_name: `toolstation-data-storage.range.productAttributes`;;

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: attribute {
    type: string
    sql: ${TABLE}.attribute ;;
  }

  dimension: attribute_value {
    type: string
    sql: ${TABLE}.attributeValue ;;
  }

  dimension_group: date_updated {
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
    sql: ${TABLE}.dateUpdated ;;
  }
}
