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
      separate_month,
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
    -sites.number_of_DCs,
    -calendar_completed_date.today_day_in_month,
    -calendar_completed_date.holiday_name,
    -calendar_completed_date.is_holiday,
    -calendar_completed_date.is_weekend,
    -calendar_completed_date.exclude_christmas_new_year,
    -calendar_completed_date.fiscal_year_week,
    -calendar_completed_date.fiscal_year,
    -calendar_completed_date.fiscal_week_of_year,
    -calendar_completed_date.fiscal_month_of_year,
    -calendar_completed_date.calendar_quarter,
    -calendar_completed_date.month_name_in_year,
    -calendar_completed_date.day_in_year,
    -calendar_completed_date.today_day_in_week,
    -calendar_completed_date.today_day_in_year,
    -calendar_completed_date.today_date,
    -calendar_completed_date.day_in_month,
    -calendar_completed_date.number_of_year,
    -calendar_completed_date.filter_on_field_to_hide
  ]

  sql_always_where:${period_over_period};;

  join: calendar_completed_date{
    # fields: [base.select_comparison_period,base.select_number_of_periods,base.select_date_range,base.select_fixed_range,base.select_date_reference,base.pivot_dimension,calendar_completed_date.date,calendar_completed_date.calendar_year,calendar_completed_date.calendar_year_month,calendar_completed_date.calendar_year_quarter]
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.number_of_branches,transactions.aov_net_sales,transactions.aov_units,transactions.total_margin_incl_funding,transactions.total_net_sales,transactions.payment_type,transactions.product_department,transactions.number_of_departments]
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
    sql_on: ${key_accounts_targets.bdm} = ${key_accounts_customers.bdm} and ${key_accounts_targets.month}=${calendar_completed_date.calendar_year_month2};;
  }

  join: bdm_ledger {
    view_label: "Ledger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${bdm_ledger.bdm} = ${bdm_customers.bdm} and ${bdm_ledger.customer_uid} = ${bdm_customers.customer_uid};;
  }

  join: key_accounts_ledger {
    view_label: "Ledger"
    type: left_outer
    relationship: many_to_one
    sql_on: ${key_accounts_ledger.bdm} = ${bdm_customers.bdm} and ${key_accounts_ledger.customer_uid} = ${bdm_customers.customer_uid};;
  }

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

  join: products {
    view_label: "Products"
    type:  left_outer
    relationship: many_to_one
    fields: [products.is_own_brand,products.description,products.product_code,products.product_name,products.subdepartment,products.brand]
    sql_on: ${transactions.product_uid}=${products.product_uid};;
  }

}
