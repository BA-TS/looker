# include: "/custom_views/**/*.view"
include: "/views/prod/date/period_over_period.view"

view: base {

  derived_table: {
    sql: select date from UNNEST(GENERATE_DATE_ARRAY('2015-01-01', date(extract(year from current_date), 12, 31))) date ;;
    datagroup_trigger: toolstation_transactions_datagroup
  }

  # extends: [pop]
  extends: [period_on_period_new]

  dimension_group: base_date {
    view_label: "Calendar - Completed Date"
    group_label: "Date/Time"
    description: "Base Date"
    label: ""
    type: time
    timeframes: [raw, date]
    sql: timestamp(${TABLE}.date) ;;
  }

}
