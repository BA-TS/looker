include: "/views/prod/date/base.view"

# PTD #

test: PD_PP {
  explore_source: base {
    column: date {
      field: base.date_date
    }
    filters: [base.select_fixed_range: "PD", base.select_comparison_period: "Period", base.select_number_of_periods: "3"]
    sorts: [base.date_date: desc]
  }
  assert: valid {
    expression: diff_days(${base.date_date}, add_days(-1, now())) = 0 ;; # include count of dates = 1
  }
}
test: PD_PW {
  explore_source: base {
    column: date {
      field: base.date_date
    }
    filters: [base.select_fixed_range: "PD", base.select_comparison_period: "Week", base.select_number_of_periods: "3"]
    sorts: [base.date_date: desc]
  }
  assert: valid {
    expression: diff_days(${base.date_date}, add_days(-1, now())) = 0 OR diff_days(${base.date_date}, add_days(-7, add_days(-1, now()))) = 0 OR diff_days(${base.date_date}, add_days((-7 * 2), add_days(-1, now()))) = 0 ;; # include count of dates = 3
  }
}
test: PD_PM {
  explore_source: base {
    column: date {
      field: base.date_date
    }
    filters: [base.select_fixed_range: "PD", base.select_comparison_period: "Month", base.select_number_of_periods: "3"]
    sorts: [base.date_date: desc]
  }
  assert: valid {
    expression: extract_days(${base.date_date}) = extract_days(add_days(-1, now())) ;; # include count of dates = 3
  }
}
test: PD_PQ {
  explore_source: base {
    column: date {
      field: base.date_date
    }
    filters: [base.select_fixed_range: "PD", base.select_comparison_period: "Quarter", base.select_number_of_periods: "3"]
    sorts: [base.date_date: desc]
  }
  assert: valid {
    expression: diff_days(${base.date_date}, add_days(-1, now())) = 0 OR diff_days(${base.date_date}, add_days(-91, add_days(-1, now()))) = 0 OR diff_days(${base.date_date}, add_days((-91 * 2), add_days(-1, now()))) = 0 ;; # include count of dates = 3
  }
}
# test: PD_PH {}
test: PD_PY {
  explore_source: base {
    column: date {
      field: base.date_date
    }
    filters: [base.select_fixed_range: "PD", base.select_comparison_period: "Year", base.select_number_of_periods: "3"]
    sorts: [base.date_date: desc]
  }
  assert: valid {
    expression: diff_days(${base.date_date}, add_days(-1, now())) = 0 OR diff_days(${base.date_date}, add_days(-364, add_days(-1, now()))) = 0 OR diff_days(${base.date_date}, add_days((-364 * 2), add_days(-1, now()))) = 0 ;; # include count of dates = 3
  }
}









# test: WTD_PP {
#   explore_source: base {
#     column: date {
#       field: base.date_date
#     }
#     column: day_of_week {
#       field: base.dynamic_day_of_week
#     }

#     filters: [base.select_fixed_range: "WTD", base.select_comparison_period: "Period", base.select_number_of_periods: "3"]
#     sorts: [base.date_date: desc]

#   }
#   assert: valid {
#     expression: count(${base.date_date}) = case(when(row()=1,${base.dynamic_day_of_week}*1),0) ;;
#   }
# }


# test: WTD_PW {
#   explore_source: base {
#     column: date {
#       field: base.date_date
#     }
#     column: day_of_week {
#       field: base.dynamic_day_of_week
#     }
#     filters: [base.select_fixed_range: "WTD", base.select_comparison_period: "Week", base.select_number_of_periods: "3"]
#     sorts: [base.date_date: desc]
#   }
#   assert: valid {
#     expression: count(${base.date_date}) = case(when(row()=1,${base.dynamic_day_of_week}*3),0) ;;
#   }
# }


# test: WTD_PM {
#   explore_source: base {
#     column: date {
#       field: base.date_date
#     }
#     column: day_of_week {
#       field: base.dynamic_day_of_week
#     }
#     filters: [base.select_fixed_range: "WTD", base.select_comparison_period: "Month", base.select_number_of_periods: "3"]
#     sorts: [base.date_date: desc]
#   }
#   assert: valid {
#     expression: count(${base.date_date}) = case(when(row()=1,${base.dynamic_day_of_week}*3),0) ;;
#   }
# }


# test: WTD_PQ {
#   explore_source: base {
#     column: date {
#       field: base.date_date
#     }
#     column: day_of_week {
#       field: base.dynamic_day_of_week
#     }
#     filters: [base.select_fixed_range: "WTD", base.select_comparison_period: "Quarter", base.select_number_of_periods: "3"]
#     sorts: [base.date_date: desc]
#   }
#   assert: valid {
#     expression: count(${base.date_date}) = case(when(row()=1,${base.dynamic_day_of_week}*3),0) ;;
#   }
# }


# # test: WTD_PH {}


# test: WTD_PY {
#   explore_source: base {
#     column: date {
#       field: base.date_date
#     }
#     column: day_of_week {
#       field: base.dynamic_day_of_week
#     }
#     filters: [base.select_fixed_range: "WTD", base.select_comparison_period: "Year", base.select_number_of_periods: "3"]
#     sorts: [base.date_date: desc]
#   }
#   assert: valid {
#     expression: count(${base.date_date}) = case(when(row()=1,${base.dynamic_day_of_week}*3),0) ;;
#   }
# }









# MTD #

# test: MTD_PP {}
# test: MTD_PD {}
# test: MTD_PW {}
# test: MTD_PM {}
# test: MTD_PQ {}
# test: MTD_PH {}
# test: MTD_PY {}


# YTD #

# test: YTD_PP {}
# test: YTD_PD {}
# test: YTD_PW {}
# test: YTD_PM {}
# test: YTD_PQ {}
# test: YTD_PH {}
# test: YTD_PY {}
