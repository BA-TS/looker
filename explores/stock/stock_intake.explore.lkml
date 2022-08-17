include: "/views/**/*.view"

explore: stock_intake {

  required_access_grants: [is_super]

  sql_always_where:
  ${products.product_type} = "Real" AND ${scmatrix.is_active} = 1;;


  join: products {
    type:  inner
    relationship: many_to_one
    sql_on: ${stock_intake.product_uid}=${products.product_uid} ;;
  }


  join: scmatrix {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${scmatrix.product_code} ;;
  }


  join: sites {
    type:  inner
    relationship:  many_to_one
    sql_on: ${stock_intake.destination_site_uid}=${sites.site_uid} ;;
  }

  # join: distribution_centre_names {
  #   type:  left_outer
  #   relationship: many_to_one
  #   sql_on: ${stock_intake.destination_site_uid}=${distribution_centre_names.site_uid} ;;
  # }

  join: suppliers {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_intake.supplier_uid}=${suppliers.supplier_uid} ;;
  }

}
