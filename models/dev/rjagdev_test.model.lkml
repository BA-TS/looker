#connection: "toolstation"

include: "/views/**/*.view"              # include all views in the views/ folder in this project
label: "ragdev_testy_test"

explore: GA4_testy {
  required_access_grants: [ranjit_test]
  view_name: calendar
  label: "ranjit Test"
  sql_always_where: _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', date_sub(current_date,interval 2 month)) and FORMAT_DATE('%Y%m%d', date_sub(current_date,interval 1 day))
  and ((${ga4_rjagdev_test.Item_id}=${ga4_transactions.item_id}) or (${ga4_rjagdev_test.Item_id} is not null and ${ga4_transactions.item_id} is null) or (${ga4_rjagdev_test.Item_id}=${ga4_transactions.item_id}) or (${ga4_rjagdev_test.Item_id} is null and ${ga4_transactions.item_id} is null)) ;;
  always_filter: {
    filters: [
      calendar.date: "7 days"
    ]}

  join: ga4_rjagdev_test {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${ga4_rjagdev_test.date_date};;
  }

  join: ga4_transactions {
    view_label: "GA4: Transactions"
    sql: LEFT JOIN UNNEST (${ga4_rjagdev_test.transactions}) as ga4_transactions ;;
    relationship: one_to_many
  }


}
