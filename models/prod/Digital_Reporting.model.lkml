#connection: "toolstation"

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "/views/**/*.view"

explore: base {

  extends: []
  label: "digital_reporting"
  description: "Explore Toolstation transactional data."

  always_filter: {
    filters: [
      select_date_type: "Calendar",
      select_date_reference: "app^_web^_data"
    ]

  }

  conditionally_filter: {
    filters:
    [
      select_date_range: "21 days",
      total_sessions.session_date_filter: "21 days",
      stock_cover.date_filter: "Yesterday"
      ]

    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
      catalogue.catalogue_name,
      catalogue.extra_name,
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month,
      Mobile_app.Date_date
    ]

  }

  fields: [
    ALL_FIELDS*,
    -products.department
  ]

  sql_always_where:

  ${period_over_period}

        ;;

  join: digital_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${digital_budget.Date_date};;
  }

  # join: transactionsv2 {
  #   type: left_outer
  #   relationship: one_to_many

  #   sql_on:

  #       ${base.base_date_date} = ${transactionsv2.transaction_date_filter}

  #     ;;

  # }

  join: app_web_data {
    type: left_outer
    relationship: one_to_many
    sql_on:

    ${base.base_date_date} = ${app_web_data.transaction_date_filter} ;;
  }

  join: channel_budget {
    view_label: "Budget"
    type:  left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date}=${channel_budget.date_date} AND ${app_web_data.salesChannel} = ${channel_budget.channel}
      ;;
  }

  join: category_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date}=${category_budget.date} AND UPPER(${products.department}) = UPPER(${category_budget.department})
      ;;
  }

  # join: site_budget {
  #   view_label: "Budget"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on:
  #       ${base.date_date} = ${site_budget.date_date} AND ${transactionsv2.site_uid} = ${site_budget.site_uid}
  #     ;;
  # }

  join: products {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${app_web_data.ProductUID}=${products.product_uid}
      ;;
  }

  # join: sites {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.site_uid}=${sites.site_uid} ;;
  # }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  # join: customers {
  #   type :  inner
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.customer_uid}=${customers.customer_uid} ;;
  # }

  # join: suppliers {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  #   fields: [suppliers.master_supplier_name, suppliers.supplier_name, suppliers.supplier_uid, suppliers.supplier_planner, suppliers.sage_supplier_code]
  # }

  # join: customer_segmentation {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.customer_uid} = ${customer_segmentation.ucu_uid} ;;
  # }

  # join: trade_customers {
  #   type:  left_outer
  #   relationship: many_to_one
  #   sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  # }

  join: promo_main_catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.product_code} = ${promo_main_catalogue.product_code} and ${base.date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
  }

  # join: promo_extra {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.product_code} = ${promo_extra.product_code} and ${base.date_date} between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
  # }

  # join: single_line_transactions {
  #   type:  left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
  # }

  # join: product_first_sale_date {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.product_code} = ${product_first_sale_date.product_code} ;;
  # }

  # join: trade_credit_ids {

  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${customers.customer_uid} = ${trade_credit_ids.customer_uid} ;;

  # }

  # join: trade_credit_details {

  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${trade_credit_ids.main_trade_credit_account_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;

  # }

  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
  }

  join: Mobile_app {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} = ${Mobile_app.Date_date}
    and ${calendar_completed_date.date}=${Mobile_app.Date_date};;
  }

#  join: digital_transaction_mapping {
 #   type: left_outer
  #  relationship: one_to_one
   # sql_on: ${transactions.parent_order_uid} = ${digital_transaction_mapping.transaction_uid} ;;
  #}

  #join: backend_digital_channel_grouping {
   # type: left_outer
    #relationship: many_to_one
    #sql_on: ${digital_transaction_mapping.channel_grouping} = ${backend_digital_channel_grouping.channel_grouping} ;;
  #}

  join: total_sessions {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} = ${total_sessions.date_date}
    AND ${app_web_data.App_web} = ${total_sessions.app_web_sessions};;
  }

  join: stock_cover {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${stock_cover.product_code}
    and ${base.base_date_date} = ${stock_cover.stock_date_date};;
  }

}











