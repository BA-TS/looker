include: "/views/**/stock_intake.view"
include: "/views/**/products.view"
include: "/views/**/scmatrix.view"
include: "/views/**/sites.view"
include: "/views/**/suppliers.view"
include: "/views/**/catPromo.view"
include: "/views/**/supply_chain/**.view"

explore: stock_intake {
  label: "Stock Intake"
  required_access_grants: [can_use_supplier_information]
  sql_always_where:
  ${products.product_type} = "Real" AND ${scmatrix.is_active} = 1
  and
  ${products.isActive};;

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

  join: suppliers {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_intake.supplier_uid}=${suppliers.supplier_uid} ;;
  }

  join: catPromo {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${catPromo.Product_Code} ;;
  }

  join: srs_mandatory_moves {
    view_label: "SRS Mandatory Moves"
    type: left_outer
    relationship: one_to_one
    sql_on: ${srs_mandatory_moves.site_uid} = ${sites.site_uid};;
  }

  join: stock_by_location_direct {
    relationship: one_to_one
    sql_on: ${stock_by_location_direct.site_uid} = ${sites.site_uid};;
  }

  join: stock_by_location_retail {
    relationship: one_to_one
    sql_on: ${stock_by_location_retail.site_uid} = ${sites.site_uid};;
  }

}
