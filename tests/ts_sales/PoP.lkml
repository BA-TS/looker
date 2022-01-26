include: "/views/prod/date/transaction_base_date.view"

# PTD #

# test: pd_vs2PP {}
# test: pd_vs2PW {}
# test: pd_vs2PM {}
test: pd_vs2PY {

  explore_source: base {

    column: date {
      field: base.date_date
    }

    filters: [base.select_date_range: "Today",base.select_comparison_period: "Year", base.select_number_of_periods: "3"]
    sorts: [base.date_date: desc]

  }

  assert: valid_selection {
    expression: diff_days(${base.date_date}, now()) = 0 OR diff_days(${base.date_date}, add_days(-364, now())) = 0 OR diff_days(${base.date_date}, add_days((-364*2), now())) = 0;;
  }

}

# WTD #


# test: wtd_vs2PP {}
# test: wtd_vs2PW {}
# test: wtd_vs2PM {}
# test: wtd_vs2PY {}


# MTD #

# test: mtd_vs2PP {}
# test: mtd_vs2PW {}
# test: mtd_vs2PM {}
# test: mtd_vs2PY {}


# YTD #

# test: ytd_vs2PP {}
# test: ytd_vs2PW {}
# test: ytd_vs2PM {}
# test: ytd_vs2PY {}
