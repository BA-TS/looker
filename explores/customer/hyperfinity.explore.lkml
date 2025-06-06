include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/site_budget.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/transactions.view"
include: "/views/**/customers.view"
include: "/views/**/behaviour_categories_monthly.view"
include:"/views/prod/department_specific/hyperfinity/*"

explore: hyperfinity {
  required_access_grants: [can_use_customer_information]
  view_name: base
  label: "Hyperfinity"

  conditionally_filter: {
    filters: [
      select_date_range: "Yesterday"
    ]
    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
      catalogue.catalogue_name,
      catalogue.extra_name,
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month
    ]
  }

  sql_always_where:${period_over_period} ;;


  fields: [
    ALL_FIELDS*,
    -calendar_completed_date.distinct_month_count,
    -calendar_completed_date.distinct_week_count,
    -calendar_completed_date.distinct_year_month_count,
    -calendar_completed_date.distinct_year_count,
    -catalogue*
  ]

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: behaviour_categories_monthly {
    # fields: [behaviour_categories_monthly.cluster_high_level,behaviour_categories_monthly.cluster_low_level,behaviour_categories_monthly.final_segment,behaviour_categories_monthly.final_segment_high_level,behaviour_categories_monthly.customerUID,behaviour_categories_monthly.run_date,behaviour_categories_monthly.run_date_end]
    view_label: "Hyperfinity"
    type: left_outer
    relationship: many_to_many
    sql_on: ${base.date_date} between ${behaviour_categories_monthly.run_date} and  ${behaviour_categories_monthly.run_date_end}
    ;;
  }

  join: behaviour_categories_monthly_most_recent {
    view_label: "Hyperfinity"
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_uid}=${behaviour_categories_monthly_most_recent.customerUID}
      and ${behaviour_categories_monthly_most_recent.run_date} = ${behaviour_categories_monthly.run_date};;
  }

  join: most_recent_run_by_period {
    view_label: "Hyperfinity"
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: many_to_one
    sql_on: ${most_recent_run_by_period.last_date_period} = ${base.base_date_date} ;;
  }

  join: customers {
    fields: [customers.customer_uid,customers.number_of_customers]
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: many_to_many
    sql_on: ${customers.customer_uid}=${behaviour_categories_monthly.customerUID};;
  }

  join: transactions {
    view_label: "Transactions"
    type: left_outer
    relationship: one_to_many
    fields: [transactions.aov_net_sales,transactions.number_of_transactions,transactions.transaction_date]
    sql_on:
        ${base.base_date_date} = ${transactions.transaction_date_filter};;
  }

}
