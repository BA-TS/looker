include: "/views/**/*.view"

explore: stock_level_date_site_product {

  required_access_grants: [is_super]

  label: "Stock Holding"
  description: "By Date, Site, Product"

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

  join: dc_to_shop_mapping {
    type: left_outer
    relationship: many_to_one
    sql_on: ${stock_level_date_site_product.site_uid} = ${dc_to_shop_mapping.site_uid} ;;
  }

  join: distribution_centre_names {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dc_to_shop_mapping.distribution_centre_id} = ${distribution_centre_names.site_uid} ;;
  }

  join: sites {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dc_to_shop_mapping.site_uid} = ${sites.site_uid} ;;
  }

}
