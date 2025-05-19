include: "/views/**/calendar.view"
include: "/views/**/transactions.view"
include: "/views/**/single_line_transactions.view"
include: "/views/**/attached_products.view"
include: "/views/**/attached_products2.view"
include: "/views/**/category_budget.view"
include: "/views/**/products.view"
include: "/views/**/product_first_sale_date.view"
include: "/views/**/total_budget.view"
include: "/views/**/channel_budget.view"
include: "/views/**/site_budget.view"
include: "/views/**/sites.view"
include: "/views/**/foh_master_stores.view"
include: "/views/**/suppliers.view"
include: "/views/**/supplierAddresses.view"
include: "/views/**/promo_main_catalogue.view"
include: "/views/**/extraPromo.view"
include: "/views/**/catalogue.view"
include: "/views/**/spi_cpi.view"
include: "/views/**/spi_cpi_weekly.view"
include: "/views/**/digital_transaction_mapping.view"
include: "/views/**/digital_channel_grouping.view"
include: "/views/**/ecrebo.view"
include: "/views/**/ecrebo_items.view"
include: "/views/**/po_numbers.view"
include: "/views/**/promoHistory_Current.view"
include: "/views/**/product_dimensions.view"
include: "/views/**/product_quantity.view"
include: "/views/**/retail_price_history.view"
include: "/views/**/top_clusters_net_sales.view"
include: "/views/**/top_clusters_customers.view"
include: "/views/**/top_subdepartment_customers.view"
include: "/views/**/top_subdepartment_net_sales.view"
include: "/views/**/top_trade_types_sales.view"
include: "/views/**/top_trade_types_customers.view"
include: "/views/**/promo_orders.view"
include: "/views/**/catPromo.view"
include: "/views/**/brand_test.view"
include: "/views/**/bucketed_order_sales.view"
include: "/views/**/spc_buckets.view"
include: "/views/**/spc_buckets_customers.view"
include: "/views/**/bucketed_order_sales_department.view"
include: "/views/**/customer_spending.view"
include: "/views/**/transactions_incomplete.view"
include: "/views/**/rakuten_analysis_0112.view"
include: "/views/**/ds_assumed_trade.view"
include: "/views/**/costprice.view"
include: "/views/**/app_transactions_pre_post.view"
include: "/views/**/clickCollect.view"
include: "/views/**/foh_master_products_2024.view"
include: "/views/**/app_web_data.view"
include: "/views/**/EcreboBudget.view"
include: "/views/**/scorecard_testing_branch_mth.view"
include: "/views/**/scorecard_testing_region_mth.view"
include: "/views/**/scorecard_testing_division_mth.view"
include: "/views/**/scorecard_testing_branch_YTD.view"
include: "/views/**/scorecard_testing_region_YTD.view"
include: "/views/**/scorecard_testing_division_YTD.view"
include: "/views/**/scorecard_testing_loyalty_branch_mth.view"
include: "/views/**/scorecard_testing_loyalty_region_mth.view"
include: "/views/**/scorecard_testing_loyalty_division_mth.view"
include: "/views/**/scorecard_testing_loyalty_branch_ytd.view"
include: "/views/**/scorecard_testing_loyalty_region_ytd.view"
include: "/views/**/scorecard_testing_loyalty_division_ytd.view"
include: "/views/**/return_orders.view"
include: "/views/**/scorecard_trade_customers_filter.view"
include: "/views/**/scorecard_testing_region_11.view"
include: "/views/**/hyperfinity_customer_flag.view"
include: "/views/**/addresses.view"
include: "/views/**/customers_spend_over75_previous_month.view"
include: "/views/**/customer/**.view"
include: "/views/**/commercial/**.view"
include: "/views/**/scmatrix.view"
include: "/views/**/customer_loyalty.view"
include: "/views/**/ds_all_daily_department_sales.view"
include: "/views/**/ds_daily_sku_sales_ty_ly_lly_lw.view"
include: "/views/**/product_attributes.view"
include: "/views/**/product_detail.view"
include: "/views/**/transactions_ecrebo.view"
include: "/views/**/ecrebo_product_code_flag.view"
include: "/views/**/product_attributes_pivoted.view"
include: "/views/**/ecrebo_discounts.view"
include: "/views/**/bdm_ka_customers.view"
include: "/views/**/bdm_ka_customers2.view"
include: "/views/**/bdm_ka_customers_combined.view"
include: "/views/**/department_group.view"
include:"/views/prod/department_specific/hyperfinity/*"

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
      {% if ${transactions.charity_status} == "1" %}
        AND (${transactions.product_code} IN ('85699', '00053','44842'))
      {% else %}
        AND (${transactions.product_code} NOT IN ('85699', '00053','44842') OR ${transactions.product_code} IS NULL)
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

        AND (UPPER(${transactions.extranet_status}) in (case when ({% parameter transactions.select_extranet_status %}) in ("SALE", "INCOMPLETE") then {% parameter transactions.select_extranet_status %} else ("INCOMPLETE") end)
        or UPPER(${transactions.extranet_status}) in (case when ({% parameter transactions.select_extranet_status %}) in ("SALE", "INCOMPLETE") then {% parameter transactions.select_extranet_status %} else ("SALE") end))

        AND case when ({% parameter transactions.order_cancelled %}) in ("No") then ${transactions.order_status} in ("Completed", "Pending")  and ${transactions.is_cancelled} = 0 else (case when ({% parameter transactions.order_cancelled %}) in ("Yes") then ${transactions.order_status} in ("Cancelled") and ${transactions.is_cancelled} = 1 else (case when ({% parameter transactions.order_cancelled %}) in ("Any") then ${transactions.order_status} in ("Completed", "Pending", "Cancelled") else null end) end) end;;
  }

  join: single_line_transactions {
    view_label: "Transactions"
    type:  left_outer
    relationship: many_to_many
    sql_on: ${transactions.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
  }

  join: attached_products {
    view_label: "Transactions - Attached"
    type: left_outer
    relationship: many_to_many
    sql_on: ${single_line_transactions.parent_order_uid} = ${attached_products.parent_order_uid} ;;
  }

  join: attached_products2 {
    view_label: "Transactions - Attached"
    type: left_outer
    relationship: many_to_many
    sql_on: ${single_line_transactions.parent_order_uid} = ${attached_products2.parent_order_uid} ;;
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

  join: department_group {
    view_label: "Products"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.department}=${department_group.department} ;;
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
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on:${foh_master_products_2024.siteUID} =${sites.site_uid} and ${transactions.product_code}=${foh_master_products_2024.SKU} and ${calendar_completed_date.fiscal_year_week}=${foh_master_products_2024.Week} ;;
  }

  join: foh_master_stores {
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

  join: customer_loyalty {
    view_label: "Customers"
    required_access_grants: [can_use_customer_information2]
    type :  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid}=${customer_loyalty.customer_uid}
    and  ${base.date_date} between ${customer_loyalty.loyalty_club_start_date} and ${customer_loyalty.loyalty_club_end_date};;
  }

  join: customer_segmentation {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid} = ${customer_segmentation.ucu_uid};;
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

  join: supplierAddresses {
    required_access_grants: [can_use_supplier_information]
    view_label: "Suppliers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${suppliers.supplier_uid}=${supplierAddresses.supplierUID}
    and ${base.date_date} between ${supplierAddresses.addressStartDate} and ${supplierAddresses.addressEndDate};;
    }

# -----------------------------------------------
  join: promo_main_catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_code} = ${promo_main_catalogue.product_code} and ${base.date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: catPromo {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_many
    sql_on: ${products.product_code} = ${catPromo.Product_Code}  and ${base.date_date} between ${catPromo.live_date} and ${catPromo.end_date};;
  }

  join: extraPromo {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_code} = ${extraPromo.product_code} and ${base.date_date} between ${extraPromo.live_date} and ${extraPromo.end_date} ;;
  }

  join: promoHistory_Current {
    type: left_outer
    view_label: ""
    relationship: many_to_one
    sql_on: ${products.product_code} = ${promoHistory_Current.product_code} and ${catalogue.catalogue_name}=${promoHistory_Current.catalogueName} ;;
  }

  join: promo_orders {
    view_label: "Orders using Promo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.transaction_uid} = ${promo_orders.order_id} and ${base.date_date} = ${promo_orders.date_date} ;;
  }

  # -----------------------------------------------


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
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${ecrebo.parent_order_uid} ;;
  }

  join: ecrebo_items {
    view_label: "Ecrebo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_code} = ${ecrebo_items.item_sku} and ${ecrebo_items.transactionUuid} = ${ecrebo.transactionUuid} ;;
  }

  join: po_numbers {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${po_numbers.order_id};;
  }

  join: return_orders {
    view_label: "Returns"
    type: left_outer
    relationship: many_to_one
    sql_on: ${return_orders.return_ID} = ${transactions.transaction_uid} ;;
  }

  join: product_dimensions {
    type: left_outer
    view_label: "Products Attributes"
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${product_dimensions.product_uid};;
  }

  join: product_attributes {
    view_label: "Products Attributes"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${product_attributes.product_uid};;
  }

  join: product_attributes_pivoted {
    view_label: "Products Attributes"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_uid} = ${product_attributes_pivoted.product_uid} ;;
    }

  join: product_detail {
    type: left_outer
    view_label: "Products Attributes"
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${product_detail.product_uid};;
  }

  join: product_quantity {
    type: left_outer
    view_label: "Products"
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${product_quantity.parent_order_uid};;
  }

  join: retail_price_history {
    type: left_outer
    view_label: "Products"
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${retail_price_history.product_uid}
    and ${base.base_date_date} BETWEEN ${retail_price_history.price_start_date} AND ${retail_price_history.price_end_date};;
  }

  join: price_change_history {
    type: left_outer
    view_label: "Products"
    relationship: many_to_one
    required_access_grants: [pricing]
    sql_on: ${products.product_code} = ${price_change_history.product_code}
      and ${base.base_date_date} BETWEEN ${price_change_history.new_start_date} AND ${price_change_history.new_end_date};;
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
    sql_on: ${transactions.parent_order_uid} = ${spc_buckets.parent_order_uid};;
  }

  join: spc_buckets_customers {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid} = ${spc_buckets_customers.customer_uid};;
  }


  join: bucketed_order_sales_department {
    type: left_outer
    relationship: one_to_many
    sql_on: ${transactions.parent_order_uid} = ${bucketed_order_sales_department.parent_order_uid} and ${transactions.product_department} = ${bucketed_order_sales_department.product_department} ;;
  }

  join: customer_spending {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customer_spending.customer_uid}
    and
    ${calendar_completed_date.calendar_year_month} = ${customer_spending.year_month};;
    sql_where: ${customer_spending.brand_rank_top_brands_bigquery_2} != "Other;;
  }

  join: transactions_incomplete {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${transactions_incomplete.parent_order_uid} ;;
  }

  join: customers_wk_ly {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customers_wk_ly.customer_uid} ;;
  }

  join: customers_wk_ty {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customers_wk_ty.customer_uid} ;;
  }

  join: customers_2wk_ty {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customers_2wk_ty.customer_uid} ;;
  }

  join: ds_assumed_trade {
    view_label: "Customer Classification"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${ds_assumed_trade.customer_uid};;
  }

  join: ds_assumed_trade_paul_test {
    required_access_grants: [lz_testing]
    view_label: "Customer Classification - Paul test"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${ds_assumed_trade_paul_test.customer_uid};;
  }

  join: ds_assumed_trade_history_new_lake {
    required_access_grants: [lz_testing]
    view_label: "Customer Classification - Run History"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${ds_assumed_trade_history_new_lake.customer_uid} ;;
  }

  join: assumed_trade_measures {
    required_access_grants:[tp_testing]
    view_label: "Customer Classification"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${assumed_trade_measures.customer_uid};;
  }

  join: costPrice {
    view_label: "Products"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_uid} = ${costPrice.product_uid} ;;
  }

  join: app_transactions_pre_post {
    view_label: "Other - Ad-hoc Analysis"
    required_access_grants:[is_developer]
    type: left_outer
    relationship: one_to_one
    sql_on: ${transactions.customer_uid} = ${app_transactions_pre_post.customer_uid};;
  }

  join: clickCollect {
    view_label: "Click & Collect"
    required_access_grants: [is_super]
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.transaction_uid} = ${clickCollect.transactionUID} ;;
  }

  join: ecrebobudget {
    view_label: "Ecrebo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${ecrebobudget.date_date} and ${ecrebo.campaign_group} = ${ecrebobudget.campaign_group};;
    fields: [ecrebobudget.Budget]
  }

  join: ecrebobudget_total {
    from: ecrebobudget
    view_label: "Ecrebo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${ecrebobudget_total.date_date};;
    fields: [ecrebobudget_total.totalBudget]
  }

  join: scorecard_trade_customers_filter {
    required_access_grants:[is_retail]
    view_label: "Scorecard Testing"
    type: left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid} = ${scorecard_trade_customers_filter.customer_uid};;
  }

