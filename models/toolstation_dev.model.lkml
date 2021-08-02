connection: "toolstation"

# include all the views
include: "/views/**/*.view"

datagroup: toolstation_dev_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: toolstation_dev_default_datagroup

explore: transactions {}

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

