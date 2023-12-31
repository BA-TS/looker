#connection: "toolstation"

include: "/views/**/*.view"              # include all views in the views/ folder in this project
label: "ragdev_testy_test"

explore: GA4_test {
  hidden: yes
  required_access_grants: [GA4_access]
  view_name: ga_digital_transactions
  label: "GA4 (data model in BQ)"
  always_filter: {
    filters: [
      select_date_range: "7 days"
    ]}

  join: total_sessions_ga4_dt {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga_digital_transactions.date_date} = ${total_sessions_ga4_dt.date_date}
          and
          ${ga_digital_transactions.channel_Group} = ${total_sessions_ga4_dt.channel_grouping};;
  }

}
