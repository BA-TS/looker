include: "/views/**/ran_queries.view"

explore: ran_queries {
  label: "BigQuery Cost"
  description: "Explore for viewing BigQuery usage cost."
  required_access_grants: [is_advanced_super]

}

explore: +ran_queries {
  aggregate_table: rollup__run_start_date_date__run_start_hour__0 {
    query: {
      dimensions: [run_start_date_date, run_start_hour]
      measures: [total_cost_gbp]
    }

    materialization: {
      datagroup_trigger: ts_daily_datagroup
    }
  }

  aggregate_table: rollup__job_id_computed__run_start_date_date__user_group__1 {
    query: {
      dimensions: [job_id_computed, run_start_date_date, user_group]
      measures: [total_cost_gbp]
    }

    materialization: {
      datagroup_trigger: ts_daily_datagroup
    }
  }

  aggregate_table: rollup__run_start_date_date__2 {
    query: {
      dimensions: [run_start_date_date]
      measures: [total_cost_gbp]
      filters: [ran_queries.job_id_computed: "Data Studio"]
    }

    materialization: {
      datagroup_trigger: ts_daily_datagroup
    }
  }
}
