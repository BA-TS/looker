include: "/custom_views/**/*.view"
include: "/views/prod/date/fixed_PoP.view"

view: transactions {

  sql_table_name: `sales.transactions`;;
  extends: [pop_date_comparison, period_on_period]


# ██╗░░██╗██╗██████╗░██████╗░███████╗███╗░░██╗
# ██║░░██║██║██╔══██╗██╔══██╗██╔════╝████╗░██║
# ███████║██║██║░░██║██║░░██║█████╗░░██╔██╗██║
# ██╔══██║██║██║░░██║██║░░██║██╔══╝░░██║╚████║
# ██║░░██║██║██████╔╝██████╔╝███████╗██║░╚███║
# ╚═╝░░╚═╝╚═╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝

# ██████╗░██╗███╗░░░███╗███████╗███╗░░██╗░██████╗██╗░█████╗░███╗░░██╗░██████╗
# ██╔══██╗██║████╗░████║██╔════╝████╗░██║██╔════╝██║██╔══██╗████╗░██║██╔════╝
# ██║░░██║██║██╔████╔██║█████╗░░██╔██╗██║╚█████╗░██║██║░░██║██╔██╗██║╚█████╗░
# ██║░░██║██║██║╚██╔╝██║██╔══╝░░██║╚████║░╚═══██╗██║██║░░██║██║╚████║░╚═══██╗
# ██████╔╝██║██║░╚═╝░██║███████╗██║░╚███║██████╔╝██║╚█████╔╝██║░╚███║██████╔╝
# ╚═════╝░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

  dimension: order_line_key {
    primary_key:  yes
    type:  string
    sql: concat(${parent_order_uid},${product_uid},${transaction_line_type}) ;;
    hidden:  yes
  }
  dimension: event_raw {
    type: date_raw
    sql: ${transaction_raw} ;;
    hidden: yes
  }
  dimension: cogs {
    type: number
    sql: ${TABLE}.COGS ;;
    hidden:  yes
  }
  dimension: fulfillment_channel {
    type: string
    sql: ${TABLE}.fulfillmentChannel ;;
    hidden:  yes
  }
  dimension: gross_sale_price {
    type: number
    sql: ${TABLE}.grossSalePrice ;;
    hidden: yes
  }
  dimension: gross_sales_value {
    type: number
    sql: ${TABLE}.grossSalesValue ;;
    hidden:  yes
  }
  dimension: is_cancelled {
    type: number
    sql: ${TABLE}.isCancelled ;;
    hidden:  yes
  }
  dimension: line_discount {
    type: number
    sql: ${TABLE}.lineDiscount ;;
    hidden:  yes
  }
  dimension: margin_excl_funding {
    type: number
    sql: ${TABLE}.marginExclFunding ;;
    hidden:  yes
  }
  dimension: margin_incl_funding {
    type: number
    sql: ${TABLE}.marginInclFunding ;;
    hidden:  yes
  }
  dimension: master_customer_uid {
    type: string
    sql: ${TABLE}.masterCustomerUID ;;
    hidden:  yes
  }
  dimension: net_sale_price {
    type: number
    sql: ${TABLE}.netSalePrice ;;
    hidden: yes
  }
  dimension: net_sales_value {
    type: number
    sql: ${TABLE}.netSalesValue ;;
    hidden:  yes
  }
  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }
  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }
  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    hidden:  yes
  }
  dimension: sales_channel {
    hidden: yes
    type: string
    sql: upper(${TABLE}.salesChannel) ;;
  }
  dimension: row_id {
    type: number
    sql: ${TABLE}.rowID ;;
    hidden:  yes
  }
  dimension: site_uid {
    hidden: yes
    type: string
    sql: ${TABLE}.siteUID ;;
  }
  dimension: transaction_line_type {
    type: string
    description: "Field is currently under review - please do not use"
    sql: ${TABLE}.transactionLineType ;;
    hidden:  yes
  }
  dimension: unit_funding {
    type: number
    sql: ${TABLE}.unitFunding ;;
    hidden:  yes
  }
  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updateddate ;;
    hidden:  yes
  }


# ██████╗░███████╗███╗░░██╗██████╗░██╗███╗░░██╗░██████╗░
# ██╔══██╗██╔════╝████╗░██║██╔══██╗██║████╗░██║██╔════╝░
# ██████╔╝█████╗░░██╔██╗██║██║░░██║██║██╔██╗██║██║░░██╗░
# ██╔═══╝░██╔══╝░░██║╚████║██║░░██║██║██║╚████║██║░░╚██╗
# ██║░░░░░███████╗██║░╚███║██████╔╝██║██║░╚███║╚██████╔╝
# ╚═╝░░░░░╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░

