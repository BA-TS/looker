datagroup: ts_daily_datagroup {
  label: "TS - Daily Datagroup (Generic)"
  description: "Daily trigger for non-specific data processes."
  sql_trigger: SELECT    EXTRACT(DAY FROM CURRENT_DATE()) ;;
  max_cache_age: "24 hours"
}

datagroup: ts_weekly_datagroup {
  label: "TS - Weekly Datagroup (Generic)"
  description: "Weekly trigger for non-specific data processes."
  sql_trigger: SELECT    EXTRACT(DAYOFWEEK FROM CURRENT_DATE()) = 7 ;;
  max_cache_age: "168 hours"
}

datagroup: ts_monthly_datagroup {
  label: "TS - Monthly Datagroup (Generic)"
  description: "Monthly trigger for non-specific data processes."
  sql_trigger: SELECT    EXTRACT(MONTH FROM CURRENT_DATE()) ;;
}

datagroup: ts_googleanalytics_datagroup {
  sql_trigger: SELECT    EXTRACT(YEAR FROM CURRENT_DATE()) ;;
  max_cache_age: "24 hours"
}

# V2 #
datagroup: ts_transactions_datagroup {
  label: "TS Datagroup (Transaction)"
  description: "Datagroup trigger identified via Airflow: `transactions`"
  sql_trigger:
    SELECT     MAX(log_timestamp)
    FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
    WHERE      datagroup_name = "transactions";;
  max_cache_age: "24 hours"
}

datagroup: ts_customer_datagroup {
  label: "TS Datagroup (Customer)"
  description: "Datagroup trigger identified via Airflow: `customers`"
  sql_trigger:
    SELECT     MAX(log_timestamp)
    FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
    WHERE      datagroup_name = "customers";;
  max_cache_age: "24 hours"
}

datagroup: ts_range_datagroup {
  label: "TS Datagroup (Range)"
  description: "Datagroup trigger identified via Airflow: `products`"
  sql_trigger:
    SELECT     MAX(log_timestamp)
    FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
    WHERE      datagroup_name = "products";;
  max_cache_age: "24 hours"
}

datagroup: ts_location_datagroup {
  label: "TS Datagroup (Location)"
  description: "Datagroup trigger identified via Airflow: `sites`"
  sql_trigger:
    SELECT     MAX(log_timestamp)
    FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
    WHERE      datagroup_name = "sites";;
  max_cache_age: "24 hours"
}

datagroup: ts_stock_datagroup {
  label: "TS Datagroup (Stock)"
  description: "Datagroup trigger identified via Airflow: `stockLocation`"
  sql_trigger:
    SELECT     MAX(log_timestamp)
    FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
    WHERE      datagroup_name = "stockLocation";;
  max_cache_age: "24 hours"
}

# datagroup: ts_digital_datagroup {
#   label: "TS Datagroup (Digital)"
#   description: "Datagroup trigger identified via Airflow: `digital`"
#   sql_trigger:
#     SELECT     MAX(log_timestamp)
#     FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
#     WHERE      datagroup_name = "digital"
#   ;;
#   max_cache_age: "24 hours"
# }
# datagroup: ts_promotion_datagroup {
#   label: "TS Datagroup (Promotion)"
#   description: "Datagroup trigger identified via Airflow: `promotion`"
#   sql_trigger:
#     SELECT     MAX(log_timestamp)
#     FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
#     WHERE      datagroup_name = "promotion"
#   ;;
#   max_cache_age: "24 hours"
# }
# datagroup: ts_publication_datagroup {
#   label: "TS Datagroup (Publication)"
#   description: "Datagroup trigger identified via Airflow: `publication`"
#   sql_trigger:
#     SELECT     MAX(log_timestamp)
#     FROM       `toolstation-data-storage.looker_persistent_tables.etl_log`
#     WHERE      datagroup_name = "publication"
#   ;;
#   max_cache_age: "24 hours"
# }
