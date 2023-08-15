include: "/views/**/*.view"

explore: customers {
  label: "Customer"
  description: "Explore Toolstation customer data."
  # required_access_grants: [can_use_customer_information]
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
    ${period_over_period}
    and
    ${products.isActive};;

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

  join: promo_orders {
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.transaction_uid} = ${promo_orders.order_id} and ${base.date_date} = ${promo_orders.date_date} ;;
  }

  join: promoworking {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${promoworking.Product_Code} ;;
  }
}

explore: +customers {
  query: address_check{
    label: "Customer Address and Permissions Check"
    description: "Customer Address and Permissions Check"
    dimensions: [
      customers.customer_uid,
      customers.customer__first_name,
      customers.customer__last_name,
      customers.address__address_line1,
      customers.address__address_line2,
      customers.address__address_line3,
      customers.address__postcode,
      customers.customer__email,
      customers.customer__mobile,
      customers.customer__telephone,
      customers.permissions__offers_email_opt_in,
      customers.permissions__offers_mail_opt_in,
      customers.permissions__offers_notif_opt_in,
      customers.permissions__offers_sms_opt_in
    ]
    filters: [
      base.select_date_range: "after 2000-01-01"
      # base.select_date_range: "any time"
    ]
    limit: 500
  }
  query: trade_survey{
    label: "Trade Customer Survey - 20 Turbo Stores"
    description: "A list of customers for trade survey."
    dimensions: [
      customers.customer_uid,
      customers.customer__email,
      customer_segmentation.cluster,
      customers.permissions__offers_email_opt_in
    ]
    filters: [
      customers.permissions__offers_email_opt_in: "Yes",
      base.select_date_range: "after 2022-01-01",
      customers.customer__email: "-NULL",
      customer_segmentation.cluster: "T%",
      sites.site_uid: "B1,B6,FQ,H7,L3,M2,O1,R1,RA,RL"
    ]
    limit: 500
  }

  query: customer_selection{
    label: "Customer selection (Work in progress)"
    description: "Selecting customers for catalogue marketing"
    dimensions: [
      base.combined_week,
      transactions.product_department
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

  query: Emarsys{
    label: "Emarsys_NewCustomer_Weekly_Upload (Work in progress)"
    description: "Emarsys_NewCustomer_Weekly_Upload"
    dimensions: [
      customers.customer_uid,
      customers.customer__email,
      customers.customer__mobile,
      customers.customer__telephone,
      customers.address__address_line1,
      customers.address__address_line2,
      customers.address__address_line3,
      customers.address__address_line4,
      customers.address__address_line5,
      customers.address__postcode,
      customers.address__country,
      customers.permissions__offers_email_opt_in,
      customers.permissions__offers_mail_opt_in,
      permissions__offers_notif_opt_in,
      permissions__offers_sms_opt_in
    ]
    filters: [
      base.select_date_range: "1 days ago for 7 days"
    ]
    limit: 500
    sorts: [
      customers.customer_uid: asc
    ]
  }
}