explore: +base {

  extends: []
  label: "Summarised sales"
  description: "Explore Toolstation transactional data."

  always_filter: {
    filters: [
      select_date_type: "Calendar",
      select_date_reference: "summarised^_daily^_Sales"
    ]
  }


  conditionally_filter: {
    filters:
    [
      summarised_daily_Sales.dated_date: "21 days"
    ]

    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
      catalogue.catalogue_name,
      catalogue.extra_name,
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

  join: summarised_daily_Sales {
    view_label: "daily sales"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${summarised_daily_Sales.dated_date};;
  }

  join: digital_budget {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date}=${digital_budget.Date_date} ;;
  }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
  }

  join: dim_date {
    type: inner
    relationship: one_to_one
    sql_on: ${base.date_date}=${dim_date.Current_Date_date} ;;
  }

  join: total_sessions {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} = ${total_sessions.date_date}
      AND ${summarised_daily_Sales.App_Web} = ${total_sessions.app_web_sessions};;
  }

}





















# EXAMPLES #

# explore: +base {

#   query: department_weekly_sales {

#     label: "Weekly Sales (By Department)"
#     description: "This provides information to user."

#     dimensions: [
#       base.combined_week, transactions.product_department
#     ]
#     measures: [
#       transactions.total_net_sales
#     ]
#     filters: [
#       base.select_date_range: "28 days ago for 28 days"
#     ]
#     limit: 500
#     sorts: [
#       base.combined_week: desc,
#       transactions.product_department: asc
#     ]
#     pivots: [
#       base.date_date
#     ]

#   }

#   query: channel_weekly_sales {

#     label: "Weekly Sales (By Channel)"
#     description: "This provides information to user."

#     dimensions: [
#       base.combined_week, transactions.sales_channel
#     ]
#     measures: [
#       transactions.total_net_sales
#     ]
#     filters: [
#       base.select_date_range: "28 days ago for 28 days"
#     ]
#     limit: 500
#     sorts: [
#       base.combined_week: desc,
#       transactions.sales_channel: asc
#     ]
#     pivots: [
#       base.date_date
#     ]

#   }

#   query: department_daily_performance {

#     label: "7 Day Performance (By Department)"
#     description: "This provides information to user."

#     dimensions: [
#       base.date_date, transactions.product_department
#     ]
#     measures: [
#       transactions.total_net_sales,
#       transactions.total_margin_rate_incl_funding
#     ]
#     filters: [
#       base.select_date_range: "7 days ago for 7 days"
#     ]
#     limit: 500
#     sorts: [
#       base.date_date: desc,
#       transactions.product_department: asc,
#       transactions.total_net_sales: desc
#     ]
#     pivots: [
#       base.date_date
#     ]

#   }

#   query: previous_day_site_performance {

#     label: "Store Performance (PTD)"
#     description: "This provides information to user."

#     dimensions: [
#       sites.site_uid,
#       sites.site_name
#     ]
#     measures: [
#       transactions.total_net_sales,
#       transactions.total_margin_rate_incl_funding,
#       transactions.number_of_unique_customers,
#       transactions.number_of_transactions
#     ]
#     filters: [
#       base.select_fixed_range: "PD",
#       sites.site_name: "-Website"
#     ]
#     limit: 50
#     sorts: [
#       transactions.total_net_sales: desc
#     ]
#     pivots: [

#     ]

#   }

#   query: ptd_yoy_sales_performance {

#     label: "Sales Performance (PTD)"
#     description: "This provides information to user."

#     dimensions: [
#       base.dynamic_fiscal_year
#     ]
#     measures: [
#       transactions.total_net_sales,
#       transactions.total_margin_incl_funding,
#       transactions.total_margin_rate_incl_funding,
#       transactions.total_units
#     ]
#     filters: [
#       base.select_comparison_period: "Year",
#       base.select_fixed_range: "WTD",
#       base.select_number_of_periods: "3"
#     ]
#     limit: 50
#     sorts: [
#       base.dynamic_fiscal_year: desc,
#       transactions.total_net_sales: desc
#     ]
#     pivots: [

#     ]

#   }

#   query: product_performance {

