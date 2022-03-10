include: "/views/**/*.view.lkml"                # include all views in the views/ folder in this project

label: "TS - Scheduled Exports"

explore: daily_orders_placed_jnl {
  required_access_grants: [is_developer]
  label: "DAILY - Orders Placed JNL"
}

explore: monthly_pendingOrders {
  required_access_grants: [is_developer]
  label: "Monthly - Pending Orders"
}


explore: weekly_new_stores_performance {
  required_access_grants: [is_developer]
  label: "Weekly - New Stores Sales Performance"
}


explore: weekly_new_stores_sales {
  required_access_grants: [is_developer]
  label: "Weekly - New Stores Sales"
}
