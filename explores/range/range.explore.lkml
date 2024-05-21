include: "/views/**/products.view"
include: "/views/**/suppliers.view"

explore: products {
  label: "Products"
  description: "Explore Toolstation product data."
  join: suppliers {
    view_label: "Suppliers"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  }
}
