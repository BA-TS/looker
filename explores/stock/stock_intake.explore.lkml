include: "/views/**/*.view"

explore: stock_intake {
  required_access_grants: [is_developer, is_super]
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
