
include: "/views/**/*.view"
#include: "/views/prod/date/calendar.view.lkml"
#include: "/views/prod/date/period_over_period.view"
# include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

# explore: calendar {

#   extends: []
#   label: "Transactions"
#   description: "Explore Toolstation transactional data."
#   required_access_grants: [is_super]

#   always_filter: {
#     filters: [
#       select_date_type: "Calendar",
#       select_date_reference: "Transaction"
#     ]
#   }

#   conditionally_filter: {

#     filters: [
#       select_date_range: "Yesterday"
#     ]
#     unless: [
#       select_fixed_range,
#       dynamic_fiscal_year,
#       dynamic_fiscal_half,
#       dynamic_fiscal_quarter,
#       dynamic_fiscal_month,
#       dynamic_actual_year,
#       combined_week,
#       combined_month,
#       combined_quarter,
#       combined_year,
#       separate_month
#     ]

#   }

#   fields: [
#     ALL_FIELDS*

#   ]

#   sql_always_where:

#   ${period_over_period}

#         ;;


explore: app_web_data {
  required_access_grants: [is_super]
  label: "Digital_Report_WebApp"
  always_filter: {
  filters: [current_date_range: "6 months", compare_to: "Year" ]
}

join: calendar {
  type: inner
  relationship: one_to_many
  sql_on: ${app_web_data.transactiondateTEST_date}=${calendar.date};;
  #required_access_grants: [is_super]
  #label: "Digital_Report_WebApp"
  #always_filter: {
    #filters: [current_date_range: "6 months", compare_to: "Year" ]
  }

  join: total_sessions {
    type: inner
    relationship: many_to_one
    sql_on: ${app_web_data.App_web}=${total_sessions.app_web_sessions} and
    ${calendar.date}=${total_sessions.date_date};;

  }

  join: dim_date {
    type: inner
    relationship: one_to_one
    sql_on: ${calendar.date}=${dim_date.fullDateTEST_date} ;;
  }

  join: digital_budget {
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date}=${digital_budget.Date_date} ;;
  }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${calendar.date}=${calendar_completed_date.date} ;;
  }
}
