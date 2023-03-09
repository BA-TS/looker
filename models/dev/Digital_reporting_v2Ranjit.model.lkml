#connection: "toolstation"

include: "/views/**/*.view"
#include: "/views/dev/cg_testing/catalogue.view.lkml"

explore: base {

  extends: []
  label: "Summarised sales"
  description: "Explore Toolstation transactional data."

  always_filter: {
    filters: [
      select_date_type: "Calendar",
      select_date_reference: "summarised^_daily^_Sales"
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
    ALL_FIELDS*
  ]

  sql_always_where:

  ${period_over_period}

        ;;

    join: summarised_daily_Sales {
      view_label: "daily sales"
      type: left_outer
      relationship: many_to_one
      sql_on: ${base.date_date} = ${summarised_daily_Sales.dated_date};;
    }

  join: digital_budget {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date}=${digital_budget.Date_date} ;;
  }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
  }

  join: dim_date {
    type: inner
    relationship: one_to_one
    sql_on: ${base.date_date}=${dim_date.fullDate_date} ;;
  }

  join: total_sessions {
    type: inner
    relationship: many_to_one
    sql_on: ${summarised_daily_Sales.App_Web}=${total_sessions.app_web_sessions} and
      ${base.date_date}=${total_sessions.date_date};;

  }

}



explore: +base {

  query: App_Web_weekly_sales {

    label: "Weekly Sales (By trolley method)"
    description: "This provides information to user."

    dimensions: [
      base.combined_week, summarised_daily_Sales.App_Web
    ]
    measures: [
      summarised_daily_Sales.revenueDaily
    ]
    filters: [
      base.select_date_range: "28 days ago for 28 days"
    ]
    limit: 500
    sorts: [
      base.combined_week: desc,
      summarised_daily_Sales.App_Web: asc
    ]
    pivots: [
      base.date_date
    ]

  }

  query: method_daily_performance {

    label: "7 Day Performance (By method)"
    description: "This provides information to user."

    dimensions: [
      base.date_date, summarised_daily_Sales.App_Web
    ]
    measures: [
      summarised_daily_Sales.TotalNetSaleDaily,
      summarised_daily_Sales.MarginDaily
    ]
    filters: [
      base.select_date_range: "7 days ago for 7 days"
    ]
    limit: 500
    sorts: [
      base.date_date: desc,
      summarised_daily_Sales.App_Web: asc,
      summarised_daily_Sales.TotalNetSaleDaily: desc
    ]
    pivots: [
      base.date_date
    ]

  }

}
