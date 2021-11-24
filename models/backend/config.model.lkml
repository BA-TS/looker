include: "/admin/*"

connection: "toolstation"

persist_with: toolstation_transactions_datagroup
datagroup: toolstation_transactions_datagroup {
  sql_trigger:
        SELECT    MAX(log_timestamp)
        FROM      toolstation-data-storage.looker_persistent_tables.etl_log
        WHERE     datagroup_name = 'transactions';;
  max_cache_age: "22 hour"
}

datagroup: ts_googleanalytics_datagroup {
  sql_trigger: SELECT EXTRACT(month from CURRENT_DATE()) ;;
}

week_start_day: sunday
