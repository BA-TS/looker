# include: "/custom_views/**/*.view"

#   view: trans_7_day_moving_avg_all {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#       }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       primary_key: yes
#       hidden: no
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#     ################################################################################

#     measure: total_net_sales_7day_avg_custom {
#       label: "Net Sales (7 day moving avg)"
#       group_label: "Sales Metrics (7 day moving avg)"
#       type: sum
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#       sql:  {% if trans_7_day_moving_avg_channel.sales_channel._is_selected
#                   and trans_7_day_moving_avg_department.department._is_selected
#                   and trans_7_day_moving_avg_site.site_name._is_selected %}              trans_7_day_moving_avg_channel_department_site.net_sales_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_department.department._is_selected %} trans_7_day_moving_avg_channel_department.net_sales_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_channel_site.net_sales_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_department_site.net_sales_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected %}     trans_7_day_moving_avg_channel.net_sales_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected %}     trans_7_day_moving_avg_department.net_sales_7day_avg
#               {% elsif  trans_7_day_moving_avg_site.site_name._is_selected %}            trans_7_day_moving_avg_site.net_sales_7day_avg
#               {% else %} trans_7_day_moving_avg_all.net_sales_7day_avg
#             {% endif %}  ;;
#     }

#     measure: total_margin_7day_avg_custom {
#       label: "Margin (7 day moving avg)"
#       group_label: "Sales Metrics (7 day moving avg)"
#       type: sum
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#       sql:  {% if trans_7_day_moving_avg_channel.sales_channel._is_selected
#                   and trans_7_day_moving_avg_department.department._is_selected
#                   and trans_7_day_moving_avg_site.site_name._is_selected %}              trans_7_day_moving_avg_channel_department_site.margin_incl_funding_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_department.department._is_selected %} trans_7_day_moving_avg_channel_department.margin_incl_funding_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_channel_site.margin_incl_funding_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_department_site.margin_incl_funding_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected %}     trans_7_day_moving_avg_channel.margin_incl_funding_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected %}     trans_7_day_moving_avg_department.margin_incl_funding_7day_avg
#               {% elsif  trans_7_day_moving_avg_site.site_name._is_selected %}            trans_7_day_moving_avg_site.margin_incl_funding_7day_avg
#               {% else %} trans_7_day_moving_avg_all.margin_incl_funding_7day_avg
#             {% endif %}  ;;
#     }

#     measure: total_transactions_7day_avg_custom {
#       label: "Transactions (7 day moving avg)"
#       group_label: "Sales Metrics (7 day moving avg)"
#       type: sum
#       value_format_name: decimal_0
#       sql:  {% if trans_7_day_moving_avg_channel.sales_channel._is_selected
#                   and trans_7_day_moving_avg_department.department._is_selected
#                   and trans_7_day_moving_avg_site.site_name._is_selected %}              trans_7_day_moving_avg_channel_department_site.transactions_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_department.department._is_selected %} trans_7_day_moving_avg_channel_department.transactions_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_channel_site.transactions_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_department_site.transactions_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected %}     trans_7_day_moving_avg_channel.transactions_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected %}     trans_7_day_moving_avg_department.transactions_7day_avg
#               {% elsif  trans_7_day_moving_avg_site.site_name._is_selected %}            trans_7_day_moving_avg_site.transactions_7day_avg
#               {% else %} trans_7_day_moving_avg_all.transactions_7day_avg
#             {% endif %}  ;;
#     }

#     measure: total_units_7day_avg_custom {
#       label: "Units (7 day moving avg)"
#       group_label: "Sales Metrics (7 day moving avg)"
#       type: sum
#       value_format_name: decimal_0
#       sql:  {% if trans_7_day_moving_avg_channel.sales_channel._is_selected
#                   and trans_7_day_moving_avg_department.department._is_selected
#                   and trans_7_day_moving_avg_site.site_name._is_selected %}              trans_7_day_moving_avg_channel_department_site.units_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_department.department._is_selected %} trans_7_day_moving_avg_channel_department.units_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_channel_site.units_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_department_site.units_7day_avg
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected %}     trans_7_day_moving_avg_channel.units_7day_avg
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected %}     trans_7_day_moving_avg_department.units_7day_avg
#               {% elsif  trans_7_day_moving_avg_site.site_name._is_selected %}            trans_7_day_moving_avg_site.units_7day_avg
#               {% else %} trans_7_day_moving_avg_all.units_7day_avg
#             {% endif %}  ;;
#     }

