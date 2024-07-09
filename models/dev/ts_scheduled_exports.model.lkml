include: "/views/prod/scheduled_queries/*.view.lkml"
include: "/models/backend/config.model"

label: "Scheduled Exports"

explore: weekly_new_stores_performance {
  required_access_grants: [is_advanced_super]
  label: "Weekly - New Stores Sales Performance"
  # hidden: yes
}

explore: Sage_Sales{
  required_access_grants: [is_advanced_super]
  label: "Daily - Sage Sales"
  # hidden: yes
}

explore: daily_transactions_incomplete {
  required_access_grants: [is_advanced_super]
  label: "Daily - Incomplete Transactions"
  # hidden: yes
}

explore: weekly_new_stores_sales {
  required_access_grants: [is_super]
  label: "Weekly - New Stores Sales"
  # hidden: yes
}

explore: TP_Lightside_Invoice_Data {
  required_access_grants: [is_advanced_super]
  label: "Daily - TP Lightside Invoice Data"
  # hidden: yes
}

explore: monthly_pendingOrders {
  required_access_grants: [is_advanced_super]
  label: "Monthly - Pending Orders"
  # hidden: yes
}
