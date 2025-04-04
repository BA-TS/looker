#connection: "toolstation"

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "/views/**/*.view"
include: "/models/backend/config.model"
include: "/views/prod/GA_data/GA4.view.lkml"
include: "/views/prod/GA_data/Videoly_funnel_GA4.view.lkml"
include: "/views/prod/GA_data/PDP_Purchase_funnel.view.lkml"
include: "/views/prod/GA_data/Search_PLP_to_PDP_funnel.view.lkml"
label: "Digital"
explore: GA4_test {
  hidden: yes
  view_name: calendar
  label: "GA4 (Old)"
  view_label: "Datetime (of event)"
  conditionally_filter: {
    filters: [
      calendar.filter_on_field_to_hide: "7 days"
    ]
    unless:[basket_buy_to_detail_trends.filter_on_field_to_hide,
      ga_digital_transactions.select_date_range]
    }

  fields: [
    ALL_FIELDS*
  ]

  join: products {
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} BETWEEN ${products.activeFrom_date} AND ${products.activeTo_date};;
  }

  join: ga_digital_transactions {
    view_label: "GA4"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ga_digital_transactions.date_date}=${calendar.date}
    and
    ((case when ${ga_digital_transactions.item_id} is null or length(${ga_digital_transactions.item_id}) != 5 then "null" else ${ga_digital_transactions.item_id} end) = ${products.product_code});;
    sql_where: ${ga_digital_transactions.date_date}=${calendar.date} ;;
  }

  join: catalogue {
    view_label: ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${calendar.date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: catPromo {
    view_label: "Products"
    type: left_outer
    relationship: many_to_many
    sql_on: ${products.product_code} = ${catPromo.Product_Code}  and ${calendar.date} between ${catPromo.live_date} and ${catPromo.end_date};;
  }

  join: calendar_completed_datev2{
    from:  calendar
    view_label: "Order Placed"
    type:  inner
    relationship: one_to_many
    sql_on: ${ga_digital_transactions.placed_date_date}=${calendar_completed_datev2.date} ;;
  }

  join: customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga_digital_transactions.customerv2}=${customers.customer_uid} ;;
  }

  join: customer_classification {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customer_classification.customer_uid} ;;
  }

  join: trade_customers {
    view_label: "Customers"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  }


  join: stock_cover {
    view_label: "Stock Cover"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.product_code} = ${stock_cover.product_code}
    and ${calendar.date} = ${stock_cover.stock_date_date};;
  }

  join: aac {
    view_label: ""
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_cover.stock_date_date} = ${aac.date} and ${products.product_uid} = ${aac.product_uid} ;;
  }

  join: videoly_funnel_ga4 {
    view_label: "Videoly Funnel"
    type: left_outer
    relationship: many_to_one
    sql_on:
    ${calendar.date} = ${videoly_funnel_ga4.date_date}
    and ${products.product_code} = ${videoly_funnel_ga4.item_id};;
  }

  join: page_type_to_purchase_funnel {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${page_type_to_purchase_funnel.date_date}
    and ((case when ${page_type_to_purchase_funnel.item_id} is null or length(${page_type_to_purchase_funnel.item_id}) != 5 then "null" else ${page_type_to_purchase_funnel.item_id} end) = ${products.product_code});;
  }

  join: basket_buy_to_detail_trends {
    view_label: "Trends"
    type: left_outer
    relationship: one_to_many
    sql_on: ${basket_buy_to_detail_trends.date_date}=${calendar.date}
    and
    ((case when ${basket_buy_to_detail_trends.item_id} is null or length(${basket_buy_to_detail_trends.item_id}) != 5 then "null" else ${basket_buy_to_detail_trends.item_id} end) = ${products.product_code});;
    sql_where: ${basket_buy_to_detail_trends.date_date}=${calendar.date} ;;
  }

  join: non_pdp_atc_purchase_funnel {
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${non_pdp_atc_purchase_funnel.date_date}
    and
    ((case when ${non_pdp_atc_purchase_funnel.item_id} is null or length(${non_pdp_atc_purchase_funnel.item_id}) != 5 then "null" else ${non_pdp_atc_purchase_funnel.item_id} end) = ${products.product_code})
      ;;
  }


}
#explore: GA4 {
  #required_access_grants: []
#   required_access_grants: [GA4_access]
#   hidden: yes
#   view_name: ga4

#   extends: []
#   label: "GA4"
#   description: "GA4 Web and App data"

#   always_filter: {
#     filters: [
#       ga4.select_date_range: "7 days"
#     ]}


