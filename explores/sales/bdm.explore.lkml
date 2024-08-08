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
include: "/views/**/products.view"
include: "/views/**/targets.view"
include: "/views/**/bdm_ka_customers.view"
include: "/views/**/ledger.view"


# persist_with: ts_transactions_datagroup

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
      separate_month,
    ]
  }

  fields: [
    ALL_FIELDS*,
    -catalogue*,
    -customers*
  ]

  sql_always_where:${period_over_period};;

  join: calendar_completed_date{
    fields: [calendar_completed_date.date,calendar_completed_date.calendar_year,calendar_completed_date.calendar_year_month,calendar_completed_date.calendar_year_quarter]
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.number_of_branches,transactions.spc_net_sales,transactions.aov_net_sales,transactions.aov_units,transactions.total_margin_incl_funding,transactions.total_net_sales,transactions.payment_type,transactions.product_department,transactions.number_of_departments]
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
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  # join: bdm_customers {
  #   view_label: "Teams"
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${customers.customer_uid} = ${bdm_customers.customer_uid};;
  # }

  join: bdm_ka_customers {
    view_label: "Teams"
    type: left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_uid} = ${bdm_ka_customers.customer_uid};;
  }

  join: targets {
    view_label: "Targets"
    type: left_outer
    relationship: many_to_one
    sql_on: ${targets.bdm} = ${bdm_ka_customers.bdm} and ${targets.team} = ${bdm_ka_customers.team} and ${targets.month}=${calendar_completed_date.calendar_year_month2};;
  }

  # join: bdm_targets {
  #   view_label: "Teams"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${bdm_targets.bdm} = ${bdm_customers.bdm} and ${bdm_targets.month}=${calendar_completed_date.calendar_year_month2};;
  # }

  # join: key_accounts_targets {
  #   view_label: "Teams"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${key_accounts_targets.bdm} = ${key_accounts_customers.bdm} and ${key_accounts_targets.month}=${calendar_completed_date.calendar_year_month2};;
  # }

  join: ledger {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ledger.bdm} = ${bdm_ka_customers.bdm} and ${ledger.customer_uid} = ${bdm_ka_customers.customer_uid};;
  }

  # join: bdm_ledger {
  #   view_label: "Ledger"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${bdm_ledger.bdm} = ${bdm_ka_customers.bdm} and ${bdm_ledger.customer_uid} = ${bdm_ka_customers.customer_uid};;
  # }

  # join: key_accounts_ledger {
  #   view_label: "Ledger"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${key_accounts_ledger.bdm} = ${bdm_ka_customers.bdm} and ${key_accounts_ledger.customer_uid} = ${bdm_ka_customers.customer_uid};;
  # }

  # join: key_accounts_customers {
  #   view_label: "Teams"
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${customers.customer_uid} = ${bdm_ka_customers.customer_uid};;
  # }

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
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }

  join: trade_customers {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  }

  join: products {
    type:  left_outer
    relationship: many_to_one
    fields: [products.is_own_brand,products.description,products.product_code,products.product_name,products.subdepartment,products.brand]
    sql_on: ${transactions.product_uid}=${products.product_uid};;
  }

}
