include: "/models/backend/config.model"
include: "/views/prod/department_specific/data/ran_queries.view.lkml"

explore: ran_queries{
  label: "BigQuery Cost"
}
