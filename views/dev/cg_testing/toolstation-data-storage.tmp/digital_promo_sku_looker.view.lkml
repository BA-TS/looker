# The name of this view in Looker is "Digital Promo SKU Looker"
view: digital_promo_sku_looker {

  sql_table_name: `toolstation-data-storage.digital.digital_promoSKU_looker`
    ;;

  dimension: department {
    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension_group: end {
    type: time
    description: "%d/%m/%E4Y"
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
    sql: ${TABLE}.End_date ;;
  }

  dimension: promo_type {
    type: string
    sql: ${TABLE}.Promo_type ;;
  }

  dimension: sku {
    type: string
    sql: CAST(${TABLE}.SKU AS STRING) ;;
  }

  dimension_group: start {
    type: time
    description: "%m/%d/%E4Y"
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
    sql: ${TABLE}.Start_Date ;;
  }

  dimension: subdepartment {
    type: string
    sql: ${TABLE}.Subdepartment ;;
  }

  dimension: week_cat {
    type: string
    sql: ${TABLE}.Week_Cat ;;
  }

}
