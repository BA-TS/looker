view: promoHistory_Current{
  derived_table: {
  sql:with sub1 as (SELECT distinct date(inputtedBy.
  completedAt) as endDate, publication.catalogue.
  publicationName, productCode, cycleID,financial.costPrice,financial.vatRate, financial.regularPrice, financial.promoPrice,retail.descriptionFOH,retail.isAisleEnd,retail.isTrough,retail.isGrabBin,retail.isCounterTop, retail.isPoster, retail.isStand,retail.isDumpStack,retail.isFSDU
  FROM `toolstation-data-storage.promotions.promoHistory`
  union distinct
  SELECT distinct date(inputtedBy.
  completedAt) as endDate, publication.catalogue.
  publicationName, productCode, cycleID,financial.costPrice,financial.vatRate, financial.regularPrice, financial.promoPrice,retail.descriptionFOH,retail.isAisleEnd,retail.isTrough,retail.isGrabBin,retail.isCounterTop, retail.isPoster, retail.isStand,retail.isDumpStack,retail.isFSDU
  FROM `toolstation-data-storage.promotions.promoWorking` )
  select distinct row_number() over () as P_K, sub1.* from sub1;;
  datagroup_trigger: ts_weekly_datagroup
}

  dimension: P_K {
    description: "Primary Key"
    type: string
    sql: ${TABLE}.P_K ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_code {
    label: "1. Product Code"
    description: "SKU of the product"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: cycleID {
    label: "2. Cycle ID"
    type: string
    sql: ${TABLE}.cycleID ;;
  }

  dimension: catalogueName {
    description: "Catalogue Name"
    type: string
    hidden: yes
    sql: ${TABLE}.publicationName ;;
  }

  dimension: financial_costPrice {
    group_label: "3. Financial"
    label: "Cost Price"
    description: "Cost price of the product"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.costPrice ;;
  }

  dimension: financial_vatRate {
    group_label: "3. Financial"
    label: "VAT Rate"
    description: "VAT rate of the product"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.vatRate ;;
  }

  dimension: financial_regularPrice {
    group_label: "3. Financial"
    label: "Regular Price"
    description: "Regular Price of the product"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.regularPrice ;;
  }

  dimension: financial_promoPrice {
    group_label: "3. Financial"
    label: "Promo Price"
    description: "Promo Price of the product"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.promoPrice ;;
  }

  dimension: retail_descriptionFOH {
    group_label: "4. Product Location"
    label: "Description FOH"
    description: ""
    type: string
    sql: ${TABLE}.descriptionFOH ;;
  }

  dimension: retail_isAisleEnd {
    group_label: "4. Product Location"
    label: "AisleEnd"
    description: ""
    type: yesno
    sql: ${TABLE}.isAisleEnd ;;
  }

  dimension: retail_isTrough {
    group_label: "4. Product Location"
    label: "Trough"
    description: ""
    type: yesno
    sql: ${TABLE}.isTrough ;;
  }

  dimension: retail_isGrabBin {
    group_label: "4. Product Location"
    label: "GrabBin"
    description: ""
    type: yesno
    sql: ${TABLE}.isGrabBin ;;
  }

  dimension: retail_isCounterTop {
    group_label: "4. Product Location"
    label: "CounterTop"
    description: ""
    type: yesno
    sql: ${TABLE}.isCounterTop ;;
  }

  dimension: retail_isPoster {
    group_label: "4. Product Location"
    label: "Poster"
    description: ""
    type: yesno
    sql: ${TABLE}.isPoster ;;
  }

  dimension: retail_isStand {
    group_label: "4. Product Location"
    label: "Stand"
    description: ""
    type: yesno
    sql: ${TABLE}.retail.isStand ;;
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

  measure: avg_financial_costPrice {
    group_label: "Financial"
    label: "Avg Cost Price"
    description: "Cost price of the product"
    type: average
    value_format_name: gbp
    sql: ${TABLE}.costPrice ;;
  }

  measure: avg_financial_vatRate {
    group_label: "Financial"
    label: "Avg VAT Rate"
    description: "VAT rate of the product"
    type: average
    value_format_name: gbp
    sql: ${TABLE}.vatRate ;;
  }

  measure: avg_financial_regularPrice {
    group_label: "Financial"
    label: "Avg Regular Price"
    description: "Regular Price of the product"
    type: average
    value_format_name: gbp
    sql: ${TABLE}.regularPrice ;;
  }

  measure: avg_financial_promoPrice {
    group_label: "Financial"
    label: "Avg Promo Price"
    description: "Promo Price of the product"
    type: average
    value_format_name: gbp
    sql: ${TABLE}.promoPrice ;;
  }
}
