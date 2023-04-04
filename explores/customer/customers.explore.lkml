include: "/views/**/*.view"

explore: customers {

  label: "Customer"
  description: "Explore Toolstation customer data."

  required_access_grants: [can_use_customer_information]

  view_name: base

  # join: trade_customers {
  #   view_label: "Budget"
  #   type: left_outer
  #   relationship: one_to_one
  #   sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid};;
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

# }

# explore: base {

  extends: []
  # label: "Transactions"
  # description: "Explore Toolstation transactional data."

  always_filter: {
    filters: [
      select_date_type: "Calendar",
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

  sql_always_where:
    ${period_over_period}

        ;;

 join: customers {
    type :  full_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }

  join: trade_credit_ids {
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_credit_ids.customer_uid} ;;

  }

  join: trade_credit_details {
    type: left_outer
    relationship: many_to_one
    sql_on: ${trade_credit_ids.main_trade_credit_account_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;

  }

 join: total_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${total_budget.total_budget_date};;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many

    sql_on:

        ${base.base_date_date} = ${transactions.transaction_date_filter}
          AND
        (${transactions.is_cancelled} = 0
          OR
        ${transactions.is_cancelled} IS NULL)

      {% if transactions.charity_status == "1" %}
      AND (transactions.product_code IN ('85699', '00053'))
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
      UPPER(${transactions.extranet_status}) = {% parameter transactions.select_extranet_status %}
      ;;

  }

  join: channel_budget {
    view_label: "Budget"
    type:  left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date}=${channel_budget.date} AND ${transactions.sales_channel} = ${channel_budget.channel}
      ;;
  }

  join: category_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date}=${category_budget.date} AND UPPER(${transactions.product_department}) = UPPER(${category_budget.department})
      ;;
  }

  join: site_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date} = ${site_budget.date_date} AND ${transactions.site_uid} = ${site_budget.site_uid}
      ;;
  }

  join: products {
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
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
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
    sql_on: ${transactions.product_code} = ${promo_main_catalogue.product_code} and ${base.date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
  }

  join: promo_extra {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_code} = ${promo_extra.product_code} and ${base.date_date} between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
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


  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
  }

  join: digital_transaction_mapping {
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
    view_label: "Digital Budget rf1 2023"
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

}