#   fields: [
#     ALL_FIELDS*, - base.select_date_reference
#   ]
#   #, -base.period_over_period, -base.flexible_pop,  -base.__comparator_order__
#   #sql_always_where:
#   #${period_over_period};;

#   join: calendar_completed_date{
#     from:  calendar
#     view_label: "Date"
#     type:  inner
#     relationship: one_to_many
#     sql_on: ${ga4.date_date}=${calendar_completed_date.date} ;;
#   }

# join: base {
#   view_label: ""
#   type: inner
#   relationship: one_to_one
#   sql_on: ${base.date_date} = ${calendar_completed_date.date};;
# }


  #join: ga4 {
   # type: left_outer
  #  relationship: many_to_one
   # sql_on:
  #   ${base.date_date} = ${ga4.date_date} ;;
  #}

 #   join: products {
#     view_label: "Products"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${ga4.product_Sku} = ${products.product_code};;
#   }

#   join: app_web_data {
#     view_label: "Digital Transactions"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: regexp_extract(${ga4.transaction_id},"^.{0,11}") = ${app_web_data.OrderID}
#     and ${products.product_uid} = ${app_web_data.ProductUID}
#     and ${ga4.date_date} = ${app_web_data.Placed_date}
#     and ${base.date_date} = ${app_web_data.Placed_date};;
#   }

#   join: ga4_all_transaction_ids {
#     view_label: ""
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${ga4_all_transaction_ids.OrderID} = ${app_web_data.OrderID} ;;
#   }

#   #${app_web_data.OrderID} = regexp_extract(${ga4.transaction_id},"^.{0,11}")

