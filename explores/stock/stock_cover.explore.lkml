include: "/views/**/*.view"

explore: stock_cover {

  required_access_grants: [is_super]

  label: "Stock Cover"
  description: "Still under development/QA, please contact Business Analytics."


  conditionally_filter: {
    filters: [
      stock_cover.date_filter: "Yesterday"
    ]
  }

  sql_always_where:

  {% condition stock_cover.date_filter %} TIMESTAMP(${date}) {% endcondition %}

  ;;

  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${stock_cover.product_code} = ${products.product_code} ;;
  }
  join: suppliers {
    view_label: "Supplier"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  }

  # join: dc_to_shop_mapping {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${stock_level_date_site_product.site_uid} = ${dc_to_shop_mapping.site_uid} ;;
  # }

  # join: distribution_centre_names {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${dc_to_shop_mapping.distribution_centre_id} = ${distribution_centre_names.site_uid} ;;
  # }

  # join: sites {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${stock_level_date_site_product.site_uid} = ${sites.site_uid} ;;
  # }

}
