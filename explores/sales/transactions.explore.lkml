include: "/views/**/*.view"

explore: base {

  extends: []
  label: "Transactions"
  description: "Explore Toolstation transactional data."

  conditionally_filter: {
    filters: [
      base.select_date_range: "Yesterday"
    ]
    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
    ]
  }

  fields: [
    ALL_FIELDS*,
    -products.department
  ]

  sql_always_where:

  ${period_over_period}

    ;;

    join: total_budget {
      view_label: "Budget"
      type: left_outer
      relationship: one_to_one
      sql_on: ${base.date_date} = ${total_budget.total_budget_date};;
    }

    join: transactions {
      type: left_outer
      relationship: one_to_many

      sql_on:

        ${base.base_date_date} = date(${transactions.transaction_date})
        and (${transactions.is_cancelled} = 0 and ${transactions.is_cancelled} is not null)

       {% if ${transactions.charity_status} == "1" %}
       and (${transactions.product_code} = '85699' and ${transactions.product_code} = '00053')
        {% else %}
      and (${transactions.product_code} <> '85699' and ${transactions.product_code} <> '00053')
        {% endif %}

        and ${transactions.product_code} is not null

        {% if
          (category_budget._in_query and site_budget._in_query)
          or (channel_budget._in_query and category_budget._in_query)  %}
          MULTIPLE_BUDGETS_SELECTED
        {% elsif (channel_budget._in_query and site_budget._in_query) %}
          MULTIPLE_BUDGETS_SELECTED
        {% elsif (channel_budget._in_query and site_budget._in_query and category_budget._in_query) %}
          MULTIPLE_BUDGETS_SELECTED
        {% elsif channel_budget._in_query %}
          and ${transactions.sales_channel} is not null
        {% elsif category_budget._in_query %}
          and ${transactions.product_department} is not null
        {% elsif site_budget._in_query %}
          and ${transactions.site_uid} is not null
        {% else %}
          and (${transactions.sales_channel} is not null and ${transactions.site_uid} is not null and ${transactions.product_department} is not null)
        {% endif %}

      ;;
    }

    join: channel_budget {
      view_label: "Budget"
      type:  left_outer
      relationship: many_to_one
      sql_on:
          ${base.base_date_date}=${channel_budget.date} and ${transactions.sales_channel} = ${channel_budget.channel}
        ;;
    }

    join: category_budget {
      view_label: "Budget"
      type: left_outer
      relationship: many_to_one
      sql_on:
          ${base.base_date_date}=${category_budget.date} and upper(${transactions.product_department}) = upper(${category_budget.department})
          ;;
    }

    join: site_budget {
      view_label: "Budget"
      type: left_outer
      relationship: many_to_one
      sql_on:
      ${base.base_date_date} = ${site_budget.date_date} and ${transactions.site_uid} = ${site_budget.site_uid}
      ;;
    }

    join: products {
      type:  left_outer
      relationship: many_to_one
      sql_on:
              -- additional join if department budget fields are used
              {% if
                category_budget.department_net_sales_budget._in_query
                or category_budget.department_margin_inc_Retro_funding_budget._in_query
                or category_budget.department_margin_inc_all_funding_budget._in_query
                or category_budget.department_margin_rate_inc_retro_funding_budget._in_query
              %}
                (${transactions.product_uid}=${products.product_uid} or ${transactions.product_uid} is null)
                and upper(products.productDepartment) = upper(category_budget.department)
              {% else %}
              ${transactions.product_uid}=${products.product_uid}
              {% endif %}
      ;;
    }

    join: sites {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
    }

    join: calendar_completed_date{
      from:  calendar
      view_label: "Date"
      type:  inner
      relationship:  many_to_one
      sql_on: ${base.base_date_date}=${calendar_completed_date.date} ;;
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
      fields: [suppliers.master_supplier_name, suppliers.supplier_name, suppliers.supplier_uid, suppliers.supplier_planner, suppliers.sage_supplier_code]
    }

    join: customer_segmentation {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.customer_uid} = ${customer_segmentation.ucu_uid} ;;
    }

    join: trade_customers {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
    }

    join: promo_main_catalogue {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${promo_main_catalogue.product_code} and ${base.base_date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
    }

    join: promo_extra {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${promo_extra.product_code} and ${base.base_date_date} between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
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

    # join: trade_credit_details {
    #   type: left_outer
    #   relationship: one_to_one
    #   sql_on: ${transactions.customer_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;
    # }

  }

# EXAMPLES #

explore: +base {

  query: department_weekly_sales {

    label: "Weekly Sales (By Department)"
    description: "This provides information to user."

    dimensions: [
      base.date_date, transactions.product_department
    ]
    measures: [
      transactions.total_net_sales
    ]
    filters: [
      base.select_date_range: "28 days ago for 28 days"
    ]
    limit: 500
    sorts: [
      base.date_date: desc,
      transactions.product_department: asc
    ]
    pivots: [
      base.date_date
    ]

  }

  query: channel_weekly_sales {

    label: "Weekly Sales (By Channel)"
    description: "This provides information to user."

    dimensions: [
      base.date_date, transactions.sales_channel
    ]
    measures: [
      transactions.total_net_sales
    ]
    filters: [
      base.select_date_range: "28 days ago for 28 days"
    ]
    limit: 500
    sorts: [
      base.date_date: desc,
      transactions.sales_channel: asc
    ]
    pivots: [
      base.date_date
    ]

  }

  query: department_daily_performance {

    label: "7 Day Performance (By Department)"
    description: "This provides information to user."

    dimensions: [
      base.date_date, transactions.product_department
    ]
    measures: [
      transactions.total_net_sales,
      transactions.total_margin_rate_incl_funding
    ]
    filters: [
      base.select_date_range: "7 days ago for 7 days"
    ]
    limit: 500
    sorts: [
      base.date_date: desc,
      transactions.product_department: asc,
      transactions.total_net_sales: desc
    ]
    pivots: [
      base.date_date
    ]

  }

  query: previous_day_site_performance {

    label: "Store Performance (PTD)"
    description: "This provides information to user."

    dimensions: [
      sites.site_uid,
      sites.site_name
    ]
    measures: [
      transactions.total_net_sales,
      transactions.total_margin_rate_incl_funding,
      transactions.number_of_unique_customers,
      transactions.number_of_transactions
    ]
    filters: [
      base.select_fixed_range: "PD",
      sites.site_name: "-Website"
    ]
    limit: 50
    sorts: [
      transactions.total_net_sales: desc
    ]
    pivots: [

    ]

  }

  query: ptd_yoy_sales_performance {

    label: "Sales Performance (PTD)"
    description: "This provides information to user."

    dimensions: [
      base.dynamic_fiscal_year
    ]
    measures: [
      transactions.total_net_sales,
      transactions.total_margin_incl_funding,
      transactions.total_margin_rate_incl_funding,
      transactions.total_units
    ]
    filters: [
      base.select_comparison_period: "Year",
      base.select_fixed_range: "WTD",
      base.select_number_of_periods: "3"
    ]
    limit: 50
    sorts: [
      base.dynamic_fiscal_year: desc,
      transactions.total_net_sales: desc
    ]
    pivots: [

    ]

  }

  query: product_performance {

    label: "Top Performing Products (PTD)"
    description: "This provides information to user."

    dimensions: [
      transactions.product_code,
      products.description,
      products.department,
      products.subdepartment
    ]
    measures: [
      transactions.total_net_sales,
      transactions.margin_incl_funding,
      transactions.total_margin_rate_incl_funding,
      transactions.total_units,
      transactions.number_of_transactions,
      transactions.number_of_unique_customers
    ]
    filters: [
      base.select_fixed_range: "PD"
    ]
    limit: 20
    sorts: [
      transactions.total_net_sales: desc,
      transactions.total_margin_rate_incl_funding: desc
    ]
    pivots: [

    ]

  }

}



# AA #


explore: +base {

  # DAILY SALES #

  aggregate_table: daily_sales_summary_DATE {
    query: {
      dimensions: [
        date_date,
        base.pivot_dimension,
        base.__comparator_order__
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
