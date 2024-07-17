include: "/views/**/*base*.view"
# include: "/views/**/calendar.view"
include: "/views/**/sites.view"

view: transactions {
  derived_table: {
    sql:
    SELECT *, row_number() OVER(ORDER BY salesChannel) AS prim_key
    FROM
    ((
        SELECT
        transactionDate, UPPER(salesChannel) AS salesChannel,siteUID,products.productDepartment,
        t.* EXCEPT (transactionDate, salesChannel, siteUID)
        FROM
        (SELECT
        transactions.*,"SALE" AS extranet_status
        FROM `toolstation-data-storage.sales.transactions` AS transactions
        UNION ALL
        (SELECT
        incomplete.* EXCEPT(status, rowID),NULL, NULL, NULL, NULL,NULL,NULL,incomplete.rowID,CAST(UPPER(incomplete.status) = "CANCELLED" AS INT64),NULL,NULL,"INCOMPLETE"
        FROM `toolstation-data-storage.sales.transactions_incomplete` AS incomplete)) AS t
        INNER JOIN `toolstation-data-storage.range.products_current` AS products USING(productUID))
       UNION ALL
       (SELECT
        TIMESTAMP(missing_dimensions.date) AS transactionDate,missing_dimensions.salesChannel AS salesChannel,missing_dimensions.siteUID,missing_dimensions.department,
        NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
        NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,NULL
        FROM `toolstation-data-storage.looker_persistent_tables.missing_channel_dimensions` AS missing_dimensions
        ));;
    partition_keys: ["transactionDate"]
    cluster_keys: ["salesChannel", "productDepartment", "productCode"]
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension: order_line_key {
    type:  string
    sql: concat(${parent_order_uid},${product_uid},${transaction_line_type}) ;;
    hidden:  yes
  }

  dimension: extranet_status {
    sql: ${TABLE}.extranet_status ;;
    hidden: yes
  }

  parameter: select_extranet_status {
    view_label: "Transactions"
    label: "Select Extranet"
    type: string
    allowed_value: {
      label: "Sale"
      value: "SALE"
    }
    allowed_value: {
      label: "Incomplete"
      value: "INCOMPLETE"
    }
    default_value: "SALE"
  }

  parameter: merge_epos {
    view_label: "Overrides"
    label: "Merge EPOS Sales Channel(s)"
    description: "By default, EPOSAV and EPOSER are separate channels. Selecting 'Yes' will merge both to a single Sales Channel of 'EPOS'."
    type: string
    allowed_value: {
      label: "Yes"
      value: "1"
    }
    allowed_value: {
      label: "No"
      value: "0"
    }
    default_value: "0"
  }

  parameter: include_charity {
    view_label: "Overrides"
    label: "Show Charity"
    description: "By default, SKU 85699 and 00053 are excluded. Selecting 'Yes' will isolate those SKUs in the query."
    type: string
    allowed_value: {
      label: "Yes"
      value: "1"
    }
    allowed_value: {
      label: "No"
      value: "0"
    }
    default_value: "0"
  }

  dimension: is_next_day_click_and_collect {
    group_label: "Flags"
    label: "Next Day Click and Collect"
    description: "Selecting 'Yes' will show only Next Day Click & Collect transactions"
    type: yesno
    sql: UPPER(${originating_site_uid}) = "XN" ;;
  }

  dimension: transaction_date_filter {
    group_label: "Placed Date"
    label: "Placed Date Filter"
    type: date
    datatype: date
    sql:
    {% if base.select_date_reference._parameter_value == "Placed" %} DATE(${transactions.placed_date}) {% else %} DATE(${transactions.transaction_date}) {% endif %};;
    hidden: yes
  }

  dimension: charity_status {
    view_label: "Overrides"
    type: string
    sql:{% parameter include_charity %};;
    hidden: yes
  }

  dimension: epos_merge {
    view_label: "Overrides"
    type: string
    sql:{% parameter merge_epos %};;
    hidden: yes
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
    value_format_name: gbp
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
    required_access_grants: [lz_testing]
    type: number
    sql: ${TABLE}.quantity ;;
    label: "Units"
  }

  dimension: quantity_tier {
    required_access_grants: [lz_testing]
    type: tier
    sql: ${quantity};;
    label: "Units Tier"
    tiers: [0,1,2,3,4]
  }

  dimension: sales_channel {
    label: "Sales Channel"
    group_label: "Purchase Details"
    description: "The sales channel the customer used"
    type: string
    sql:
    {% if ${transactions.epos_merge} == "1" %}
      CASE
        WHEN UPPER(${TABLE}.salesChannel) LIKE "EPOS%"
          THEN "EPOS"
        ELSE upper(${TABLE}.salesChannel)
      END
    {% else %}
      UPPER(${TABLE}.salesChannel)
    {% endif %};;
  }

  dimension: sales_channel_digital {
    label: "Sales Channel - Digital"
    group_label: "Purchase Details"
    description: "If the sales channel is digital"
    type: yesno
    sql:${sales_channel} IN ("WEB", "CLICK & COLLECT", "EBAY","CONTACT CENTRE");;
  }

  dimension: sales_channel_branch {
    label: "Sales Channel - Branch"
    group_label: "Purchase Details"
    description: "if the sales channel is branch"
    type: yesno
    sql:${sales_channel} IN ("BRANCHES", "EPOSAV", "EPOSER");;
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
    hidden: yes
  }

  dimension: transaction_line_type {
    type: string
    description: "Field is currently under review - please do not use"
    sql: ${TABLE}.transactionLineType ;;
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

  dimension: has_trade_account {
    view_label: "Customers"
    group_label: "Flags"
    label: "Has Trade Account?"
    description: "Flags whether the customer has a trade account"
    type: yesno
    sql:
       ${trade_credit_details.account_id} IS NOT NULL
         AND
       ${transactions.transaction_time} > ${trade_credit_details.tc_account_created_time} ;;
  }

  dimension: customer_uid {
    label: "Customer UID"
    group_label: "Order Details"
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: delivery_address_uid {
    label: "Delivery Address UID"
    group_label: "Order Details"
    type: string
    sql: ${TABLE}.deliveryAddressUID ;;
    hidden: yes
  }

  dimension: originating_site_uid {
    label: "Originating Site UID"
    group_label: "Order Details"
    description: "The site UID of where the order was placed"
    type: string
    sql: ${TABLE}.originatingSiteUID ;;
  }

  dimension: postal_area {
    label: "Postal Area"
    type: string
    sql: ${TABLE}.postalArea ;;
    hidden: yes
  }

  dimension: postal_district {
    label: "Postal District"
    type: string
    sql: ${TABLE}.postalDistrict ;;
    hidden: yes
  }

  dimension: user_uid {
    label: "User UID"
    group_label: "Order Details"
    description: "The ID of the colleague processing the transaction"
    type: string
    sql: ${TABLE}.userUID ;;
  }

  dimension_group: transaction {
    label: "Transaction"
    type: time
    timeframes: [
      raw,
      time,
      date,
      month_num,
      day_of_week_index
    ]
    sql: ${TABLE}.transactionDate ;;
    hidden: yes
  }

  dimension_group: order_completed {
    group_label: "Order Details"
    description: "Date and time the order was completed"
    type: time
    timeframes: [
      time,
      date
    ]
    sql: ${TABLE}.transactionDate ;;
  }

  dimension_group: placed {
    group_label: "Order Details"
    label: "Order Placed"
    description: "Date and time the order was placed"
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.placedDate ;;
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
    required_access_grants: [is_super]
    group_label: "Order Details"
    label: "Reason for Order"
    type: string
    sql: ${TABLE}.orderReason ;;
  }

  dimension: order_special_requests {
    required_access_grants: [is_super]
    group_label: "Order Details"
    label: "Special Requests"
    description: "Any special requests made by the customer when ordering"
    type: string
    sql: ${TABLE}.orderSpecialRequests ;;
  }

  dimension: is_working_hours {
    view_label: "Date"
    group_label: "Time"
    label: "Within normal working hours"
    required_access_grants: [lz_testing]
    type:  yesno
    sql: (TIME(${transaction_raw}) BETWEEN "07:00:00" AND "16:59:59.999999");;
  }

  dimension: is_working_day {
    view_label: "Date"
    group_label: "Time"
    required_access_grants: [lz_testing]
    type:  yesno
    sql: (${transaction_day_of_week_index} BETWEEN 1 and 5);;
  }

  dimension: is_working_day_hours {
    view_label: "Date"
    group_label: "Time"
    label: "Within normal working days and hours"
    required_access_grants: [lz_testing]
    type:  yesno
    sql: ${is_working_day} and ${is_working_hours};;
  }

  dimension: fulfillment_channel_tk {
    view_label: "Transactions"
    group_label: "Purchase Details"
    label: "Fulfillment Channel"
    description: "Dropship = Dropship, Branch/Standard Click & Collect (excluding originating site UID 'XN') = RDC Fulfilled, Rest = Ecomm Fulfilled"
    type: string
    sql: CASE
         WHEN ${sales_channel} IN ("DROPSHIP") THEN "Dropship"
         WHEN (${sales_channel} IN ("BRANCHES") OR (${sales_channel} IN ("CLICK & COLLECT") AND ${originating_site_uid} != "XN")) THEN "RDC"
         ELSE "E-commerce"
       END ;;
  }



  measure: working_day_hours_total {
    type: count_distinct
    value_format: "#,##0;(#,##0)"
    required_access_grants: [lz_testing]
    sql: CASE WHEN ${is_working_day_hours} = true THEN ${parent_order_uid}  ELSE NULL END;;
    hidden: yes
  }

  measure: non_working_day_hours_total {
    type: count_distinct
    value_format: "#,##0;(#,##0)"
    required_access_grants: [lz_testing]
    sql: CASE WHEN ${is_working_day_hours} = false THEN ${parent_order_uid}  ELSE NULL END;;
    hidden: yes
  }

  measure: working_day_hour_percent {
    view_label: "Measures"
    group_label: "Other Metrics"
    label: "Transactions within working day/hours %"
    required_access_grants: [lz_testing]
    type: number
    sql: ${working_day_hours_total}/NULLIF((${working_day_hours_total}+${non_working_day_hours_total}),0);;
    value_format: "0.0%"
  }

  dimension: time_bucket {
    view_label: "Date"
    group_label: "Time"
    label: "Time Buckets"
    case: {
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "00:00:00" AND "00:59:59.999999" ;;
        label: "0 to 1"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "01:00:00" AND "01:59:59.999999" ;;
        label: "1 to 2"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "02:00:00" AND "02:59:59.999999" ;;
        label: "2 to 3"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "03:00:00" AND "03:59:59.999999" ;;
        label: "3 to 4"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "04:00:00" AND "04:59:59.999999" ;;
        label: "4 to 5"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "05:00:00" AND "05:59:59.999999" ;;
        label: "5 to 6"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "06:00:00" AND "06:59:59.999999" ;;
        label: "6 to 7"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "07:00:00" AND "07:59:59.999999" ;;
        label: "7 to 8"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "08:00:00" AND "08:59:59.999999" ;;
        label: "8 to 9"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "09:00:00" AND "09:59:59.999999" ;;
        label: "9 to 10"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "10:00:00" AND "10:59:59.999999" ;;
        label: "10 to 11"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "11:00:00" AND "11:59:59.999999" ;;
        label: "11 to 12"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "12:00:00" AND "12:59:59.999999" ;;
        label: "12 to 13"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "13:00:00" AND "13:59:59.999999" ;;
        label: "13 to 14"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "14:00:00" AND "14:59:59.999999" ;;
        label: "14 to 15"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "15:00:00" AND "15:59:59.999999" ;;
        label: "15 to 16"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "16:00:00" AND "16:59:59.999999" ;;
        label: "16 to 17"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "17:00:00" AND "17:59:59.999999" ;;
        label: "17 to 18"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "18:00:00" AND "18:59:59.999999" ;;
        label: "18 to 19"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "19:00:00" AND "19:59:59.999999" ;;
        label: "19 to 20"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "20:00:00" AND "20:59:59.999999" ;;
        label: "20 to 21"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "21:00:00" AND "21:59:59.999999" ;;
        label: "21 to 22"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "22:00:00" AND "22:59:59.999999" ;;
        label: "22 to 23"
      }
      when: {
        sql: TIME(${transaction_raw}) BETWEEN "23:00:00" AND "23:59:59.999999" ;;
        label: "23 to 24"
      }
      else: "ERROR - CONTACT DATA@TOOLSTATION.COM"
    }
  }

  dimension: product_department {
    view_label: "Products"
    group_label: "Product Details"
    label: "Department"
    description: "Product Deprtmant"
    type:  string
    sql: initcap(${TABLE}.productDepartment) ;;
  }

  # EXTERNAL - PRODUCTS #
  dimension: is_new_product {
    view_label: "Products"
    group_label: "Flags"
    label: "New Product"
    description: "Flags if a product is new to the business within the last 6 months old"
    type:  yesno
    sql:(${product_first_sale_date.first_sale_date} + 182) <= ${base.base_date_date};;
  }

  dimension: is_new_product_current_year {
    view_label: "Products"
    group_label: "Flags"
    label: "New Product (Current Year)"
    description: "Flags if a product is new to the business this calendar year"
    type:  yesno
    sql:${product_first_sale_date.first_sale_date_group_year}=EXTRACT(Year from CURRENT_DATE);;
  }

  dimension: is_new_product_previous_year {
    view_label: "Products"
    group_label: "Flags"
    label: "New Product (Previous Year)"
    description: "Flags if a product is new to the business in the previous calendar year"
    type:  yesno
    sql:${product_first_sale_date.first_sale_date_group_year}=EXTRACT(Year from CURRENT_DATE)-1;;
  }

  # dimension: customer_transaction_year_2023 {
  #   required_access_grants: [lz_testing]
  #   hidden: yes
  #   view_label: "Customer"
  #   group_label: "Flags"
  #   type:  yesno
  #   sql:extract (year from ${transactions.transaction_date})=2023;;
  # }

  # UID #
  dimension: parent_order_uid {
    group_label: "Order Details"
    label: "Parent Order UID"
    description: "Main order ID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: transaction_uid {
    label: "Child Order UID"
    group_label: "Order Details"
    description: "Child order ID linked to a parent order ID"
    type: string
    sql: ${TABLE}.transactionUID ;;
  }

  # FLAGS #
  dimension: is_lfl {
    group_label: "Flags"
    label: "LFL"
    description: "Flags if an order is Like For Like. Orders placed at site IDs that have been open for 1 year or more"
    type: yesno
    sql: ${TABLE}.isLFL = 1 ;;
  }

  dimension: is_closing {
    view_label: "Location"
    group_label: "Flags"
    label: "Is Closing"
    type: yesno
    sql: date(${transactions.transaction_date})>date(${sites.date_closed_12months_date}) ;;
  }

  dimension: is_mature {
    group_label: "Flags"
    label: "Mature"
    description: "Flags if an order is Like For Like. Orders placed at site IDs that have been open for 5 years or more"
    type: yesno
    sql: ${TABLE}.isMature = 1 ;;
  }

  dimension: is_sale {
    group_label: "Flags"
    type: yesno
    description: "True when an order is a sale, do NOT use the false flag as false can include multiple categories"
    sql: ${transaction_line_type} = "Sale" ;;
  }

  dimension: is_return {
    group_label: "Flags"
    type: yesno
    description: "True when an order is a return, do NOT use the false flag as false can include multiple categories"
    sql: ${transaction_line_type} = "Return" ;;
  }

  # ORDER DETAILS #

  # PURCHASE DETAILS #
  dimension: payment_type {
    group_label: "Purchase Details"
    label: "Payment Type"
    description: "Payment method used"
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension: vat_rate {
    group_label: "Purchase Details"
    label: "VAT Rate"
    description: "VAT rate"
    type: number
    sql: ${TABLE}.vatRate ;;
  }

  # PROMO #
  dimension: promo_in_main_catalogue {
    label: "In Catalogue?"
    view_label: "Products"
    group_label: "Flags"
    # required_access_grants: [is_developer]
    description: "Flags if a product is in the main catalogue"
    type: yesno
    sql: case when ${promo_main_catalogue.product_code} is null then false else true end ;;
  }

  dimension: promo_in_extra {
    label: "In Extra?"
    view_label: "Products"
    group_label: "Flags"
    # required_access_grants: [is_developer]
    description: "Flags if a product is in the extra publication"
    type: yesno
    sql: case when ${promo_extra.product_code} is null then false else true end ;;
  }

  dimension: promo_in_any {
    view_label: "Products"
    group_label: "Flags"
    label: "In Catalogue or Promo?"
    # required_access_grants: [is_developer]
    description: "Flags is a product in the main catalogue or extra publication"
    type: yesno
    sql: case when ${promo_main_catalogue.product_code} is null and ${promo_extra.product_code} is null then false else true end ;;
  }

  # Sites

  dimension: days_before_refurb {
    view_label: "Location"
    group_label: "Site Information"
    description: "Days before refurbishment (at a site level)"
    type: number
    sql: date_diff(${sites.Refurb_start_date},${transactions.transaction_date},day);;
  }

  dimension: days_after_refurb {
    view_label: "Location"
    group_label: "Site Information"
    description: "Days after refurbishment (at a site level)"
    type: number
    sql: date_diff(${transactions.transaction_date},${sites.Refurb_end_date},day);;
  }

  dimension: refurb_pre_post {
    view_label: "Location"
    group_label: "Site Information"
    label: "Pre vs Post Refurb"
    type: string
    sql:
    case
    when ${days_before_refurb} between 1 and 56 then "Pre"
    when ${days_after_refurb} >0 then "Post"
    when ${days_before_refurb} <=0 and ${days_after_refurb} <=0 then "Refurb"
    else "Other"
    end;;
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
    sql:sum(CASE
        WHEN not ${promo_in_any}
          THEN ${margin_incl_funding}
        ELSE 0
        END) /
        sum(CASE
        WHEN not ${promo_in_any}
          THEN ${net_sales_value}
        ELSE 0
        END);;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }

  measure: net_sales_PT {
    label: "% Net Sales - PT"
    type: number
    sql:          sum(CASE
                      WHEN ${product_department} = "Power Tools"
                      THEN ${net_sales_value}
                      ELSE 0
                      END) / sum(${net_sales_value});;
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
                      END) / sum(${net_sales_value});;
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
                      END) / sum(${net_sales_value});;
    value_format: "##0.0%;(##0.0%)"
    hidden: yes
  }

  dimension: customer_cluster{
    type: string
    description: "Placed in Transactions due to potential permissions requirement on Customers"
    sql: ${customer_segmentation.cluster};;
    hidden: yes
  }

  dimension: is_trade_customer {
    type: yesno
    description: "Placed in Transactions due to potential permissions requirement on Customers"
    sql: CASE WHEN ${customer_cluster} LIKE "T%" THEN true else false END ;;
    hidden: yes
  }

  dimension: net_sales_tier {
    type: tier
    tiers: [0,20,40,60,1000]
    style: integer
    sql: ${net_sales_value} ;;
  }

  # Core #
  measure: total_gross_sales {
    label: "Gross Sales"
    description: "Sales value including VAT"
    type:  sum
    view_label: "Measures"
    group_label: "Core Metrics"
    sql: ${gross_sales_value} ;;
    value_format_name: gbp
  }

  measure: total_net_sales {
    label: "Net Sales"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Sales value excluding VAT"
    type:  sum
    sql: coalesce(${net_sales_value},null) ;;
    value_format_name: gbp
  }

  measure: total_cogs {
    label: "COGS"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Product cost price"
    type:  sum
    sql: ${cogs} ;;
    value_format_name: gbp
  }

  measure: total_unit_funding {
    label: "Unit Funding"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Retro funding"
    type:  sum
    sql: ${unit_funding} ;;
    value_format_name: gbp
  }

  measure: total_margin_excl_funding {
    label: "Margin (Excluding Funding)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Standard margin excluding unit funding"
    type:  sum
    sql: ${margin_excl_funding} ;;
    value_format_name: gbp
  }

  measure: total_margin_incl_funding {
    label: "Margin (Including Funding)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Margin including unit funding"
    type:  sum
    sql: ${margin_incl_funding} ;;
    value_format_name: gbp
  }

  measure: total_margin_rate_excl_funding {
    label: "Margin Rate (Excluding Funding)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Standard margin % excluding unit funding"
    type:  number
    sql:COALESCE(SAFE_DIVIDE(${total_margin_excl_funding}, ${total_net_sales}),null);;
    value_format: "##0.00%;(##0.00%)"
  }

  measure: total_margin_rate_incl_funding {
    label: "Margin Rate (Including Funding)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Margin % including unit funding"
    type:  number
    sql:
    COALESCE(SAFE_DIVIDE(${total_margin_incl_funding}, ${total_net_sales}),null) ;;
    value_format: "0.00%;(0.00%)"
  }

  measure: total_units {
    label: "Units"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Number of units sold - only inclduing retail products"
    type:  sum
    sql: case when ${product_code} like '0%' then 0 else ${quantity} end ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: total_units_uk {
    label: "Units (UK only)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Number of units sold - only inclduing retail products (UK only)"
    type:  sum
    sql: case when ${customers.address__country_is_uk} =false then 0 else ${quantity} end ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: total_units_export {
    label: "Units (Export only)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Number of units sold - only inclduing retail products (Export only)"
    type:  sum
    sql:${quantity}-(case when ${customers.address__country_is_uk} =false then 0 else ${quantity} end) ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: total_units_incl_system_codes {
    label: "Units (System Codes)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Number of units sold - including retail products and system codes (i.e carrier bags, vouchers)"
    type:  sum
    sql: ${quantity} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: first_transaction_date {
    label: "First Transaction Date"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "First transaction date"
    type: date
    sql: min(timestamp(${transactions.transaction_date}));;
  }

  dimension: app_transactions_date {
    hidden: yes
    type: date
    sql: case when ${user_uid} = "APP" then ${transactions.transaction_date} else null end;;
  }

  measure: first_app_transaction_date {
    label: "First APP Transaction Date"
    view_label: "Measures"
    group_label: "Core Metrics"
    type: date
    hidden: yes
    sql: min(timestamp(${app_transactions_date}));;
  }

  measure: last_transaction_date {
    view_label: "Measures"
    group_label: "Core Metrics"
    type: date
    sql: max(timestamp(${transactions.transaction_date}));;
  }

  measure: average_customer_tenure{
    view_label: "Measures"
    group_label: "Core Metrics"
    label: "Number of days between first and last transactions"
    required_access_grants: [lz_testing]
    type: number
    sql: date_diff(${last_transaction_date},${first_transaction_date},day);;
  }

  measure: number_of_transactions {
    label: "Number of Transactions"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Number of orders"
    type: count_distinct
    sql: ${parent_order_uid} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: number_of_departments {
    view_label: "Measures"
    group_label: "Other Metrics"
    description: "Number of unique departments"
    type: count_distinct
    sql: ${product_department} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: number_of_unique_products {
    label: "Number of Products"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Number of unique product codes sold"
    type: count_distinct
    sql: ${product_code} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: number_of_unique_customers {
    label: "Number of Customers"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Number of unique customers"
    type: count_distinct
    sql: ${customer_uid} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: number_of_branches {
    view_label: "Measures"
    group_label: "Other Metrics"
    description: "Number of branches"
    type: count_distinct
    sql: ${site_uid} ;;
    value_format: "#,##0;(#,##0)"
  }

  # AOV #
  measure: aov_gross_sales{
    label: "Gross Sales AOV"
    view_label: "Measures"
    group_label: "AOV"
    description: "Average gross sales per order"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_gross_sales}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }

  measure: spc_gross_sales{
    label: "Spend Per Customer (Gross sales)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Spend per customer - Gross sales divided by number of unique customers"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_gross_sales}, ${number_of_unique_customers}),0) ;;
    value_format_name: gbp
  }

 # measure: spends_per_customer{
    #label: "Spend Per Customer"
    #view_label: "Measures"
    #group_label: "LFL"
    #description: "total customer spend"
    #type:  number
    #sql: sum(${net_sales_value}) over (partition by ${customer_uid}) ;;
    #value_format_name: gbp
  #}

  measure: aov_net_sales {
    label: "Net Sales AOV"
    view_label: "Measures"
    group_label: "AOV"
    description: "Average net sales per order"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_net_sales}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }

  measure: spc_net_sales{
    label: "Spend Per Customer (Net sales)"
    view_label: "Measures"
    group_label: "Core Metrics"
    description: "Net sales divided by number of unique customers"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_net_sales}, ${number_of_unique_customers}),0) ;;
    value_format_name: gbp
  }

  measure: transaction_frequency{
    view_label: "Measures"
    group_label: "Core Metrics"
    label: "Frequency"
    description: "Number of transactions divided by number of unique customers"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${number_of_transactions}, ${number_of_unique_customers}),0) ;;
    value_format_name: "decimal_2"
  }

  measure: aov_margin_excl_funding {
    label: "Margin (Excluding Funding) AOV"
    view_label: "Measures"
    group_label: "AOV"
    description: "Average margin (excluding unit funding) per order"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_margin_excl_funding}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }

  measure: aov_margin_incl_funding {
    label: "Margin (Including Funding) AOV"
    view_label: "Measures"
    group_label: "AOV"
    description: "Average margin (including unit funding) per order"
    type:  number
    sql: COALESCE(SAFE_DIVIDE(${total_margin_incl_funding}, ${number_of_transactions}),0) ;;
    value_format_name: gbp
  }

  measure: aov_units{
    label: "Units AOV" #  (Transaction)
    view_label: "Measures"
    group_label: "AOV"
    description: "Average units (only retail products) per order"
    type: number
    sql: COALESCE(SAFE_DIVIDE(${total_units}, ${number_of_transactions}),0) ;;
    value_format: "#,##0.00;(\#,##0.00)"
  }

  measure: aov_units_incl_system_codes{
    label: "Average Units Inc System" # (Transaction)
    view_label: "Measures"
    group_label: "AOV"
    description: "Average units (retail products and system codes) per order"
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
    value_format_name: gbp
  }

  # LFL #
  measure: lfl_gross_sales {
    label: "Gross Sales (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Like for like gross sales. Only sites open for 1 year or more are eligible"
    type: sum
    sql: case when ${is_lfl} then ${gross_sales_value} else 0 end;;
  }

  measure: lfl_net_sales {
    label: "Net Sales (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Like for like net sales. Only sites open for 1 year or more are eligible"
    type: sum
    sql: case when ${is_lfl} then ${net_sales_value} else 0 end;;
  }

  measure: lfl_margin_excl_funding{
    label: "Margin (Excluding Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Like for like margin excluing unit funding. Only sites open for 1 year or more are eligible"
    type: sum
    sql: case when ${is_lfl} then ${margin_excl_funding} else 0 end;;
  }

  measure: lfl_margin_incl_funding {
    label: "Margin (Including Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Like for like margin including unit funding. Only sites open for 1 year or more are eligible"
    type: sum
    sql: case when ${is_lfl} then ${margin_incl_funding} else 0 end;;
  }

  measure: lfl_margin_rate_excl_funding {
    label: "Margin Rate (Excluding Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Like for like margin % (excluding unit funding). Only sites open for 1 year or more are eligible"
    type:  number
    sql: SAFE_DIVIDE(${lfl_margin_excl_funding}, ${lfl_net_sales}) ;;
    value_format: "0.00%;(0.00%)"
  }

  measure: lfl_margin_rate_incl_funding {
    label: "Margin Rate (Including Funding) (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Like for like margin % (including unit funding). Only sites open for 1 year or more are eligible"
    type:  number
    sql: SAFE_DIVIDE(${lfl_margin_incl_funding}, ${lfl_net_sales}) ;;
    value_format: "0.00%;(0.00%)"
  }

  measure: lfl_number_of_customers{
    label: "Number of Customers (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Number of customers at like for like sites (sites open for 1 year or more)"
    type: sum
    sql: case when ${is_lfl} then ${customer_uid} else 0 end;;
  }

  measure: lfl_number_of_transactions {
    label: "Number of Transactions (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Number of orders at like for like sites (sites open for 1 year or more)"
    type: count_distinct
    sql: case when ${is_lfl} then ${parent_order_uid} else null end;;
  }

  measure: lfl_number_of_units {
    label: "Units (LFL)"
    view_label: "Measures"
    group_label: "LFL"
    description: "Number of units sold at like for like sites (sites open for 1 year or more)"
    type: sum
    sql: case when ${is_lfl} and ${product_code} not like '0%' then ${quantity} else 0 end;;
  }

  dimension: promoFlag {
    label: "Used Promo?"
    group_label: "Order Details"
    type: yesno
    hidden: yes
    sql: case when ${promo_orders.promo_id} is not null then true else false end;;
  }

  measure: orders_using_promo {
    label: "Number of Transactions (using coupon)"
    view_label: "Measures"
    group_label: "Core Metrics"
    filters: [promoFlag: "Yes"]
    type: count_distinct
    hidden: yes
    sql: ${parent_order_uid} ;;
  }

  measure: Net_sales_using_promo {
    label: "Net Sales (using coupon)"
    view_label: "Measures"
    group_label: "Core Metrics"
    filters: [promoFlag: "Yes"]
    type: sum
    hidden: yes
    value_format_name: gbp
    sql: ${net_sales_value} ;;
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

  # dimension: has_trade_account {
  #   group_label: "Trade Credit"
  #   view_label: "Customers"
  #   type: yesno
  #   sql: case when ${trade_credit_details.main_trade_credit_account_uid} is not null then true else false end ;;
  # }

  # measure: net_sales_promo_mix {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   type: number
  #   sql:
  #             sum(CASE
  #             WHEN ${promo_in_any}
  #               THEN ${net_sales_value}
  #             ELSE 0
  #             END) / sum(${net_sales_value})

  #             ;;
  #   value_format: "##0.0%;(##0.0%)"
  #   hidden: yes
  # }
  # measure: margin_rate_promo {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   type: number
  #   sql:

  #             sum(CASE
  #             WHEN ${promo_in_any}
  #               THEN ${margin_incl_funding}
  #             ELSE 0
  #             END) /
  #             sum(CASE
  #             WHEN ${promo_in_any}
  #               THEN ${net_sales_value}
  #             ELSE 0
  #             END)
  #             ;;
  #   value_format: "##0.0%;(##0.0%)"
  #   # hidden: yes
  # }
  # measure: total_gross_sales_promo {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   type: number
  #   sql:

  #   CASE
  #     WHEN ${promo_in_any}
  #       THEN ${total_gross_sales_main} + ${total_gross_sales_extra}
  #     ELSE 0
  #   END
  #   ;;
  #   # hidden: yes
  # }
  # measure: total_net_sales_promo {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   description: "This needs fixing! 28/10"
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_any}
  #       THEN ${net_sales_value}
  #     ELSE 0
  #   END
  #   ;;
  #   # hidden: yes
  # }
  # measure: total_margin_excl_funding_promo {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   type: number
  #   sql:

  #   CASE
  #     WHEN ${promo_in_any}
  #       THEN ${total_margin_excl_funding_main} + ${total_margin_excl_funding_extra}
  #     ELSE 0
  #   END

  #   ;;
  #   # hidden: yes
  # }
  # measure: total_margin_incl_funding_promo {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   type: sum
  #   sql:

  #   CASE
  #     WHEN ${promo_in_any}
  #       THEN ${margin_incl_funding}
  #     ELSE 0
  #   END

  #   ;;
  #   # hidden: yes
  # }
  # measure: total_units_promo {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   type: number
  #   sql:

  #   CASE
  #     WHEN ${promo_in_any}
  #       THEN ${total_units_main} + ${total_units_extra}
  #     ELSE 0
  #   END
  #   ;;
  #   # hidden: yes
  # }
  # measure: total_number_of_transactions_promo {
  #   required_access_grants: [is_developer]
  #   view_label: "Measures"
  #   group_label: "Promo"
  #   type: number
  #   sql:
  #   CASE
  #     WHEN ${promo_in_any}
  #       THEN ${total_number_of_transactions_main} + ${total_number_of_transactions_extra}
  #     ELSE 0
  #   END
  #   ;;
  #   # hidden: yes
  # }


  # Detail SEGMENT (T/D only) #

  # measure: number_of_trade_customers {
  #   required_access_grants: [is_expert]
  #   group_label: "Segmentation"
  #   label: "Number of Customers (Trade)"
  #   type: count_distinct
  #   sql:
  #   CASE
  #     WHEN ${is_trade_customer}
  #       THEN ${customer_uid}
  #     ELSE NULL
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: number_of_diy_customers {
  #   required_access_grants: [is_expert]
  #   group_label: "Segmentation"
  #   label: "Number of Customers (DIY)"
  #   type: count_distinct
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer}
  #       THEN ${customer_uid}
  #     ELSE NULL
  #   END
  #   ;;
  #   hidden: yes
  # }

  # measure: percentage_of_customers_trade {
  #   required_access_grants: [is_expert]
  #   group_label: "Segmentation"
  #   label: "Percentage of Customers (Trade)"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${number_of_trade_customers}, ${number_of_unique_customers});;
  #   hidden: yes
  #   value_format: "##0.0%;(##0.0%)"
  # }
  # measure: percentage_of_customers_diy {
  #   required_access_grants: [is_expert]
  #   group_label: "Segmentation"
  #   label: "Percentage of Customers (DIY)"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${number_of_diy_customers}, ${number_of_unique_customers})  #   ;;
  #   hidden: yes
  #   value_format: "##0.0%;(##0.0%)"
  # }

  # measure: trade_gross_sales {
  #   required_access_grants: [is_expert]
  #   label: "Gross Sales"
  #   type: sum
  #   group_label: "Trade"
  #   sql:
  #   CASE
  #     WHEN ${is_trade_customer}
  #       THEN ${gross_sales_value}
  #     ELSE 0
  #   END ;;
  #   hidden: yes
  # }
  # measure: diy_gross_sales {
  #   required_access_grants: [is_expert]
  #   label: "Gross Sales"
  #   type: sum
  #   group_label: "DIY"
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer}
  #       THEN ${gross_sales_value}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: trade_net_sales {
  #   required_access_grants: [is_expert]
  #   label: "Net Sales"
  #   type: sum
  #   group_label: "Trade"
  #   sql:
  #   CASE
  #     WHEN ${is_trade_customer}
  #       THEN ${net_sales_value}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: diy_net_sales {
  #   required_access_grants: [is_expert]
  #   type: sum
  #   label: "Total Net Sales"
  #   group_label: "DIY"
  #   description: "Where is not Trade then assuming DIY to avoid dropping data"
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer}
  #       THEN ${net_sales_value}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: trade_margin_excl_funding {
  #   required_access_grants: [is_expert]
  #   label: "Margin Exc Funding"
  #   type: sum
  #   group_label: "Trade"
  #   sql:
  #   CASE
  #     WHEN ${is_trade_customer}
  #       THEN ${margin_excl_funding}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: diy_margin_excl_funding {
  #   required_access_grants: [is_expert]
  #   label: "Margin Exc Funding"
  #   type: sum
  #   group_label: "DIY"
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer}
  #       THEN ${margin_excl_funding}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: trade_margin_incl_funding {
  #   required_access_grants: [is_expert]
  #   label: "Margin Inc Funding"
  #   type: sum
  #   group_label: "Trade"
  #   sql:
  #   CASE
  #     WHEN ${is_trade_customer}
  #       THEN ${margin_incl_funding}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: diy_margin_incl_funding {
  #   required_access_grants: [is_expert]
  #   label: "Margin Inc Funding"
  #   type: sum
  #   group_label: "DIY"
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer}
  #       THEN ${margin_incl_funding}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # ## MR % x 2

  # measure: trade_units {
  #   required_access_grants: [is_expert]
  #   label: "Units"
  #   type: sum
  #   group_label: "Trade"
  #   sql:
  #   CASE
  #     WHEN ${is_trade_customer} AND ${product_code} NOT LIKE '0%'
  #       THEN ${quantity}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: diy_units {
  #   required_access_grants: [is_expert]
  #   label: "Units"
  #   type: sum
  #   group_label: "DIY"
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer} AND ${product_code} NOT LIKE '0%'
  #       THEN ${quantity}
  #     ELSE 0
  #   END
  #   ;;
  # }
  # measure: trade_units_incl_system_codes {
  #   required_access_grants: [is_expert]
  #   label: "Units Inc System"
  #   type: sum
  #   group_label: "Trade"
  #   sql:
  #   CASE
  #     WHEN ${is_trade_customer}
  #       THEN ${quantity}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: diy_units_incl_system_codes {
  #   required_access_grants: [is_expert]
  #   label: "Units Inc System"
  #   type: sum
  #   group_label: "DIY"
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer}
  #       THEN ${quantity}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: trade_number_of_transactions {
  #   required_access_grants: [is_expert]
  #   label: "Number of Transactions"
  #   type: count_distinct
  #   group_label: "Trade"
  #   sql:

  #   CASE
  #     WHEN ${is_trade_customer}
  #       THEN ${parent_order_uid}
  #     ELSE ""
  #   END
  #   ;;
  #   hidden: yes
  #   value_format: "#,##0;(#,##0)"
  # }
  # measure: diy_number_of_transactions {
  #   required_access_grants: [is_expert]
  #   label: "Number of Transactions"
  #   type: sum
  #   group_label: "DIY"
  #   sql:
  #   CASE
  #     WHEN NOT ${is_trade_customer}
  #       THEN ${parent_order_uid}
  #     ELSE false
  #   END
  #   ;;
  #   hidden: yes
  # }

  # measure: trade_gross_sales_mix {
  #   required_access_grants: [is_expert]
  #   label: "Gross Sales Mix (Trade)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${trade_gross_sales}, ${total_gross_sales})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: diy_gross_sales_mix {
  #   required_access_grants: [is_expert]
  #   label: "Gross Sales Mix (DIY)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${diy_gross_sales}, ${total_gross_sales})
  #   ;;
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: trade_net_sales_mix {
  #   required_access_grants: [is_expert]
  #   label: "Net Sales Mix (Trade)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${trade_net_sales}, ${total_net_sales})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: diy_net_sales_mix {
  #   required_access_grants: [is_expert]
  #   label: "Net Sales Mix (DIY)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${diy_net_sales}, ${total_net_sales})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: trade_margin_excl_funding_mix {
  #   required_access_grants: [is_expert]
  #   label: "Margin Excl Funding Mix (Trade)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${trade_margin_excl_funding}, ${total_margin_excl_funding})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: diy_margin_excl_funding_mix {
  #   required_access_grants: [is_expert]
  #   label: "Margin Excl Funding Mix (DIY)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${diy_margin_excl_funding}, ${total_margin_excl_funding})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: trade_margin_incl_funding_mix {
  #   required_access_grants: [is_expert]
  #   label: "Margin Inc Funding Mix (Trade)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${trade_margin_incl_funding}, ${total_margin_incl_funding})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: diy_margin_incl_funding_mix {
  #   required_access_grants: [is_expert]
  #   label: "Margin Inc Funding Mix (DIY)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${diy_margin_incl_funding}, ${total_margin_incl_funding})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # # MR % x 2
  # measure: trade_units_mix {
  #   required_access_grants: [is_expert]
  #   label: "Unit Mix (Trade)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${trade_net_units}, ${total_units})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: diy_units_mix {
  #   required_access_grants: [is_expert]
  #   label: "Unit Mix (DIY)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${diy_net_units}, ${total_units})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: trade_units_incl_system_codes_mix {
  #   required_access_grants: [is_expert]
  #   label: "Unit System Codes Mix (Trade)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${trade_units_incl_system_codes}, ${total_units_incl_system_codes})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: diy_units_incl_system_codes_mix {
  #   required_access_grants: [is_expert]
  #   label: "Unit System Codes Mix (DIY)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${diy_units_incl_system_codes}, ${total_units_incl_system_codes})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: trade_number_of_transactions_mix {
  #   required_access_grants: [is_expert]
  #   label: "Number of Transactions Mix (Trade)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${trade_number_of_transactions}, ${number_of_transactions})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }
  # measure: diy_number_of_transactions_mix {
  #   required_access_grants: [is_expert]
  #   label: "Number of Transactions Mix (DIY)"
  #   group_label: "Segmentation"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${diy_number_of_transactions}, ${number_of_transactions})
  #   ;;
  #   hidden: yes
  #   value_format: "##0.00%;(##0.00%)"
  # }

  # # Detail PROMO #

  # measure: total_gross_sales_main {
  #   label: "Gross Sales (Main)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: number
  #   sql:
  #   sum(CASE
  #     WHEN ${promo_in_main_catalogue}
  #       THEN ${gross_sales_value}
  #     ELSE 0
  #   END)
  #   ;;
  #   hidden: yes
  # }
  # measure: total_gross_sales_extra {
  #   label: "Gross Sales (Extra)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: number
  #   sql:
  #   sum(CASE
  #     WHEN ${promo_in_extra}
  #       THEN ${gross_sales_value}
  #     ELSE 0
  #   END)
  #   ;;
  #   hidden: yes
  # }

  # measure: total_gross_sales_main_mix {
  #   label: "Gross Sales Main Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Gross Sales"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_gross_sales_main}, ${total_gross_sales})
  #   ;;
  #   hidden: yes
  # }
  # measure: total_gross_sales_extra_mix {
  #   label: "Gross Sales Extra Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Gross Sales"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_gross_sales_extra}, ${total_gross_sales})
  #   ;;
  #   hidden: yes
  # }

  # measure: total_net_sales_main {
  #   label: "Net Sales (Main)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_main_catalogue}
  #       THEN ${net_sales_value}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: total_net_sales_extra {
  #   label: "Net Sales (Extra)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_extra}
  #       THEN ${net_sales_value}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }

  # measure: total_net_sales_main_mix {
  #   label: "Net Sales Main Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Net Sales"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_net_sales_main}, ${total_net_sales})
  #   ;;
  #   hidden: yes
  # }
  # measure: total_net_sales_extra_mix {
  #   label: "Net Sales Extra Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Net Sales"
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_net_sales_extra}, ${total_net_sales})
  #   ;;
  #   hidden: yes
  # }

  # measure: total_margin_excl_funding_main {
  #   label: "Margin Exc Funding  (Main)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_main_catalogue}
  #       THEN ${margin_excl_funding}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: total_margin_excl_funding_extra {
  #   label: "Margin Exc Funding  (Extra)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_extra}
  #       THEN ${margin_excl_funding}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }

  # measure: total_margin_excl_funding_main_mix {
  #   label: "Margin Exc Funding Main Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Margin Exc Funding "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_margin_excl_funding_main}, ${total_margin_excl_funding})
  #   ;;
  #   hidden: yes
  # }
  # measure: total_margin_excl_funding_extra_mix {
  #   label: "Margin Exc Funding Extra Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Margin Exc Funding "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_margin_excl_funding_extra}, ${total_margin_excl_funding})
  #   ;;
  #   hidden: yes
  # }

  # measure: total_margin_incl_funding_main {
  #   label: "Margin Inc Funding  (Main)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_main_catalogue}
  #       THEN ${margin_incl_funding}
  #     ELSE 0
  #   END
  #   ;;
  # }
  # measure: total_margin_incl_funding_extra {
  #   label: "Margin Inc Funding  (Extra)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_extra}
  #       THEN ${margin_incl_funding}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }

  # measure: total_margin_incl_funding_main_mix {
  #   label: "Margin Inc Funding Main Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Margin Inc Funding "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_margin_incl_funding_main}, ${total_margin_incl_funding})
  #   ;;
  #   hidden: yes
  # }
  # measure: total_margin_incl_funding_extra_mix {
  #   label: "Margin Inc Funding Extra Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Margin Inc Funding "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_margin_incl_funding_extra}, ${total_margin_incl_funding})
  #   ;;
  #   hidden: yes
  # }

  # measure: total_units_main {
  #   label: "Units  (Main)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_main_catalogue}
  #       THEN ${quantity}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: total_units_extra {
  #   label: "Units  (Extra)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: sum
  #   sql:
  #   CASE
  #     WHEN ${promo_in_extra}
  #       THEN ${quantity}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: total_units_main_mix {
  #   label: "Units Main Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Units "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_units_main}, ${total_units})
  #   ;;
  #   hidden: yes
  # }
  # measure: total_units_extra_mix {
  #   label: "Units Extra Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Units "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_units_extra}, ${total_units})
  #   ;;
  #   hidden: yes
  # }

  # measure: total_number_of_transactions_main {
  #   label: "Transactions (Main)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: number
  #   sql:
  #   CASE
  #     WHEN ${promo_in_main_catalogue}
  #       THEN ${number_of_transactions}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: total_number_of_transactions_extra {
  #   label: "Transactions (Extra)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   type: number
  #   sql:
  #   CASE
  #     WHEN ${promo_in_extra}
  #       THEN ${number_of_transactions}
  #     ELSE 0
  #   END
  #   ;;
  #   hidden: yes
  # }
  # measure: total_number_of_transactions_main_mix {
  #   label: "Transactions Main Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Transactions "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_number_of_transactions_main}, ${number_of_transactions})
  #   ;;
  #   hidden: yes
  # }
  # measure: total_number_of_transactions_extra_mix {
  #   label: "Transactions Extra Mix (Trade)"
  #   group_label: "Promo"
  #   required_access_grants: [is_expert]
  #   description: "Mix is % vs Total Transactions "
  #   type: number
  #   sql:
  #   SAFE_DIVIDE(${total_number_of_transactions_extra}, ${number_of_transactions})
  #   ;;
  #   hidden: yes
  # }
}
