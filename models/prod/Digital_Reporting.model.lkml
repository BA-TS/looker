#connection: "toolstation"

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "/views/**/*.view"
include: "/views/GA4.view.lkml"
include: "/Videoly_funnel_GA4.view.lkml"
label: "Digital"

explore: GA4 {
  #required_access_grants: []
  required_access_grants: [GA4_access]
  view_name: base

  extends: []
  label: "GA4"
  description: "GA4 Web and App data"

  always_filter: {
    filters: [
      select_date_range: "7 days"
    ]}
  #select_date_reference: "app^_web^_data",

  conditionally_filter: {
    filters:
    [
      ga4.select_date_range: "7 days"
    ]

    #total_sessionsGA4.select_date_range: "7 days",
    #,select_date_reference: "Placed"

    #stock_cover.date_filter: "Yesterday",
    #summarised_daily_Sales.date_date: "21 days",
    #,
    #EcommerceEventsGA4.select_date_range: "7 days",
    #Purchase_events_GA4.select_date_range: "7 days"

    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month,
      videoly_funnel_ga4.purchase_sessions,
      select_date_range
    ]

  }

  #,select_date_reference: "ga4"

  fields: [
    ALL_FIELDS*
  ]
  #, -base.period_over_period, -base.flexible_pop,  -base.__comparator_order__
  sql_always_where:
  ${period_over_period};;

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship: one_to_many
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

 # join: app_web_data {
  #  type: left_outer
   # relationship: many_to_one
    #sql_on: ${base.base_date_date} = ${app_web_data.transaction_date_filter} ;;
  #}

  join: ga4 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${ga4.date_date};;
  }

  join: catalogue {
    view_label: ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: products {
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4.product_Sku}=${products.product_code};;
  }

  join: videoly_funnel_ga4 {
    view_label: "Videoly_funnel"
    type: left_outer
    relationship: one_to_many
    sql_on: ${base.date_date} = ${videoly_funnel_ga4.date_date} ;;
  }

  join: stock_cover {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.product_code} = ${stock_cover.product_code}
      and ${base.base_date_date} = ${stock_cover.stock_date_date};;
  }

}

