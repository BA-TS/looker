include: "/views/prod/scheduled_queries/*.view.lkml"
include: "/models/backend/config.model"

label: "Scheduled Exports"

explore: weekly_new_stores_performance {
  required_access_grants: [is_developer]
  label: "Weekly - New Stores Sales Performance"
  hidden: yes
}

explore: Sage_Sales{
  required_access_grants: [is_developer]
  label: "Daily - Sage Sales"
  hidden: yes
}

explore: daily_transactions_incomplete {
  required_access_grants: [is_developer]
  label: "Daily - Incomplete Transactions"
  hidden: yes
}

explore: weekly_new_stores_sales {
  required_access_grants: [is_developer]
  label: "Weekly - New Stores Sales"
  hidden: yes
}

explore: TP_Lightside_Invoice_Data {
  required_access_grants: [is_developer]
  label: "Daily - TP Lightside Invoice Data"
  hidden: yes
}

explore: monthly_pendingOrders {
  required_access_grants: [is_developer]
  label: "Monthly - Pending Orders"
  hidden: yes
}

# explore: daily_orders_placed_jnl {
#   required_access_grants: [is_developer]
#   label: "DAILY - Orders Placed JNL"
# }