#   join: catalogue {
#     view_label: ""
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${ga4.date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
#   }

#   join: videoly_funnel_ga4 {
#     view_label: "Videoly_funnel - Last Complete Week"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${ga4.date_date} = ${videoly_funnel_ga4.date_date} ;;
#   }

#   join: stock_cover {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${products.product_code} = ${stock_cover.product_code}
#       and ${ga4.date_date} = ${stock_cover.stock_date_date};;
#   }

#   join: pdp_purchase_funnel {
#     view_label: "PDP to Purchase funnel WEB ONLY - Last Complete Week"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${ga4.date_date} = ${pdp_purchase_funnel.PDP_date_date}
#     and ${products.product_code} = ${pdp_purchase_funnel.ItemID};;
#   }

#   join: search_plp_to_pdp_funnel {
#     view_label: "Search/PLP to PDP funnel - Last Complete Week"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${ga4.date_date} = ${search_plp_to_pdp_funnel.date_date} ;;
#   }





#   join: aac {
#     view_label: ""
#     type:  left_outer
#     relationship: many_to_one
#     sql_on: ${stock_cover.stock_date_date} = ${aac.date} and ${products.product_uid} = ${aac.product_uid} ;;
#   }

#   join: catPromo {
#     view_label: "Products"
#     type: left_outer
#     relationship: one_to_one
#     sql_on: ${products.product_code} = ${catPromo.Product_Code}
#     and cast(${catalogue.catalogue_id} as string) = cast(${catPromo.cycleID} as string);;
#   }

#   join: total_sessions_ga4 {
#     view_label: "Ga4"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${ga4.date_date} = ${total_sessions_ga4.date_date}
#     and ${ga4.channelGrouping} = ${total_sessions_ga4.channel_grouping};;
#   }

#   join: ga4_totalsessions_channelgrouping {
#     view_label: "Ga4"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${ga4.date_date} = ${ga4_totalsessions_channelgrouping.date_date}
#     and ${ga4.channelGrouping} = ${ga4_totalsessions_channelgrouping.channel_grouping};;
#   }

#   join: currentRetailPrice {
#     type: left_outer
#     view_label: "Products"
#     relationship: many_to_one
#     sql_on: ${products.product_uid} = ${currentRetailPrice.Product_ID};;
#   }

# }

explore: digital_reporting {
  view_name: base

  extends: []
  label: "Digital Reporting"
  description: "Explore Toolstation transactional data."

  conditionally_filter: {
    filters: [
      base.select_date_range: "54 weeks",
      select_date_reference: "Placed"

    ]
  }

 # ,
  #    select_date_reference: "app^_web^_data"

  fields: [
    ALL_FIELDS*
  ]
  #,-products.department
  sql_always_where:
    ${period_over_period}
  and
    ${productv2.isActive}
 ;;

##  ${period_over_period}
  ##and
  #join: digital_budget {
   # view_label: ""
    #type: inner
    #relationship: many_to_one
    #sql_on: ${base.date_date} = ${digital_budget.Date_date};;
  #}

  join: productv2 {
    view_label: "Products"
    from: products
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} BETWEEN ${productv2.activeFrom_date} AND ${productv2.activeTo_date};;
  }


  join: app_web_data {
    view_label: "Digital Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} = ${app_web_data.transaction_date_filter} and ${app_web_data.ProductUID} = ${productv2.product_uid};;
    #sql_where: ${app_web_data.transaction_date_filter} BETWEEN date({% date_start base.select_date_range %}) and date({% date_end base.select_date_range %}) ;;
  }


  join: channel_budget {
    view_label: "Budget"
    type:  left_outer
    relationship: many_to_one
    sql_on:
        ${base.date_date}=${channel_budget.date_date}
        AND
        ${app_web_data.salesChannel} = ${channel_budget.channel}
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

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship: one_to_many
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
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
    view_label: ""
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

  #join: summarised_daily_Sales {
   # view_label: "daily sales"
    #type: left_outer
    #relationship: many_to_one
    #sql_on: ${base.date_date} = ${summarised_daily_Sales.date_date}
     # ;;
  #}

  #--and ${total_sessions.app_web_sessions} = ${summarised_daily_Sales.App_Web}

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
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${productv2.product_uid} = ${currentRetailPrice.Product_ID} ;;
  }

  #join: TalkSport_BrandFunnel {
   # type: left_outer
    #relationship: many_to_one
    #sql_on: ${calendar_completed_date.date}=${TalkSport_BrandFunnel.Date_date} ;;
  #}

  #join: TalkSport_Customers {
    #type: left_outer
    #relationship: many_to_one
    #sql_on: (${calendar_completed_date.calendar_year} || LPAD (cast(${calendar_completed_date.week_in_year} as string),2,"0"))=cast(${TalkSport_Customers.Week_Number} as string);;
  #}


  #join: TalkSport_SOV_vs_Cost {
   # type: left_outer
    #relationship: many_to_one
    #sql_on: ${calendar_completed_date.date}=${TalkSport_SOV_vs_Cost.Date_date} ;;
  #}

  join: customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${app_web_data.CustomerID}=${customers.customer_uid} ;;
  }

  join: trade_customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${app_web_data.CustomerID}=${trade_customers.customer_uid}
    and ${customers.customer_uid}=${trade_customers.customer_uid};;
  }

  join: aac {
    view_label: ""
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_cover.stock_date_date} = ${aac.date} and ${productv2.product_uid} = ${aac.product_uid} ;;
  }

  join: catPromo {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${productv2.product_code} = ${catPromo.Product_Code} ;;
  }

  join: ga_orderids_yesterday {
    view_label: "GA Order IDs Yesterday"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga_orderids_yesterday.order_id} = ${app_web_data.OrderID}
    and ${ga_orderids_yesterday.item_id} = ${productv2.product_code};;
  }

  join: ecrebo {
    view_label: "Ecrebo"
    type: left_outer
    relationship: one_to_many
    sql_on:
    ${app_web_data.OrderID} = ${ecrebo.parent_order_uid};;
  }

  join: single_line_transactions {
    view_label: "transactions single"
    type: left_outer
    relationship: one_to_many
    sql_on: ${app_web_data.OrderID} = ${single_line_transactions.parent_order_uid} ;;
  }


  join: digitalreport_top10depts {
    view_label: "Top N Ranking"
    type: left_outer
    relationship: many_to_one
    sql_on: ${productv2.department} = ${digitalreport_top10depts.Department} ;;
    sql_where: ${digitalreport_top10depts.dept_rank_top_dept_bigquery_4} != "Other" ;;
  }

  join: ecrebobudget {
    view_label: "Ecrebo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${ecrebobudget.date_date} and ${ecrebo.campaign_group} = ${ecrebobudget.campaign_group};;
    fields: [ecrebobudget.Budget]

  }

  join: ecrebobudget_total {
    from: ecrebobudget
    view_label: "Ecrebo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.date_date} = ${ecrebobudget_total.date_date};;
    fields: [ecrebobudget_total.totalBudget]
    #sql_where: ${ecrebobudget_total.campaign_group} in ("Total") ;;

  }



}

