
include: "/views/**/*.view"
# include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: app_web_data {
  required_access_grants: [is_super]
  label: "Digital_Report_WebApp"
  always_filter: {
    filters: [current_date_range: "6 months", compare_to: "Year" ]
  }

  join: total_sessions {
    type: inner
    relationship: many_to_one
    sql_on: ${app_web_data.App_web}=${total_sessions.app_web_sessions} and
    ${app_web_data.transactiondateTEST_date}=${total_sessions.date_date};;

  }

  join: dim_date {
    type: inner
    relationship: many_to_one
    sql_on: ${app_web_data.transactiondateTEST_date}=${dim_date.fullDateTEST_date} ;;
  }

  join: digital_budget {
    type: left_outer
    relationship: many_to_one
    sql_on: ${app_web_data.transactiondateTEST_date}=${digital_budget.Date_date} ;;
  }
}