explore: digital_reporting {
  view_name: base

  extends: []
  label: "Digital Reporting"
  description: "Explore Toolstation transactional data."

  always_filter: {
    filters: [
      select_date_range: "7 days"
    ]
  }

  conditionally_filter: {
    filters:
    [
      total_sessions.select_date_range: "7 days",
      select_date_reference: "app^_web^_data",
      EcommerceEvents.session_date_filter: "7 days"
      ]

    #total_sessionsGA4.select_date_range: "7 days",

      #stock_cover.date_filter: "Yesterday",
      #summarised_daily_Sales.date_date: "21 days",
      #,
      #EcommerceEventsGA4.select_date_range: "7 days",
      #Purchase_events_GA4.select_date_range: "7 days"

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
    ALL_FIELDS*
  ]
  #,-products.department
  sql_always_where:

  ${period_over_period}
 ;;

  join: digital_budget {
    view_label: "Budget"
    type: inner
    relationship: many_to_one
    sql_on: ${base.date_date} = ${digital_budget.Date_date};;
  }

  # join: transactionsv2 {
  #   type: left_outer
  #   relationship: one_to_many

  #   sql_on:

  #       ${base.base_date_date} = ${transactionsv2.transaction_date_filter}

  #     ;;

  # }

  join: app_web_data {
    type: left_outer
    relationship: many_to_one
    sql_on:

    ${base.base_date_date} = ${app_web_data.transaction_date_filter} ;;
  }

  join: total_sessions {
    type: left_outer
    relationship: many_to_one
    sql_on:
    ${base.date_date}=${total_sessions.date_date}
    and ${app_web_data.App_web} = ${total_sessions.app_web_sessions};;
  }

  #and ${app_web_data.transaction_date_filter} = ${total_sessions.session_date_filter}
  #      ${calendar_completed_date.date}=${total_sessions.session_date_filter}
  #and ${app_web_data.App_web} = ${EcommerceEventsGA4.app_web_sessions}

  join: channel_budget {
    view_label: "Budget"
    type:  left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date}=${channel_budget.date_date} AND ${app_web_data.salesChannel} = ${channel_budget.channel}
      ;;
  }

  join: total_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${total_budget.total_budget_date};;
  }

  join: category_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date}=${category_budget.date} AND UPPER(${productv2.department}) = UPPER(${category_budget.department})
      ;;
  }

  # join: site_budget {
  #   view_label: "Budget"
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on:
  #       ${base.date_date} = ${site_budget.date_date} AND ${transactionsv2.site_uid} = ${site_budget.site_uid}
  #     ;;
  # }

  # join: sites {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.site_uid}=${sites.site_uid} ;;
  # }

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship: one_to_many
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  # join: customers {
  #   type :  inner
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.customer_uid}=${customers.customer_uid} ;;
  # }

  # join: suppliers {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  #   fields: [suppliers.master_supplier_name, suppliers.supplier_name, suppliers.supplier_uid, suppliers.supplier_planner, suppliers.sage_supplier_code]
  # }

  # join: customer_segmentation {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.customer_uid} = ${customer_segmentation.ucu_uid} ;;
  # }

  # join: trade_customers {
  #   type:  left_outer
  #   relationship: many_to_one
  #   sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  # }

  # join: products {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${app_web_data.ProductUID}=${products.product_uid}
  #     ;;
  # }

  join: EcommerceEvents {
    view_label: "Eccomerce Events"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${base.date_date}=${EcommerceEvents.date_date}
      and ${productv2.product_code}=${EcommerceEvents.product_code}
      and ${app_web_data.App_web} = ${EcommerceEvents.app_web_sessions}
      and ${total_sessions.Medium} = ${EcommerceEvents.Medium}
      and ${total_sessions.app_web_sessions} = ${EcommerceEvents.app_web_sessions}
      and ${total_sessions.deviceCategory} = ${EcommerceEvents.deviceCategory};;
  }

  join: NonEcommerceEvents {
    view_label: " Non Eccomerce Events"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${base.date_date}=${NonEcommerceEvents.date_date}
      and ${total_sessions.channel_grouping}=${NonEcommerceEvents.channel_grouping}
      and ${app_web_data.App_web} = ${NonEcommerceEvents.app_web_sessions}
      and ${total_sessions.Medium} = ${NonEcommerceEvents.Medium}
      and ${total_sessions.app_web_sessions} = ${NonEcommerceEvents.app_web_sessions}
      and ${total_sessions.deviceCategory} = ${NonEcommerceEvents.deviceCategory};;
  }

  join: productv2 {
    view_label: "Products"
    from: products
    type: left_outer
    relationship: many_to_one
    sql_on: ${app_web_data.ProductUID}=${productv2.product_uid};;
  }


  join: promo_main_catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${productv2.product_code} = ${promo_main_catalogue.product_code}
        and ${base.date_date} between ${promo_main_catalogue.live_date} and ${promo_main_catalogue.end_date} ;;
  }

  # join: promo_extra {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.product_code} = ${promo_extra.product_code} and ${base.date_date} between ${promo_extra.live_date} and ${promo_extra.end_date} ;;
  # }

  # join: single_line_transactions {
  #   type:  left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.parent_order_uid} = ${single_line_transactions.parent_order_uid} ;;
  # }

  # join: product_first_sale_date {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${transactionsv2.product_code} = ${product_first_sale_date.product_code} ;;
  # }

  # join: trade_credit_ids {

  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${customers.customer_uid} = ${trade_credit_ids.customer_uid} ;;

  # }

  # join: trade_credit_details {

  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${trade_credit_ids.main_trade_credit_account_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;

  # }

  join: catalogue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

 # join: Mobile_app {
  #  type: left_outer
   # relationship: many_to_one
    #sql_on: ${base.base_date_date} = ${Mobile_app.Date_date}
    #and ${calendar_completed_date.date}=${Mobile_app.Date_date};;
  #}

  join: summarised_daily_Sales {
    view_label: "daily sales"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${summarised_daily_Sales.date_date}
      --and ${total_sessions.app_web_sessions} = ${summarised_daily_Sales.App_Web}
      ;;
  }

#  join: digital_transaction_mapping {
 #   type: left_outer
  #  relationship: one_to_one
   # sql_on: ${transactions.parent_order_uid} = ${digital_transaction_mapping.transaction_uid} ;;
  #}

  #join: backend_digital_channel_grouping {
   # type: left_outer
    #relationship: many_to_one
    #sql_on: ${digital_transaction_mapping.channel_grouping} = ${backend_digital_channel_grouping.channel_grouping} ;;
  #}



  #${app_web_data.App_web}=${total_sessions.app_web_sessions} and

  join: stock_cover {
    type: left_outer
    relationship: many_to_one
    sql_on: ${productv2.product_code} = ${stock_cover.product_code}
    and ${base.base_date_date} = ${stock_cover.stock_date_date};;
  }

  join: currentRetailPrice {
    type: left_outer
    relationship: many_to_one
    sql_on: ${productv2.product_uid} = ${currentRetailPrice.Product_ID} ;;
  }

  join: TalkSport_BrandFunnel {
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar_completed_date.date}=${TalkSport_BrandFunnel.Date_date} ;;
  }

  join: TalkSport_Customers {
    type: left_outer
    relationship: many_to_one
    sql_on: (${calendar_completed_date.calendar_year} || LPAD (cast(${calendar_completed_date.week_in_year} as string),2,"0"))=cast(${TalkSport_Customers.Week_Number} as string);;
  }


  join: TalkSport_SOV_vs_Cost {
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar_completed_date.date}=${TalkSport_SOV_vs_Cost.Date_date} ;;
  }

  join: customers {
    type: left_outer
    relationship: many_to_one
    sql_on: ${app_web_data.CustomerID}=${customers.customer_uid} ;;
  }

  join: trade_customers {
    type: left_outer
    relationship: many_to_one
    sql_on: ${app_web_data.CustomerID}=${trade_customers.customer_uid}
    and ${customers.customer_uid}=${trade_customers.customer_uid};;
  }


}











