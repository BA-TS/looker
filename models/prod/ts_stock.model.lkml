include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Stock"

explore: stock_intake {
  join: products {
    type:  inner
    relationship: many_to_one
    sql_on: ${stock_intake.product_uid}=${products.product_uid} ;;
  }
  join: sites {
    type:  inner
    relationship:  many_to_one
    sql_on: ${stock_intake.destination_site_uid}=${sites.site_uid} ;;
  }
  join: disctribution_centre_names {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_intake.destination_site_uid}=${disctribution_centre_names.site_uid} ;;
  }
  join: suppliers {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_intake.supplier_uid}=${suppliers.supplier_uid} ;;
  }
}

explore: stock_level_date_site_product {

  label: "Stock Holding By Date, Site, Product"

  join: aac {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_level_date_site_product.opening_stock_date} = ${aac.date} and ${stock_level_date_site_product.product_uid} = ${aac.product_uid} ;;
  }
  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${stock_level_date_site_product.product_uid} = ${products.product_uid} ;;
  }
  join: suppliers {
    view_label: "Supplier"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  }

}
