include: "/views/prod/date/base_date.view"

test: base_start_date {

  # REASON FOR TEST: ensure that the starting date for the `base` table is valid

  explore_source: base {

    column: date {
      field: base.date_date
    }

    limit: 1
    filters: [base.select_date_range: "after 1970/01/01"]
    sorts: [base.date_date: asc]

  }

  assert: valid_start_date {
    expression: ${base.date_date} = to_date("2015-01-01");;
  }

}

test: base_count_date {

  # REASON FOR TEST: ensure that the `base` table has the expected number of dates

  explore_source: base {

    column: count_of_dates {
      field: base.count_of_dates
    }

    filters: [base.select_date_range: "after 1970/01/01"]

  }

  assert: count_of_dates {
    expression: ${base.count_of_dates} = diff_days(to_date("2015-01-01"), add_days(365,trunc_years(now())));;
  }

}


test: base_end_date {

  # REASON FOR TEST: ensure that the ending date for the `base` table is valid

  explore_source: base {

    column: date {
      field: base.date_date
    }

    limit: 1
    filters: [base.select_date_range: "0 days ago for 365 days"]
    sorts: [base.date_date: desc]

  }

  assert: valid_final_date {
    expression: ${base.date_date} = add_days(364,trunc_years(now()));;
  }

}
