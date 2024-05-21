# include: "/views/**/*.view"
include: "/views/**/customers.view"
include: "/views/**/*trade_credit_ids.view"
include: "/views/**/*trade_credit_details.view"
include: "/views/**/*transactions.view"
include: "/views/**/*products.view"
include: "/views/**/*sites.view"
include: "/views/**/*catalogue.view"
include: "/views/**/*calendar.view"
include: "/views/**/*customer_segmentation.view"
include: "/views/**/*trade_customers.view"
include: "/views/**/*crm_master_seedlist.view"

explore: customers {
  label: "Customer"
  description: "Explore Toolstation customer data."
  hidden: yes
  view_name: base
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
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month
    ]
  }

  fields: [
    ALL_FIELDS*,
    -products.department,
    -customer_segmentation.trade_specific_cluster,
    -products.product_promo,
  ]

  sql_always_where:
    ${period_over_period};;

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

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.number_of_branches]
    sql_on:
        ${base.base_date_date} = ${transactions.transaction_date_filter}
          AND
        (${transactions.is_cancelled} = 0
          OR
        ${transactions.is_cancelled} IS NULL)
      {% if transactions.charity_status == "1" %}
      AND (transactions.product_code IN ('85699', '00053','44842'))
      {% else %}
      AND (${transactions.product_code} NOT IN ('85699', '00053','44842') OR ${transactions.product_code} IS NULL)
      {% endif %};;
  }

  join: products {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${transactions.product_uid}=${products.product_uid};;
  }

  join: sites {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }

  join: calendar_completed_date{
    from:  calendar
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
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

  join: single_line_transactions {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
  }

  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: crm_master_seedlist {
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} =${crm_master_seedlist.customer_uid}
        AND ${customers.customer__first_name} =${crm_master_seedlist.customer__first_name}
        AND ${customers.customer__company} =${crm_master_seedlist.customer__company}
        AND ${customers.address__address_line1} =${crm_master_seedlist.address__address_line1}
        AND ${customers.address__address_line2} =${crm_master_seedlist.address__address_line2}
        AND ${customers.address__address_line3} =${crm_master_seedlist.address__address_line3}
        AND ${customers.address__address_line4} =${crm_master_seedlist.address__address_line4}
        AND ${customers.address__postcode} =${crm_master_seedlist.address__postcode};;
  }
}
