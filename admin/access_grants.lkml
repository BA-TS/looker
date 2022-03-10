# access_grant: can_use_transactions {
#   user_attribute: ts_permissions
#   allowed_values: ["TRANSACTIONS"]
# }
# access_grant: can_use_customers {
#   user_attribute: ts_permissions
#   allowed_values: ["CUSTOMERS"]
# }
access_grant: can_use_customer_information {
  user_attribute: ts_sensitive
  allowed_values: ["Y"]
}
access_grant: is_developer {
  user_attribute: ts_developer
  allowed_values: ["Y"]
}
access_grant: is_super {
  user_attribute: ts_super
  allowed_values: ["Y"]
}
access_grant: is_expert {
  user_attribute: ts_developer
  allowed_values: ["YS"] # always fail
}
