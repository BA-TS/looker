access_grant: can_use_transactions {
  user_attribute: ts_permissions
  allowed_values: ["TRANSACTIONS"]
}
access_grant: can_use_customers {
  user_attribute: ts_permissions
  allowed_values: ["CUSTOMERS"]
}
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
# access_grant: dev_00001 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV00001"]
# }

# access_grant: test {
#   user_attribute: dev_testing
#   allowed_values: ["B,C"]
# }

# access_grant: dev_00002 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00002"]
# }
# access_grant: dev_00003 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00003"]
# }
# access_grant: dev_00004 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00004"]
# }
# access_grant: dev_00005 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00005"]
# }
# access_grant: dev_00006 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00006"]
# }
# access_grant: dev_00007 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00007"]
# }
# access_grant: dev_00008 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00008"]
# }
# access_grant: dev_00009 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00009"]
# }
# access_grant: dev_00010 {
#   user_attribute: ts_permissions
#   allowed_values: ["DEV-00010"]
# }
