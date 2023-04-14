view: promoHistory{
  sql_table_name: `toolstation-data-storage.promotions.promoHistory`;;

  dimension: product_code {
    label: "1. Product Code"
    description: "SKU of the product"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: cycleID {
    label: "2. Cycle ID"
    description: ""
    type: string
    sql: ${TABLE}.cycleID ;;
  }

  dimension: financial_costPrice {
    group_label: "3. Financial"
    label: "Cost Price"
    description: "Cost price of the product"
    type: number
    sql: ${TABLE}.financial.costPrice ;;
  }

  dimension: financial_vatRate {
    group_label: "3. Financial"
    label: "VAT Rate"
    description: "VAT rate of the product"
    type: number
    sql: ${TABLE}.financial.vatRate ;;
  }

  dimension: financial_regularPrice {
    group_label: "3. Financial"
    label: "Regular Price"
    description: "Regular Price of the product"
    type: number
    sql: ${TABLE}.financial.vatRate ;;
  }

  dimension: financial_promoPrice {
    group_label: "3. Financial"
    label: "Promo Price"
    description: "Promo Price of the product"
    type: number
    sql: ${TABLE}.financial.vatRate ;;
  }

  dimension: retail_descriptionFOH {
    group_label: "4. Product Location"
    label: "Description FOH"
    description: ""
    type: string
    sql: ${TABLE}.retail.descriptionFOH ;;
  }

  dimension: retail_isAisleEnd {
    group_label: "4. Product Location"
    label: "AisleEnd"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isAisleEnd ;;
  }

  dimension: retail_isTrough {
    group_label: "4. Product Location"
    label: "Trough"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isTrough ;;
  }

  dimension: retail_isGrabBin {
    group_label: "4. Product Location"
    label: "GrabBin"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isGrabBin ;;
  }

  dimension: retail_isCounterTop {
    group_label: "4. Product Location"
    label: "CounterTop"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isCounterTop ;;
  }

  dimension: retail_isPoster {
    group_label: "4. Product Location"
    label: "Poster"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isGrabBin ;;
  }

  dimension: retail_isStand {
    group_label: "4. Product Location"
    label: "Stand"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isGrabBin ;;
  }

  dimension: retail_isDumpStack {
    group_label: "4. Product Location"
    label: "DumpStack"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isDumpStack ;;
  }

  dimension: retail_isFSDU {
    group_label: "4. Product Location"
    label: "FSDU"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isFSDU ;;
  }
}
