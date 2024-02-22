#connection: "toolstation"

include: "/views/**/*.view"              # include all views in the views/ folder in this project
label: "ragdev_testy_test"

explore: GA4_testy {
  required_access_grants: [ranjit_test]
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
    sql_where: ((${ga4_rjagdev_test.Item_id}=${ga4_transactions.item_id}) or (${ga4_rjagdev_test.Item_id} is not null and ${ga4_transactions.item_id} is null) or (${ga4_rjagdev_test.Item_id}=${ga4_transactions.item_id}) or (${ga4_rjagdev_test.Item_id} is null and ${ga4_transactions.item_id} is null)) ;;
  }


}
