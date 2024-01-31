include: "/views/**/*.view"

explore: retail {
  view_name: google_reviews
  required_access_grants: [lz_testing]
  label: "Retail Scorecard"

  fields: [
    ALL_FIELDS*,
    -calendar_completed_date.date,
    -calendar_completed_date.today_date,
    -calendar_completed_date.today_calendar_quarter,
    -calendar_completed_date.today_calendar_year_month,
    -calendar_completed_date.day_in_month,
    -calendar_completed_date.today_day_in_month,
    -calendar_completed_date.day_in_week,
    -calendar_completed_date.today_day_in_week,
    -calendar_completed_date.day_in_year,
    -calendar_completed_date.today_day_in_year,
    -calendar_completed_date.today_fiscal_week_of_year,
    -calendar_completed_date.is_holiday,
    -calendar_completed_date.holiday_name,
    -calendar_completed_date.is_weekend,
    -calendar_completed_date.calendar_quarter,
    -calendar_completed_date.calendar_year_quarter
  ]

  join: calendar_completed_date{
    required_access_grants: [lz_testing]
    from:  calendar
    view_label: "Date"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${google_reviews.month}=${calendar_completed_date.calendar_year_month2} ;;
  }

  join: sites {
    view_label: "Site Information"
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${sites.site_uid} ;;
  }

  join: appraisals {
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${appraisals.siteUID} and ${google_reviews.month}=${appraisals.month} ;;
  }

  join: compliance_support {
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${compliance_support.siteUID} and ${google_reviews.month}=${compliance_support.month} ;;
  }

  join: paid_hours {
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${paid_hours.siteUID} and ${google_reviews.month}=${paid_hours.month} ;;
  }

  join: holiday_management {
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${holiday_management.siteUID} and ${google_reviews.month}=${holiday_management.month} ;;
  }

  join: profit_protection {
    type: left_outer
    relationship: many_to_one
    sql_on: ${profit_protection.siteUID}=${holiday_management.siteUID} and ${profit_protection.month}=${holiday_management.month} ;;
  }

  # join: foh_master_products_2024 {
  #   view_label: "FOH Location"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on:${foh_master_products_2024.siteUID} =${sites.site_uid} and ${calendar_completed_date.fiscal_year_week}=${foh_master_products_2024.Week}  ;;
  # }

  join: scorecard_branch_dev {
    view_label: "Scorecard Dev"
    type: left_outer
    relationship: many_to_one
    sql_on:${scorecard_branch_dev.siteUID} =${sites.site_uid} and ${google_reviews.month}=${scorecard_branch_dev.month}  ;;
  }

}
