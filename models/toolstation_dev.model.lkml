connection: "toolstation"

# include all the views
include: "/views/**/*.view"

persist_with: toolstation_transactions_datagroup

week_start_day: sunday

datagroup: toolstation_transactions_datagroup {
  sql_trigger:
        SELECT    MAX(log_timestamp)
        FROM      toolstation-data-storage.looker_persistent_tables.etl_log
        WHERE     datagroup_name = 'transactions';;
  max_cache_age: "22 hour"
}

access_grant: can_use_transactions {
  user_attribute: ts_permissions
  allowed_values: ["TRANSACTIONS"]
}
access_grant: can_use_customers {
  user_attribute: ts_permissions
  allowed_values: ["CUSTOMERS"]
}
access_grant: can_use_customer_information {
  user_attribute: ts_sensitive # CG - consider wider group option of BU_sensitive flag (to propose)
  allowed_values: ["Y"]
}
access_grant: is_developer {
  user_attribute: ts_developer
  allowed_values: ["Y"]
}
access_grant: is_expert {
  user_attribute: ts_developer
  allowed_values: ["YS"]
}
# Place in `toolstation_dev` model


explore: transactions {

  # CG 04/11 TODO - look at DS report and try to collate agg table - may need to include period_ attribute TBC

  aggregate_table: aggtable-tdate {
    query: {
      dimensions: [transaction_date]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]
    }
    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }
  aggregate_table: aggtable-tdate_tchannel {
    query: {
      dimensions: [transaction_date, sales_channel]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]
    }
    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }
  aggregate_table: aggtable-tdate_tparentuid {
    query: {
      dimensions: [transaction_date, parent_order_uid]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]
    }
    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }
  aggregate_table: aggtable-tdate_ccustomeruid {
    query: {
      dimensions: [transaction_date, customers.customer_uid]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]
    }
    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }
  aggregate_table: aggtable-tdate_pcode {
    query: {
      dimensions: [transactions.transaction_date, products.product_code]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]
    }
    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }
  aggregate_table: aggtable-tdate_pcode_tdepartment_psubdepartment{
    query: {
      dimensions: [transaction_date, products.product_code,products.department, products.subdepartment]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]
    }
    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }
  aggregate_table: aggtable-tdate_s_siteuid {
    query: {
      dimensions: [transaction_date, sites.site_uid]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]

    }

    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }
  aggregate_table: aggtable-tparentuid_ttransactionuid {
    query: {
      dimensions: [transactions.parent_order_uid, transactions.transaction_uid]
      measures: [

        transactions.total_gross_sales,
        transactions.total_margin_excl_funding,
        transactions.total_margin_incl_funding,
        transactions.total_margin_rate_excl_funding,
        transactions.total_margin_rate_incl_funding,
        transactions.total_net_sales,
        transactions.number_of_unique_customers,
        transactions.number_of_transactions,
        transactions.total_cogs,
        transactions.total_unit_funding,
        transactions.total_units,
        transactions.total_units_incl_system_codes,
        transactions.aov_units,
        transactions.aov_units_incl_system_codes,
        transactions.aov_gross_sales,
        transactions.aov_margin_excl_funding,
        transactions.aov_margin_incl_funding,
        transactions.aov_price,
        transactions.aov_net_sales

      ]
    }
    materialization: {
      datagroup_trigger: toolstation_transactions_datagroup
    }
  }

  # always_filter: {
  #   filters: [period_to_date: "PD", previous_period_to_date: "CY"]
  # }
  # access_filter: {} -- to look at


  sql_always_where:
  ${pivot_period}
  AND
  (${is_cancelled} = 0 or ${is_cancelled} is null) AND (${product_code} <> '85699' or ${product_code} is null)

  ;;

    join: products {
      type:  inner
      relationship: many_to_one
      sql_on: ${transactions.product_uid}=${products.product_uid} ;;
    }

    join: channel_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: date(${transactions.transaction_date})=${channel_budget.date} and upper(${transactions.sales_channel})=upper(${channel_budget.channel}) ;;
    }

    join: site_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: date(${transactions.transaction_date})=${site_budget.date_date} and ${transactions.site_uid}=${site_budget.site_uid};;
    }

    join: category_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: date(${transactions.transaction_date})=${category_budget.date} and initcap(${products.department})=initcap(${category_budget.department}) ;;
    }

    join: sites {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
    }

    join: calendar_completed_date{
      from:  calendar
      view_label: "Calendar - Completed Date"
      type:  inner
      relationship:  many_to_one
      sql_on: ${transactions.transaction_date_coalesce}=${calendar_completed_date.date} ;;
    }

    join: calendar_placed_date{
      from:  calendar
      view_label: "Calendar - Placed Date"
      type:  inner
      relationship:  many_to_one
      sql_on: date(${transactions.placed_date})=${calendar_placed_date.date} ;;
    }

    join: customers {
      type :  inner
      relationship: many_to_one
      sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
    }

    join: suppliers {
      type: left_outer
      relationship: many_to_one
      sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
    }

    join: customer_segmentation {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.customer_uid} = ${customer_segmentation.ucu_uid} ;;
    }

    join: trade_customers {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${customers.customer_uid} = ${trade_customers.customer_number} ;;
    }
    join: promo_main_catalogue {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${promo_main_catalogue.product_code} and date(${transactions.transaction_date}) between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
    }
    join: promo_extra {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${promo_extra.product_code} and date(${transactions.transaction_date}) between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
    }
    join: single_line_transactions {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${transactions.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
    }
    join: product_first_sale_date {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${product_first_sale_date.product_code} ;;
    }
  }



  explore: stock_intake {
    join: products {
      type:  inner
      relationship: many_to_one
      sql_on: ${stock_intake.product_uid}=${products.product_uid} ;;
    }
    join: sites {
      type:  inner
      relationship:  many_to_one
      sql_on: ${stock_intake.destination_site_uid}=${sites.site_uid} ;;
    }
    join: disctribution_centre_names {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${stock_intake.destination_site_uid}=${disctribution_centre_names.site_uid} ;;
    }
    join: suppliers {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${stock_intake.supplier_uid}=${suppliers.supplier_uid} ;;
    }
  }

  explore: stock_level_date_site_product {

    label: "Stock Holding By Date, Site, Product"

    join: aac {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${stock_level_date_site_product.opening_stock_date} = ${aac.date} and ${stock_level_date_site_product.product_uid} = ${aac.product_uid} ;;
    }
    join: products {
      type: inner
      relationship: many_to_one
      sql_on: ${stock_level_date_site_product.product_uid} = ${products.product_uid} ;;
    }
    join: suppliers {
      view_label: "Supplier"
      type: left_outer
      relationship: many_to_one
      sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
    }

  }


# explore: view_weeklyconversion_testl {}
# explore: test_dgtl_ds_contibution {}


  explore: digital_product_conversion {
    label: "Product Conversion (DIGITAL)"
    join: products {
      type: inner
      relationship: many_to_one
      sql_on: ${digital_product_conversion.ga_sku}=${products.product_code} ;;
    }
  }
