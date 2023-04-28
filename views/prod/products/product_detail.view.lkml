view: product_detail {
  sql_table_name: `toolstation-data-storage.range.productDetail`;;

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: ean {
    label: "Product EAN(s)"
    type: string
    sql: ${TABLE}.EAN ;;
  }

  dimension: enrating {
    type: string
    sql: ${TABLE}.ENRating ;;
  }

  dimension: hazard_code {
    type: string
    sql: ${TABLE}.hazardCode ;;
  }

  dimension: includes_batteries {
    type: yesno
    sql: ${TABLE}.includesBatteries = 1 ;;
  }

  dimension: intrastat {
    type: string
    sql: ${TABLE}.intrastat ;;
  }

  dimension: manufacturer_id {
    type: string
    sql: ${TABLE}.manufacturerID ;;
  }

  dimension: mpc {
    type: string
    sql: ${TABLE}.MPC ;;
  }

  dimension: pack_size {
    type: string
    sql: ${TABLE}.packSize ;;
  }

  dimension: product_review_rating {
    type: number
    sql: ${TABLE}.productReviewRating ;;
  }

  dimension: risk_code {
    type: string
    sql: ${TABLE}.riskCode ;;
  }

  dimension: zero_vatrated {
    type: yesno
    sql: ${TABLE}.ZeroVATRated = 1 ;;
  }

  # dimension: ebay_category {
  #   type: string
  #   sql: ${TABLE}.eBayCategory ;;
  # }

  # dimension: ebay_item_id {
  #   type: string
  #   sql: ${TABLE}.eBayItemID ;;
  # }
}
