include: "/views/**/*.view"

explore: customers {

  label: "Customer"
  description: "Explore Toolstation customer data."

  required_access_grants: [can_use_customer_information]

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
      ;;
  }

  join: products {
    type:  left_outer
    relationship: many_to_one
    sql_on:
          ${transactions.product_uid}=${products.product_uid}
      ;;
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
}

# EXAMPLES #

explore: +customers {


  query: CRM1 {

    label: "Customer 20 Turbo Stores"
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

  query: CRM2{

    label: "Customer selection"
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

  query: CRM3{

    label: "Customer Address Check"
    description: "This provides information to user."

    dimensions: [
      customer_uid,
      customers.customer__first_name,
      customers.customer__last_name,
      customers.address__address_line1,
      customers.address__address_line2,
      customers.address__address_line3
    ]

    limit: 500
  }


}
