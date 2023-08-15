include: "/views/**/*.view"

explore: stock_level_date_site_product {
  required_access_grants: [can_use_supplier_information]
  view_name: base

  extends: []
  label: "Stock Holding"

  always_filter: {
    filters: [
      stock_level_date_site_product.select_date_range: "7 days"
    ]}
  #select_date_reference: "app^_web^_data",

  conditionally_filter: {
    filters:
    [
      stock_level_date_site_product.select_date_range: "7 days"
    ]

    #total_sessionsGA4.select_date_range: "7 days",
    #,select_date_reference: "Placed"

    #stock_cover.date_filter: "Yesterday",
    #summarised_daily_Sales.date_date: "21 days",
    #,
    #EcommerceEventsGA4.select_date_range: "7 days",
    #Purchase_events_GA4.select_date_range: "7 days"

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

  #,select_date_reference: "ga4"

  fields: [
    ALL_FIELDS*
  ]
  #, -base.period_over_period, -base.flexible_pop,  -base.__comparator_order__
  sql_always_where:
  ${period_over_period};;

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship: one_to_many
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: stock_level_date_site_product {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${stock_level_date_site_product.opening_stock_date} ;;
  }

  join: aac {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${aac.date} and ${stock_level_date_site_product.product_uid} = ${aac.product_uid} ;;
  }

  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${stock_level_date_site_product.product_uid} = ${products.product_uid} ;;
  }

  join: scmatrix {
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code}  =   ${scmatrix.product_code};;
  }

  join: suppliers {
    view_label: "Supplier"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  }

  join: sites {
    type: left_outer
    relationship: many_to_one
    sql_on: ${stock_level_date_site_product.site_uid} = ${sites.site_uid} ;;
  }

  join: catalogue {
    view_label: ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  # join: dc_to_shop_mapping {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${stock_level_date_site_product.site_uid} = ${dc_to_shop_mapping.site_uid} ;;
  # }

  # join: distribution_centre_names {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${dc_to_shop_mapping.distribution_centre_id} = ${distribution_centre_names.site_uid} ;;
  # }
}
