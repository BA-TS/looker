include: "/views/**/*.view"

explore: base {

  required_access_grants: [is_developer]

  label: "TEST 1"

  conditionally_filter: {
    filters: [
      base.select_date_range: "Yesterday"
    ]
    unless: [
      select_fixed_range
    ]
  }

  fields: [
    ALL_FIELDS*
  ]

  sql_always_where:

  ${period_over_period}

    ;;

  join: ga_sessions {
    view_label: "GA Sessions"
    type: left_outer
    relationship: one_to_one
    sql_on: ${base.date_date} = ${ga_sessions.visit_start_date};;
  }

}
