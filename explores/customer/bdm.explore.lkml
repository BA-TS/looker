include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/transactions.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/customers.view"
include: "/views/**/bdm_customers.view"
include: "/views/**/key_accounts_customers.view"
include: "/views/**/*customer_segmentation.view"
include: "/views/**/*trade_customers.view"


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
      select_date_range: "1 month ago for 1 month"
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
    -catalogue.catalogue_live_date
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
    fields: [transactions.refurb_pre_post,transactions.number_of_branches,transactions.total_net_sales]
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

  join: key_accounts_customers {
    view_label: "Key Accounts"
    type: left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_uid} = ${key_accounts_customers.customer_uid};;
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
