include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/transactions.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/retail/**.view"

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
    fields: [transactions.refurb_pre_post,transactions.number_of_branches]
    sql_on: ${base.base_date_date} = ${transactions.transaction_date_filter};;
  }

  join: sites {
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }

  join: scorecard_branch_dev{
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${scorecard_branch_dev.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${scorecard_branch_dev.siteUID} ;;
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
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${sites.site_uid}=${lto.siteUID} ;;
  }

  join: appraisals {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${appraisals.siteUID} and ${calendar_completed_date.calendar_year_month2}=${appraisals.month} ;;
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
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${rm_visits.siteUID} and ${calendar_completed_date.calendar_year_month2}=${rm_visits.month} ;;
  }

  join: stock_moves {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${stock_moves.siteUID} and ${calendar_completed_date.calendar_year_month2}=${stock_moves.month} ;;
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

}