# Hyperfinity------------
  join: behaviour_categories_monthly {
    view_label: "Hyperfinity"
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_uid}=${behaviour_categories_monthly.customerUID};;
  }

  join: behaviour_categories_monthly2 {
    from: behaviour_categories_monthly
    # fields: [behaviour_categories_monthly2.customerUID,behaviour_categories_monthly2.has_a_run,behaviour_categories_monthly2.period_code]

    view_label: "Hyperfinity (Month End)"
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid}=${behaviour_categories_monthly2.customerUID}
    and ${behaviour_categories_monthly.period_code} = ${behaviour_categories_monthly2.period_code}
    and ${behaviour_categories_monthly2.period_code} = ${calendar_completed_date.calendar_year_month2}
    ;;
  }

  join: behaviour_categories_monthly3 {
    from: behaviour_categories_monthly
    fields: [behaviour_categories_monthly3.customerUID,behaviour_categories_monthly3.has_a_run,behaviour_categories_monthly3.period_code
      ,behaviour_categories_monthly3.month_start
      ]
    view_label: "Hyperfinity (Month Start)"
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid}=${behaviour_categories_monthly3.customerUID}
          and ${behaviour_categories_monthly3.month_start} = ${calendar_completed_date.calendar_year_month2} ;;
  }

  join: behaviour_categories_monthly_most_recent {
    view_label: "Hyperfinity"
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_uid}=${behaviour_categories_monthly_most_recent.customerUID}
    and ${behaviour_categories_monthly_most_recent.run_date} = ${behaviour_categories_monthly.run_date};;
  }

  join: rfv_monthly_final {
    view_label: "Hyperfinity"
    required_access_grants: [can_use_customer_information]
    type :  left_outer
    relationship: one_to_many
    sql_on:
    ${customers.customer_uid}=${rfv_monthly_final.customerUID} and ${rfv_monthly_final.run_date} = ${behaviour_categories_monthly.run_date};;
  }


