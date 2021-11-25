include: "/explores/sales/transactions.explore.lkml"

explore: +base {

  # DAILY SALES #


  aggregate_table: daily_sales_summary_DATE {
    query: {
      dimensions: [
        date_date,
        base.pivot_dimension,
        base.order_for_period
      ]
      measures: [
        total_budget.net_sales_budget,
        category_budget.department_net_sales_budget,
        transactions.aov_price,
        transactions.number_of_unique_customers,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales
      ]
      filters: [
        base.select_comparison_period: "Year",
        base.select_date_range: "45 days ago for 59 days",
        base.select_number_of_periods: "3"
      ]
    }

    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }

  }

  aggregate_table: daily_sales_summary_PD {
    query: {
      dimensions: [
        date_date
      ]
      measures: [
        total_budget.net_sales_budget,
        category_budget.department_net_sales_budget,
        transactions.aov_price,
        transactions.number_of_unique_customers,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales
      ]
      filters: [
        base.select_comparison_period: "Year",
        base.select_fixed_range: "PD",
        base.select_number_of_periods: "3"
      ]
    }

    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }

  aggregate_table: daily_sales_summary_WTD {
    query: {
      dimensions: [
        date_date
      ]
      measures: [
        category_budget.department_net_sales_budget,
        transactions.aov_price,
        transactions.number_of_unique_customers,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales
      ]
      filters: [
        base.select_comparison_period: "Year",
        base.select_fixed_range: "WTD",
        base.select_number_of_periods: "3"
      ]
    }

    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }

  }

  aggregate_table: daily_sales_summary_MTD {
    query: {
      dimensions: [
        date_date
      ]
      measures: [
        category_budget.department_net_sales_budget,
        transactions.aov_price,
        transactions.number_of_unique_customers,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales
      ]
      filters: [
        base.select_comparison_period: "Year",
        base.select_fixed_range: "MTD",
        base.select_number_of_periods: "3"
      ]
    }

    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }

  }

  aggregate_table: daily_sales_summary_YTD {
    query: {
      dimensions: [
        date_date
      ]
      measures: [
        category_budget.department_net_sales_budget,
        transactions.aov_price,
        transactions.number_of_unique_customers,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales
      ]
      filters: [
        base.select_comparison_period: "Year",
        base.select_fixed_range: "YTD",
        base.select_number_of_periods: "3"
      ]
    }

    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }

  }

}



# explore: +base {

#   aggregate_table: aggtable-tdate {

#     query: {

#       dimensions: [base.date_date]

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
#       dimensions: [base.date_date, transactions.sales_channel]
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
#       dimensions: [base.date_date, transactions.parent_order_uid]
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
#       dimensions: [base.date_date, customers.customer_uid]
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
#   # aggregate_table: aggtable-tdate_pcode_tdepartment_psubdepartment{
#   #   query: {
#   #     dimensions: [base.date_date, products.product_code, products.department, products.subdepartment]
#   #     measures: [

#   #       transactions.total_gross_sales,
#   #       transactions.total_margin_excl_funding,
#   #       transactions.total_margin_incl_funding,
#   #       transactions.total_margin_rate_excl_funding,
#   #       transactions.total_margin_rate_incl_funding,
#   #       transactions.total_net_sales,
#   #       transactions.number_of_unique_customers,
#   #       transactions.number_of_transactions,
#   #       transactions.total_cogs,
#   #       transactions.total_unit_funding,
#   #       transactions.total_units,
#   #       transactions.total_units_incl_system_codes,
#   #       transactions.aov_units,
#   #       transactions.aov_units_incl_system_codes,
#   #       transactions.aov_gross_sales,
#   #       transactions.aov_margin_excl_funding,
#   #       transactions.aov_margin_incl_funding,
#   #       transactions.aov_price,
#   #       transactions.aov_net_sales

#   #     ]
#   #   }
#   #   materialization: {
#   #     datagroup_trigger: toolstation_transactions_datagroup
#   #   }
#   # }
#   aggregate_table: aggtable-tdate_s_siteuid {
#     query: {
#       dimensions: [base.date_date, sites.site_uid]
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





# }