#     label: "Top Performing Products (PTD)"
#     description: "This provides information to user."

#     dimensions: [
#       transactions.product_code,
#       products.description,
#       transactions.product_department,
#       products.subdepartment
#     ]
#     measures: [
#       transactions.total_net_sales,
#       transactions.margin_incl_funding,
#       transactions.total_margin_rate_incl_funding,
#       transactions.total_units,
#       transactions.number_of_transactions,
#       transactions.number_of_unique_customers
#     ]
#     filters: [
#       base.select_fixed_range: "PD"
#     ]
#     limit: 20
#     sorts: [
#       transactions.total_net_sales: desc,
#       transactions.total_margin_rate_incl_funding: desc
#     ]
#     pivots: [

#     ]

#   }

# }












































# AA #


# explore: +base {

#   # DAILY SALES #

#   aggregate_table: daily_sales_summary_DATE {
#     query: {
#       dimensions: [
#         date_date,
#         base.pivot_dimension,
#         base.__comparator_order__
#       ]
#       measures: [
#         total_budget.net_sales_budget,
#         category_budget.department_net_sales_budget,
#         transactions.aov_price,
#         transactions.total_margin_rate_incl_funding,
#         transactions.total_net_sales
#       ]
#       filters: [
#         base.select_comparison_period: "Year",
#         base.select_date_range: "45 days ago for 59 days",
#         base.select_number_of_periods: "3",
#         base.select_date_reference: "Transaction"
#       ]
#     }

#     materialization: {
#       datagroup_trigger: ts_transactions_datagroup
#     }

#   }

#   aggregate_table: daily_sales_summary_PD {
#     query: {
#       dimensions: [
#         date_date
#       ]
#       measures: [
#         total_budget.net_sales_budget,
#         category_budget.department_net_sales_budget,
#         transactions.aov_price,
#         transactions.aov_net_sales,
#         transactions.total_margin_rate_incl_funding,
#         transactions.total_net_sales
#       ]
#       filters: [
#         base.select_comparison_period: "Year",
#         base.select_fixed_range: "PD",
#         base.select_number_of_periods: "3",
#         base.select_date_reference: "Transaction"
#       ]
#     }

#     materialization: {
#       datagroup_trigger: ts_transactions_datagroup
#     }
#   }

#   aggregate_table: daily_sales_summary_WTD {
#     query: {
#       dimensions: [
#         date_date
#       ]
#       measures: [
#         category_budget.department_net_sales_budget,
#         transactions.aov_price,
#         transactions.total_margin_rate_incl_funding,
#         transactions.total_net_sales
#       ]
#       filters: [
#         base.select_comparison_period: "Year",
#         base.select_fixed_range: "WTD",
#         base.select_number_of_periods: "3",
#         base.select_date_reference: "Transaction"
#       ]
#     }

#     materialization: {
#       datagroup_trigger: ts_transactions_datagroup
#     }

#   }

#   aggregate_table: daily_sales_summary_MTD {
#     query: {
#       dimensions: [
#         date_date
#       ]
#       measures: [
#         category_budget.department_net_sales_budget,
#         transactions.aov_price,
#         transactions.total_margin_rate_incl_funding,
#         transactions.total_net_sales
#       ]
#       filters: [
#         base.select_comparison_period: "Year",
#         base.select_fixed_range: "MTD",
#         base.select_number_of_periods: "3",
#         base.select_date_reference: "Transaction"
#       ]
#     }

#     materialization: {
#       datagroup_trigger: ts_transactions_datagroup
#     }

#   }

#   aggregate_table: daily_sales_summary_YTD {
#     query: {
#       dimensions: [
#         date_date
#       ]
#       measures: [
#         category_budget.department_net_sales_budget,
#         transactions.aov_price,
#         transactions.total_margin_rate_incl_funding,
#         transactions.total_net_sales
#       ]
#       filters: [
#         base.select_comparison_period: "Year",
#         base.select_fixed_range: "YTD",
#         base.select_number_of_periods: "3",
#         base.select_date_reference: "Transaction"
#       ]
#     }

#     materialization: {
#       datagroup_trigger: ts_transactions_datagroup
#     }

#   }

# }

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
