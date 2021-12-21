
view: open_to_buy_model {

  required_access_grants: [is_developer]

  sql_table_name:

  `toolstation-data-storage.ts_analytics.open_to_buy_model`

  ;;

  dimension_group: date {
    type: time
    timeframes: [raw, date]

    sql:

    ${TABLE}.date

    ;;
  }

  dimension: department {
    type: string
    sql:

    ${TABLE}.department

    ;;
  }

  measure: open_to_buy {
    type: sum
    sql:

    ${TABLE}.open_to_buy

    ;;
  }

  measure: stock_budget {
    type: sum
    sql:

    ${TABLE}.stock_budget

    ;;
  }

  measure: stock_forecast {
    type: sum
    sql:

    ${TABLE}.stock_forecast

    ;;
  }

}
