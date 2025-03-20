include: "/views/**/base.view"
include: "/views/**/date/**.view"
include: "/views/**/transactions.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/retail/**.view"
include: "/views/**/customer/**.view"
include: "/views/**/retail/**.view"
include: "/views/**/trade_credit_details.view"
include: "/views/**/trade_credit_ids.view"

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
    fields: [transactions.total_units,transactions.refurb_pre_post,transactions.number_of_branches,transactions.aov_price,transactions.transaction_frequency,transactions.aov_units,transactions.total_units,transactions.loyalty_net_sales_percent,transactions.trade_account_net_sales,transactions.trade_account_net_sales_percent]
    sql_on: ${base.base_date_date} = ${transactions.transaction_date_filter};;
  }

  join: trade_credit_details {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${trade_credit_ids.main_trade_credit_account_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;
  }

  join: trade_credit_ids {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_credit_ids.customer_uid} ;;
  }


  join: sites {
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }

  join: scorecard_branch_dev{
    view_label: "2024 Scorecard Monthly"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${scorecard_branch_dev.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${scorecard_branch_dev.siteUID} ;;
  }

  join: scorecard_branch_dev25{
    view_label: "2025 Scorecard Monthly"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${scorecard_branch_dev25.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${scorecard_branch_dev25.siteUID} ;;
  }

  join: scorecard_branch_dev_ytd{
    view_label: "2024 Scorecard YTD"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${scorecard_branch_dev_ytd.month}=${calendar_completed_date.calendar_year_month2} and ${sites.site_uid}=${scorecard_branch_dev_ytd.siteUID} ;;
  }

  join: scorecard_branch_dev_ytd25{
    view_label: "2025 Scorecard YTD"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${sites.site_uid}=${scorecard_branch_dev_ytd25.siteUID} ;;
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
    view_label: "Appraisals"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.site_uid}=${appraisals.siteUID} and ${calendar_completed_date.calendar_year_month2}=${appraisals.month} ;;
  }

  join: appraisals_ytd {
    view_label: "Appraisals"
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
    view_label: "Stock Moves"
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
    view_label: "Cannibalisation YTD"
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
    fields: [customers.customer_uid,customers.number_of_customers]
    view_label: "Customers"
    type :  left_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }

  join: yoy_comparison {
    required_access_grants: [lz_only]
    view_label: "YOY Comparison"
    type :  left_outer
    relationship: many_to_one
    # sql_on: ${yoy_comparison.site_uid}=${sites.site_uid}
    # and  ${base.base_date_date}=${yoy_comparison.ty_date}
    # ;;
    sql_on: ${yoy_comparison.site_uid}=${sites.site_uid}
    and  ${yoy_comparison.calendar_year_month2}=${calendar_completed_date.calendar_year_month2}
    ;;

  }

  join: yoy_comparison_py {
    required_access_grants: [lz_only]
    view_label: "YOY Comparison PY"
    type :  left_outer
    relationship: many_to_one
    # sql_on: ${yoy_comparison_py.site_uid}=${sites.site_uid}
    #       and  ${base.base_date_date}=${yoy_comparison_py.ty_date}
    #       ;;
    sql_on: ${yoy_comparison_py.site_uid}=${sites.site_uid}
    and  ${yoy_comparison_py.calendar_year_month2}=${calendar_completed_date.calendar_year_month2};;
  }

}

explore: +retail {
    aggregate_table: rollup__branch_performance {
    query: {
      dimensions: [
        branch_market_share.distance_1km,
        branch_market_share.distance_2km,
        branch_market_share.distance_5km,
        branch_market_share.urban_classification,
        branch_market_share.urban_classification_average,
        break_dates_branch.break_notice_date,
        change_hours.change_hours,
        retail_trading_profit_ytd.retail_trading_profit_ly,
        retail_trading_profit_ytd.retail_trading_profit_ty,
        sites.Is_mature_branch,
        sites.Refurb_start_date,
        sites.date_opened_year,
        sites.division,
        sites.region_name,
        sites.salesTier,
        sites.site_name,
        sites.site_uid
      ]
      measures: [availability_branch_ytd.availability, availability_branch_ytd_py.availability, scorecard_branch_dev_ytd25.NPS, scorecard_branch_dev_ytd25.ltoPercent, scorecard_branch_dev_ytd25.netSales, scorecard_branch_dev_ytd25.overallRank, scorecard_branch_dev_ytd25.pillarRankColleague, scorecard_branch_dev_ytd25.pillarRankCust, scorecard_branch_dev_ytd25.pillarRankSimplicityEfficiency, scorecard_branch_dev_ytd25.pyEBIT, scorecard_branch_dev_ytd25.pySales, scorecard_branch_dev_ytd25.py_EBIT_net_sales, scorecard_branch_dev_ytd25.tyEBIT, scorecard_branch_dev_ytd25.ty_EBIT_net_sales, scorecard_branch_dev_ytd25.var_PY_Net_Sales, scorecard_branch_dev_ytd25.var_PY_Sales_Percent, scorecard_branch_dev_ytd25.vs_PY_EBIT, transactions.loyalty_net_sales_percent, transactions.trade_account_net_sales_percent]
      filters: [
        base.select_date_range: "1 month ago for 1 month",
        base.select_date_reference: "Transaction"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }
}


explore: +retail {
  aggregate_table: rollup__scorecard {
    query: {
      dimensions: [sites.site_uid]
      measures: [scorecard_branch_dev25.NPS, scorecard_branch_dev25.anonPercent, scorecard_branch_dev25.apprenticeship, scorecard_branch_dev25.contributionVsBudget, scorecard_branch_dev25.holidayTakenPercent, scorecard_branch_dev25.labourBudgetPercent, scorecard_branch_dev25.ltoPercent, scorecard_branch_dev25.overallRank, scorecard_branch_dev25.processCompPercent, scorecard_branch_dev25.safetyCompliance, scorecard_branch_dev25.shrinkagePercent, scorecard_branch_dev25.trainingPercentCompleted, scorecard_branch_dev25.tsClubSales, scorecard_branch_dev25.tsClubSalesPercent, scorecard_branch_dev25.yoyFrequency, scorecard_branch_dev25.yoyTradeSales, scorecard_branch_dev25.yoyUPT, scorecard_branch_dev_ytd25.NPS, scorecard_branch_dev_ytd25.anonPercent, scorecard_branch_dev_ytd25.apprenticeship, scorecard_branch_dev_ytd25.contributionVsBudget, scorecard_branch_dev_ytd25.holidayTakenPercent, scorecard_branch_dev_ytd25.labourBudgetPercent, scorecard_branch_dev_ytd25.ltoPercent, scorecard_branch_dev_ytd25.processCompPercent, scorecard_branch_dev_ytd25.safetyCompliance, scorecard_branch_dev_ytd25.shrinkagePercent, scorecard_branch_dev_ytd25.trainingPercentCompleted, scorecard_branch_dev_ytd25.tsClubSales, scorecard_branch_dev_ytd25.yoyFrequency, scorecard_branch_dev_ytd25.yoyTradeSales, scorecard_branch_dev_ytd25.yoyUPT]
      filters: [
        base.select_date_range: "1 month ago for 1 month",
        base.select_date_reference: "Transaction",
        sites.Is_top_50_FY24_maturesales: "Yes"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }
}
