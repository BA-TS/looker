include: "/views/**/*.view"

explore: stock_soq {

  required_access_grants: [is_developer]

  label: "Stock SOQ"
  description: ""

  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${stock_soq.product_uid} = ${products.product_uid} ;;
  }

  join: dc_to_shop_mapping {
    type: left_outer
    relationship: many_to_one
    sql_on: ${stock_soq.site_uid} = ${dc_to_shop_mapping.site_uid} ;;
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
