#connection: "toolstation"

include: "/views/**/*.view"              # include all views in the views/ folder in this project
label: "Digital"

explore: GA4_testy {
  hidden: no
  required_access_grants: [GA4_access_v2]
  view_name: calendar
  label: "ranjit Test"
  #sql_always_where:  ;;
  conditionally_filter: {
    filters: [
      calendar.filter_on_field_to_hide: "7 days"
    ]

    #unless:[ga4_rjagdev_test.select_date_range]
    }

  join: ga4_rjagdev_test {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${ga4_rjagdev_test.date_date};;
    sql_where: _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {% date_start calendar.filter_on_field_to_hide %}) and FORMAT_DATE('%Y%m%d', {% date_end calendar.filter_on_field_to_hide %})
      ;;
  }

  join: ga4_transactions {
    view_label: "GA4: Transactions"
    sql: LEFT JOIN UNNEST (${ga4_rjagdev_test.transactions}) as ga4_transactions WITH OFFSET as test1 ;;
    relationship: one_to_one
    sql_where: ((${ga4_rjagdev_test.itemid}=${ga4_transactions.productCode}) or (${ga4_rjagdev_test.itemid} is not null and ${ga4_transactions.productCode} is null) or (${ga4_rjagdev_test.itemid} is null and ${ga4_transactions.productCode} is null)) ;;
  }

  join: ga4_landingpage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_landingpage.land_session} ;;
    sql_where: ga4_landingpage._TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {% date_start calendar.filter_on_field_to_hide %}) and FORMAT_DATE('%Y%m%d', {% date_end calendar.filter_on_field_to_hide %})
      ;;
  }

  join: ga4_exitpage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_exitpage.exit_session} and ${calendar.date} = ${ga4_exitpage.date_date};;
    sql_where: ${ga4_exitpage.LastE} = 1
      ;;
  }


}
