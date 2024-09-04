include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/transactions.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/po_numbers.view"
include: "/views/**/products.view"
include: "/views/**/customer/**.view"
include: "/views/**/bdm/**.view"

persist_with: ts_transactions_datagroup

explore: bdm_test_customer {
  required_access_grants: [lz_testing]
  view_name: base
  label: "BDM Customer Test"
  always_filter: {
    filters: [
      select_date_reference: "Transaction"
    ]
  }

  conditionally_filter: {
    filters: [
      select_date_range: "this month",
      bdm_ka_customers.is_active: "Yes",
      bdm_ka_customers.team: "BDM",
      bdm_ka_customers.bdm: ""
    ]
    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month,
    ]
  }

  fields: [
    ALL_FIELDS*,
    -catalogue*,
  ]

  sql_always_where:${period_over_period};;

  join: calendar_completed_date{
    fields: [calendar_completed_date.date,calendar_completed_date.calendar_year,calendar_completed_date.calendar_year_month,calendar_completed_date.calendar_year_month2,calendar_completed_date.calendar_year_quarter]
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.number_of_branches,transactions.number_of_unique_products,transactions.number_of_transactions,transactions.spc_net_sales,transactions.aov_net_sales,transactions.aov_units,transactions.total_margin_incl_funding,transactions.total_net_sales,transactions.payment_type,transactions.product_department,transactions.number_of_departments]
    sql_on: ${base.base_date_date} = ${transactions.transaction_date_filter};;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: bdm_ka_customers {
    view_label: "Teams"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${bdm_ka_customers.customer_uid}=${transactions.customer_uid};;
  }

  join: targets {
    view_label: "Targets"
    type: left_outer
    relationship: many_to_one
    sql_on: ${targets.bdm} = ${bdm_ka_customers.bdm} and ${targets.team} = ${bdm_ka_customers.team} and ${targets.month}=${calendar_completed_date.calendar_year_month2};;
  }

  join: ledger {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ledger.bdm} = ${bdm_ka_customers.bdm} and ${ledger.customer_uid} = ${bdm_ka_customers.customer_uid};;
  }

  join: incremental_customer {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${base.date_date}=${incremental_customer.ty_date} and ${ledger.customer_uid} = ${incremental_customer.customer_uid} ;;
  }
}
