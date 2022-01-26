include: "/views/prod/date/period_over_period.view"

view: base {

  derived_table: {
    sql:

    select date
    from UNNEST(GENERATE_DATE_ARRAY('2015-01-01', date(extract(year from current_date), 12, 31))) date

    ;;
    datagroup_trigger: toolstation_transactions_datagroup
  }

  extends: [period_on_period_new]

  dimension_group: base_date {
    type: time
    timeframes: [raw, date]
    sql:

    timestamp(${TABLE}.date)

    ;;
    hidden: yes
  }

  dimension: base_date_pk {
    primary_key: yes
    type: date
    sql:

    date(${TABLE}.date)

    ;;
    hidden: yes
  }

  measure: count_of_dates {
    type: count_distinct
    sql: ${base_date_date} ;;
    hidden: yes # only used by Data Tests
  }

}
