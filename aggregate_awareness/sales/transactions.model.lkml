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
        transactions.aov_net_sales,
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
