view: product_detail {
  sql_table_name: `toolstation-data-storage.range.productDetail`;;

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: ean {
    group_label: "Product Details"
    label: "Product EAN(s)"
    type: string
    sql: ${TABLE}.EAN ;;
  }

  dimension: enrating {
    group_label: "Product Details"
    label: "EN Rating"
    type: string
    sql: ${TABLE}.ENRating ;;
  }

  dimension: hazard_code {
   group_label: "Product Details"
    type: string
    sql: ${TABLE}.hazardCode ;;
  }

  dimension: includes_batteries {
    group_label: "Product Details"
    type: yesno
    sql: ${TABLE}.includesBatteries = 1 ;;
  }

  dimension: intrastat {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.intrastat ;;
  }

  dimension: manufacturer_id {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.manufacturerID ;;
  }

  dimension: mpc {
    group_label: "Product Details"
    label:"MPC"
    type: string
    sql: ${TABLE}.MPC ;;
  }

  dimension: pack_size {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.packSize ;;
  }

  dimension: product_review_rating {
    group_label: "Product Details"
    type: number
    sql: ${TABLE}.productReviewRating ;;
  }

  dimension: risk_code {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.riskCode ;;
  }

  dimension: zero_vatrated {
    group_label: "Product Details"
    label: "Zero Vat Rated"
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
