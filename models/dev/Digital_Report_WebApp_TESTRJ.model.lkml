
include: "/views/**/*.view"
#include: "/views/prod/date/base_date_noCatalogue.view.lkml"
#include: "/views/prod/date/PoP.view.lkml"
include: "/views/prod/products/products.view.lkml"
#include: "/views/prod/date/calendar.view.lkml"
#include: "/views/prod/date/period_over_period.view"
# include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore: base {

  required_access_grants: [is_developer]
  extends: []
  label: "Transactions"
  description: "Explore Toolstation transactional data."

  always_filter: {
    filters: [
      select_date_type: "Calendar",
      select_date_reference: "transactiondateTEST"
    ]
  }

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
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month
    ]

  }

  fields: [
    ALL_FIELDS*
  ]

  sql_always_where:

  ${period_over_period}

        ;;

join: app_web_data {
  required_access_grants: [is_super]
  view_label: "Digital_Report_WebApp"
  type: left_outer
  relationship: many_to_one
  sql_on: ${base.date_date} = ${app_web_data.transaction_date_filter};;
  #always_filter: {
  #filters: [current_date_range: "6 months", compare_to: "Year" ]
}

join: calendar {
  type: inner
  relationship: one_to_many
  sql_on: ${base.date_date}=${calendar.date};;
  #required_access_grants: [is_super]
  #label: "Digital_Report_WebApp"
  #always_filter: {
    #filters: [current_date_range: "6 months", compare_to: "Year" ]
  }

  join: total_sessions {
    type: inner
    relationship: many_to_one
    sql_on: ${app_web_data.App_web}=${total_sessions.app_web_sessions} and
    ${base.date_date}=${total_sessions.date_date} and ${products.product_code}=${total_sessions.product_code};;

  }

  # join: dim_date {
  #   type: inner
  #   relationship: one_to_one
  #   sql_on: ${base.date_date}=${dim_date.Current_Date_date} ;;
  # }


  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }


  join: products {
    type: left_outer
    relationship: one_to_many
    sql_on: ${products.product_uid} = ${app_web_data.ProductUID};;
  }

  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
  }
}