explore: GA4_testy {
  #required_access_grants: [GA4_access_v2]
  hidden: yes
  view_name: calendar
  label: "GA4"
  view_label: "Datetime (of event)"


  conditionally_filter: {
    filters: [
      calendar.filter_on_field_to_hide: "7 days"
    ]
  }

#sql_always_where: {% if _user_attributes['ga4_access_v2'] == 'Y' %}
#${ga4_rjagdev_test.platform} = "App"
#{% else %}
#1=1
#{% endif %} ;;


  join: products {
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} BETWEEN ${products.activeFrom_date} AND ${products.activeTo_date};;
  }

  join: currentRetailPrice {
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.product_uid} = ${currentRetailPrice.Product_ID} ;;
  }

  join: ga4_rjagdev_test {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${ga4_rjagdev_test.date_date} and ${products.product_code} = (case when ${ga4_rjagdev_test.itemid} is null or length(${ga4_rjagdev_test.itemid}) != 5 then "null" else ${ga4_rjagdev_test.itemid} end);;
    sql_where: ga4_rjagdev_test._TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {% date_start calendar.filter_on_field_to_hide %}) and FORMAT_DATE('%Y%m%d', {% date_end calendar.filter_on_field_to_hide %})
    and ((${ga4_rjagdev_test.event_name} in ("search", "search_actions", "blank_search", "bloomreach_search_unknown_attribute") and not regexp_contains(${ga4_rjagdev_test.label_1}, "^(shop|SHOP)[a-zA-Z0-9]") ) or (${ga4_rjagdev_test.event_name} not in ("search", "search_actions", "blank_search", "bloomreach_search_unknown_attribute") and regexp_contains(${ga4_rjagdev_test.label_1}, "^(shop|SHOP)[a-zA-Z0-9]")) or
(${ga4_rjagdev_test.event_name} not in ("search", "search_actions", "blank_search", "bloomreach_search_unknown_attribute") and (not regexp_contains(${ga4_rjagdev_test.label_1}, "^(shop|SHOP)[a-zA-Z0-9]") or ${ga4_rjagdev_test.label_1} is null) ))
      ;;
  }

  join: ga4_transactions {
    sql: LEFT JOIN UNNEST (${ga4_rjagdev_test.transactions}) as ga4_transactions WITH OFFSET as test1;;
    relationship: one_to_one
    sql_where: ((${ga4_rjagdev_test.itemid}=${ga4_transactions.productCode}) or (${ga4_rjagdev_test.itemid} is not null and ${ga4_transactions.productCode} is null) or (${ga4_rjagdev_test.itemid} is null and ${ga4_transactions.productCode} is null)) and (regexp_contains(${ga4_transactions.OrderID}, "^([A-Z]*[0-9]*)$") or ${ga4_transactions.OrderID} is null)
    ;;
  }

  #${ga4_transactions.OrderID} not in ("(not set)")  and ${ga4_transactions.customer} is not null and

  join: catalogue {
    view_label: ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${calendar.date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: catPromo {
    view_label: "Products"
    type: left_outer
    relationship: many_to_many
    sql_on: ${products.product_code} = ${catPromo.Product_Code}  and ${calendar.date} between ${catPromo.live_date} and ${catPromo.end_date};;
  }

  join: calendar_completed_datev2{
    from:  calendar
    view_label: "Order Placed"
    type:  inner
    relationship: one_to_many
    sql_on: ${ga4_transactions.placed_date}=${calendar_completed_datev2.date} ;;
    fields: [calendar_completed_datev2.today_day_in_month,calendar_completed_datev2.today_day_in_week, calendar_completed_datev2.today_day_in_year,calendar_completed_datev2.today_date]
  }

  join: customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.User}=${customers.customer_uid} ;;
  }

  join: products2 {
    from: products
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.label_1} = ${products2.product_code};;
    fields: [product_code, product_name]

  }

  join: customer_classification {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${customer_classification.customer_uid} ;;
  }

  join: trade_customers {
    view_label: "Customers"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  }

  join: page_type_to_purchase_funnel {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${page_type_to_purchase_funnel.date_date}
      and ((case when ${page_type_to_purchase_funnel.item_id} is null or length(${page_type_to_purchase_funnel.item_id}) != 5 then "null" else ${page_type_to_purchase_funnel.item_id} end) = ${products.product_code});;
    #sql_where: _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {% date_start calendar.filter_on_field_to_hide %}) and FORMAT_DATE('%Y%m%d', {% date_end calendar.filter_on_field_to_hide %}) ;;
  }

  join: non_pdp_atc_purchase_funnel {
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${non_pdp_atc_purchase_funnel.date_date}
          and
          ((case when ${non_pdp_atc_purchase_funnel.item_id} is null or length(${non_pdp_atc_purchase_funnel.item_id}) != 5 then "null" else ${non_pdp_atc_purchase_funnel.item_id} end) = ${products.product_code})
            ;;
  }

  join: stock_cover {
    view_label: "Stock Cover"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.product_code} = ${stock_cover.product_code}
      and ${calendar.date} = ${stock_cover.stock_date_date};;
  }

  join: aac {
    view_label: ""
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_cover.stock_date_date} = ${aac.date} and ${products.product_uid} = ${aac.product_uid} ;;
  }

  join: videoly_funnel_ga4 {
    view_label: "Videoly Funnel"
    type: left_outer
    relationship: many_to_one
    sql_on:
    ${calendar.date} = ${videoly_funnel_ga4.date_date}
    and ${products.product_code} = ((case when ${videoly_funnel_ga4.item_id} is null or length(${videoly_funnel_ga4.item_id}) != 5 then "null" else ${videoly_funnel_ga4.item_id} end) = ${products.product_code});;
  }

  join: ecrebo {
    view_label: "Ecrebo"
    type: left_outer
    relationship: one_to_many
    sql_on:
    ${ga4_transactions.OrderID} = ${ecrebo.parent_order_uid};;
  }

  join: single_line_transactions {
    view_label: "transactions single"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ga4_transactions.OrderID} = ${single_line_transactions.parent_order_uid} ;;
  }

  join: ga4_landingpage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_landingpage.land_session} and ${calendar.date} = ${ga4_landingpage.date_date};;
    sql_where: ${ga4_landingpage.firstE} = 1
    ;;
  }

  join: ga4_exitpage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_exitpage.exit_session} and ${calendar.date} = ${ga4_exitpage.date_date};;
    sql_where: ${ga4_exitpage.LastE} = 1
      ;;
  }

  join: ga4_lastevent {
    from: ga4_exitpage
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_lastevent.exit_session} and ${calendar.date} = ${ga4_lastevent.date_date} and ${ga4_rjagdev_test.Mintime} = ${ga4_lastevent.Mintime} ;;
    sql_where: ${ga4_lastevent.LastE} = 1
      ;;
  }

  join: search_purchase {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${search_purchase.search_ID} and ${calendar.date} = ${search_purchase.search_date_date};;
    #sql_where: ${ga4_exitpage.LastE} = 1;;
  }

  join: recommend_purchase {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${recommend_purchase.recommend_ID} and ${calendar.date} = ${recommend_purchase.recommend_date_date} and ${products.product_code} = ${recommend_purchase.item_id};;
    #sql_where: ${ga4_exitpage.LastE} = 1;;
  }

  join: last12_week_metrics {
    type: left_outer
    relationship: one_to_many
    sql_on: ${calendar.date} = ${last12_week_metrics.date_date} ;;
  }

  join: search_purchase12W {
    from: search_purchase
    type: left_outer
    relationship: many_to_one
    view_label: "Last12 Week Metrics"
    sql_on: ${calendar.date} = ${search_purchase12W.search_date_date};;
    #fields: [search_date_date, search_purchase_rate, search_purch_diff]
  }

  join: recommend_purchase12W {
    from: recommend_purchase
    view_label: "Last12 Week Metrics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${recommend_purchase12W.recommend_date_date};;
    #sql_where: ${ga4_exitpage.LastE} = 1;;
  }

  join: oos_items_l12weeks {
    view_label: "Last12 Week Metrics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${oos_items_l12weeks.date_date};;
  }

  join: order_shippingmethod_l12weeks {
    view_label: "Last12 Week Metrics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${order_shippingmethod_l12weeks.date_date};;
  }

  join: ecrebobudget {
    view_label: "Ecrebo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${ecrebobudget.date_date} and ${ecrebo.campaign_group} = ${ecrebobudget.campaign_group};;
    fields: [ecrebobudget.Budget]

  }

  join: ecrebobudget_total {
    from: ecrebobudget
    view_label: "Ecrebo"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${ecrebobudget_total.date_date};;
    fields: [ecrebobudget_total.totalBudget]
    #sql_where: ${ecrebobudget_total.campaign_group} in ("Total") ;;
  }

  join: search_purchase_funnel {
    view_label: "Search to Purchase (inc Query)"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${search_purchase_funnel.search_date_date} ;;
  }

  join: blank_search_purchase_funnel {
    view_label: "Search to Purchase (inc Query)"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${blank_search_purchase_funnel.Blanksearch_date_date} ;;
  }



}
