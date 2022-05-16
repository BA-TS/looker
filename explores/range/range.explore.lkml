include: "/views/**/*.view"

explore: products {

  extends: []
  label: "Products"
  description: "Explore Toolstation product data."

  # always_filter: {
  #   filters: [
  #     isActive: "1"
  #   ]
  # }

  fields: [
    ALL_FIELDS*,
  ]

  join: suppliers {
    view_label: "Suppliers"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  }



}