# ██╗░░██╗██╗██████╗░██████╗░███████╗███╗░░██╗
# ██║░░██║██║██╔══██╗██╔══██╗██╔════╝████╗░██║
# ███████║██║██║░░██║██║░░██║█████╗░░██╔██╗██║
# ██╔══██║██║██║░░██║██║░░██║██╔══╝░░██║╚████║
# ██║░░██║██║██████╔╝██████╔╝███████╗██║░╚███║
# ╚═╝░░╚═╝╚═╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝

  dimension: customer_uid {
    label: "Customer UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes #!
  }
  dimension: delivery_address_uid {
    label: "Delivery Address UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.deliveryAddressUID ;;
    hidden: yes #!
  }
  dimension: originating_site_uid {
    label: "Originating Site UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.originatingSiteUID ;;
    hidden: yes #!
  }
  dimension: postal_area {
    label: "Postal Area"
    type: string
    sql: ${TABLE}.postalArea ;;
    hidden: yes #!
  }
  dimension: postal_district {
    label: "Postal District"
    type: string
    sql: ${TABLE}.postalDistrict ;;
    hidden: yes #!
  }
  dimension: user_uid {
    label: "User UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.userUID ;;
    hidden: yes
  }
  dimension_group: transaction {
    label: "Transaction"
    description: "This has been temporarily added and should not be relied upon long term."
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.transactiondate ;;
    hidden: no
  }


  dimension: __core_date__ {
    view_label: "UNDER DEVELOPMENT"
    type: date
    datatype: timestamp
    sql:

    COALESCE(${TABLE}.transactiondate,DATE_ADD(CAST(${site_budget.raw_date} AS TIMESTAMP), INTERVAL 12 HOUR), DATE_ADD(CAST(${category_budget.date} AS TIMESTAMP), INTERVAL 12 HOUR), DATE_ADD(CAST(${channel_budget.date} AS TIMESTAMP), INTERVAL 12 HOUR))

    ;;
  }

  dimension: __enduser_date__ {
    view_label: "UNDER DEVELOPMENT"
    type: date
    datatype: timestamp
    sql:

    ${__core_date__}

    ;;
  }

  dimension: __pop_date__ {
    view_label: "UNDER DEVELOPMENT"
    type: date
    datatype: timestamp
    sql:

    ${__core_date__}

    ;;
  }



  dimension_group: transaction_date_coalesce {
    # required_access_grants: [is_developer]
    view_label: "Calendar - Completed Date"
    group_label: "Date/Time"
    label: "Date"
    type: time
    datatype: timestamp
    timeframes: [
      date,
      time,
      time_of_day,
      raw
    ]
    description: "Date that order reached complete status"
    sql: COALESCE(${TABLE}.transactiondate,TIMESTAMP_ADD(CAST(${site_budget.raw_date} AS TIMESTAMP), INTERVAL 12 HOUR), TIMESTAMP_ADD(CAST(${category_budget.date} AS TIMESTAMP), INTERVAL 12 HOUR), TIMESTAMP_ADD(CAST(${channel_budget.date} AS TIMESTAMP), INTERVAL 12 HOUR)) ;;
    # sql:

    # {% if
    #     category_budget.category_budget_in_query == 'TRUE'
    #     and channel_budget.channel_budget_in_query == 'TRUE'
    #     and site_budget.site_budget_in_query == 'TRUE'
    #     %}
    #     COALESCE(${TABLE}.transactiondate,timestamp_add(timestamp(${site_budget.raw_date}), INTERVAL 12 HOUR), timestamp_add(timestamp(${category_budget.date}), INTERVAL 12 HOUR), timestamp_add(timestamp(${channel_budget.date}), INTERVAL 12 HOUR))
    #   {% elsif
    #     category_budget.category_budget_in_query == 'TRUE'
    #     and channel_budget.channel_budget_in_query == 'TRUE'
    #     %}
    #     COALESCE(${TABLE}.transactiondate, timestamp_add(timestamp(${category_budget.date}), INTERVAL 12 HOUR), timestamp_add(timestamp(${channel_budget.date}), INTERVAL 12 HOUR))
    #   {% elsif
    #     category_budget.category_budget_in_query == 'TRUE'
    #     and site_budget.site_budget_in_query == 'TRUE'
    #     %}
    #     COALESCE(${TABLE}.transactiondate,timestamp_add(timestamp(${site_budget.raw_date}), INTERVAL 12 HOUR), timestamp_add(timestamp(${category_budget.date}), INTERVAL 12 HOUR))
    #   {% elsif
    #     site_budget.site_budget_in_query == 'TRUE'
    #     and channel_budget.channel_budget_in_query == 'TRUE'
    #     %}
    #     COALESCE(${TABLE}.transactiondate,timestamp_add(timestamp(${site_budget.raw_date}), INTERVAL 12 HOUR), timestamp_add(timestamp(${channel_budget.date}), INTERVAL 12 HOUR))
    #   {% elsif
    #     category_budget.category_budget_in_query == 'TRUE'
    #     %}
    #   COALESCE(${TABLE}.transactiondate, timestamp_add(timestamp(${category_budget.date}), INTERVAL 12 HOUR))
    #   {% elsif
    #     channel_budget.channel_budget_in_query == 'TRUE'
    #     %}
    #   COALESCE(${TABLE}.transactiondate, timestamp_add(timestamp(${channel_budget.date}), INTERVAL 12 HOUR))
    #   {% elsif
    #     site_budget.site_budget_in_query == 'TRUE'
    #   %}
    #   COALESCE(${TABLE}.transactiondate, timestamp_add(timestamp(${site_budget.raw_date}), INTERVAL 12 HOUR))
    #   {% else %}
    #     ${TABLE}.transactiondate
    # {% endif %}


    # ;;
  }



