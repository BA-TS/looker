include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/site_budget.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/transactions.view"
include: "/views/**/customers.view"
include: "/views/**/behaviour_categories_monthly.view"
include:"/views/prod/department_specific/hyperfinity/*"
include: "/views/**/promo_orders.view"

explore: hyperfinity {

  view_name: base
  label: "Hyperfinity"

  conditionally_filter: {
    filters: [
      select_date_range: "2024-12",
      calendar_completed_date.previous_fiscal_week: "",
      most_recent_run_by_period.use_latest: "Yes",
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
    -catalogue*,
    -promo_orders*,
    -customers.is_trade,
    -transactions.has_trade_account,
    -transactions.is_new_product,
    -transactions.promo_in_any,
    -transactions.customer_cluster,
    -transactions.net_sales_non_trade_category,
    -transactions.days_before_refurb,
    -transactions.promo_in_extra,
    -transactions.is_closing,
    -transactions.is_new_product_previous_year,
    -transactions.is_new_product_current_year,
    -transactions.days_after_refurb,
    -transactions.net_sales_trade_category,
    -transactions.loyalty_club_net_sales,
    -transactions.promo_in_main_catalogue,
    -transactions.promoFlag,
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

  # join: behaviour_categories_monthly {
  #   view_label: "Hyperfinity"
  #   type: left_outer
  #   relationship: many_to_many
  #   sql_on: ${base.date_date} between ${behaviour_categories_monthly.run_date} and  ${behaviour_categories_monthly.run_date_end}
  #   ;;
  # }

  # join: behaviour_categories_monthly_most_recent {
  #   view_label: "Hyperfinity"
  #   type :  left_outer
  #   relationship: one_to_many
  #   sql_on: ${customers.customer_uid}=${behaviour_categories_monthly_most_recent.customerUID}
  #     and ${behaviour_categories_monthly_most_recent.run_date} = ${behaviour_categories_monthly.run_date};;
  # }

  join: most_recent_run_by_period {
    view_label: "Hyperfinity"
    type :  left_outer
    relationship: many_to_one
    sql_on: ${most_recent_run_by_period.last_date_period} = ${base.base_date_date} ;;
  }

  join: customers {
#     fields: [
#       -customers.is_trade
# ]
    type :  left_outer
    relationship: many_to_many
    sql_on: ${customers.customer_uid}=${looker_hyperfinity_customer_spending_roll_up.customer_uid};;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many
    # fields: [transactions.aov_net_sales,transactions.number_of_transactions,transactions.transaction_date,transactions.parent_order_uid,transactions.transaction_frequency,transactions.aov_units]
    sql_on:
        ${base.base_date_date} = ${transactions.transaction_date_filter};;
  }

# join: customers_with_transactions {
#   type: left_outer
#   relationship: one_to_many
#   sql_on:  ${customers_with_transactions.customer_uid} = ${customers.customer_uid};;
# }

  join: looker_hyperfinity_customer_spending_roll_up {
    required_access_grants: [can_use_customer_information2]
    view_label: "Hyperfinity"
    type :  left_outer
    relationship: many_to_many
    sql_on: ${looker_hyperfinity_customer_spending_roll_up.calendar_year_month} =${calendar_completed_date.calendar_year_month}
          ;;
  }

  join: promo_orders {
    view_label: "Orders using Promo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.transaction_uid} = ${promo_orders.order_id} and ${base.date_date} = ${promo_orders.date_date} ;;
  }


}
