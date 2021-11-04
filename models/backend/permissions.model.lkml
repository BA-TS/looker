include: "/models/backend/config.model"

access_grant: can_use_transactions {
  user_attribute: ts_permissions
  allowed_values: ["TRANSACTIONS"]
}
access_grant: can_use_customers {
  user_attribute: ts_permissions
  allowed_values: ["CUSTOMERS"]
}
access_grant: can_use_customer_information {
  user_attribute: ts_sensitive # CG - consider wider group option of BU_sensitive flag (to propose)
  allowed_values: ["Y"]
}
access_grant: is_developer {
  user_attribute: ts_developer
  allowed_values: ["Y"]
}
access_grant: is_expert {
  user_attribute: ts_developer
  allowed_values: ["YS"]
}