#     measure: net_aov_7day_avg_custom {
#       label: "Net AOV (7 day moving avg)"
#       group_label: "Sales Metrics (7 day moving avg)"
#       type: sum
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#       sql:  {% if trans_7_day_moving_avg_channel.sales_channel._is_selected
#                   and trans_7_day_moving_avg_department.department._is_selected
#                   and trans_7_day_moving_avg_site.site_name._is_selected %}              trans_7_day_moving_avg_channel_department_site.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_channel_department_site.units_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_department.department._is_selected %} trans_7_day_moving_avg_channel_department.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_channel_department.units_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_channel_site.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_channel_site.units_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_department_site.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_department_site.units_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected %}     trans_7_day_moving_avg_channel.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_channel.units_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected %}     trans_7_day_moving_avg_department.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_department.units_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_site.site_name._is_selected %}            trans_7_day_moving_avg_site.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_site.units_7day_avg,0)
#               {% else %} trans_7_day_moving_avg_all.net_sales_7day_avg / NULLIF(trans_7_day_moving_avg_all.units_7day_avg,0)
#             {% endif %}  ;;
#     }

#     measure: percent_margin_7day_avg_custom {
#       label: "Margin % (7 day moving avg)"
#       group_label: "Sales Metrics (7 day moving avg)"
#       type: sum
#       value_format_name: percent_2
#       sql:  {% if trans_7_day_moving_avg_channel.sales_channel._is_selected
#                   and trans_7_day_moving_avg_department.department._is_selected
#                   and trans_7_day_moving_avg_site.site_name._is_selected %}              trans_7_day_moving_avg_channel_department_site.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_channel_department_site.net_sales_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_department.department._is_selected %} trans_7_day_moving_avg_channel_department.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_channel_department.net_sales_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_channel_site.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_channel_site.net_sales_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_department_site.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_department_site.net_sales_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected %}     trans_7_day_moving_avg_channel.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_channel.net_sales_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected %}     trans_7_day_moving_avg_department.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_department.net_sales_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_site.site_name._is_selected %}            trans_7_day_moving_avg_site.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_site.net_sales_7day_avg,0)
#               {% else %} trans_7_day_moving_avg_all.margin_incl_funding_7day_avg / NULLIF(trans_7_day_moving_avg_all.net_sales_7day_avg,0)
#             {% endif %}  ;;
#     }

#     measure: units_per_trans_7day_avg_custom {
#       label: "Units / Transactions (7 day moving avg)"
#       group_label: "Sales Metrics (7 day moving avg)"
#       type: sum
#       value_format_name: decimal_2
#       sql:  {% if trans_7_day_moving_avg_channel.sales_channel._is_selected
#                   and trans_7_day_moving_avg_department.department._is_selected
#                   and trans_7_day_moving_avg_site.site_name._is_selected %}              trans_7_day_moving_avg_channel_department_site.units_7day_avg / NULLIF(trans_7_day_moving_avg_channel_department_site.transactions_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_department.department._is_selected %} trans_7_day_moving_avg_channel_department.units_7day_avg / NULLIF(trans_7_day_moving_avg_channel_department.transactions_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_channel_site.units_7day_avg / NULLIF(trans_7_day_moving_avg_channel_site.transactions_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected
#                         and trans_7_day_moving_avg_site.site_name._is_selected %}        trans_7_day_moving_avg_department_site.units_7day_avg / NULLIF(trans_7_day_moving_avg_department_site.transactions_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_channel.sales_channel._is_selected %}     trans_7_day_moving_avg_channel.units_7day_avg / NULLIF(trans_7_day_moving_avg_channel.transactions_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_department.department._is_selected %}     trans_7_day_moving_avg_department.units_7day_avg / NULLIF(trans_7_day_moving_avg_department.transactions_7day_avg,0)
#               {% elsif  trans_7_day_moving_avg_site.site_name._is_selected %}            trans_7_day_moving_avg_site.units_7day_avg / NULLIF(trans_7_day_moving_avg_site.transactions_7day_avg,0)
#               {% else %} trans_7_day_moving_avg_all.units_7day_avg / NULLIF(trans_7_day_moving_avg_all.transactions_7day_avg,0)
#             {% endif %}  ;;
#     }

