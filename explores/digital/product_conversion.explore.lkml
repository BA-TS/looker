include: "/views/**/*.view"

explore: digital_product_conversion {
  label: "Product Conversion"
  sql_always_having:
    ${products.isActive} = "Yes" ;;
  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${digital_product_conversion.ga_sku}=${products.product_code} ;;
  }

  join: promoworking {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${promoworking.Product_Code} ;;
  }

}
