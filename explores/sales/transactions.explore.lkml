include: "/views/**/*.view"

explore: base {
  label: "Transactions"
  description: "Explore Toolstation transactional data."
  always_filter: {
    filters: [

      select_date_reference: "Transaction"
      ]
  }

  conditionally_filter: {
    filters: [
      select_date_range: "Yesterday"
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
    ALL_FIELDS*,
    -products.department
  ]

  sql_always_where:${period_over_period} and
    ${products.isActive};;

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: transactions {
    view_label: "Transactions"
    type: left_outer
    relationship: one_to_many
    sql_on:
        ${base.base_date_date} = ${transactions.transaction_date_filter}
          AND
        (${transactions.is_cancelled} = 0
          OR
        ${transactions.is_cancelled} IS NULL)
      {% if ${transactions.charity_status} == "1" %}
        AND (${transactions.product_code} IN ('85699', '00053'))
      {% else %}
        AND (${transactions.product_code} NOT IN ('85699', '00053') OR ${transactions.product_code} IS NULL)
      {% endif %}
        {% if
          (category_budget._in_query and site_budget._in_query)
          or (channel_budget._in_query and category_budget._in_query)  %}
          MULTIPLE_BUDGETS_SELECTED
        {% elsif (channel_budget._in_query and site_budget._in_query) %}
          MULTIPLE_BUDGETS_SELECTED
        {% elsif (channel_budget._in_query and site_budget._in_query and category_budget._in_query) %}
          MULTIPLE_BUDGETS_SELECTED
        {% elsif channel_budget._in_query %}
          AND ${transactions.sales_channel} IS NOT NULL
        {% elsif category_budget._in_query %}
          AND ${transactions.product_department} IS NOT NULL
        {% elsif site_budget._in_query %}
          AND ${transactions.site_uid} IS NOT NULL
        {% else %}
          AND (${transactions.sales_channel} IS NOT NULL AND ${transactions.site_uid} IS NOT NULL AND ${transactions.product_department} IS NOT NULL)
        {% endif %}
          AND
        UPPER(${transactions.extranet_status}) = {% parameter transactions.select_extranet_status %};;
  }

  join: single_line_transactions {
    view_label: "Transactions"
    type:  left_outer
    relationship: many_to_many
    sql_on: ${transactions.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
  }

  join: attached_products {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_many
    sql_on: ${single_line_transactions.parent_order_uid} = ${attached_products.parent_order_uid} ;;
  }

  join: category_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date}=${category_budget.date} AND UPPER(${transactions.product_department}) = UPPER(${category_budget.department});;
  }

  join: products {
    view_label: "Products"
    type:  left_outer
    relationship: many_to_one
    sql_on:
        {% if
          category_budget.department_net_sales_budget._in_query
          or category_budget.department_margin_inc_Retro_funding_budget._in_query
          or category_budget.department_margin_inc_all_funding_budget._in_query
          or category_budget.department_margin_rate_inc_retro_funding_budget._in_query
        %}
          (${transactions.product_uid}=${products.product_uid} OR ${transactions.product_uid} IS NULL)
            AND upper(products.productDepartment) = upper(category_budget.department)
        {% else %}
          ${transactions.product_uid}=${products.product_uid}
        {% endif %};;
  }

  join: product_first_sale_date {
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_code} = ${product_first_sale_date.product_code} ;;
  }

  join: total_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${total_budget.total_budget_date};;
  }

  join: channel_budget {
    view_label: "Budget"
    type:  left_outer
    relationship: many_to_one
    sql_on:${base.date_date}=${channel_budget.date_date} AND ${transactions.sales_channel} = ${channel_budget.channel} ;;
  }

  join: site_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${site_budget.date_date} AND ${transactions.site_uid} = ${site_budget.site_uid};;
  }

  join: sites {
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }

  join: foh_master_products_2024 {
    required_access_grants: [lz_testing]
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on:${foh_master_products_2024.siteUID} =${sites.site_uid} and ${transactions.product_code}=${foh_master_products_2024.SKU} and ${calendar_completed_date.fiscal_year_week}=${foh_master_products_2024.Week}  ;;
  }

  join: foh_master_stores {
    required_access_grants: [lz_testing]
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${foh_master_stores.SKU}=${transactions.product_code} and ${calendar_completed_date.fiscal_year_week}=${foh_master_stores.Week};;
  }

  join: customers {
    view_label: "Customers"
    type :  left_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }

  join: customer_segmentation {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid} = ${customer_segmentation.ucu_uid};;
   # and ${customers.customer_uid} = ${customer_segmentation.ucu_uid} ;;
  }

  join: assumed_trade_customers {
    view_label: "Customers"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${assumed_trade_customers.customer_uid} ;;
  }


  join: trade_customers {
    view_label: "Customers"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  }

  join: trade_credit_details {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${trade_credit_ids.main_trade_credit_account_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;
  }

  join: trade_credit_ids {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_credit_ids.customer_uid} ;;
  }

  join: suppliers {
    view_label: "Suppliers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
    fields: [suppliers.master_supplier_name, suppliers.supplier_name, suppliers.supplier_uid, suppliers.supplier_planner, suppliers.supplier_contact,suppliers.sage_supplier_code]
  }

  join: promo_main_catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_code} = ${promo_main_catalogue.product_code} and ${base.date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
  }

  join: promo_extra {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_code} = ${promo_extra.product_code} and ${base.date_date} between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: digital_transaction_mapping {
    view_label: "Digital"
    type: left_outer
    relationship: one_to_one
    sql_on: ${transactions.parent_order_uid} = ${digital_transaction_mapping.transaction_uid} ;;
  }

  join: backend_digital_channel_grouping {
    type: left_outer
    relationship: many_to_one
    sql_on: ${digital_transaction_mapping.channel_grouping} = ${backend_digital_channel_grouping.channel_grouping} ;;
  }

  join: digital_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${digital_budget.Date_date};;
  }

  join: ecrebo {
    view_label: "Ecrebo"
    type: left_outer
    relationship: one_to_many
    sql_on: ${base.date_date} = ${ecrebo.ecrebo_date_filter} AND ${transactions.parent_order_uid} = ${ecrebo.parent_order_uid};;
  }

  join: po_numbers {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${po_numbers.order_id};;
  }

  join: promoHistory_Current {
    type: left_outer
    view_label: ""
    relationship: many_to_one
    sql_on: ${products.product_code} = ${promoHistory_Current.product_code} and ${catalogue.catalogue_name}=${promoHistory_Current.catalogueName} ;;
  }

  join: product_dimensions {
    type: left_outer
    view_label: "Products"
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${product_dimensions.product_uid};;
  }

  join: retail_price_history {
    type: left_outer
    view_label: "Products"
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${retail_price_history.product_uid}
    and ${base.base_date_date} BETWEEN ${retail_price_history.price_start_date} AND ${retail_price_history.price_end_date};;
  }

  join: currentRetailPrice {
    type: left_outer
    view_label: "Products"
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${currentRetailPrice.Product_ID}
    and ${retail_price_history.product_uid} =  ${currentRetailPrice.Product_ID};;
  }

  join: top_clusters_net_sales {
    view_label: "Top N Ranking"
    type: left_outer
    relationship: many_to_one
    fields: [top_rank_limit,top_clusters_net_sales.brand_rank_top_brands_bigquery]
    sql_on: ${customer_segmentation.cluster} = ${top_clusters_net_sales.Cluster};;
    sql_where: ${top_clusters_net_sales.brand_rank_top_brands_bigquery} != "Other" ;;
  }

  join: top_clusters_customers {
   view_label: "Top N Ranking"
    type: left_outer
    relationship: many_to_one
    fields: [top_clusters_customers.top_rank_limit_2,top_clusters_customers.brand_rank_top_brands_bigquery_2]
    sql_on: ${customer_segmentation.cluster} = ${top_clusters_customers.Cluster};;
    sql_where: ${top_clusters_customers.brand_rank_top_brands_bigquery_2} != "Other" ;;
  }

  join: top_subdepartment_customers {
    view_label: "Top N Ranking"
    type: left_outer
    relationship: many_to_one
    fields: [top_subdepartment_customers.top_rank_limit_3,top_subdepartment_customers.brand_rank_top_brands_bigquery_3]
    sql_on: ${products.subdepartment} = ${top_subdepartment_customers.SubDepartment};;
    sql_where: ${top_subdepartment_customers.brand_rank_top_brands_bigquery_3} != "Other" ;;
  }

  join: top_subdepartment_net_sales {
    view_label: "Top N Ranking"
    type: left_outer
    relationship: many_to_one
    fields: [top_subdepartment_net_sales.top_rank_limit_4,top_subdepartment_net_sales.brand_rank_top_brands_bigquery_4]
    sql_on: ${products.subdepartment} = ${top_subdepartment_net_sales.SubDepartment};;
    sql_where: ${top_subdepartment_net_sales.brand_rank_top_brands_bigquery_4} != "Other" ;;
  }

  join: top_trade_types_sales {
    view_label: "Top N Ranking"
    type: left_outer
    relationship: many_to_one
    fields: [top_trade_types_sales.top_rank_limit_4,top_trade_types_sales.brand_rank_top_brands_bigquery_4]
    sql_on: ${trade_customers.trade_type} = ${top_trade_types_sales.Trade_type};;
    sql_where: ${top_trade_types_sales.brand_rank_top_brands_bigquery_4} != "Other" ;;
  }

  join: top_trade_types_customers {
    view_label: "Top N Ranking"
    type: left_outer
    relationship: many_to_one
    fields: [top_trade_types_customers.top_rank_limit_4,top_trade_types_customers.brand_rank_top_brands_bigquery_4]
    sql_on: ${trade_customers.trade_type} = ${top_trade_types_customers.Trade_type};;
    sql_where: ${top_trade_types_customers.brand_rank_top_brands_bigquery_4} != "Other" ;;
  }

  join: promo_orders {
    view_label: "Orders using Promo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.transaction_uid} = ${promo_orders.order_id} and ${base.date_date} = ${promo_orders.date_date} ;;
  }

  join: promoworking {
    view_label: "Products"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${promoworking.Product_Code} and ${catalogue.catalogue_name}=${promoworking.publicationName};;
  }

  join: brand_test {
    view_label: "Sales by Brand"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} = ${brand_test.date_date} and ${products.product_code} = ${brand_test.productCode}
    and ${customers.customer_uid} = ${brand_test.customer_uid} ;;
  }

  join: bucketed_order_sales {
    type: left_outer
    relationship: one_to_many
    sql_on: ${transactions.parent_order_uid} = ${bucketed_order_sales.parent_order_uid} ;;
  }

  join: spc_buckets {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${spc_buckets.parent_order_uid} ;;
  }

  join: customer_classification {
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customer_classification.customer_uid} ;;
  }

  join: customer_spending {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customer_spending.customer_uid}
    and
    ${calendar_completed_date.calendar_year_month} = ${customer_spending.year_month};;
    sql_where: ${customer_spending.brand_rank_top_brands_bigquery_2} != "Other" ;;
  }

  join: transactions_incomplete {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${transactions_incomplete.parent_order_uid} ;;
  }

  join: customers_wks47_22 {
    view_label: "Other - Ad-hoc Analysis"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customers_wks47_22.customer_uid} ;;
  }

  join: customers_wks47_23 {
    view_label: "Other - Ad-hoc Analysis"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customers_wks47_23.customer_uid} ;;
  }

  join: rakuten_analysis_0112 {
    view_label: "Other - Ad-hoc Analysis"
    required_access_grants: [adhoc_rakuten]
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${rakuten_analysis_0112.customerUID} and ${transactions.parent_order_uid} = ${rakuten_analysis_0112.parent_order_UID};;
  }

  join: assumed_trade_dataiku {
    required_access_grants:[lz_testing]
    view_label: "Customer Classification"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${assumed_trade_dataiku.customer_uid} ;;
  }

  join: assumed_trade_measures {
    required_access_grants:[lz_testing]
    view_label: "Customer Classification"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${assumed_trade_measures.customer_uid};;
  }
}