# explore: +base {

#   extends: []
#   label: "Summarised sales"
#   description: "Explore Toolstation transactional data."

#   always_filter: {
#     filters: [
#       select_date_type: "Calendar",
#       select_date_reference: "summarised^_daily^_Sales"
#     ]
#   }


#   conditionally_filter: {
#     filters:
#     [
#       summarised_daily_Sales.dated_date: "21 days"
#     ]

#     unless: [
#       select_fixed_range,
#       dynamic_fiscal_year,
#       dynamic_fiscal_half,
#       dynamic_fiscal_quarter,
#       dynamic_fiscal_month,
#       dynamic_actual_year,
#       catalogue.catalogue_name,
#       catalogue.extra_name,
#       combined_week,
#       combined_month,
#       combined_quarter,
#       combined_year,
#       separate_month
#     ]

#   }

#   fields: [
#     ALL_FIELDS*
#   ]

#   sql_always_where:

#   ${period_over_period}

#             ;;

#   join: summarised_daily_Sales {
#     view_label: "daily sales"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${base.date_date} = ${summarised_daily_Sales.dated_date};;
#   }

#   join: digital_budget {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${base.date_date}=${digital_budget.Date_date} ;;
#   }

#   join: calendar_completed_date{
#     from:  calendar
#     view_label: "Date"
#     type:  inner
#     relationship:  many_to_one
#     sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
#   }

#   join: catalogue {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date_date} AND ${catalogue.catalogue_end_date_date} ;;
#   }

#   join: dim_date {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${base.date_date}=${dim_date.Current_Date_date} ;;
#   }

#   # join: total_sessions {
#   #   type: inner
#   #   relationship: many_to_one
#   #   sql_on: ${base.base_date_date} = ${total_sessions.date_date};;
#   #   # AND ${summarised_daily_Sales.App_Web} = ${total_sessions.app_web_sessions};;
#   # }

# }

#join: total_sessionsGA4 {
  #type: left_outer
  #relationship: many_to_one
  #sql_on:
    #${base.date_date}=${total_sessionsGA4.date_date}
    #and ${app_web_data.App_web} = ${total_sessionsGA4.app_web_sessions};;
#}

#join: Purchase_events_GA4 {
  #from:  EcommerceEventsGA4
  #view_label: "Purchase events GA4"
  #type: left_outer
  #relationship: many_to_one
  #sql_on:
    #${base.date_date}=${EcommerceEventsGA4.date_date}
    #and ${productv2.product_code}=${EcommerceEventsGA4.product_Sku}
    #and ${app_web_data.App_web} = ${EcommerceEventsGA4.app_web_sessions}
    #and ${app_web_data.OrderID} = ${EcommerceEventsGA4.transaction_id}
    #and ${total_sessionsGA4.Medium} = ${EcommerceEventsGA4.Medium}
    #and ${total_sessionsGA4.app_web_sessions} = ${EcommerceEventsGA4.app_web_sessions}
    #and ${total_sessionsGA4.deviceCategory} = ${EcommerceEventsGA4.deviceCategory}
    #and ${total_sessionsGA4.Campaign_name} = ${EcommerceEventsGA4.Campaign_name};;
#}


#join: EcommerceEventsGA4 {
  #from:  EcommerceEventsGA4
  #view_label: "EcommerceEventsGA4"
  #type: full_outer
  #relationship: many_to_one
  #sql_on:
    #${base.date_date}=${EcommerceEventsGA4.date_date}
    #and ${productv2.product_code}=${EcommerceEventsGA4.product_Sku}
    #and ${app_web_data.App_web} = ${EcommerceEventsGA4.app_web_sessions}
    #--and ${app_web_data.OrderID} = ${EcommerceEventsGA4.transaction_id}
    #and ${total_sessionsGA4.Medium} = ${EcommerceEventsGA4.Medium}
    #and ${total_sessionsGA4.app_web_sessions} = ${EcommerceEventsGA4.app_web_sessions}
    #and ${total_sessionsGA4.deviceCategory} = ${EcommerceEventsGA4.deviceCategory}
    #and ${total_sessionsGA4.Campaign_name} = ${EcommerceEventsGA4.Campaign_name};;
#}
