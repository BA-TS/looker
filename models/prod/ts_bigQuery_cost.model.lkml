include: "/models/backend/config.model"
include: "/views/prod/department_specific/data/ran_queries.view.lkml"

explore: ran_queries{
  label: "BigQuery Cost"
  persist_with: ts_daily_datagroup
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
