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
include: "/views/**/branch_department_availability.view"


explore: availability {
  required_access_grants: [lz_testing]
  view_name: base
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
    -transactions.payment_type,
    -transactions*
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
    fields: [catalogue.catalogue_live_date]
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: products {
    view_label: "Products"
    type:  left_outer
    relationship: many_to_one
    fields: [products.is_own_brand,products.description,products.product_code,products.product_name,products.subdepartment,products.brand,products.department]
    sql_on: ${transactions.product_uid}=${products.product_uid};;
  }

  join: branch_department_availability {
    view_label: "Branch Availability"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}= ${branch_department_availability.site_uid} and ${base.base_date_date} = ${branch_department_availability.availability_date} and ${products.department} = ${branch_department_availability.product_department};;
  }

}
