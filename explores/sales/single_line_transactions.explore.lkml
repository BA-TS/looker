include: "/views/**/*.view"

explore: single_line_transactions {
  label: "Single Line Transactions"
  hidden: yes
  view_name: base
  persist_with: ts_transactions_datagroup
  always_filter: {
    filters: [
      select_date_type: "Calendar",
      select_date_reference: "Transaction"
    ]
  }
  conditionally_filter: {
    filters: [
      select_date_range: "7 days"
    ]
    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
      catalogue.catalogue_name,
      catalogue.extra_name,
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month
    ]
  }

  fields: [
    ALL_FIELDS*,
  ]

  sql_always_where:
    ${period_over_period}
    and
    ${products.isActive};;

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.number_of_transactions]
    sql_on:
        ${base.base_date_date} = ${transactions.transaction_date_filter}
          AND
        (${transactions.is_cancelled} = 0
          OR
        ${transactions.is_cancelled} IS NULL)
      {% if transactions.charity_status == "1" %}
      AND (transactions.product_code IN ('85699', '00053','44842'))
      {% else %}
      AND (${transactions.product_code} NOT IN ('85699', '00053','44842') OR ${transactions.product_code} IS NULL)
      {% endif %};;
  }

  join: products {
    type:  left_outer
    fields: [products.product_code,products.product_name,products.description]
    relationship: many_to_one
    sql_on: ${transactions.product_uid}=${products.product_uid};;
  }

  join: calendar_completed_date{
    from:  calendar
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: single_line_transactions {
    view_label: "Transactions"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
  }

  join: attached_products {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${single_line_transactions.parent_order_uid} = ${attached_products.parent_order_uid} ;;
  }

  join: catalogue {
    fields: [catalogue.catalogue_live_date]
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

}
