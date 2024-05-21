include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/spi_cpi.view"
include: "/views/**/spi_cpi_weekly.view"
include: "/views/**/catalogue.view"
include: "/views/**/products.view"

explore: spi_cpi {
  required_access_grants: [is_super]
  view_name: base
  label: "SPI CPI"
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
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month
    ]
  }

  fields: [
    ALL_FIELDS*,
    -products.has_trade_products_10_subdepartments,
    -calendar_completed_date.distinct_month_count,
    -calendar_completed_date.distinct_week_count,
    -calendar_completed_date.distinct_year_month_count,
    -calendar_completed_date.distinct_year_count,
    -products.number_of_subdepartments,
    -products.manufacturer_id,
    -products.supplier_part_number,
    -products.buyer,
    -products.buying_manager,
    -products.trade_products_10_subdepartments,
    -products.product_promo,
    -catalogue.catalogue_end_date,
    -catalogue.catalogue_id,
    -catalogue.catalogue_live_date,
    -catalogue.extra_end_date,
    -catalogue.extra_id,
    -catalogue.extra_live_date,
    -catalogue.catalogue_active,
    -catalogue.extra_active,
    -catalogue.catalogue_name,
    -catalogue.extra_name
  ]

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: spi_cpi {
    view_label: "SPI CPI"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${base.date_date} = ${spi_cpi.date_date};;
  }

  join: spi_cpi_weekly {
    view_label: "SPI CPI (By Fiscal Week)"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${calendar_completed_date.fiscal_year_week} = ${spi_cpi_weekly.fiscal_year_week}
      and ${spi_cpi.productCode}=${spi_cpi_weekly.productCode};;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: products {
    view_label: "Products"
    type:  left_outer
    relationship: many_to_one
    sql_on:
    ${spi_cpi.productCode}= ${products.product_code};;
  }
}
