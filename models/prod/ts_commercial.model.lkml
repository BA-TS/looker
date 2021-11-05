include: "/models/backend/config.model"
include: "/custom_views/**/*.view"
include: "/views/**/*.view"

label: "TS - Commercial"

explore: transactions {

  label: "Transactions"

  # CG 04/11 TODO - look at DS report and try to collate agg table - may need to include period_ attribute TBC

  always_filter: {
    filters: [current_date_range: "Yesterday"]
  }
  # access_filter: {} -- to look at

  sql_always_where:
    {% condition transactions.current_date_range %} ${transactions.base_date_raw} {% endcondition %}

      {% if transactions.previous_date_range._is_filtered or transactions.compare_to._in_query %}
        {% if transactions.comparison_periods._parameter_value == "2" %}

            or ${transactions.base_date_raw} >= ${period_2_start} and ${transactions.base_date_raw} < ${period_2_end}

          {% elsif transactions.comparison_periods._parameter_value == "3" %}
            or ${transactions.base_date_raw} >= ${period_2_start} and ${transactions.base_date_raw} < ${period_2_end}
            or ${transactions.base_date_raw} >= ${period_3_start} and ${transactions.base_date_raw} < ${period_3_end}

        {% endif %}

      {% endif %}
    ;;




    join: transactions_data {
      view_label: "Transaction"
      type: left_outer
      relationship: one_to_many
      sql_on: ${transactions.base_date_date} = date(${transactions_data.transaction_date}) and ${transactions_data.is_cancelled} = 0 and ${transactions_data.product_code} <> '85699'  ;;
    }

    join: products {
      type:  inner
      relationship: many_to_one
      sql_on: ${transactions_data.product_uid}=${products.product_uid} ;;
    }

    join: channel_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: ${transactions.base_date_date}=${channel_budget.date} and upper(${transactions_data.sales_channel})=upper(${channel_budget.channel}) ;;
    }

    join: site_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: ${transactions.base_date_date} = ${site_budget.date_date} and ${transactions_data.site_uid}=${site_budget.site_uid};;
    }

    join: category_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: ${transactions.base_date_date}=${category_budget.date} and initcap(${products.department})=initcap(${category_budget.department}) ;;
    }

    join: sites {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions_data.site_uid_coalesce}=${sites.site_uid} ;;
    }

    join: calendar_completed_date{
      from:  calendar
      view_label: "Calendar - Completed Date"
      type:  inner
      relationship:  many_to_one
      sql_on: ${transactions.base_date_date}=${calendar_completed_date.date} ;;
    }

    join: calendar_placed_date{
      from:  calendar
      view_label: "Calendar - Placed Date"
      type:  inner
      relationship:  many_to_one
      sql_on: date(${transactions_data.placed_date})=${calendar_placed_date.date} ;;
    }

    join: customers {
      type :  inner
      relationship: many_to_one
      sql_on: ${transactions_data.customer_uid}=${customers.customer_uid} ;;
    }

    join: suppliers {
      type: left_outer
      relationship: many_to_one
      sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
    }

    join: customer_segmentation {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions_data.customer_uid} = ${customer_segmentation.ucu_uid} ;;
    }

    join: trade_customers {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${customers.customer_uid} = ${trade_customers.customer_number} ;;
    }
    join: promo_main_catalogue {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions_data.product_code} = ${promo_main_catalogue.product_code} and ${transactions.base_date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
    }
    join: promo_extra {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions_data.product_code} = ${promo_extra.product_code} and ${transactions.base_date_date} between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
    }
    join: single_line_transactions {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${transactions_data.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
    }
    join: product_first_sale_date {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions_data.product_code} = ${product_first_sale_date.product_code} ;;
    }
  }





  # explore: +transactions {
  #   aggregate_table: aggtable-tdate {
  #     query: {
  #       dimensions: [transaction_date]
  #       measures: [

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

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

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

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

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

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

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tdate_pcode {
  #     query: {
  #       dimensions: [transactions_data.transaction_date, products.product_code]
  #       measures: [

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

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

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

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

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

  #       ]

  #     }

  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }
  #   aggregate_table: aggtable-tparentuid_ttransactionuid {
  #     query: {
  #       dimensions: [transactions_data.parent_order_uid, transactions_data.transaction_uid]
  #       measures: [

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  #   }

  #   aggregate_table: aggtable-dailysales_summary {

  #     query: {
  #       filters: [transactions_data.period_to_date: "YTD", transactions_data.previous_period_to_date: "LY2LY"]
  #       dimensions: [transactions_data.__target_year__, transactions_data.period_enabled_transaction_date]
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
  #       dimensions: [transactions_data.department_coalesce,products.product_code,sales_channel, products.description ,transactions_data.__target_year__, transactions_data.period_enabled_transaction_date]
  #       measures: [

  #         transactions_data.total_gross_sales,
  #         transactions_data.total_margin_excl_funding,
  #         transactions_data.total_margin_incl_funding,
  #         transactions_data.total_margin_rate_excl_funding,
  #         transactions_data.total_margin_rate_incl_funding,
  #         transactions_data.total_net_sales,
  #         transactions_data.number_of_unique_customers,
  #         transactions_data.number_of_transactions,
  #         transactions_data.total_cogs,
  #         transactions_data.total_unit_funding,
  #         transactions_data.total_units,
  #         transactions_data.total_units_incl_system_codes,
  #         transactions_data.aov_units,
  #         transactions_data.aov_units_incl_system_codes,
  #         transactions_data.aov_gross_sales,
  #         transactions_data.aov_margin_excl_funding,
  #         transactions_data.aov_margin_incl_funding,
  #         transactions_data.aov_price,
  #         transactions_data.aov_net_sales,
  #         category_budget.department_net_sales_budget

  #       ]
  #     }
  #     materialization: {
  #       datagroup_trigger: toolstation_transactions_datagroup
  #     }
  # }
  # }
