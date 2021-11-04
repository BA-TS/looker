include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Digital"

explore: digital_product_conversion {
  label: "Product Conversion (DIGITAL)"
  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${digital_product_conversion.ga_sku}=${products.product_code} ;;
  }
}
