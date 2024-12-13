include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/site_budget.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"

explore: aop {
  required_access_grants: [is_super]
  view_name: base
  label: "AOP"

  conditionally_filter: {
    filters: [
      calendar_completed_date.date:"2025"
    ]
  }

  fields: [
    ALL_FIELDS*,
    -calendar_completed_date.distinct_month_count,
    -calendar_completed_date.distinct_week_count,
    -calendar_completed_date.distinct_year_month_count,
    -calendar_completed_date.distinct_year_count,
    -catalogue*
  ]

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: site_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${site_budget.date_date};;
  }

  join: sites {
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${site_budget.site_uid}=${sites.site_uid} ;;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

}