explore: +base {
  query: department_weekly_sales {
    label: "Weekly Sales (By Department)"
    description: "This provides information to user."
    dimensions: [
      base.combined_week, transactions.product_department
    ]
    measures: [
      transactions.total_net_sales
    ]
    filters: [
      base.select_date_range: "28 days ago for 28 days"
    ]
    limit: 500
    sorts: [
      base.combined_week: desc,
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
      base.combined_week, transactions.sales_channel
    ]
    measures: [
      transactions.total_net_sales
    ]
    filters: [
      base.select_date_range: "28 days ago for 28 days"
    ]
    limit: 500
    sorts: [
      base.combined_week: desc,
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
  }

  query: product_performance {
    label: "Top Performing Products (PTD)"
    description: "This provides information to user."
    dimensions: [
      transactions.product_code,
      products.description,
      transactions.product_department,
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
  }
}

explore: +base {
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
        base.select_number_of_periods: "3",
      base.select_date_reference: "Transaction"
      ]
    }
    materialization: {
      datagroup_trigger: ts_transactions_datagroup
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
        base.select_number_of_periods: "3",
      base.select_date_reference: "Transaction"
      ]
    }
    materialization: {
      datagroup_trigger: ts_transactions_datagroup
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
        base.select_number_of_periods: "3",
      base.select_date_reference: "Transaction"
      ]
    }
    materialization: {
      datagroup_trigger: ts_transactions_datagroup
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
        base.select_number_of_periods: "3",
      base.select_date_reference: "Transaction"
      ]
    }
    materialization: {
      datagroup_trigger: ts_transactions_datagroup
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
        base.select_number_of_periods: "3",
      base.select_date_reference: "Transaction"
      ]
    }
    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }
}
