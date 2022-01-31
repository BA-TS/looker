include: "/views/dev/sales_alert.view"

test: alert_start_date {

  # REASON FOR TEST: ensure that the starting date for the `sales_alerting` table is valid

  explore_source: sales_alerting {

    column: date {
      field: sales_alerts.date_date
    }

    limit: 1
    filters: [sales_alerts.date_date: "after 1970/01/01"]
    sorts: [sales_alerts.date_date: asc]

  }

  assert: valid_start_date {
    expression: ${base.date_date} = to_date("2021-01-01");;
  }

}


test: alert_count_date {

  # REASON FOR TEST: ensure that the `base` table has the expected number of dates

  explore_source: sales_alerting {

    column: count_of_dates {
      field: base.count_of_dates
    }

    filters: [base.select_date_range: "after 1970/01/01"]

  }

  assert: count_of_dates {
    expression: ${sales_alerting.count_of_dates} = diff_days(to_date("2015-01-01"), add_days(365,trunc_years(now())));;
  }

}


test: alert_end_date {

  # REASON FOR TEST: ensure that the ending date for the `sales_alerting` table is valid

  explore_source: sales_alerting {

    column: date {
      field: sales_alerting.date_date
    }

    limit: 1
    filters: [sales_alerts.date_date: "after 1970/01/01"]
    sorts: [sales_alerts.date_date: desc]

  }

  assert: valid_end_date {
    expression: diff_days(${sales_alerts.date_date}, add_days(-1, now())) = 0;;
  }

}
