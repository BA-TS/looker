include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "Development"

explore: attached_products_derived {
}

# explore: competitor_matrix_history {
#   label: "DEV - Competitor Matrix"
#   required_access_grants: [is_developer]
#   sql_always_where: ${competitor_matrix_history.product_code_toolstation} IS NOT NULL ;;
#   always_filter: {
#     filters: [
#       competitor_matrix_history.load_date_date: "Yesterday"
#     ]
#   }
#   join: products {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${competitor_matrix_history.product_code_toolstation} = ${products.product_code} ;;
#   }
#   join: suppliers {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${products.default_supplier} = ${suppliers.supplier_uid} ;;
#   }
#   fields: [competitor_matrix_history*]
# }

# explore: base {
#   label: "DEVELOPER - Retail Pricing"
#   required_access_grants: [is_developer]
#   sql_always_where: ${period_over_period} ;;
#   join: retail_price_history {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${base.date_date} = ${retail_price_history.price_start_date} ;;
#   }
#   join: products {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${retail_price_history.product_uid} = ${products.product_uid} ;;
#   }
#   join: calendar_completed_date{
#     from:  calendar
#     view_label: "Date"
#     type:  inner
#     relationship:  many_to_one
#     sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
#   }
#   join: catalogue {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${base.date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
#   }
# }

# explore: products {
#   required_access_grants: [is_developer]
#   label: "DEVELOPER - Suppliers"
#   always_join: [suppliers]
#   join: aac {
#     type:  left_outer
#     relationship: many_to_one
#     sql_on: ${stock_level_date_site_product.opening_stock_date} = ${aac.date} and ${stock_level_date_site_product.product_uid} = ${aac.product_uid} ;;
#   }
#   join: stock_level_date_site_product {
#     type: inner
#     relationship: many_to_one
#     sql_on: ${stock_level_date_site_product.product_uid} = ${products.product_uid} ;;
#   }
#   join: suppliers {
#     view_label: "Supplier"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
#   }
# }

# explore: promo_table_design {
#   required_access_grants: [is_developer]
# }

# explore: bq_daily_stock_data_history {
#   required_access_grants: [is_developer]
#   join: products {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${bq_daily_stock_data_history.product_uid} = ${products.product_uid} ;;
#   }
#   join: aac {
#     type:  left_outer
#     relationship: many_to_one
#     sql_on: ${bq_daily_stock_data_history.product_uid} = ${aac.product_uid} ;; # TBC - ${bq_daily_stock_data_history.active_from_date}= ${aac.date} and
#   }
# }


# explore: lcm_history {
#   label: "Landed Cost Model"
#   required_access_grants: [is_developer]
#   join: products {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${lcm_history.product_uid} = ${products.product_uid} ;;
#   }
#   join: suppliers {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${lcm_history.supplier_uid} = ${suppliers.supplier_uid} ;;
#   }
# }

# explore: promoHistory {
#   label: "Promo History"
#   required_access_grants: [is_developer]
# }

# explore: cltv_orders {
#   label: "orders"
#   required_access_grants: [is_developer]
#   join:  cltv_customers{
#     type: inner
#     relationship: many_to_one
#     sql_on: ${cltv_orders.CUSTOMERUID}=${cltv_customers.CUSTOMERUID};;
#   }
# }
