include: "/models/prod/*.model"
include: "/models/backend/config.model"

explore: +transactions {

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
}
