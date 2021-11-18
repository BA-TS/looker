connection: "toolstation"

persist_with: toolstation_transactions_datagroup
datagroup: toolstation_transactions_datagroup {
  sql_trigger:
        SELECT    MAX(log_timestamp)
        FROM      toolstation-data-storage.looker_persistent_tables.etl_log
        WHERE     datagroup_name = 'transactions';;
  max_cache_age: "22 hour"
}

week_start_day: sunday

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
  allowed_values: ["YS"]
}
access_grant: is_developer {
  user_attribute: ts_developer
  allowed_values: ["Y"]
}
access_grant: is_expert {
  user_attribute: ts_developer
  allowed_values: ["YS"] #always false
}