# ------------
  join: addresses {
    view_label: "Transactions"
    type :  left_outer
    relationship: many_to_many
    sql_on: ${addresses.address_uid}=${transactions.delivery_address_uid} ;;
  }

  join: customers_spend_over75_previous_month {
    view_label: "Customers"
    type :  left_outer
    relationship: one_to_one
    sql_on: ${customers_spend_over75_previous_month.customer_uid}=${customers.customer_uid} and  ${calendar_completed_date.date_first_day_prev_month} = ${customers_spend_over75_previous_month.date_first_day_month};;
  }

  join: summer_sale_skus {
    view_label: "Products"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${summer_sale_skus.product_code};;
  }

  join: tp_hire_enquiries {
    view_label: "TP Hire Enquiries"
    type :  left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid}=${tp_hire_enquiries.customerUID} and ${tp_hire_enquiries.site_uid}=${sites.site_uid};;
  }

  join: assumed_trade_adhoc {
    view_label: "Customer Classification - Paul test"
    required_access_grants: [lz_testing]
    type :  left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid}=${assumed_trade_adhoc.customer_uid};;
  }

  join:   assumed_trade_spend {
    view_label: "Customer Classification - Paul test"
    required_access_grants: [lz_testing]
    type :  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid}=${assumed_trade_spend.customer_uid} and ${calendar_completed_date.calendar_year_month} = ${assumed_trade_spend.calendar_year_month};;
  }

  join: scmatrix {
    view_label: "SC Matrix"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code}  =   ${scmatrix.product_code};;
  }

  join: ds_all_daily_department_sales {
    view_label: "Commercial Performance Report"
    required_access_grants: [lz_testing]
    type: left_outer
    relationship: one_to_one
    sql_on: ${ds_all_daily_department_sales.date_date}  =  ${base.date_date} and ${ds_all_daily_department_sales.department}=${products.department};;
  }

  join: ds_daily_sku_sales_ty_ly_lly_lw {
    view_label: "Commercial Performance Report"
    required_access_grants: [lz_testing]
    type: left_outer
    relationship: one_to_one
    sql_on: ${ds_all_daily_department_sales.date_date}  =  ${base.date_date} and ${ds_daily_sku_sales_ty_ly_lly_lw.product_code}=${products.product_code};;
  }

  join: transactions_ecrebo {
    view_label: "Ecrebo Transactions"
    required_access_grants: [ecrebo]
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code}  =  ${transactions_ecrebo.product_code} and  ${transactions.parent_order_uid}= ${transactions_ecrebo.parent_order_uid};;
  }

  join: ecrebo_discounts {
    view_label: "Ecrebo Discounts"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.product_code}  =  ${ecrebo_discounts.product_code} and  ${transactions.parent_order_uid}= ${ecrebo_discounts.parent_order_uid}
    and
    ${transactions.transaction_line_type}= ${ecrebo_discounts.transaction_line_type}
    ;;
  }

  join: ecrebo_product_code_flag {
    view_label: "Ecrebo Transactions"
    required_access_grants: [ecrebo]
    type: left_outer
    relationship: one_to_one
    sql_on: ${transactions.parent_order_uid}= ${ecrebo_product_code_flag.parent_order_uid};;
  }

  join: bdm_ka_customers2 {
    required_access_grants: [is_bdm]
    view_label: "BDM"
    type: left_outer
    relationship: many_to_many
    sql_on:  ${bdm_ka_customers2.customer_uid}=${transactions.customer_uid} and ${base.base_date_date} between ${bdm_ka_customers2.start_date} and date_sub(${bdm_ka_customers2.end_date},interval 0 day);;
  }

  join: bdm_ka_customers_combined {
    required_access_grants: [is_bdm]
    view_label: "BDM"
    type: left_outer
    relationship: many_to_many
    sql_on:  ${bdm_ka_customers_combined.customer_uid}=${transactions.customer_uid} and ${base.base_date_date} between ${bdm_ka_customers_combined.start_date} and date_sub(${bdm_ka_customers_combined.end_date},interval 0 day);;
  }

  join: tradekartcustomer {
    required_access_grants:  [can_use_customer_information]
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} =${tradekartcustomer.customerUID};;
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

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__transactions_product_department__0 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, transactions.product_department]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          transactions.product_department: "-Uncatalogued,-Marketing Vouchers,-Deleted"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__transactions_sales_channel__1 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, transactions.sales_channel]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__products_subdepartment__2 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, products.subdepartment]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          products.subdepartment: "-Delivery Charges,-Marketing Vouchers"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__customer_segmentation_cluster__3 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, customer_segmentation.cluster]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__ds_assumed_trade_customer_type_pb__4 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, ds_assumed_trade.customer_type_pb]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__sites_site_name__5 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, sites.site_name]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          sites.site_name: "-Website"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__sites_division__6 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, sites.division]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          sites.division: "Division 1,Division 2,Division 3",
          sites.site_name: "-Website"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__sites_region_name__7 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, sites.region_name]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          sites.site_name: "-Website"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__transactions_user_uid__8 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, transactions.user_uid]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          sites.site_name: "-Website",
          transactions.user_uid: "WWW,APP"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__products_product_name__9 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, products.product_name]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          transactions.product_department: "-Uncatalogued,-Marketing Vouchers,-Deleted"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__transactions_promoFlag__10 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, transactions.promoFlag]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__sites_region_name__11 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, sites.region_name]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          sites.division: "-Other Channels,-Unallocated",
          sites.site_uid: "B9,R8,B6,A2,B3,B1,RN,CN,BS,GJ,O3,C3,TK,S1,G6,AK,G4,H7,RA,CB,AI,AE,H2,FK,I3,L3,L9,BM,O1,P2,R5,R1,Site UID,S3,FQ,S7,RL,T4,W3,O7,YS"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__trade_customers_trade_type__12 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, trade_customers.trade_type]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          trade_customers.trade_type: "-NULL"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__calendar_completed_date_fiscal_year_week__transactions_is_next_day_click_and_collect__13 {
      query: {
        dimensions: [calendar_completed_date.fiscal_year_week, transactions.is_next_day_click_and_collect]
        measures: [customers.number_of_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "calendar_completed_date.fiscal_year_week" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          calendar_completed_date.fiscal_year_week: "202413,202313",
          # "customers_2wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_2wk_ty.is_customer: "Yes,No",
          # "customers_wk_ly.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ly.is_customer: "Yes,No",
          # "customers_wk_ty.is_customer" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          customers_wk_ty.is_customer: "Yes,No",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY",
          transactions.sales_channel: "CLICK & COLLECT"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }

    aggregate_table: rollup__customers_wk_ly_is_customer__customers_wk_ty_is_customer__14 {
      query: {
        dimensions: [customers_wk_ly.is_customer, customers_wk_ty.is_customer]
        measures: [transactions.number_of_unique_customers]
        filters: [
          base.select_date_range: "NOT NULL",
          base.select_date_reference: "Transaction",
          # "ds_assumed_trade.customer_type_pb" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
          ds_assumed_trade.customer_type_pb: "Combined Trade,DIY"
        ]
      }

      materialization: {
        datagroup_trigger: ts_transactions_datagroup
      }
    }
  }
