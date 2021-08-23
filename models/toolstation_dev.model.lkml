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
  join: category_budget {
    type: left_outer
    relationship: many_to_one
    sql_on: date(${transactions.transaction_date})=${category_budget.date_date} and ${products.department}=${category_budget.department} ;;
  }

  # Exclude cancelled orders and the charity SKU
  sql_always_where: ${is_cancelled} = 0 and ${product_code} <> '85699' ;;
}

explore: stock_intake {
  join: products {
    type:  inner
    relationship: many_to_one
    sql_on: ${stock_intake.product_uid}=${products.product_uid} ;;
  }
  join: sites {
    type:  inner
    relationship:  many_to_one
    sql_on: ${stock_intake.destination_site_uid}=${sites.site_uid} ;;
  }
  join: disctribution_centre_names {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_intake.destination_site_uid}=${disctribution_centre_names.site_uid} ;;
  }
}
