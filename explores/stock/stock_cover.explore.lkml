include: "/views/**/*.view"

explore: stock_cover {
  required_access_grants: [is_super]
  label: "Stock Cover"
  description: "Still under development/QA, please contact Business Analytics."
  #hidden: yes

  always_filter: {
    filters: [products.isActive: "Yes"]
  }
  conditionally_filter: {
    filters: [
      stock_cover.date_filter: "Yesterday"
    ]

    unless: [new_products.date_date]
  }
  sql_always_where:{% condition stock_cover.date_filter %} (${stock_cover.stock_date_date}) {% endcondition %}
      --and ${products.isActive}
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

  join: aac {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_cover.stock_date_date} = ${aac.date} and ${products.product_uid} = ${aac.product_uid} ;;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: one_to_many
    sql_on: ${stock_cover.stock_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: promoworking {
    view_label: "Active Promotions"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${promoworking.Product_Code} ;;
  }

  join: new_products {
  view_label: "New Products"
  from: products
  type: left_outer
  relationship: one_to_many
  fields: [new_products.date_date,new_products.product_code,new_products.product_uid,new_products.product_status]
  sql_on: ${new_products.date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date}
  and ${stock_cover.product_code} = ${new_products.product_code};;
  sql_where: ${new_products.product_status} = "New" ;;

  }

}
