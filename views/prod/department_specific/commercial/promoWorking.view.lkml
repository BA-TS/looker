view: promoworking {

   derived_table: {
     sql: SELECT distinct row_number() over () as P_K,publication.catalogue.publicationName,productCode,
cycleID, financial.costPrice,financial.regularPrice,financial.promoPrice, offer.type as offer_type

FROM `toolstation-data-storage.promotions.promoHistory`
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
    hidden: yes
    type: string
    sql: ${TABLE}.publicationName ;;
   }

  dimension: Product_Code {
    label: "Product Code"
    description: "Product Code"
    type: string
    hidden: yes
    sql: ${TABLE}.productCode ;;
  }

  dimension: cycleID {
    label: "cycleID"
    description: "cycleID"
    type: string
    hidden: yes
    sql: ${TABLE}.cycleID ;;
  }

  dimension: costPrice {
    label: "Cost Price"
    description: "costPrice"
    hidden: yes
    type: number
    value_format_name: gbp
    sql: ${TABLE}.costPrice ;;
  }

  dimension: regularPrice {

    group_label: "Pricing"
    view_label: "
        {% if _explore._name == 'GA4' %}
        {% else %}
        Products
        {% endif %}"
    label: "Regular Price"
    hidden: yes
    description: "Pricing when not on promo"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.regularPrice ;;
  }

  dimension: PromoPrice {
    view_label: "Products"
    group_label: "Current Retail Price"
    label: "Promo Price"
    description: "promoPrice"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.promoPrice ;;
  }

  dimension: offer_type {
    group_label: "Product Details"
    label: "Offer Type"
    type: string
    sql: ${TABLE}.offer_type ;;
  }

 }
