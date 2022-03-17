persist_with: toolstation_core_datagroup
datagroup: toolstation_core_datagroup {
  sql_trigger:
        SELECT    MAX(log_timestamp)
        FROM      toolstation-data-storage.looker_persistent_tables.etl_log
        WHERE     datagroup_name = 'transactions';;
  max_cache_age: "24 hours"
}

datagroup: ts_googleanalytics_datagroup {
  sql_trigger: SELECT EXTRACT(month from CURRENT_DATE()) ;;
}

datagroup: ts_dev_datagroup {
  sql_trigger: SELECT EXTRACT(DAY FROM CURRENT_DATE())  ;;
}
