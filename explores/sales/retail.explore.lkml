include: "/views/**/base.view"
include: "/views/**/date/**.view"
include: "/views/**/transactions.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/retail/**.view"
include: "/views/**/customer/**.view"

persist_with: ts_transactions_datagroup

explore: retail {
  required_access_grants: [is_retail]
  view_name: base
  label: "Retail"
  always_filter: {
    filters: [
      select_date_reference: "Transaction"
    ]
  }

  conditionally_filter: {
    filters: [
      select_date_range: "1 month ago for 1 month"
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
    -catalogue.catalogue_live_date
  ]

  sql_always_where:${period_over_period};;

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.total_units,transactions.refurb_pre_post,transactions.number_of_branches,transactions.aov_price,transactions.transaction_frequency,transactions.aov_units,transactions.total_units,transactions.loyalty_net_sales_percent]
    sql_on: ${base.base_date_date} = ${transactions.transaction_date_filter};;
  }

  join: sites {
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }

  join: scorecard_branch_dev{
    view_label: "Scorecard Monthly"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${scorecard_branch_dev.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${scorecard_branch_dev.siteUID} ;;
  }

  join: scorecard_branch_dev_ytd{
    view_label: "Scorecard YTD"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${scorecard_branch_dev_ytd.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${scorecard_branch_dev_ytd.siteUID} ;;
  }


  join: catalogue {
    view_label: "Catalogue"
    fields: [catalogue.catalogue_live_date]
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: google_reviews{
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${google_reviews.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${google_reviews.siteUID} ;;
  }

  join: training{
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${training.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${training.siteUID} ;;
  }

  join: lto{
    view_label: "LTO"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${sites.site_uid}=${lto.siteUID} and ${lto.month}=${calendar_completed_date.calendar_year_month2} ;;
  }

  join: appraisals {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${appraisals.siteUID} and ${calendar_completed_date.calendar_year_month2}=${appraisals.month} ;;
  }

  join: appraisals_ytd {
    view_label: "Appraisals YTD"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${appraisals_ytd.siteUID} and ${calendar_completed_date.calendar_year_month2}=${appraisals_ytd.month} ;;
  }

  join: compliance_support {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${compliance_support.siteUID} and ${calendar_completed_date.calendar_year_month2}=${compliance_support.month} ;;
  }

  join: paid_hours {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${paid_hours.siteUID} and ${calendar_completed_date.calendar_year_month2}=${paid_hours.month} ;;
  }

  join: rm_visits {
    view_label: "RM Visits"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${rm_visits.siteUID} and ${calendar_completed_date.calendar_year_month2}=${rm_visits.month} ;;
  }

  join: hs_visits {
    view_label: "Stay Safe Visits"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${hs_visits.siteUID} and ${calendar_completed_date.calendar_year_month2}=${hs_visits.month} ;;
  }

  join: stock_moves {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${stock_moves.siteUID} and ${calendar_completed_date.calendar_year_month2}=${stock_moves.month} ;;
  }

  join: stock_moves_ytd {
    view_label: "Stock Moves YTD"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${stock_moves_ytd.siteUID} and ${calendar_completed_date.calendar_year_month2}=${stock_moves_ytd.month} ;;
  }

  join: operational_compliance {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${operational_compliance.siteUID} and ${calendar_completed_date.calendar_year_month2}=${operational_compliance.month} ;;
  }

  join: apprenticeship {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${apprenticeship.siteUID} and ${calendar_completed_date.calendar_year_month2}=${apprenticeship.month} ;;
  }

  join: holiday_management {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${holiday_management.siteUID} and ${calendar_completed_date.calendar_year_month2}=${holiday_management.month} ;;
  }

  join: profit_protection {
    type: left_outer
    relationship: many_to_one
    sql_on: ${profit_protection.siteUID}=${sites.site_uid} and ${profit_protection.month}=${calendar_completed_date.calendar_year_month2} ;;
  }

  join: customer_experience {
    view_label: "Customer Experience"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customer_experience.siteUID}=${sites.site_uid} and ${customer_experience.month}=${calendar_completed_date.calendar_year_month2} ;;
  }

  join: customer_experience_trade {
    view_label: "Customer Experience"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customer_experience_trade.siteUID}=${sites.site_uid} and ${customer_experience_trade.month}=${calendar_completed_date.calendar_year_month2} ;;
  }

  join: availability_branch_ytd {
    view_label: "Availability"
    type: left_outer
    relationship: many_to_one
    sql_on: ${availability_branch_ytd.site_uid}=${sites.site_uid};;
  }

  join: availability_branch_last_week {
    view_label: "Availability"
    type: left_outer
    relationship: many_to_one
    sql_on: ${availability_branch_last_week.site_uid}=${sites.site_uid};;
  }

  join: availability_branch_ytd_py {
    view_label: "Availability"
    type: left_outer
    relationship: many_to_one
    sql_on: ${availability_branch_ytd_py.site_uid}=${sites.site_uid};;
  }

  join:retail_trading_profit_ytd {
    view_label: "P&L"
    type: left_outer
    relationship: many_to_one
    sql_on: ${retail_trading_profit_ytd.site_uid}=${sites.site_uid};;
  }

  join:break_dates_branch {
    view_label: "Break Dates"
    type: left_outer
    relationship: many_to_one
    sql_on: ${break_dates_branch.site_uid}=${sites.site_uid};;
  }

  join:change_hours {
    view_label: "Change Hours"
    type: left_outer
    relationship: many_to_one
    sql_on: ${change_hours.site_uid}=${sites.site_uid};;
  }

  join:branch_market_share {
    view_label: "Market Share"
    type: left_outer
    relationship: many_to_one
    sql_on: ${branch_market_share.site_uid}=${sites.site_uid};;
  }

  join:cannibalisation_2024 {
    view_label: "Cannibalisation"
    type: left_outer
    relationship: many_to_one
    sql_on: ${cannibalisation_2024.site_uid}=${sites.site_uid};;
  }

  join: customer_loyalty {
    view_label: "Customers"
    required_access_grants: [can_use_customer_information2]
    type :  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid}=${customer_loyalty.customer_uid}
      and  ${base.date_date} between ${customer_loyalty.loyalty_club_start_date} and ${customer_loyalty.loyalty_club_end_date};;
  }

  join: customers {
    required_access_grants: [lz_only]
    fields: [customers.customer_uid]
    view_label: "Customers"
    type :  left_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }



}
