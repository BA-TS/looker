#connection: "toolstation"

include: "/views/**/*.view"

explore: base_noCatalogue {

  extends: []
  label: "Transactions"
  description: "Explore Toolstation transactional data."

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
      #catalogue.catalogue_name,
      #catalogue.extra_name,
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
      sql_on: ${base_noCatalogue.date_date} = ${summarised_daily_Sales.dated_date};;
    }

  join: digital_budget {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base_noCatalogue.date_date}=${digital_budget.Date_date} ;;
  }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base_noCatalogue.date_date}=${calendar_completed_date.date} ;;
  }
}


explore: +base_noCatalogue {

  query: App_Web_weekly_sales {

    label: "Weekly Sales (By trolley method)"
    description: "This provides information to user."

    dimensions: [
      base_noCatalogue.combined_week, summarised_daily_Sales.App_Web
    ]
    measures: [
      summarised_daily_Sales.revenueDaily
    ]
    filters: [
      base_noCatalogue.select_date_range: "28 days ago for 28 days"
    ]
    limit: 500
    sorts: [
      base_noCatalogue.combined_week: desc,
      summarised_daily_Sales.App_Web: asc
    ]
    pivots: [
      base_noCatalogue.date_date
    ]

  }

}
