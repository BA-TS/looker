include: "/views/**/*.view"

# explore: sales_alert {
#   label: "Sales Alerts OLD"
# }

explore: sales_alerts { # sales_alert_v2
  required_access_grants: [is_developer, is_super]
  label: "Sales Alerts"
}
