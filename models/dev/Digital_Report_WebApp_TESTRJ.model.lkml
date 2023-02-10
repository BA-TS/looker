
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
  join: total_sessions {
    type: inner
    relationship: many_to_one
    sql_on: ${app_web_data.App_web}=${app_web_data.App_web} and
    ${app_web_data.transactiondate_date}=${total_sessions.date_date};;
  }
}
