include: "/models/backend/permissions.model"
include: "/views/**/*.view"

label: "TS - Commercial"

explore: transactions {

  # CG 04/11 TODO - look at DS report and try to collate agg table - may need to include period_ attribute TBC


  # always_filter: {
  #   filters: [period_to_date: "PD", previous_period_to_date: "CY"]
  # }
  # access_filter: {} -- to look at


  sql_always_where:
  ${pivot_period}
  AND
  (${is_cancelled} = 0 or ${is_cancelled} is null) AND (${product_code} <> '85699' or ${product_code} is null)

  ;;

    join: products {
      type:  inner
      relationship: many_to_one
      sql_on: ${transactions.product_uid}=${products.product_uid} ;;
    }

    join: channel_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: date(${transactions.transaction_date})=${channel_budget.date} and upper(${transactions.sales_channel})=upper(${channel_budget.channel}) ;;
    }

    join: site_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: date(${transactions.transaction_date})=${site_budget.date_date} and ${transactions.site_uid}=${site_budget.site_uid};;
    }

    join: category_budget {
      view_label: "Budget"
      type: full_outer
      relationship: many_to_one
      sql_on: date(${transactions.transaction_date})=${category_budget.date} and initcap(${products.department})=initcap(${category_budget.department}) ;;
    }

    join: sites {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
    }

    join: calendar_completed_date{
      from:  calendar
      view_label: "Calendar - Completed Date"
      type:  inner
      relationship:  many_to_one
      sql_on: ${transactions.transaction_date_coalesce}=${calendar_completed_date.date} ;;
    }

    join: calendar_placed_date{
      from:  calendar
      view_label: "Calendar - Placed Date"
      type:  inner
      relationship:  many_to_one
      sql_on: date(${transactions.placed_date})=${calendar_placed_date.date} ;;
    }

    join: customers {
      type :  inner
      relationship: many_to_one
      sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
    }

    join: suppliers {
      type: left_outer
      relationship: many_to_one
      sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
    }

    join: customer_segmentation {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.customer_uid} = ${customer_segmentation.ucu_uid} ;;
    }

    join: trade_customers {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${customers.customer_uid} = ${trade_customers.customer_number} ;;
    }
    join: promo_main_catalogue {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${promo_main_catalogue.product_code} and date(${transactions.transaction_date}) between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
    }
    join: promo_extra {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${promo_extra.product_code} and date(${transactions.transaction_date}) between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
    }
    join: single_line_transactions {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${transactions.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
    }
    join: product_first_sale_date {
      type: left_outer
      relationship: many_to_one
      sql_on: ${transactions.product_code} = ${product_first_sale_date.product_code} ;;
    }
  }
