include: "/explores/sales/transactions.explore.lkml"

explore: +base {

  aggregate_table: aggtable-tdate {
        query: {
          dimensions: [base.date_date]
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
