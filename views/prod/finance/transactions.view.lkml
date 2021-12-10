# include: "/custom_views/**/*.view"
include: "/views/**/*base*.view"

view: transactions {

  derived_table: {
    sql:
      (select
          transactionDate,
          upper(salesChannel) as salesChannel,
          siteUID,
          p.productDepartment,
          t.* except (transactionDate, salesChannel, siteUID)

          from `toolstation-data-storage.sales.transactions` t
          inner join `toolstation-data-storage.range.products_current` p
          using(productUID)
      )

      union all

      (select
          timestamp(date) transactionDate,
          salesChannel,
          siteUID,
          department,
          null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null

          from `toolstation-data-storage.looker_persistent_tables.missing_channel_dimensions`);;

    partition_keys: ["transactionDate"]
    cluster_keys: ["salesChannel", "productDepartment", "productCode"]
    datagroup_trigger: toolstation_transactions_datagroup
    }


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
    label: "Sales Channel"
    group_label: "Purchase Details"
    type: string
    sql: upper(${TABLE}.salesChannel) ;;
  }
  dimension: row_id {
    type: number
    sql: ${TABLE}.rowID ;;
    hidden:  yes
  }
  dimension: site_uid {
    label: "Site UID"
    view_label: "Sites"
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

  dimension: customer_uid {
    label: "Customer UID"
    group_label: "Order ID"
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes #!
  }
  dimension: delivery_address_uid {
    label: "Delivery Address UID"
    group_label: "Order ID"
    type: string
    sql: ${TABLE}.deliveryAddressUID ;;
    hidden: yes #!
  }
  dimension: originating_site_uid {
    label: "Originating Site UID"
    group_label: "Order ID"
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
    group_label: "Order ID"
    type: string
    sql: ${TABLE}.userUID ;;
    hidden: yes
  }
  dimension_group: transaction {
    label: "Transaction"
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.transactiondate ;;
    hidden: yes
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

dimension_group: order_completed {
    view_label: "Date"
    group_label: "Time"
    type: time
    timeframes: [hour_of_day
    ]
    sql: ${TABLE}.transactionDate ;;
    hidden: yes
  }

  dimension: placed_date { # _group
    type: date
    datatype: date
    sql: ${TABLE}.placeddate ;;
    hidden: yes
  }
  dimension: is_open18_months {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Open 18 Months"
    type: yesno
    sql: ${TABLE}.isOpen18Months = 1 ;;
    hidden: yes
  }
  dimension: is_originating_lfl {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Originating LFL"
    type: yesno
    sql: ${TABLE}.isOriginatingLFL = 1 ;;
    hidden: yes
  }
  dimension: is_originating_mature {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Originating Mature"
    type: yesno
    sql: ${TABLE}.isOriginatingMature = 1 ;;
    hidden: yes
  }
  dimension: is_originating_open18_months {
    required_access_grants: [is_developer]
    group_label: "Flags"
    label: "Originating Open (18 Months)"
    type: yesno
    sql: ${TABLE}.isOriginatingOpen18Months = 1 ;;
    hidden: yes
  }

  dimension: order_reason {
    required_access_grants: [is_developer]
    group_label: "Order Details"
    label: "Reason for Order"
    type: string
    sql: ${TABLE}.orderReason ;;
    hidden: yes
  }
  dimension: order_special_requests {
    required_access_grants: [is_developer]
    group_label: "Order Details"
    label: "Special Requests"
    type: string
    sql: ${TABLE}.orderSpecialRequests ;;
    hidden: yes
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


  dimension: product_department {
    view_label: "Products"
    group_label: "Product Details"
    label: "Department"
    type:  string
    sql: initcap(${TABLE}.productDepartment) ;;
  }

  # EXTERNAL - CALENDAR #


  # EXTERNAL - PRODUCTS #

  dimension: is_new_product {
    view_label: "Products"
    group_label: "Flags"
    label: "New Product"
    type:  yesno

    sql:

    (${product_first_sale_date.first_sale_date} + 182) <= ${base.base_date_date}

    ;;

  }

  # UID #

  dimension: parent_order_uid {
    group_label: "Order ID"
    label: "Parent Order UID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }
  dimension: transaction_uid {
    label: "Child Order UID"
    group_label: "Order ID"
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
  # ORDER DETAILS #


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
    required_access_grants: [is_developer]
    type: yesno
    sql: case when ${promo_main_catalogue.product_code} is null then false else true end ;;
  }
  dimension: promo_in_extra {
    label: "In Extra"
    group_label: "Promo"
    required_access_grants: [is_developer]
    type: yesno
    sql: case when ${promo_extra.product_code} is null then false else true end ;;
  }
  dimension: promo_in_any {
    label: "In Any"
    group_label: "Promo"
    required_access_grants: [is_developer]
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
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
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
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
    type: number
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
    # hidden: yes
  }
  measure: total_gross_sales_promo {
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_gross_sales_main} + ${total_gross_sales_extra}
      ELSE 0
    END

    ;;
    # hidden: yes
  }
  measure: total_net_sales_promo {
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
    description: "This needs fixing! 28/10"
    type: sum
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${net_sales_value}
      ELSE 0
    END

    ;;
    # hidden: yes
  }
  measure: total_margin_excl_funding_promo {
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_margin_excl_funding_main} + ${total_margin_excl_funding_extra}
      ELSE 0
    END

    ;;
    # hidden: yes
  }
  measure: total_margin_incl_funding_promo {
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
    type: sum
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${margin_incl_funding}
      ELSE 0
    END

    ;;
    # hidden: yes
  }
  measure: total_units_promo {
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_units_main} + ${total_units_extra}
      ELSE 0
    END

    ;;
    # hidden: yes
  }
  measure: total_number_of_transactions_promo {
    required_access_grants: [is_developer]
    view_label: "Measures"
    group_label: "Promo"
    type: number
    sql:

    CASE
      WHEN ${promo_in_any}
        THEN ${total_number_of_transactions_main} + ${total_number_of_transactions_extra}
      ELSE 0
    END

    ;;
    # hidden: yes
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
                      WHEN ${product_department} = "Power Tools"
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
    view_label: "Measures"
    group_label: "Core"
    sql: ${gross_sales_value} ;;
    value_format_name: gbp
  }
  measure: total_net_sales {
    label: "Net Sales"
    view_label: "Measures"
    group_label: "Core"
    type:  sum
    sql: ${net_sales_value} ;;
    value_format_name: gbp
  }
  measure: total_cogs {
    label: "COGS"
    view_label: "Measures"
    group_label: "Core"
    type:  sum
    sql: ${cogs} ;;
    value_format_name: gbp
    hidden: no
  }
  measure: total_unit_funding {
    label: "Unit Funding"
    view_label: "Measures"
    group_label: "Core"
    type:  sum
    sql: ${unit_funding} ;;
    value_format_name: gbp
    hidden: no
  }
  measure: total_margin_excl_funding {
    label: "Margin (Excluding Funding)"
    view_label: "Measures"
    group_label: "Core"
    type:  sum
    sql: ${margin_excl_funding} ;;
  }
  measure: total_margin_incl_funding {
    label: "Margin (Including Funding)"
    view_label: "Measures"
    group_label: "Core"
    type:  sum
    sql: ${margin_incl_funding} ;;
    value_format_name: gbp
  }
  measure: total_margin_rate_excl_funding {
    label: "Margin Rate (Excluding Funding)"
    view_label: "Measures"
    group_label: "Core"
    type:  number
    sql:
      COALESCE(SAFE_DIVIDE(${total_margin_excl_funding}, ${total_net_sales}),0)
     ;;
    value_format: "##0.00%;(##0.00%)"
  }
  measure: total_margin_rate_incl_funding {
    label: "Margin Rate (Including Funding)"
    view_label: "Measures"
    group_label: "Core"
    type:  number
    sql:
    COALESCE(SAFE_DIVIDE(${total_margin_incl_funding}, ${total_net_sales}),0) ;;
    value_format: "0.00%;(0.00%)"
  }
  measure: total_units {
    label: "Units"
    view_label: "Measures"
    group_label: "Core"
    type:  sum
    sql: case when ${product_code} like '0%' then 0 else ${quantity} end ;;
    value_format: "#,##0;(#,##0)"
  }
  measure: total_units_incl_system_codes {
    label: "Units (System Codes)"
    view_label: "Measures"
    group_label: "Core"
    type:  sum
    sql: ${quantity} ;;
    value_format: "#,##0;(#,##0)"
  }
  measure: number_of_transactions {
    label: "Number of Transactions"
    view_label: "Measures"
    group_label: "Core"
    type: count_distinct
    sql: ${parent_order_uid} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: number_of_unique_customers {
    label: "Number of Customers"
    view_label: "Measures"
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
    hidden: yes
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
    hidden: yes
  }

  measure: percentage_of_customers_trade {
    required_access_grants: [is_expert]
    group_label: "Segmentation"
    label: "Percentage of Customers (Trade)"
    type: number
    sql:

    SAFE_DIVIDE(${number_of_trade_customers}, ${number_of_unique_customers})

    ;;
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
  }

  measure: trade_gross_sales_mix {
    required_access_grants: [is_expert]
    label: "Gross Sales Mix (Trade)"
    group_label: "Segmentation"
    type: number
    sql:

    SAFE_DIVIDE(${trade_gross_sales}, ${total_gross_sales})

    ;;
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
  }

  # AOV #

  measure: aov_gross_sales{
    label: "Gross Sales AOV"
    view_label: "Measures"
    group_label: "AOV"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_gross_sales}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }
  measure: aov_net_sales {
    label: "Net Sales AOV"
    view_label: "Measures"
    group_label: "AOV"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_net_sales}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }
  measure: aov_margin_excl_funding {
    label: "Margin (Excluding Funding) AOV"
    view_label: "Measures"
    group_label: "AOV"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_margin_excl_funding}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }
  measure: aov_margin_incl_funding {
    label: "Margin (Including Funding) AOV"
    view_label: "Measures"
    group_label: "AOV"
    type:  number
    sql: COALESCE(AFE_DIVIDE(${total_margin_incl_funding}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }
  measure: aov_units{
    label: "Units AOV" #  (Transaction)
    view_label: "Measures"
    group_label: "AOV"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${total_units}, ${number_of_transactions}),0) ;;
    value_format: "#,##0.00;(\#,##0.00)"
  }
  measure: aov_units_incl_system_codes{
    label: "Average Units Inc System" # (Transaction)
    view_label: "Measures"
    group_label: "AOV"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${total_units_incl_system_codes}, ${number_of_transactions}),0) ;;
    value_format: "#,##0.00;(\#,##0.00)"
  }
  measure: aov_price {
    label: "Net ASP" # (Transaction)
    view_label: "Measures"
    group_label: "AOV"
    description: "Net Sales AOV / Average Units"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${aov_net_sales}, ${aov_units})) ;;
  }

  # LFL #

  measure: lfl_gross_sales {
    label: "Gross Sales (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type: sum
    sql: case when ${is_lfl} then ${gross_sales_value} else 0 end;;
  }
  measure: lfl_net_sales {
    label: "Net Sales (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type: sum
    sql: case when ${is_lfl} then ${net_sales_value} else 0 end;;
  }
  measure: lfl_margin_excl_funding{
    label: "Margin (Excluding Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type: sum
    sql: case when ${is_lfl} then ${margin_excl_funding} else 0 end;;
  }
  measure: lfl_margin_incl_funding {
    label: "Margin (Including Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type: sum
    sql: case when ${is_lfl} then ${margin_incl_funding} else 0 end;;
  }
  measure: lfl_margin_rate_excl_funding {
    label: "Margin Rate (Excluding Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type:  number
    sql: SAFE_DIVIDE(${lfl_margin_excl_funding}, ${lfl_net_sales}) ;;
    value_format: "0.00%;(0.00%)"
  }
  measure: lfl_margin_rate_incl_funding {
    label: "Margin Rate (Including Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type:  number
    sql: SAFE_DIVIDE(${lfl_margin_incl_funding}, ${lfl_net_sales}) ;;
    value_format: "0.00%;(0.00%)"
  }

  measure: lfl_number_of_customers{
    label: "Number of Customers (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type: sum
    sql: case when ${is_lfl} then ${customer_uid} else 0 end;;
  }
  measure: lfl_number_of_transactions {
    label: "Number of Transactions (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type: count_distinct
    sql: case when ${is_lfl} then ${parent_order_uid} else 0 end;;
  }
  measure: lfl_number_of_units {
    label: "Units (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    type: sum
    sql: case when ${is_lfl} and ${product_code} not like '0%' then ${quantity} else 0 end;;
  }

}
