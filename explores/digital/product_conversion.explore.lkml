include: "/models/backend/config.model"
include: "/views/**/*.view"


explore: digital_product_conversion {
  label: "Product Conversion"
  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${digital_product_conversion.ga_sku}=${products.product_code} ;;
  }
}
