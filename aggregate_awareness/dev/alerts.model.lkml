include: "/explores/dev/alerts/alerts.explore.lkml"

# explore: +sales_alert {

#     aggregate_table: daily_alerts {
#       query: {
#         dimensions: [date_date, sales_channel]
#         measures: [
#           net_sales,
#           net_sales_1w_change,
#           net_sales_1w_prior,
#           net_sales_1y_change,
#           net_sales_1y_prior,
#           net_sales_2w_change,
#           net_sales_2w_prior]
#         filters: [
#           sales_alert.1_week_deviation_parameter: "YES",
#           sales_alert.1_year_deviation_parameter: "YES",
#           sales_alert.2_week_deviation_parameter: "YES",
#           sales_alert.minimum_deviation: "0.05"
#         ]
#       }

#       materialization: {
#         datagroup_trigger: toolstation_transactions_datagroup
#       }
#     }

# }
