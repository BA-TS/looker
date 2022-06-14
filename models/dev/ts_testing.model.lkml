include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Development"






explore: cltv_orders {
  label: "orders"
  required_access_grants: [is_super]
  join:  cltv_customers{
    type: inner
    relationship: many_to_one
    sql_on: ${cltv_orders.CUSTOMERUID}=${cltv_customers.CUSTOMERUID}

          ;;

  }

}










explore: base {

  label: "DEVELOPER - Retail Pricing"

  required_access_grants: [is_super]

  sql_always_where: ${period_over_period} ;;

  join: retail_price_history {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${retail_price_history.price_start_date} ;;
  }

  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${retail_price_history.product_uid} = ${products.product_uid} ;;
  }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
  }

}



explore: products {

  required_access_grants: [is_developer]

  label: "DEVELOPER - Suppliers"

  always_join: [suppliers]

  join: aac {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_level_date_site_product.opening_stock_date} = ${aac.date} and ${stock_level_date_site_product.product_uid} = ${aac.product_uid} ;;
  }
  join: stock_level_date_site_product {
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

  # access_filter: {
  #   field: suppliers.supplier_uid
  #   user_attribute: ts_supplier_id
  # }

}



# explore: promo_table_design {
#   label: "DEVELOPER - Promo"
#   required_access_grants: [is_developer]

#   join: catalogue {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${promo_table_design.catalogue_id} = ${catalogue.catalogue_id} ;;
#   }

# }


# explore: catalogue {
#   required_access_grants: [is_developer]
#   always_join: [catalogue_promo]
#   join: catalogue_promo {
#     relationship: many_to_many
#     sql_on: ${catalogue.catalogue_id} = ${catalogue_promo.catalogue_id} ;;
#     type: cross
#   }
# }


# explore: publication_testing {
#   required_access_grants: [is_developer]}
explore: promo_table_design {
  required_access_grants: [is_developer]
}






explore: bq_daily_stock_data_history {
  required_access_grants: [is_developer]
  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${bq_daily_stock_data_history.product_uid} = ${products.product_uid} ;;
  }

  join: aac {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${bq_daily_stock_data_history.product_uid} = ${aac.product_uid} ;; # TBC - ${bq_daily_stock_data_history.active_from_date}= ${aac.date} and
  }
}





# explore: base {

#   extends: []
#   label: "DATE V2"
#   description: ""

#   conditionally_filter: {
#     filters: [
#       date_testing.select_date_type: "Calendar"
#     ]
#   }


#   sql_always_where:

#   ${period_over_period}

#     ;;


#     join: calendar_completed_date{
#       from:  calendar
#       view_label: "Date"
#       type:  inner
#       relationship:  many_to_one
#       sql_on: ${date_testing.date_testing_date_date}=${calendar_completed_date.date} ;;
#     }

#     join: catalogue {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${date_testing.date_testing_date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
#     }


# }
