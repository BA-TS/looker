include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Sales"

include: "/explores/sales/*"
include: "/aggregate_awareness/sales/*"
include: "/dashboards/sales/daily_sales_report/*"

# explore: base {

#   # required_access_grants: [can_use_transactions]

#   extends: []
#   label: "Transactions"
#   description: ""

#   conditionally_filter: {
#     filters: [
#       base.select_date_range: "Yesterday"
#     ]
#     unless: [
#       select_fixed_range
#       ]
#   }

#   fields: [
#     ALL_FIELDS*,
#     -products.department
#   ]

#   sql_always_where:

#   ${period_over_period}

#     ;;

#     join: total_budget {
#       view_label: "Budget"
#       type: left_outer
#       relationship: one_to_one
#       sql_on: ${base.date_date} = ${total_budget.total_budget_date};;
#     }

#     join: transactions {
#       type: left_outer
#       relationship: one_to_many
#       sql_on:
#         ${base.base_date_date} = date(${transactions.transaction_date})
#         and (${transactions.is_cancelled} = 0 or ${transactions.is_cancelled} is null)
#         and (${transactions.product_code} <> '85699' or ${transactions.product_code} is null)
#         {% if
#           (category_budget._in_query and site_budget._in_query)
#           or (channel_budget._in_query and category_budget._in_query)  %}
#           MULTIPLE_BUDGETS_SELECTED
#         {% elsif (channel_budget._in_query and site_budget._in_query) %}
#           MULTIPLE_BUDGETS_SELECTED
#         {% elsif (channel_budget._in_query and site_budget._in_query and category_budget._in_query) %}
#           MULTIPLE_BUDGETS_SELECTED
#         {% elsif channel_budget._in_query %}
#           and ${transactions.sales_channel} is not null
#         {% elsif category_budget._in_query %}
#           and ${transactions.product_department} is not null
#         {% elsif site_budget._in_query %}
#           and ${transactions.site_uid} is not null
#         {% else %}
#           and (${transactions.sales_channel} is not null and ${transactions.site_uid} is not null and ${transactions.product_department} is not null)
#         {% endif %}



#       ;;
#       }

#     join: channel_budget {
#         view_label: "Budget"
#         type:  left_outer
#         relationship: many_to_one
#         sql_on:
#           ${base.base_date_date}=${channel_budget.date} and ${transactions.sales_channel} = ${channel_budget.channel}
#         ;;
#       }

#     join: category_budget {
#         view_label: "Budget"
#         type: left_outer
#         relationship: many_to_one
#         sql_on:
#           ${base.base_date_date}=${category_budget.date} and upper(${transactions.product_department}) = upper(${category_budget.department})
#           ;;
#     }

#   join: site_budget {
#     view_label: "Budget"
#     type: left_outer
#     relationship: many_to_one
#     sql_on:
#       ${base.base_date_date} = ${site_budget.date_date} and ${transactions.site_uid} = ${site_budget.site_uid}
#       ;;
#     }
#     join: products {
#       type:  left_outer
#       relationship: many_to_one
#       sql_on:
#               -- additional join if department budget fields are used
#               {% if
#                 category_budget.department_net_sales_budget._in_query
#                 or category_budget.department_margin_inc_Retro_funding_budget._in_query
#                 or category_budget.department_margin_inc_all_funding_budget._in_query
#                 or category_budget.department_margin_rate_inc_retro_funding_budget._in_query
#               %}
#                 (${transactions.product_uid}=${products.product_uid} or ${transactions.product_uid} is null)
#                 and upper(products.productDepartment) = upper(category_budget.department)
#               {% else %}
#               ${transactions.product_uid}=${products.product_uid}
#               {% endif %}
#       ;;
#     }


#     join: sites {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
#     }

#     join: calendar_completed_date{
#       from:  calendar
#       view_label: "Date"
#       type:  inner
#       relationship:  many_to_one
#       sql_on: ${base.base_date_date}=${calendar_completed_date.date} ;;
#     }

