view: promoworking {

   derived_table: {
     sql: SELECT distinct row_number() over () as P_K,publication.catalogue.publicationName,productCode,
cycleID, financial.costPrice,financial.regularPrice,financial.promoPrice

FROM `toolstation-data-storage.promotions.promoWorking`
       ;;
   }

#   # Define your dimensions and measures here, like this:
   dimension: P_K {
    description: "Primary Key"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
   }

   dimension: publicationName {
    label: "Catalogue"
    description: "Catalogue"
    type: string
    sql: ${TABLE}.publicationName ;;
   }

  dimension: Product_Code {
    label: "Product Code"
    description: "Product Code"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: cycleID {
    label: "cycleID"
    description: "cycleID"
    type: string
    sql: ${TABLE}.cycleID ;;
  }

  dimension: costPrice {
    label: "Cost Price"
    description: "costPrice"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.costPrice ;;
  }

  dimension: regularPrice {
    label: "Regular Price"
    description: "regularPrice"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.regularPrice ;;
  }

  dimension: PromoPrice {
    label: "Promo Price"
    description: "promoPrice"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.promoPrice ;;
  }

 }