# ██╗░░░██╗██╗░██████╗██╗██████╗░██╗░░░░░███████╗
# ██║░░░██║██║██╔════╝██║██╔══██╗██║░░░░░██╔════╝
# ╚██╗░██╔╝██║╚█████╗░██║██████╦╝██║░░░░░█████╗░░
# ░╚████╔╝░██║░╚═══██╗██║██╔══██╗██║░░░░░██╔══╝░░
# ░░╚██╔╝░░██║██████╔╝██║██████╦╝███████╗███████╗
# ░░░╚═╝░░░╚═╝╚═════╝░╚═╝╚═════╝░╚══════╝╚══════╝

# ██████╗░██╗███╗░░░███╗███████╗███╗░░██╗░██████╗██╗░█████╗░███╗░░██╗░██████╗
# ██╔══██╗██║████╗░████║██╔════╝████╗░██║██╔════╝██║██╔══██╗████╗░██║██╔════╝
# ██║░░██║██║██╔████╔██║█████╗░░██╔██╗██║╚█████╗░██║██║░░██║██╔██╗██║╚█████╗░
# ██║░░██║██║██║╚██╔╝██║██╔══╝░░██║╚████║░╚═══██╗██║██║░░██║██║╚████║░╚═══██╗
# ██████╔╝██║██║░╚═╝░██║███████╗██║░╚███║██████╔╝██║╚█████╔╝██║░╚███║██████╔╝
# ╚═════╝░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░


  dimension: sales_channel_coalesce {
    label: "Sales Channel"
    group_label: "Purchase Details"
    type: string
    # sql:

    # {% if channel_budget.channel_budget_in_query == 'TRUE' %}
    #     initCap(coalesce(upper(${TABLE}.salesChannel),upper(${channel_budget.channel})))
    #   {% else %}
    #     initCap(upper(${TABLE}.salesChannel))
    #   {% endif %}

    # ;;
    sql: coalesce(upper(${TABLE}.salesChannel),upper(${channel_budget.channel})) ;;
  }
  dimension: site_uid_coalesce {
    label: "Site UID"
    view_label: "Sites"
    type: string
    # sql:

    # {% if site_budget.site_budget_in_query == 'TRUE' %}
    #     coalesce(${TABLE}.siteUID,${site_budget.site_uid})
    #   {% else %}
    #     ${TABLE}.siteUID
    #   {% endif %}

    # ;;
    sql: coalesce(${TABLE}.siteUID,${site_budget.site_uid}) ;;
  }
  dimension: department_coalesce {
    view_label: "Products"
    group_label: "Product Details"
    label: "Department"
    type:  string
    # sql:

    # {% if category_budget.category_budget_in_query == 'TRUE' %}
    #     coalesce(INITCAP(${products.department}),initcap(${category_budget.department}))
    #   {% else %}
    #     INITCAP(${products.department})
    #   {% endif %}

    # ;;
    sql: coalesce(INITCAP(${products.department}),initcap(${category_budget.department})) ;;
  }

  # EXTERNAL - CALENDAR #

  dimension: placed_date { # _group
    label: "Date"
    view_label: "Calendar - Placed Date"
    group_label: "Placed Date"
    description: "DEV - consider changing this to group (current issue with pre-integrated with 7 day moving average works)."
    type: date
    datatype: date
    # type: time
    # timeframes: [
    #   raw,
    #   time,
    #   date,
    #   year,
    #   month,
    #   quarter,
    # ]
    sql: ${TABLE}.placeddate ;;
  }

  # EXTERNAL - PRODUCTS #

  dimension: is_new_product {
    view_label: "Products"
    group_label: "Flags"
    label: "New Product"
    type:  yesno
    sql: (${product_first_sale_date.first_sale_date} + 182) <= ${__target_date__}    ;;
  }

  # UID #

  dimension: parent_order_uid {
    group_label: "UID"
    label: "Parent Order UID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }
  dimension: transaction_uid {
    label: "Transaction UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.transactionUID ;;
  }

  # FLAGS #

  dimension: is_lfl {
    group_label: "Flags"
    label: "LFL"
    type: yesno
    sql: ${TABLE}.isLFL = 1 ;;
  }
  dimension: is_mature {

    group_label: "Flags"
    label: "Mature"
    type: yesno
    sql: ${TABLE}.isMature = 1 ;;
  }
  dimension: is_open18_months {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Open 18 Months"
    type: yesno
    sql: ${TABLE}.isOpen18Months = 1 ;;
  }
  dimension: is_originating_lfl {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Originating LFL"
    type: yesno
    sql: ${TABLE}.isOriginatingLFL = 1 ;;
  }
  dimension: is_originating_mature {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Originating Mature"
    type: yesno
    sql: ${TABLE}.isOriginatingMature = 1 ;;
  }
  dimension: is_originating_open18_months {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Originating Open (18 Months)"
    type: yesno
    sql: ${TABLE}.isOriginatingOpen18Months = 1 ;;
  }

  # ORDER DETAILS #

  dimension: order_reason {
    required_access_grants: [is_developer]
    group_label: "Order Details"
    label: "Reason for Order"
    type: string
    sql: ${TABLE}.orderReason ;;
  }
  dimension: order_special_requests {
    required_access_grants: [is_developer]
    group_label: "Order Details"
    label: "Special Requests"
    type: string
    sql: ${TABLE}.orderSpecialRequests ;;
  }

  # PURCHASE DETAILS #

  dimension: payment_type {
    group_label: "Purchase Details"
    label: "Payment Type"
    type: string
    sql: ${TABLE}.paymentType ;;
  }
  dimension: vat_rate {
    group_label: "Purchase Details"
    label: "VAT Rate"
    type: number
    sql: ${TABLE}.vatRate ;;
  }

  # PROMO #

  dimension: promo_in_main_catalogue {
    label: "In Main Catalogue"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: yesno
    sql: case when ${promo_main_catalogue.product_code} is null then false else true end ;;
  }
  dimension: promo_in_extra {
    label: "In Extra"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: yesno
    sql: case when ${promo_extra.product_code} is null then false else true end ;;
  }
  dimension: promo_in_any {
    label: "In Any"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: yesno
    sql: case when ${promo_main_catalogue.product_code} is null and ${promo_extra.product_code} is null then false else true end ;;
  }


# ██╗░░██╗██╗██████╗░██████╗░███████╗███╗░░██╗
# ██║░░██║██║██╔══██╗██╔══██╗██╔════╝████╗░██║
# ███████║██║██║░░██║██║░░██║█████╗░░██╔██╗██║
# ██╔══██║██║██║░░██║██║░░██║██╔══╝░░██║╚████║
# ██║░░██║██║██████╔╝██████╔╝███████╗██║░╚███║
# ╚═╝░░╚═╝╚═╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝

# ███╗░░░███╗███████╗░█████╗░░██████╗██╗░░░██╗██████╗░███████╗░██████╗
# ████╗░████║██╔════╝██╔══██╗██╔════╝██║░░░██║██╔══██╗██╔════╝██╔════╝
# ██╔████╔██║█████╗░░███████║╚█████╗░██║░░░██║██████╔╝█████╗░░╚█████╗░
# ██║╚██╔╝██║██╔══╝░░██╔══██║░╚═══██╗██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
# ██║░╚═╝░██║███████╗██║░░██║██████╔╝╚██████╔╝██║░░██║███████╗██████╔╝
# ╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░

  # move dimensions that directly feed visible measures into here - TODO



# ██████╗░███████╗███╗░░██╗██████╗░██╗███╗░░██╗░██████╗░
# ██╔══██╗██╔════╝████╗░██║██╔══██╗██║████╗░██║██╔════╝░
# ██████╔╝█████╗░░██╔██╗██║██║░░██║██║██╔██╗██║██║░░██╗░
# ██╔═══╝░██╔══╝░░██║╚████║██║░░██║██║██║╚████║██║░░╚██╗
# ██║░░░░░███████╗██║░╚███║██████╔╝██║██║░╚███║╚██████╔╝
# ╚═╝░░░░░╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░

# ██╗░░██╗██╗██████╗░██████╗░███████╗███╗░░██╗
# ██║░░██║██║██╔══██╗██╔══██╗██╔════╝████╗░██║
# ███████║██║██║░░██║██║░░██║█████╗░░██╔██╗██║
# ██╔══██║██║██║░░██║██║░░██║██╔══╝░░██║╚████║
# ██║░░██║██║██████╔╝██████╔╝███████╗██║░╚███║
# ╚═╝░░╚═╝╚═╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝

  measure: net_sales_promo_mix {
    type: number
    sql:
              sum(CASE
              WHEN ${promo_in_any}
                THEN ${net_sales_value}
              ELSE 0
              END) / sum(${net_sales_value})

              ;;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }
  measure: margin_rate_promo {
    type: number
    group_label: "Margin"
    sql:

              sum(CASE
              WHEN ${promo_in_any}
                THEN ${margin_incl_funding}
              ELSE 0
              END) /
              sum(CASE
              WHEN ${promo_in_any}
                THEN ${net_sales_value}
              ELSE 0
              END)
              ;;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }
  measure: trade_net_margin {
    type: sum
    label: "Total Margin inc (Trade Only)"
    group_label: "Margin"
    description: "Placed in Transactions due to potential permissions requirement on Customers"
    sql: CASE WHEN ${is_trade_customer} THEN ${margin_incl_funding} else 0 END ;;
    hidden: yes
  }
  measure: diy_net_margin {
    type: sum
    label: "Total Margin inc (DIY Only)"
    group_label: "Margin"
    description: "Placed in Transactions due to potential permissions requirement on Customers; Where is not %T then assuming trade to avoid dropping data"
    sql: CASE WHEN NOT ${is_trade_customer} THEN ${margin_incl_funding} else 0 END ;;
    hidden: yes
  }
  measure: trade_net_units {
    type: sum
    label: "Total Net Units (Trade Only)"
    group_label: "Unit"
    description: "Placed in Transactions due to potential permissions requirement on Customers"
    sql: CASE WHEN ${is_trade_customer} THEN ${quantity} else 0 END ;;
    hidden: yes
  }
  measure: diy_net_units {
    type: sum
    label: "Total Net Units (DIY Only)"
    group_label: "Unit"
    description: "Placed in Transactions due to potential permissions requirement on Customers; Where is not %T then assuming trade to avoid dropping data"
    sql: CASE WHEN NOT ${is_trade_customer} THEN ${quantity} else 0 END ;;
    hidden: yes
  }
  measure: margin_rate_core {
    type: number
    group_label: "Margin"
    sql:


          sum(CASE
        WHEN not ${promo_in_any}
          THEN ${margin_incl_funding}
        ELSE 0
        END) /
        sum(CASE
        WHEN not ${promo_in_any}
          THEN ${net_sales_value}
        ELSE 0
        END)

                      ;;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }
  measure: net_sales_PT {
    label: "% Net Sales - PT"
    type: number
    sql:

                      sum(CASE
                      WHEN ${department_coalesce} = "Power Tools"
                      THEN ${net_sales_value}
                      ELSE 0
                      END) / sum(${net_sales_value})

                      ;;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }
  measure: net_sales_trade_category{
    type: number
    sql:

                      sum(CASE
                      WHEN ${products.trade_department}
                      THEN ${net_sales_value}
                      ELSE 0
                      END) / sum(${net_sales_value})

                      ;;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }
  measure: net_sales_non_trade_category{
    type: number
    sql:

                      sum(CASE
                      WHEN not ${products.trade_department}
                      THEN ${net_sales_value}
                      ELSE 0
                      END) / sum(${net_sales_value})

                      ;;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }
  dimension: customer_cluster{
    type: string
    description: "Placed in Transactions due to potential permissions requirement on Customers"
    sql: ${customer_segmentation.cluster};;
    hidden: yes #!
  } #!
  dimension: is_trade_customer {
    type: yesno
    description: "Placed in Transactions due to potential permissions requirement on Customers"
    sql: CASE WHEN ${customer_cluster} LIKE "T%" THEN true else false END ;;
    hidden: yes #!
  } #!



# ██╗░░░██╗██╗░██████╗██╗██████╗░██╗░░░░░███████╗
# ██║░░░██║██║██╔════╝██║██╔══██╗██║░░░░░██╔════╝
# ╚██╗░██╔╝██║╚█████╗░██║██████╦╝██║░░░░░█████╗░░
# ░╚████╔╝░██║░╚═══██╗██║██╔══██╗██║░░░░░██╔══╝░░
# ░░╚██╔╝░░██║██████╔╝██║██████╦╝███████╗███████╗
# ░░░╚═╝░░░╚═╝╚═════╝░╚═╝╚═════╝░╚══════╝╚══════╝

# ███╗░░░███╗███████╗░█████╗░░██████╗██╗░░░██╗██████╗░███████╗░██████╗
# ████╗░████║██╔════╝██╔══██╗██╔════╝██║░░░██║██╔══██╗██╔════╝██╔════╝
# ██╔████╔██║█████╗░░███████║╚█████╗░██║░░░██║██████╔╝█████╗░░╚█████╗░
# ██║╚██╔╝██║██╔══╝░░██╔══██║░╚═══██╗██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
# ██║░╚═╝░██║███████╗██║░░██║██████╔╝╚██████╔╝██║░░██║███████╗██████╔╝
# ╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░

  # Core #

  measure: total_gross_sales {
    label: "Gross Sales"
    type:  sum
    group_label: "Core"
    sql: ${gross_sales_value} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: total_net_sales {
    label: "Net Sales"
    group_label: "Core"
    type:  sum
    sql: ${net_sales_value} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: total_cogs {
    label: "Total COGS"
    group_label: "Core"
    type:  sum
    sql: ${cogs} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
    hidden: no
  }
  measure: total_unit_funding {
    label: "Total Unit Funding"
    group_label: "Core"
    type:  sum
    sql: ${unit_funding} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
    hidden: no
  }
  measure: total_margin_excl_funding {
    label: "Margin (Excluding Funding)"
    group_label: "Core"
    type:  sum
    sql: ${margin_excl_funding} ;;
  }
  measure: total_margin_incl_funding {
    label: "Margin (Including Funding)"
    group_label: "Core"
    type:  sum
    sql: ${margin_incl_funding} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: total_margin_rate_excl_funding {
    label: "Margin Rate (Excluding Funding)"
    group_label: "Core"
    type:  number
    sql:
      SAFE_DIVIDE(${total_margin_excl_funding}, ${total_net_sales})
     ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: total_margin_rate_incl_funding {
    label: "Margin Rate (Including Funding)"
    group_label: "Core"
    type:  number
    sql:
    SAFE_DIVIDE(${total_margin_incl_funding}, ${total_net_sales}) ;;
    value_format: "0.00%;(0.00%)"
  }
  measure: total_units {
    label: "Total Units"
    group_label: "Core"
    type:  sum
    sql: case when ${product_code} like '0%' then 0 else ${quantity} end ;;
    value_format: "#,##0;(#,##0)"
  }
  measure: total_units_incl_system_codes {
    label: "Total Units (System Codes)"
    group_label: "Core"
    type:  sum
    sql: ${quantity} ;;
    value_format: "#,##0;(#,##0)"
  }
  measure: number_of_transactions {
    label: "Number of Transactions"
    group_label: "Core"
    type: count_distinct
    sql: ${parent_order_uid} ;;
    value_format: "#,##0;(#,##0)"
  }
  measure: number_of_unique_customers {
    label: "Number of Customers"
    group_label: "Core"
    type: count_distinct
    sql: ${customer_uid} ;;
    value_format: "#,##0;(#,##0)"
  }

  # Detail SEGMENT (T/D only) #

  measure: number_of_trade_customers {
    required_access_grants: [is_expert]
    group_label: "Segmentation"
    label: "Number of Customers (Trade)"
    type: count_distinct
    sql:

    CASE
      WHEN ${is_trade_customer}
        THEN ${customer_uid}
      ELSE NULL
    END

    ;;
  }
  measure: number_of_diy_customers {
    required_access_grants: [is_expert]
    group_label: "Segmentation"
    label: "Number of Customers (DIY)"
    type: count_distinct
    sql:

    CASE
      WHEN NOT ${is_trade_customer}
        THEN ${customer_uid}
      ELSE NULL
    END

    ;;
  }

  measure: percentage_of_customers_trade {
    required_access_grants: [is_expert]
    group_label: "Segmentation"
    label: "Percentage of Customers (Trade)"
    type: number
    sql:

    SAFE_DIVIDE(${number_of_trade_customers}, ${number_of_unique_customers})

    ;;
    value_format: "##0.0%;(##0.0%)"
  }
  measure: percentage_of_customers_diy {
    required_access_grants: [is_expert]
    group_label: "Segmentation"
    label: "Percentage of Customers (DIY)"
    type: number
    sql:

    SAFE_DIVIDE(${number_of_diy_customers}, ${number_of_unique_customers})

    ;;
    value_format: "##0.0%;(##0.0%)"
  }



  measure: trade_gross_sales {
    required_access_grants: [is_expert]
    label: "Gross Sales"
    type: sum
    group_label: "Trade"
    sql:

    CASE
      WHEN ${is_trade_customer}
        THEN ${gross_sales_value}
      ELSE 0
    END

    ;;
  }
  measure: diy_gross_sales {
    required_access_grants: [is_expert]
    label: "Gross Sales"
    type: sum
    group_label: "DIY"
    sql:

    CASE
      WHEN NOT ${is_trade_customer}
        THEN ${gross_sales_value}
      ELSE 0
    END

     ;;
  }
  measure: trade_net_sales {
    required_access_grants: [is_expert]
    label: "Net Sales"
    type: sum
    group_label: "Trade"
    sql:

    CASE
      WHEN ${is_trade_customer}
        THEN ${net_sales_value}
      ELSE 0
    END

    ;;
  }
  measure: diy_net_sales {
    required_access_grants: [is_expert]
    type: sum
    label: "Total Net Sales"
    group_label: "DIY"
    description: "Where is not Trade then assuming DIY to avoid dropping data"
    sql:

    CASE
      WHEN NOT ${is_trade_customer}
        THEN ${net_sales_value}
      ELSE 0
    END

     ;;
  }
  measure: trade_margin_excl_funding {
    required_access_grants: [is_expert]
    label: "Margin Exc Funding"
    type: sum
    group_label: "Trade"
    sql:

    CASE
      WHEN ${is_trade_customer}
        THEN ${margin_excl_funding}
      ELSE 0
    END

    ;;
  }
  measure: diy_margin_excl_funding {
    required_access_grants: [is_expert]
    label: "Margin Exc Funding"
    type: sum
    group_label: "DIY"

    sql:

    CASE
      WHEN NOT ${is_trade_customer}
        THEN ${margin_excl_funding}
      ELSE 0
    END

    ;;
  }
  measure: trade_margin_incl_funding {
    required_access_grants: [is_expert]
    label: "Margin Inc Funding"
    type: sum
    group_label: "Trade"
    sql:

    CASE
      WHEN ${is_trade_customer}
        THEN ${margin_incl_funding}
      ELSE 0
    END

    ;;
  }
  measure: diy_margin_incl_funding {
    required_access_grants: [is_expert]
    label: "Margin Inc Funding"
    type: sum
    group_label: "DIY"
    sql:

    CASE
      WHEN NOT ${is_trade_customer}
        THEN ${margin_incl_funding}
      ELSE 0
    END

    ;;
  }

  ## MR % x 2

  measure: trade_units {
    required_access_grants: [is_expert]
    label: "Units"
    type: sum
    group_label: "Trade"
    sql:

    CASE
      WHEN ${is_trade_customer} AND ${product_code} NOT LIKE '0%'
        THEN ${quantity}
      ELSE 0
    END

    ;;
  }
  measure: diy_units {
    required_access_grants: [is_expert]
    label: "Units"
    type: sum
    group_label: "DIY"
    sql:

    CASE
      WHEN NOT ${is_trade_customer} AND ${product_code} NOT LIKE '0%'
        THEN ${quantity}
      ELSE 0
    END

    ;;
  }
  measure: trade_units_incl_system_codes {
    required_access_grants: [is_expert]
    label: "Units Inc System"
    type: sum
    group_label: "Trade"
    sql:

    CASE
      WHEN ${is_trade_customer}
        THEN ${quantity}
      ELSE 0
    END

    ;;
  }
  measure: diy_units_incl_system_codes {
    required_access_grants: [is_expert]
    label: "Units Inc System"
    type: sum
    group_label: "DIY"
    sql:

    CASE
      WHEN NOT ${is_trade_customer}
        THEN ${quantity}
      ELSE 0
    END

    ;;
  }
  measure: trade_number_of_transactions {
    required_access_grants: [is_expert]
    label: "Number of Transactions"
    type: count_distinct
    group_label: "Trade"
    sql:

    CASE
      WHEN ${is_trade_customer}
        THEN ${parent_order_uid}
      ELSE ""
    END

    ;;
    value_format: "#,##0;(#,##0)"

  }
  measure: diy_number_of_transactions {
    required_access_grants: [is_expert]
    label: "Number of Transactions"
    type: sum
    group_label: "DIY"
    sql:

    CASE
      WHEN NOT ${is_trade_customer}
        THEN ${parent_order_uid}
      ELSE false
    END

    ;;
  }

  measure: trade_gross_sales_mix {
    required_access_grants: [is_expert]
    label: "Gross Sales Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_gross_sales}, ${total_gross_sales})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: diy_gross_sales_mix {
    required_access_grants: [is_expert]
    label: "Gross Sales Mix (DIY)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${diy_gross_sales}, ${total_gross_sales})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: trade_net_sales_mix {
    required_access_grants: [is_expert]
    label: "Net Sales Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_net_sales}, ${total_net_sales})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: diy_net_sales_mix {
    required_access_grants: [is_expert]
    label: "Net Sales Mix (DIY)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${diy_net_sales}, ${total_net_sales})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: trade_margin_excl_funding_mix {
    required_access_grants: [is_expert]
    label: "Margin Excl Funding Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_margin_excl_funding}, ${total_margin_excl_funding})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: diy_margin_excl_funding_mix {
    required_access_grants: [is_expert]
    label: "Margin Excl Funding Mix (DIY)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${diy_margin_excl_funding}, ${total_margin_excl_funding})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: trade_margin_incl_funding_mix {
    required_access_grants: [is_expert]
    label: "Margin Inc Funding Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_margin_incl_funding}, ${total_margin_incl_funding})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: diy_margin_incl_funding_mix {
    required_access_grants: [is_expert]
    label: "Margin Inc Funding Mix (DIY)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${diy_margin_incl_funding}, ${total_margin_incl_funding})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  # MR % x 2
  measure: trade_units_mix {
    required_access_grants: [is_expert]
    label: "Unit Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_net_units}, ${total_units})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: diy_units_mix {
    required_access_grants: [is_expert]
    label: "Unit Mix (DIY)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${diy_net_units}, ${total_units})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: trade_units_incl_system_codes_mix {
    required_access_grants: [is_expert]
    label: "Unit System Codes Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_units_incl_system_codes}, ${total_units_incl_system_codes})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: diy_units_incl_system_codes_mix {
    required_access_grants: [is_expert]
    label: "Unit System Codes Mix (DIY)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${diy_units_incl_system_codes}, ${total_units_incl_system_codes})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: trade_number_of_transactions_mix {
    required_access_grants: [is_expert]
    label: "Number of Transactions Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_number_of_transactions}, ${number_of_transactions})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: diy_number_of_transactions_mix {
    required_access_grants: [is_expert]
    label: "Number of Transactions Mix (DIY)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${diy_number_of_transactions}, ${number_of_transactions})

    ;;
    value_format: "##0.00%;(##0.00%)"
  }

  # Detail PROMO #

  measure: total_gross_sales_main {
    label: "Gross Sales (Main)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    sum(CASE
      WHEN ${promo_in_main_catalogue}
        THEN ${gross_sales_value}
      ELSE 0
    END)

    ;;
  }
  measure: total_gross_sales_extra {
    label: "Gross Sales (Extra)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    sum(CASE
      WHEN ${promo_in_extra}
        THEN ${gross_sales_value}
      ELSE 0
    END)

    ;;
  }
  measure: total_gross_sales_promo {
    label: "Gross Sales (All)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_gross_sales_main} + ${total_gross_sales_extra}
      ELSE 0
    END

    ;;
  }
  measure: total_gross_sales_main_mix {
    label: "Gross Sales Main Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Gross Sales"
    type: number
    sql:

    SAFE_DIVIDE(${total_gross_sales_main}, ${total_gross_sales})

    ;;
  }
  measure: total_gross_sales_extra_mix {
    label: "Gross Sales Extra Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Gross Sales"
    type: number
    sql:

    SAFE_DIVIDE(${total_gross_sales_extra}, ${total_gross_sales})

    ;;
  }

  measure: total_net_sales_main {
    label: "Net Sales (Main)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_main_catalogue}
        THEN ${net_sales_value}
      ELSE 0
    END

    ;;
  }
  measure: total_net_sales_extra {
    label: "Net Sales (Extra)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_extra}
        THEN ${net_sales_value}
      ELSE 0
    END

    ;;
  }
  measure: total_net_sales_promo {
    label: "Net Sales (All)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "This needs fixing! 28/10"
    type: sum
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${net_sales_value}
      ELSE 0
    END

    ;;
  }
  measure: total_net_sales_main_mix {
    label: "Net Sales Main Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Net Sales"
    type: number
    sql:

    SAFE_DIVIDE(${total_net_sales_main}, ${total_net_sales})

    ;;
  }
  measure: total_net_sales_extra_mix {
    label: "Net Sales Extra Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Net Sales"
    type: number
    sql:

    SAFE_DIVIDE(${total_net_sales_extra}, ${total_net_sales})

    ;;
  }

  measure: total_margin_excl_funding_main {
    label: "Margin Exc Funding  (Main)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_main_catalogue}
        THEN ${margin_excl_funding}
      ELSE 0
    END

    ;;
  }
  measure: total_margin_excl_funding_extra {
    label: "Margin Exc Funding  (Extra)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_extra}
        THEN ${margin_excl_funding}
      ELSE 0
    END

    ;;
  }
  measure: total_margin_excl_funding_promo {
    label: "Margin Exc Funding  (All)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_margin_excl_funding_main} + ${total_margin_excl_funding_extra}
      ELSE 0
    END

    ;;
  }
  measure: total_margin_excl_funding_main_mix {
    label: "Margin Exc Funding Main Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Margin Exc Funding "
    type: number
    sql:

    SAFE_DIVIDE(${total_margin_excl_funding_main}, ${total_margin_excl_funding})

    ;;
  }
  measure: total_margin_excl_funding_extra_mix {
    label: "Margin Exc Funding Extra Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Margin Exc Funding "
    type: number
    sql:

    SAFE_DIVIDE(${total_margin_excl_funding_extra}, ${total_margin_excl_funding})

    ;;
  }

  measure: total_margin_incl_funding_main {
    label: "Margin Inc Funding  (Main)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_main_catalogue}
        THEN ${margin_incl_funding}
      ELSE 0
    END

    ;;
  }
  measure: total_margin_incl_funding_extra {
    label: "Margin Inc Funding  (Extra)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_extra}
        THEN ${margin_incl_funding}
      ELSE 0
    END

    ;;
  }
  measure: total_margin_incl_funding_promo {
    label: "Margin Inc Funding  (All)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${margin_incl_funding}
      ELSE 0
    END

    ;;
  }
  measure: total_margin_incl_funding_main_mix {
    label: "Margin Inc Funding Main Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Margin Inc Funding "
    type: number
    sql:

    SAFE_DIVIDE(${total_margin_incl_funding_main}, ${total_margin_incl_funding})

    ;;
  }
  measure: total_margin_incl_funding_extra_mix {
    label: "Margin Inc Funding Extra Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Margin Inc Funding "
    type: number
    sql:

    SAFE_DIVIDE(${total_margin_incl_funding_extra}, ${total_margin_incl_funding})

    ;;
  }

  measure: total_units_main {
    label: "Units  (Main)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_main_catalogue}
        THEN ${quantity}
      ELSE 0
    END

    ;;
  }
  measure: total_units_extra {
    label: "Units  (Extra)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: sum
    sql:

    CASE
      WHEN ${promo_in_extra}
        THEN ${quantity}
      ELSE 0
    END

    ;;
  }
  measure: total_units_promo {
    label: "Units  (All)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_units_main} + ${total_units_extra}
      ELSE 0
    END

    ;;
  }
  measure: total_units_main_mix {
    label: "Units Main Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Units "
    type: number
    sql:

    SAFE_DIVIDE(${total_units_main}, ${total_units})

    ;;
  }
  measure: total_units_extra_mix {
    label: "Units Extra Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Units "
    type: number
    sql:

    SAFE_DIVIDE(${total_units_extra}, ${total_units})

    ;;
  }

  measure: total_number_of_transactions_main {
    label: "Transactions (Main)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    CASE
      WHEN ${promo_in_main_catalogue}
        THEN ${number_of_transactions}
      ELSE 0
    END

    ;;
  }
  measure: total_number_of_transactions_extra {
    label: "Transactions (Extra)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    CASE
      WHEN ${promo_in_extra}
        THEN ${number_of_transactions}
      ELSE 0
    END

    ;;
  }
  measure: total_number_of_transactions_promo {
    label: "Transactions (All)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_number_of_transactions_main} + ${total_number_of_transactions_extra}
      ELSE 0
    END

    ;;
  }
  measure: total_number_of_transactions_main_mix {
    label: "Transactions Main Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Transactions "
    type: number
    sql:

    SAFE_DIVIDE(${total_number_of_transactions_main}, ${number_of_transactions})

    ;;
  }
  measure: total_number_of_transactions_extra_mix {
    label: "Transactions Extra Mix (Trade)"
    group_label: "Promo"
    required_access_grants: [is_expert]
    description: "Mix is % vs Total Transactions "
    type: number
    sql:

    SAFE_DIVIDE(${total_number_of_transactions_extra}, ${number_of_transactions})

    ;;
  }

  # AOV #

  measure: aov_gross_sales{
    label: "Gross Sales AOV"
    group_label: "AOV"
    type:  number
    sql: SAFE_DIVIDE(${total_gross_sales}, ${number_of_transactions}) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: aov_net_sales {
    label: "Net Sales AOV"
    group_label: "AOV"
    type:  number
    sql: SAFE_DIVIDE(${total_net_sales}, ${number_of_transactions}) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: aov_margin_excl_funding {
    label: "Margin Excl Funding AOV"
    group_label: "AOV"
    type:  number
    sql: SAFE_DIVIDE(${total_margin_excl_funding}, ${number_of_transactions}) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: aov_margin_incl_funding {
    label: "Margin Inc Funding AOV"
    group_label: "AOV"
    type:  number
    sql: SAFE_DIVIDE(${total_margin_incl_funding}, ${number_of_transactions}) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }
  measure: aov_units{
    label: "Average Units" #  (Transaction)
    group_label: "AOV"
    type: number
    sql:SAFE_DIVIDE(${total_units}, ${number_of_transactions}) ;;
    value_format: "#,##0.00;(\#,##0.00)"
  }
  measure: aov_units_incl_system_codes{
    label: "Average Units Inc System" # (Transaction)
    group_label: "AOV"
    type: number
    sql: SAFE_DIVIDE(${total_units_incl_system_codes}, ${number_of_transactions}) ;;
    value_format: "#,##0.00;(\#,##0.00)"
  }
  measure: aov_price {
    label: "Net ASP" # (Transaction)
    group_label: "AOV"
    description: "Net Sales AOV / Average Units"
    type: number
    sql: SAFE_DIVIDE(${aov_net_sales}, ${aov_units}) ;;
  }

}