#   }

#   view: trans_7_day_moving_avg_channel {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: sales_channel {}
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( PARTITION BY sales_channel ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( PARTITION BY sales_channel ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( PARTITION BY sales_channel ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( PARTITION BY sales_channel ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: channel_net_sales_budget { field: channel_budget.channel_net_sales_budget }
#         derived_column: channel_net_sales_budget_7day_avg {sql: AVG (channel_net_sales_budget) OVER ( PARTITION BY sales_channel ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     ##### Hide the dimensions from the PoP functionality so they don't appear multiple times #####
#     filter: current_date_range { hidden:yes}
#     filter: previous_date_range { hidden: yes}
#     parameter: compare_to { hidden: yes}
#     parameter: comparison_periods { hidden: yes}
#     dimension: period {hidden: yes}
#     dimension_group: date_in_period {hidden:yes}
#     dimension: day_in_period { hidden: yes}
#     ##############################################################################################

#     dimension: id {
#       primary_key: yes
#       hidden: yes
#       sql: CONCAT (${transaction_date},${sales_channel}) ;;
#     }
#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       hidden: yes
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }

#     dimension: sales_channel {}
#     # dimension: site_uid {}
#     # dimension: site_name {}
#     # dimension: department_uid {}
#     # dimension: department {}
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}
#     dimension: channel_net_sales_budget {hidden: yes}
#     dimension: channel_net_sales_budget_7day_avg {hidden: yes}
#     # dimension: department_net_sales_budget {hidden: yes}
#     # dimension: department_net_sales_budget_7day_avg {hidden: yes}
#     # dimension: site_net_sales_budget {hidden: yes}
#     # dimension: site_net_sales_budget_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: percent_units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#     ################################################################################
#     measure: total_channel_budget_7day_avg {
#       label: "Channel Budget 7 Day Avg"
#       group_label: "Budget"
#       type: sum
#       sql: {% if trans_7_day_moving_avg_department.department._is_selected %} NULL
#             {% elsif trans_7_day_moving_avg_site.site_name._is_selected %} NULL
#               {% else %} trans_7_day_moving_avg_channel.channel_net_sales_budget_7day_avg
#               {% endif %};;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
# }

#   view: trans_7_day_moving_avg_department {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: department_uid { field: products.department_uid }
#         column: department { field: products.department }
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( PARTITION BY department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( PARTITION BY department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( PARTITION BY department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( PARTITION BY department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: department_net_sales_budget { field: category_budget.department_net_sales_budget }
#         derived_column: department_net_sales_budget_7day_avg {sql: AVG (department_net_sales_budget) OVER ( PARTITION BY department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#       }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     ##### Hide the dimensions from the PoP functionality so they don't appear multiple times #####
#     filter: current_date_range { hidden:yes}
#     filter: previous_date_range { hidden: yes}
#     parameter: compare_to { hidden: yes}
#     parameter: comparison_periods { hidden: yes}
#     dimension: period {hidden: yes}
#     dimension_group: date_in_period {hidden:yes}
#     dimension: day_in_period { hidden: yes}
#     ###############################################################################################

#     dimension: id {
#       primary_key: yes
#       hidden: yes
#       sql: CONCAT (${transaction_date},${department_uid}) ;;
#     }
#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       hidden: yes
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }

#     dimension: department_uid {hidden:yes}
#     dimension: department {}
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}
#     dimension: department_net_sales_budget {hidden: yes}
#     dimension: department_net_sales_budget_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: percent_units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#     ################################################################################
#     measure: total_department_budget_7day_avg {
#       label: "Department Budget 7 Day Avg"
#       group_label: "Budget"
#       type: sum
#       sql: {% if trans_7_day_moving_avg_channel.sales_channel._is_selected %} NULL
#             {% elsif trans_7_day_moving_avg_site.site_name._is_selected %} NULL
#                 {% else %} trans_7_day_moving_avg_department.department_net_sales_budget_7day_avg
#                 {% endif %};;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
# }

#   view: trans_7_day_moving_avg_site {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: site_uid { field: sites.site_uid }
#         column: site_name { field: sites.site_name }
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( PARTITION BY site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( PARTITION BY site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( PARTITION BY site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( PARTITION BY site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         #column: site_net_sales_budget { field: site_budget.site_net_sales_budget }
#         #derived_column: site_net_sales_budget_7day_avg {sql: AVG (site_net_sales_budget) OVER ( PARTITION BY site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#       }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     ##### Hide the dimensions from the PoP functionality so they don't appear multiple times #####
#     filter: current_date_range { hidden:yes}
#     filter: previous_date_range { hidden: yes}
#     parameter: compare_to { hidden: yes}
#     parameter: comparison_periods { hidden: yes}
#     dimension: period {hidden: yes}
#     dimension_group: date_in_period {hidden:yes}
#     dimension: day_in_period { hidden: yes}
#     ##############################################################################################

#     dimension: id {
#       primary_key: yes
#       hidden: yes
#       sql: CONCAT (${transaction_date},${site_uid}) ;;
#     }
#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       hidden: yes
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }

#     dimension: site_uid {hidden:yes}
#     dimension: site_name {}
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}
#     # dimension: site_net_sales_budget {hidden: yes}
#     # dimension: site_net_sales_budget_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: percent_units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#     ################################################################################

#     ###!!!!!!!! COME BACK TO THIS ONCE SITE BUDGET IS SORTED !!!!!!

#     # measure: total_site_budget_7day_avg {
#     #   label: "Site Budget 7 Day Avg"
#     #   group_label: "Budget"
#     #   type: sum
#     #   sql: {% if trans_7_day_moving_avg_department.department._is_selected %} NULL
#     #         {% elsif trans_7_day_moving_avg_channel.sales_channel._is_selected %} NULL
#     #             {% else %} trans_7_day_moving_avg_site.site_net_sales_budget_7day_avg
#     #             {% endif %};;
#     #   value_format: "\£#,##0.00;(\£#,##0.00)"
#     # }
#   }

#   view: trans_7_day_moving_avg_channel_department {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: sales_channel {}
#         column: department_uid { field: products.department_uid }
#         column: department { field: products.department }
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( PARTITION BY sales_channel,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( PARTITION BY sales_channel,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( PARTITION BY sales_channel,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( PARTITION BY sales_channel,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#     }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     ##### Hide the dimensions from the PoP functionality so they don't appear multiple times #####
#     filter: current_date_range { hidden:yes}
#     filter: previous_date_range { hidden: yes}
#     parameter: compare_to { hidden: yes}
#     parameter: comparison_periods { hidden: yes}
#     dimension: period {hidden: yes}
#     dimension_group: date_in_period {hidden:yes}
#     dimension: day_in_period { hidden: yes}
#     ##############################################################################################

#     dimension: id {
#       primary_key: yes
#       hidden: yes
#       sql: CONCAT (${transaction_date},${sales_channel},${department_uid}) ;;
#     }
#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       hidden: yes
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }

#     dimension: sales_channel {hidden: yes}
#     dimension: department_uid {hidden: yes}
#     dimension: department {hidden: yes}
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: percent_units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#   }

#   view: trans_7_day_moving_avg_channel_site {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: sales_channel {}
#         column: site_uid { field: sites.site_uid }
#         column: site_name { field: sites.site_name }
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( PARTITION BY sales_channel,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( PARTITION BY sales_channel,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( PARTITION BY sales_channel,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( PARTITION BY sales_channel,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#       }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     ##### Hide the dimensions from the PoP functionality so they don't appear multiple times #####
#     filter: current_date_range { hidden:yes}
#     filter: previous_date_range { hidden: yes}
#     parameter: compare_to { hidden: yes}
#     parameter: comparison_periods { hidden: yes}
#     dimension: period {hidden: yes}
#     dimension_group: date_in_period {hidden:yes}
#     dimension: day_in_period { hidden: yes}
#     ##############################################################################################

#     dimension: id {
#       primary_key: yes
#       hidden: yes
#       sql: CONCAT (${transaction_date},${sales_channel},${site_uid}) ;;
#     }
#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       hidden: yes
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }

#     dimension: sales_channel {hidden: yes}
#     dimension: site_uid {hidden:yes}
#     dimension: site_name {hidden: yes}
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: percent_units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#   }

#   view: trans_7_day_moving_avg_department_site {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: site_uid { field: sites.site_uid }
#         column: site_name { field: sites.site_name }
#         column: department_uid { field: products.department_uid }
#         column: department { field: products.department }
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( PARTITION BY site_uid,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( PARTITION BY site_uid,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( PARTITION BY site_uid,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( PARTITION BY site_uid,department_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#       }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     ##### Hide the dimensions from the PoP functionality so they don't appear multiple times #####
#     filter: current_date_range { hidden:yes}
#     filter: previous_date_range { hidden: yes}
#     parameter: compare_to { hidden: yes}
#     parameter: comparison_periods { hidden: yes}
#     dimension: period {hidden: yes}
#     dimension_group: date_in_period {hidden:yes}
#     dimension: day_in_period { hidden: yes}
#     ##############################################################################################

#     dimension: id {
#       primary_key: yes
#       hidden: yes
#       sql: CONCAT (${transaction_date},${department_uid},${site_uid}) ;;
#     }
#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       hidden: yes
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }

#     dimension: site_uid {hidden: yes}
#     dimension: site_name {hidden: yes}
#     dimension: department_uid {hidden: yes}
#     dimension: department {hidden: yes}
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: percent_units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#   }

#   view: trans_7_day_moving_avg_channel_department_site {
#     derived_table: {
#       explore_source: transactions {
#         column: transaction_date {}
#         column: sales_channel {}
#         column: site_uid { field: sites.site_uid }
#         column: site_name { field: sites.site_name }
#         column: department_uid { field: products.department_uid }
#         column: department { field: products.department }
#         column: net_sales {field: transactions.total_net_sales}
#         derived_column: net_sales_7day_avg {sql: AVG (net_sales) OVER ( PARTITION BY sales_channel,department_uid,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: margin_incl_funding {field: transactions.total_margin_incl_funding}
#         derived_column: margin_incl_funding_7day_avg {sql: AVG (margin_incl_funding) OVER ( PARTITION BY sales_channel,department_uid,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: transactions {field: transactions.number_of_transactions}
#         derived_column: transactions_7day_avg {sql: AVG (transactions) OVER ( PARTITION BY sales_channel,department_uid,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         column: units {field: transactions.total_units}
#         derived_column: units_7day_avg {sql: AVG (units) OVER ( PARTITION BY sales_channel,department_uid,site_uid ORDER BY transaction_date ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;; }
#         }
#       datagroup_trigger: toolstation_transactions_datagroup
#     }

#     extends: [pop_date_comparison]

#     ##### Hide the dimensions from the PoP functionality so they don't appear multiple times #####
#     filter: current_date_range { hidden:yes}
#     filter: previous_date_range { hidden: yes}
#     parameter: compare_to { hidden: yes}
#     parameter: comparison_periods { hidden: yes}
#     dimension: period {hidden: yes}
#     dimension_group: date_in_period {hidden:yes}
#     dimension: day_in_period { hidden: yes}
#     ##############################################################################################

#     dimension: id {
#       primary_key: yes
#       hidden: yes
#       sql: CONCAT (${transaction_date},${sales_channel},${department_uid},${site_uid}) ;;
#     }
#     dimension: event_raw {
#       type: date_raw
#       sql: ${pop_transaction_raw} ;;
#       hidden: yes
#     }
#     dimension: transaction_date {
#       hidden: yes
#       type: date
#     }
#     dimension_group: pop_transaction {
#       type: time
#       hidden: yes
#       timeframes: [
#         raw]
#       sql: CAST( ${transaction_date} AS TIMESTAMP) ;;
#     }

#     dimension: sales_channel {hidden: yes}
#     dimension: site_uid {hidden: yes}
#     dimension: site_name {hidden: yes}
#     dimension: department_uid {hidden: yes}
#     dimension: department {hidden: yes}
#     dimension: net_sales {hidden: yes}
#     dimension: net_sales_7day_avg { hidden: yes}
#     dimension: margin_incl_funding {hidden: yes}
#     dimension: margin_incl_funding_7day_avg {hidden: yes}
#     dimension: transactions {hidden: yes}
#     dimension: transactions_7day_avg {hidden: yes}
#     dimension: units {hidden: yes}
#     dimension: units_7day_avg {hidden: yes}

#     ##### Can be un-hidden for Validation Purposes #####
#     measure: total_net_sales {
#       hidden: yes
#       type: sum
#       sql: ${net_sales} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_net_sales_7day_avg {
#       hidden: yes
#       type: sum
#       sql:  ${net_sales_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_margin_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${margin_incl_funding_7day_avg} ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: total_transactions_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${transactions_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: total_units_7day_avg {
#       hidden: yes
#       type: sum
#       sql: ${units_7day_avg} ;;
#       value_format_name: decimal_0
#     }
#     measure: net_aov_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_net_sales_7day_avg} / NULLIF(${total_units_7day_avg},0) ;;
#       value_format: "\£#,##0.00;(\£#,##0.00)"
#     }
#     measure: percent_margin_7day_avg {
#       hidden: yes
#       type: number
#       sql: 1.0 * ${total_margin_7day_avg} / NULLIF(${total_net_sales_7day_avg},0);;
#       value_format_name: percent_2
#     }
#     measure: percent_units_per_trans_7day_avg {
#       hidden: yes
#       type: number
#       sql: ${total_units_7day_avg} / NULLIF(${total_transactions_7day_avg},0) ;;
#       value_format_name: decimal_2
#     }
#   }

#   explore: trans_7_day_moving_avg_all {
#     label: "Sales - 7 Day Moving Averages"
#     view_label: "Sales - 7 Day Moving Averages"
#     persist_with: toolstation_transactions_datagroup
#     always_join: [trans_7_day_moving_avg_channel_department,trans_7_day_moving_avg_channel_site,trans_7_day_moving_avg_department_site,trans_7_day_moving_avg_channel_department_site]
#     sql_always_where:
#     {% if trans_7_day_moving_avg_all.current_date_range._is_filtered %}
#     {% condition trans_7_day_moving_avg_all.current_date_range %} ${event_raw} {% endcondition %}

#     {% if trans_7_day_moving_avg_all.previous_date_range._is_filtered or trans_7_day_moving_avg_all.compare_to._in_query %}
#     {% if trans_7_day_moving_avg_all.comparison_periods._parameter_value == "2" %}
#     or
#     ${event_raw} between ${period_2_start} and ${period_2_end}

#     {% elsif trans_7_day_moving_avg_all.comparison_periods._parameter_value == "3" %}
#     or
#     ${event_raw} between ${period_2_start} and ${period_2_end}
#     or
#     ${event_raw} between ${period_3_start} and ${period_3_end}

#     {% endif %}
#     {% else %} 1 = 1
#     {% endif %}
#     {% endif %};;

#     join: trans_7_day_moving_avg_channel {
#       view_label: "Sales - 7 Day Moving Averages"
#       type: left_outer
#       relationship: one_to_many
#       sql_on: ${trans_7_day_moving_avg_all.transaction_date} = ${trans_7_day_moving_avg_channel.transaction_date};;
#     }
#     join: trans_7_day_moving_avg_department {
#       view_label: "Sales - 7 Day Moving Averages"
#       type: left_outer
#       relationship: one_to_many
#       sql_on: ${trans_7_day_moving_avg_all.transaction_date} = ${trans_7_day_moving_avg_department.transaction_date};;
#     }
#     join: trans_7_day_moving_avg_site {
#       view_label: "Sales - 7 Day Moving Averages"
#       type: left_outer
#       relationship: one_to_many
#       sql_on: ${trans_7_day_moving_avg_all.transaction_date} = ${trans_7_day_moving_avg_site.transaction_date};;
#     }
#     join: trans_7_day_moving_avg_channel_department {
#       view_label: "Sales - 7 Day Moving Averages"
#       type: left_outer
#       relationship: one_to_many
#       sql_on: ${trans_7_day_moving_avg_channel_department.transaction_date} = ${trans_7_day_moving_avg_channel.transaction_date}
#               AND ${trans_7_day_moving_avg_channel_department.transaction_date} = ${trans_7_day_moving_avg_department.transaction_date}
#               AND ${trans_7_day_moving_avg_channel_department.department_uid} = ${trans_7_day_moving_avg_department.department_uid}
#               AND ${trans_7_day_moving_avg_channel_department.sales_channel} = ${trans_7_day_moving_avg_channel.sales_channel} ;;
#     }
#     join: trans_7_day_moving_avg_channel_site {
#       view_label: "Sales - 7 Day Moving Averages"
#       type: left_outer
#       relationship: one_to_many
#       sql_on: ${trans_7_day_moving_avg_channel_site.transaction_date} = ${trans_7_day_moving_avg_channel.transaction_date}
#               AND ${trans_7_day_moving_avg_channel_site.transaction_date} = ${trans_7_day_moving_avg_site.transaction_date}
#               AND ${trans_7_day_moving_avg_channel_site.site_uid} = ${trans_7_day_moving_avg_site.site_uid}
#               AND ${trans_7_day_moving_avg_channel_site.sales_channel} = ${trans_7_day_moving_avg_channel.sales_channel} ;;
#     }
#     join: trans_7_day_moving_avg_department_site {
#       view_label: "Sales - 7 Day Moving Averages"
#       type: left_outer
#       relationship: one_to_many
#       sql_on: ${trans_7_day_moving_avg_department_site.transaction_date} = ${trans_7_day_moving_avg_department.transaction_date}
#               AND ${trans_7_day_moving_avg_department_site.transaction_date} = ${trans_7_day_moving_avg_site.transaction_date}
#               AND ${trans_7_day_moving_avg_department_site.site_uid} = ${trans_7_day_moving_avg_site.site_uid}
#               AND ${trans_7_day_moving_avg_department_site.department_uid} = ${trans_7_day_moving_avg_department.department_uid} ;;
#     }
#     join: trans_7_day_moving_avg_channel_department_site {
#       view_label: "Sales - 7 Day Moving Averages"
#       type: left_outer
#       relationship: one_to_many
#       sql_on: ${trans_7_day_moving_avg_all.transaction_date} = ${trans_7_day_moving_avg_channel_department_site.transaction_date}
#               AND ${trans_7_day_moving_avg_channel_department_site.department_uid} = ${trans_7_day_moving_avg_department.department_uid}
#               AND ${trans_7_day_moving_avg_channel_department_site.sales_channel} = ${trans_7_day_moving_avg_channel.sales_channel}
#               AND ${trans_7_day_moving_avg_channel_department_site.site_uid} = ${trans_7_day_moving_avg_site.site_uid} ;;
#     }
#   }
