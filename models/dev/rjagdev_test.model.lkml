#connection: "toolstation"

include: "/views/**/*.view"
include: "/models/backend/config.model"
include: "/views/prod/GA_data/GA4.view.lkml"
include: "/views/prod/GA_data/Videoly_funnel_GA4.view.lkml"
include: "/views/prod/GA_data/PDP_Purchase_funnel.view.lkml"
include: "/views/prod/GA_data/Search_PLP_to_PDP_funnel.view.lkml"
include: "/views/prod/GA_data/suggested_byPRovider_purchase.view.lkml"
# include all views in the views/ folder in this project
label: "Digital"

explore: GA4_testy {
  #required_access_grants: [GA4_access_v2]
  view_name: calendar
  label: "GA4"
  view_label: "Datetime (of event)"


  always_filter: {
    filters: [
      calendar.filter_on_field_to_hide: "7 days"
    ]
  }



  join: products {
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} BETWEEN ${products.activeFrom_date} AND ${products.activeTo_date};;
  }

  join: currentRetailPrice {
    view_label: "Products"
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_uid} = ${currentRetailPrice.Product_ID} ;;
  }

  join: ga4_rjagdev_test {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${ga4_rjagdev_test.date_date} and ${products.product_code} = (case when ${ga4_rjagdev_test.itemid} is null or length(${ga4_rjagdev_test.itemid}) != 5 then "null" else ${ga4_rjagdev_test.itemid} end);;
    sql_where: ga4_rjagdev_test._TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {% date_start calendar.filter_on_field_to_hide %}) and FORMAT_DATE('%Y%m%d', {% date_end calendar.filter_on_field_to_hide %});;



  }

  join: ga4_transactions {
    sql: LEFT JOIN UNNEST (${ga4_rjagdev_test.transactions}) as ga4_transactions WITH OFFSET as test1;;
    relationship: one_to_one
    sql_where:
    (regexp_contains(${ga4_transactions.OrderID}, "^([A-Z]*[0-9]*)$") or ${ga4_transactions.OrderID} is null or ${ga4_transactions.OrderID} in ("(not set)"))
      ;;
  }

      #Start---------------------
    #((${ga4_rjagdev_test.itemid}=${ga4_transactions.productCode}) or #(${ga4_rjagdev_test.itemid} is not null and ${ga4_transactions#
    #.productCode} is null) or (${ga4_rjagdev_test.itemid} is null and
    #--${ga4_transactions.productCode} is null)) and
    #------------end------------------------
    #and

  join: fu  {
    view_label: "GA4"
    sql: left join unnest(SPLIT(${ga4_rjagdev_test.filterUSed}, ",")) as fu WITH OFFSET as test2;;
    relationship: one_to_many
  }

  join: products2 {
    from: products
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.label_1} = ${products2.product_code};;
    fields: [product_code, product_name]
  }

  #${ga4_transactions.OrderID} not in ("(not set)")  and ${ga4_transactions.customer} is not null and

  join: catalogue {
    view_label: ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${calendar.date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: promoworking {
    view_label: "Products"
    type: left_outer
    relationship: many_to_many
    sql_on: ${products.product_code} = ${promoworking.Product_Code}  and ${calendar.date} between ${promoworking.live_date} and ${promoworking.end_date};;
  }


  #join: calendar_completed_datev2{
    #from:  calendar
    #view_label: "Order Placed"
    #type:  inner
    #relationship: one_to_many
    #sql_on: ${ga4_transactions.placed_date}=${calendar_completed_datev2.date} ;;
    #fields: [calendar_completed_datev2.today_day_in_month,calendar_completed_datev2.today_day_in_week, calendar_completed_datev2.today_day_in_year,calendar_completed_datev2.today_date]
  #}

  join: customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_transactions.customer}=${customers.customer_uid} ;;
  }

  join: customer_classification {
    view_label: "Customers"
    type: left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid} = ${customer_classification.customer_uid} ;;
  }

  join: trade_customers {
    view_label: "Customers"
    type:  left_outer
    relationship: one_to_one
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
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_landingpage.land_session} and ${calendar.date} = ${ga4_landingpage.date_date} and ${ga4_rjagdev_test.page_locationHidden} = ${ga4_landingpage.land_page};;
    #sql_where: ${ga4_landingpage.firstE} = 1;;
  }

  join: ga4_exitpage {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_exitpage.exit_session} and ${calendar.date} = ${ga4_exitpage.date_date} and ${ga4_rjagdev_test.page_locationHidden} = ${ga4_exitpage.exit_page};;
    #sql_where: ${ga4_exitpage.LastE} = 1;;
  }

  join: ga4_lastevent {
    view_label: ""
    from: ga4_exitpage
    type: left_outer
    relationship: many_to_one
    sql_on: ${ga4_rjagdev_test.session_id} = ${ga4_lastevent.exit_session} and ${calendar.date} = ${ga4_lastevent.date_date} and ${ga4_rjagdev_test.Mintime} = ${ga4_lastevent.Mintime} ;;
    fields: [ga4_lastevent.LastE]
    #sql_where: ${ga4_lastevent.LastE} = 1;;
  }

  join: search_purchase {
    view_label: "GA4"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${search_purchase.search_date_date};;
    #sql_where: ${ga4_exitpage.LastE} = 1;;
  }

  join: recommend_purchase {
    view_label: "Last12 Week Metrics"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${recommend_purchase.recommend_date_date} and ${products.product_code} = ${recommend_purchase.item_id};;
    sql_where: ${recommend_purchase.item_id} not in ("00021", "00099", "00006", "00037", "00004","00033");;
    #${ga4_rjagdev_test.session_id} = ${recommend_purchase.recommend_ID} and
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

  #join: recommend_purchase12W {
    #from: recommend_purchase
    #view_label: "Last12 Week Metrics"
    #type: left_outer
    #relationship: many_to_one
    #sql_on: ${calendar.date} = ${recommend_purchase12W.recommend_date_date};;
    #sql_where: ${ga4_exitpage.LastE} = 1;;
  #}

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

  join: suggested_byprovider_purchase {
    view_label: "Suggested item to Purchase (inc provider)"
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar.date} = ${suggested_byprovider_purchase.suggest_viewdate_date} and ${products.product_code} = coalesce(${suggested_byprovider_purchase.sku}, "null") ;;
  }



}
