include: "/custom_views/**/*.view"

view: transactions {

  derived_table: {
    sql: select date from UNNEST(GENERATE_DATE_ARRAY('2015-01-01', date(extract(year from current_date), 12, 31))) date ;;
    datagroup_trigger: toolstation_transactions_datagroup
  }

  extends: [pop]

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
