include: "/views/**/*.view"

explore: stock_cover {
  required_access_grants: [is_super]
  label: "Stock Cover"
  description: "Still under development/QA, please contact Business Analytics."
  hidden: yes
  conditionally_filter: {
    filters: [
      stock_cover.date_filter: "Yesterday"
    ]
  }
  sql_always_where:{% condition stock_cover.date_filter %} TIMESTAMP(${stock_cover.stock_date_date}) {% endcondition %} ;;
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
}
