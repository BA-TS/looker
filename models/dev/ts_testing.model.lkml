include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Development"

explore: sites {
  required_access_grants: [is_developer]
}

explore: incremental_pdt {
  label: "DEVELOPER - Incremental PDT Testing"
  required_access_grants: [is_developer]
}

explore: base {

  required_access_grants: [test]

  label: "DEVELOPER - Retail Pricing"

  join: retail_price_history {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${retail_price_history.price_start_date} ;;
  }

  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${retail_price_history.product_uid} = ${products.product_uid} ;;
  }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.base_date_date}=${calendar_completed_date.date} ;;
  }

}
