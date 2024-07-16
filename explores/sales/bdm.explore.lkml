include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/transactions.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/customers.view"
include: "/views/**/bdm_customers.view"
include: "/views/**/bdm_targets.view"
include: "/views/**/key_accounts_targets.view"
include: "/views/**/bdm_ledger.view"
include: "/views/**/key_accounts_ledger.view"
include: "/views/**/key_accounts_customers.view"
include: "/views/**/*customer_segmentation.view"
include: "/views/**/*trade_customers.view"
include: "/views/**/po_numbers.view"


persist_with: ts_transactions_datagroup

explore: bdm {
  required_access_grants: [lz_testing]
  view_name: base
  label: "BDM"
  always_filter: {
    filters: [
      select_date_reference: "Transaction"
    ]
  }

  conditionally_filter: {
    filters: [
      select_date_range: "this month"
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
      separate_month
    ]
  }

  fields: [
    ALL_FIELDS*,
    -catalogue.catalogue_live_date,
    -calendar_completed_date.distinct_month_count,
    -calendar_completed_date.distinct_week_count,
    -calendar_completed_date.distinct_year_month_count,
    -calendar_completed_date.distinct_year_count,
    -customers.opt_in_percent,
    -sites.number_of_DCs

  ]

  sql_always_where:${period_over_period};;

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.number_of_branches,transactions.total_net_sales,transactions.payment_type]
    sql_on: ${base.base_date_date} = ${transactions.transaction_date_filter};;
  }

  join: sites {
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }

  join: catalogue {
    view_label: "Catalogue"
    fields: [catalogue.catalogue_live_date]
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: bdm_customers {
    view_label: "BDM"
    type: left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_uid} = ${bdm_customers.customer_uid};;
  }

  join: bdm_targets {
    view_label: "Targets"
    type: left_outer
    relationship: many_to_one
    sql_on: ${bdm_targets.bdm} = ${bdm_customers.bdm} and ${bdm_targets.month}=${calendar_completed_date.calendar_year_month2};;
  }

  join: key_accounts_targets {
    view_label: "Targets"
    type: left_outer
    relationship: many_to_one
    sql_on: ${key_accounts_targets.bdm} = ${bdm_customers.bdm} and ${key_accounts_targets.month}=${calendar_completed_date.calendar_year_month2};;
  }

  join: bdm_ledger {
    view_label: "Ledger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${bdm_ledger.bdm} = ${bdm_customers.bdm} and ${bdm_ledger.customer_uid} = ${bdm_customers.customer_uid};;
  }

  # join: key_accounts_ledger {
  #   view_label: "Ledger"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${key_accounts_ledger.bdm} = ${bdm_customers.bdm} and ${key_accounts_ledger.customer_uid} = ${bdm_customers.customer_uid};;
  # }

  join: key_accounts_customers {
    view_label: "Key Accounts"
    type: left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_uid} = ${key_accounts_customers.customer_uid};;
  }

  join: po_numbers {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${po_numbers.order_id};;
  }

  join: customers {
    view_label: "Customers"
    type :  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid}=${customers.customer_uid} ;;
  }

  join: trade_customers {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  }


}
