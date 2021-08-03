connection: "toolstation"

# include all the views
include: "/views/**/*.view"

datagroup: toolstation_dev_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: toolstation_dev_default_datagroup

explore: transactions {
  join: products {
    type:  inner
    relationship: many_to_one
    sql_on: ${transactions.product_uid}=${products.product_uid} ;;
  }
  join: customers {
    type :  inner
    relationship: many_to_one
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }
  join: suppliers {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  }
  join: sites {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }
  join: completed_date_calendar{
    from:  calendar
    type:  inner
    relationship:  many_to_one
    sql_on: date(${transactions.transaction_date})=${completed_date_calendar.date} ;;
  }
  join: placed_date_calendar{
    from:  calendar
    type:  inner
    relationship:  many_to_one
    sql_on: date(${transactions.placed_date})=${placed_date_calendar.date} ;;
  }
}

# explore: app_trolley_sales {}

# explore: braintree_payment_type {}

# explore: bundle_orders {}

# explore: click_collect_collection_times {}

# explore: customer_transactions_pending {}

# explore: record_sales_month_by_site {}

# explore: tmp_order_delays {}

# explore: transaction_deletions {}

# explore: transactions_incomplete {}

# explore: transactions_pending {}

# explore: transactions_tp {}