#     join: customers {
#       type :  inner
#       relationship: many_to_one
#       sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
#     }

#     join: suppliers {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
#       fields: [suppliers.master_supplier_name, suppliers.supplier_name, suppliers.supplier_uid, suppliers.supplier_planner, suppliers.sage_supplier_code]
#     }

#     join: customer_segmentation {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${transactions.customer_uid} = ${customer_segmentation.ucu_uid} ;;
#     }

#     join: trade_customers {
#       type:  left_outer
#       relationship: many_to_one
#       sql_on: ${customers.customer_uid} = ${trade_customers.customer_number} ;;
#     }
#     join: promo_main_catalogue {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${transactions.product_code} = ${promo_main_catalogue.product_code} and ${base.base_date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
#     }
#     join: promo_extra {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${transactions.product_code} = ${promo_extra.product_code} and ${base.base_date_date} between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
#     }
#     join: single_line_transactions {
#       type:  left_outer
#       relationship: many_to_one
#       sql_on: ${transactions.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
#     }
#     join: product_first_sale_date {
#       type: left_outer
#       relationship: many_to_one
#       sql_on: ${transactions.product_code} = ${product_first_sale_date.product_code} ;;
#     }
#   }

  # explore: +transactions {
  #   aggregate_table: aggtable-tdate {
  #     query: {
  #       dimensions: [transaction_date]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tdate_tchannel {
  #     query: {
  #       dimensions: [transaction_date, sales_channel]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tdate_tparentuid {
  #     query: {
  #       dimensions: [transaction_date, parent_order_uid]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tdate_ccustomeruid {
  #     query: {
  #       dimensions: [transaction_date, customers.customer_uid]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tdate_pcode {
  #     query: {
  #       dimensions: [transactions.transaction_date, products.product_code]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tdate_pcode_tdepartment_psubdepartment{
  #     query: {
  #       dimensions: [transaction_date, products.product_code,products.department, products.subdepartment]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tdate_s_siteuid {
  #     query: {
  #       dimensions: [transaction_date, sites.site_uid]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]

  #     }

  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tparentuid_ttransactionuid {
  #     query: {
  #       dimensions: [transactions.parent_order_uid, transactions.transaction_uid]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }

  #   aggregate_table: aggtable-dailysales_summary {

  #     query: {
  #       filters: [transactions.period_to_date: "YTD", transactions.previous_period_to_date: "LY2LY"]
  #       dimensions: [transactions.__target_year__, transactions.period_enabled_transaction_date]
  #       measures: [

  #       category_budget.department_net_sales_budget,
  #       total_net_sales,
  #       category_budget.department_margin_inc_all_funding_budget,
  #       category_budget.department_margin_inc_Retro_funding_budget,
  #       total_margin_rate_incl_funding,
  #       number_of_transactions,
  #       aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }

  #   aggregate_table: aggtable-dailysalesreport {
  #     query: {
  #       filters: []
  #       dimensions: [transactions.department_coalesce,products.product_code,sales_channel, products.description ,transactions.__target_year__, transactions.period_enabled_transaction_date]
  #       measures: [

  #         transactions.total_gross_sales,
  #         transactions.total_margin_excl_funding,
  #         transactions.total_margin_incl_funding,
  #         transactions.total_margin_rate_excl_funding,
  #         transactions.total_margin_rate_incl_funding,
  #         transactions.total_net_sales,
  #         transactions.number_of_unique_customers,
  #         transactions.number_of_transactions,
  #         transactions.total_cogs,
  #         transactions.total_unit_funding,
  #         transactions.total_units,
  #         transactions.total_units_incl_system_codes,
  #         transactions.aov_units,
  #         transactions.aov_units_incl_system_codes,
  #         transactions.aov_gross_sales,
  #         transactions.aov_margin_excl_funding,
  #         transactions.aov_margin_incl_funding,
  #         transactions.aov_price,
  #         transactions.aov_net_sales,
  #         category_budget.department_net_sales_budget

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  # }
  # }
