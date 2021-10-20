include: "/custom_views/**/*.view"

view: transactions {

  sql_table_name: `sales.transactions`;;
  # drill_fields: [transaction_uid]
  extends: [pop_date_comparison]

  ########## HIDDEN DIMENSIONS ##########

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
    label: "Product Code"
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension: product_uid {
    label: "Product UID"
    group_label: "UID"
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


  # NOTE - JD commented the below (18/10/2021) -- REASON: don't think this is needed anymore.
  # dimension: date{
  #   view_label: "Calendar Completed Date"
  #   type: date
  #   sql: coalesce(date(${TABLE}.transactionDate),${channel_budget.date}) ;;
  #   hidden:  yes
  # }

  ########## VISIBLE DIMENSIONS ##########

  # NOTE - JD modified sales_channel, site_uid, department and transaction_date to COALESCE (17/10/2021) -- REASON: budget.

  dimension: sales_channel_coalesce {
    label: "Sales Channel"
    type: string
    sql: coalesce(upper(${TABLE}.salesChannel),upper(${channel_budget.channel})) ;;
  }

  dimension: site_uid_coalesce {
    label: "Site UID"
    view_label: "Sites"
    type: string
    sql: coalesce(${TABLE}.siteUID,${site_budget.site_uid}) ;;
  }

  dimension: department_coalesce {
    view_label: "Products"
    group_label: "Commercial Details"
    label: "Department"
    type:  string
    sql: coalesce(INITCAP(${products.department}),initcap(${category_budget.department})) ;;
  }

  dimension: transaction_date_coalesce {
    type: date
    datatype: date
    label: "Date"
    view_label: "Calendar - Completed Date"
    sql: coalesce(date(${TABLE}.transactiondate),${site_budget.raw_date},${category_budget.date},${channel_budget.date}) ;;
  }


  dimension: parent_order_uid {
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

  dimension: customer_uid {
    description: "Used as KEY for joins."
    label: "Customer UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.customerUID ;;
  }

  dimension: delivery_address_uid {
    label: "Delivery Address UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.deliveryAddressUID ;;
  }


  dimension: is_lfl {
    group_label: "Flags"
    label: "Is LFL"
    type: yesno
    sql: ${TABLE}.isLFL = 1 ;;
  }

  dimension: is_mature {
    group_label: "Flags"
    label: "Is Mature"
    type: yesno
    sql: ${TABLE}.isMature = 1 ;;
  }

  dimension: is_open18_months {
    group_label: "Flags"
    label: "Is Open 18 Months"
    type: yesno
    sql: ${TABLE}.isOpen18Months = 1 ;;
  }

  dimension: is_originating_lfl {
    group_label: "Flags"
    label: "Is Originating LFL"
    type: yesno
    sql: ${TABLE}.isOriginatingLFL = 1 ;;
  }

  dimension: is_originating_mature {
    group_label: "Flags"
    label: "Is Originating Mature"
    type: yesno
    sql: ${TABLE}.isOriginatingMature = 1 ;;
  }

  dimension: is_originating_open18_months {
    group_label: "Flags"
    label: "Is Originating Open (18 Months)"
    type: yesno
    sql: ${TABLE}.isOriginatingOpen18Months = 1 ;;
  }

  dimension: order_reason {
    label: "Reason for Order"
    type: string
    sql: ${TABLE}.orderReason ;;
  }

  dimension: order_special_requests {
    label: "Special Requests"
    type: string
    sql: ${TABLE}.orderSpecialRequests ;;
  }

  dimension: originating_site_uid {
    label: "Originating Site UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.originatingSiteUID ;;
  }

  dimension: payment_type {
    label: "Payment Type"
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension_group: placed {
    label: "Placed Timestamp"
    view_label: "Calendar - Placed Date"
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.placeddate ;;

  }

  dimension: postal_area {
    label: "Postal Area"
    type: string
    sql: ${TABLE}.postalArea ;;
  }

  dimension: postal_district {
    label: "Postal District"
    type: string
    sql: ${TABLE}.postalDistrict ;;
  }


  dimension_group: transaction {
    label: "Completed Timestamp"
    view_label: "Calendar - Completed Date"
    type: time
    timeframes: [
      raw,
      time,
      date,
      year
    ]
    sql: ${TABLE}.transactiondate ;;
  }

  dimension: user_uid {
    label: "User UID"
    group_label: "UID"
    type: string
    sql: ${TABLE}.userUID ;;
  }


  dimension: vat_rate {
    label: "VAT Rate"
    type: number
    sql: ${TABLE}.vatRate ;;
  }

  dimension: promo_in_main_catalogue {
    label: "In Main Catalogue"
    group_label: "Promo"
    type: yesno
    sql: case when ${promo_main_catalogue.product_code} is null then false else true end ;;
  }

  dimension: promo_in_extra {
    label: "In Extra"
    group_label: "Promo"
    type: yesno
    sql: case when ${promo_extra.product_code} is null then false else true end ;;
  }

  dimension: promo_in_any {
    label: "In Any"
    group_label: "Promo"
    type: yesno
    sql: case when ${promo_main_catalogue.product_code} is null and ${promo_extra.product_code} is null then false else true end ;;
  }

  measure:  total_gross_sales {
    label: "Total Gross Sales"
    type:  sum
    group_label: "Sales Measures"
    sql: ${gross_sales_value} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: total_net_sales {
    label: "Total Net Sales"
    group_label: "Sales Measures"
    type:  sum
    sql: ${net_sales_value} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: total_margin_excl_funding {
    label: "Total Margin (Excluding Funding)"
    group_label: "Margin Measures"
    type:  sum
    sql: ${margin_excl_funding} ;;
  }

  measure: total_cogs {
    label: "Total COGS"
    type:  sum
    sql: ${cogs} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }


  measure: total_margin_incl_funding {
    label: "Total Margin (Including Funding)"
    group_label: "Margin Measures"
    type:  sum
    sql: ${margin_incl_funding} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: total_unit_funding {
    label: "Total Unit Funding"
    type:  sum
    sql: ${unit_funding} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: total_units {
    label: "Total Units"
    type:  sum
    sql: case when ${product_code} like '0%' then 0 else ${quantity} end ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: total_units_incl_system_codes {
    label: "Total Units (Including System Codes)"
    type:  sum
    sql: ${quantity} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: average_units_AOV {
    label: "Average Units (Transaction)"
    group_label: "AOV Measures"
    type: number
    sql: ${total_units} / ${number_of_transactions} ;;
    value_format: "#,##0.00;(\#,##0.00)"
  }

  measure: average_sales_AOV {
    label: "Net ASP (Transaction)"
    group_label: "AOV Measures"
    description: "Net Sales AOV / Average Units"
    type: number
    sql: ${net_sales_AOV} / ${average_units_AOV} ;;
  }

  measure: net_sales_AOV {
    label: "Net Sales AOV"
    group_label: "AOV Measures"
    type:  number
    sql: ${total_net_sales}  / ${number_of_transactions} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: gross_sales_AOV {
    label: "Gross Sales AOV"
    group_label: "AOV Measures"
    type:  number
    sql: ${total_gross_sales}  / ${number_of_transactions} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: number_of_transactions {
    label: "Number of Transactions"
    type: count_distinct
    sql: ${parent_order_uid} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: total_margin_rate_excl_funding {
    label: "Total Margin Rate (Excluding Funding)"
    group_label: "Margin Measures"
    type:  number
    sql:
      CASE
        WHEN ${total_net_sales} <> 0 AND ${total_margin_excl_funding} <> 0
          THEN (${total_margin_excl_funding} / ${total_net_sales})
        ELSE 0
      END ;;
    value_format: "##0.00%;(##0.00%)"
  }

  measure: total_margin_rate_incl_funding {
    label: "Total Margin Rate (Including Funding)"
    group_label: "Margin Measures"
    type:  number
    sql:

      CASE
        WHEN ${total_net_sales} <> 0 AND ${total_margin_incl_funding} <> 0
          THEN (${total_margin_incl_funding} / ${total_net_sales})
        ELSE 0
      END ;;
    value_format: "0.00%;(0.00%)"
  }

  measure: unique_customer {
    label: "Total Customers"
    type: count_distinct
    sql: ${customer_uid} ;;
    value_format: "#,##0;(#,##0)"
  }




  dimension: previous_full_day {
    description: "PFD looks at 'yesterday'"
    type: yesno
    sql:

      ${__target_date__} = (CURRENT_DATE() - 1)

      ;;
    hidden: yes
  }

  dimension: previous_full_day_LY {
    description: "PFD looks at 'yesterday' and same day last year"
    type: yesno
    sql:

      ${previous_full_day}

      OR

      ${__target_date__} = ((CURRENT_DATE() - 1) - 364)

      ;;
    hidden: yes

  }

  dimension: previous_full_day_2LY {
    description: "PFD looks at 'yesterday' and same day 2 years ago"
    type: yesno
    sql:

      ${previous_full_day}

      OR

      ${__target_date__} = ((CURRENT_DATE() - 1) - (364*2))

      ;;
    hidden: yes
  }


  dimension: previous_full_day_LW {
    description: "PDF looks at 'yesterday' and the same day last week"
    type: yesno
    sql:

      ${previous_full_day}

      OR

      ${__target_date__} = ((CURRENT_DATE() - 1) - 7)

      ;;

      hidden: yes

    }

    dimension: previous_full_day_LM {

      description: "PDF looks at 'yesterday' and the same day last month"
      type: yesno
      sql:

      ${previous_full_day}

      OR

      ${__target_date__} = ((CURRENT_DATE() - 1) - 0) -- TODO !

      ;;

      hidden: yes

      }

# WEEK TO DATE

      dimension: week_to_date {
        description: "WTD looks at all dates from the most recent previous Sunday until the following Saturday (financial week). Recommend NOT using the NO filter with this."
        type: yesno
        sql:

              EXTRACT(DAYOFWEEK FROM ${__target_date__}) <= EXTRACT(DAYOFWEEK FROM CURRENT_DATE())
              AND (${__target_date__} > (CURRENT_DATE() - 7))

              ;;
        hidden: yes
      }

      dimension: week_to_date_LY {
        description: "WTD looks at all dates from the most recent previous Sunday until the following Saturday, as well as the same dates (financial week) in the previous year. Recommend NOT using the NO filter with this."
        type:  yesno
        sql:

              ${week_to_date}

              OR

              (
              EXTRACT(DAYOFWEEK FROM ${__target_date__}) <= EXTRACT(DAYOFWEEK FROM (CURRENT_DATE() - (364+6)))
              AND ${__target_date__} > CURRENT_DATE() - (364+6) -- 364 + 6 (DUE TO BEING AT MOST 6 DAYS PRIOR FOR EQUIVALENT WTD)
              AND ${__target_date__} <= CURRENT_DATE() - 1 - 364 -- 364 AS COULD NOT BE ANY 'NEWER' THAN 6 DAYS DUE TO WTD
              )

              ;;
        hidden: yes
      }

      dimension: week_to_date_2LY {
        description: "WTD looks at all dates from the most recent previous Sunday until the following Saturday, as well as the same dates (financial week) in the previous 2 years. Recommend NOT using the NO filter with this."
        type: yesno
        sql:

              ${week_to_date}

              OR

              (
              EXTRACT(DAYOFWEEK FROM ${__target_date__}) <= EXTRACT(DAYOFWEEK FROM (CURRENT_DATE() - ((364*2)+6)))
              AND ${__target_date__} > CURRENT_DATE() - ((364*2)+6) -- 364 + 6 (DUE TO BEING AT MOST 6 DAYS PRIOR FOR EQUIVALENT WTD)
              AND ${__target_date__} <= CURRENT_DATE() - 1 - (364*2) -- 364 AS COULD NOT BE ANY 'NEWER' THAN 6 DAYS DUE TO WTD
              )

              ;;
        hidden: yes
      }

# MONTH TO DATE

      dimension: month_to_date {
        description: ""
        type: yesno
        sql:

              (
              ${__target_date__} >= CURRENT_DATE() - EXTRACT(DAY FROM CURRENT_DATE())
              )

              ;;
        hidden: yes
      }

      dimension: month_to_date_LY {
        description: ""
        type: yesno
        sql:
              (

              ${month_to_date}

              OR

              (

              ${__target_date__} < DATE(EXTRACT(YEAR FROM CURRENT_DATE())-1,EXTRACT(MONTH FROM CURRENT_DATE()),EXTRACT(DAY FROM CURRENT_DATE()))
              AND ${__target_date__} >= DATE(EXTRACT(YEAR FROM CURRENT_DATE())-1,EXTRACT(MONTH FROM CURRENT_DATE()),1)

              )

              )

              ;;
        hidden: yes
      }

      dimension: month_to_date_2LY {
        description: ""
        type: yesno
        sql:
              (

              ${month_to_date}

              OR

              (
              ${__target_date__} < DATE(EXTRACT(YEAR FROM CURRENT_DATE())-2,EXTRACT(MONTH FROM CURRENT_DATE()),EXTRACT(DAY FROM CURRENT_DATE()))
              AND ${__target_date__} >= DATE(EXTRACT(YEAR FROM CURRENT_DATE())-2,EXTRACT(MONTH FROM CURRENT_DATE()),1)
              )

              )

              ;;
        hidden: yes
      }

# YEAR TO DATE

      dimension: year_to_date {
        description: "YTD looks at all the dates from the first (1st) day of the first month of the year. Recommend NOT using the NO filter with this."
        type: yesno
        sql:

              (
              ${__target_date__} >= DATE(EXTRACT(YEAR FROM CURRENT_DATE()),1,1)
              )

              ;;
        hidden: yes

      }

      dimension: year_to_date_LY {
        description: ""
        type: yesno
        sql:

              (

              ${year_to_date}

              OR

              (

              ${__target_date__} <= DATE(EXTRACT(YEAR FROM CURRENT_DATE())-1,EXTRACT(MONTH FROM CURRENT_DATE()),EXTRACT(DAY FROM CURRENT_DATE()))
              AND ${__target_date__} >= DATE(EXTRACT(YEAR FROM CURRENT_DATE())-1,1,1)

              )

              )

              ;;
        hidden: yes

      }

      dimension: year_to_date_2LY {
        description: ""
        type: yesno
        sql:

              (

              ${year_to_date}

              OR

              (

              ${__target_date__} < DATE(EXTRACT(YEAR FROM CURRENT_DATE())-2,EXTRACT(MONTH FROM CURRENT_DATE()),EXTRACT(DAY FROM CURRENT_DATE()))
              AND ${__target_date__} >= DATE(EXTRACT(YEAR FROM CURRENT_DATE())-2,1,1)

              )

              )

              ;;
        hidden: yes

      }

# PREVIOUS PERIOD

      dimension: current_period {
        type: yesno
        sql:

              ${__target_date__} >= DATE({%date_start custom_date_period%}) and ${__target_date__} < DATE({%date_end custom_date_period%})

              ;;
        hidden: yes
      }

      dimension: current_period_LY {
        type: yesno
        sql:

              ${current_period}

              OR

              (

              ${__target_date__} < date({%date_end custom_date_period%}) - 364
              AND ${__target_date__} >= date({% date_start custom_date_period %}) - 364

              )

              ;;
        hidden: yes
      }


      dimension: current_period_2LY {
        type: yesno
        sql:

              ${current_period}

              OR

              (


              ${__target_date__} < date({%date_end custom_date_period%}) - 728
              AND ${__target_date__} >= date({% date_start custom_date_period %}) - 728

              )

              ;;
        hidden: yes
      }

#####

# FILTERS

      dimension: __target_date__ {
        sql: ${transaction_date} ;;
        hidden: yes
      }

      parameter: period_to_date{
        description: "Choose the period you would like to compare to."
        label: "Period to Date:"
        type: unquoted
        allowed_value: {
          label: "Previous Day"
          value: "PD"
        }
        allowed_value: {
          label: "Week to Date (WTD)"
          value: "WTD"
        }
        allowed_value: {
          label: "Month to Date (MTD)"
          value: "MTD"
        }
        allowed_value: {
          label: "Year to Date (YTD)"
          value: "YTD"
        }
        allowed_value: {
          label: "Custom Period (add filter)"
          value: "CP"
        }
        default_value: "PD"
        view_label: "Period To Date and YoY Filters"
      }

      parameter: previous_period_to_date {
        description: "Choose the number of previous periods you would like to compare."
        label: "Number of Period(s):"
        type: unquoted
        allowed_value: {
          label: "Last Week - USE WITH PREVIOUS DAY ONLY"
          value: "LW"
        }
        allowed_value: {
          label: "Last Month - USE WITH PREVIOUS DAY ONLY"
          value: "LM"
        }
        allowed_value: {
          label: "Current Year"
          value: "CY"
        }
        allowed_value: {
          label: "Last Year"
          value: "LY"
        }
        allowed_value: {
          label: "2 Years Ago"
          value: "2LY"
        }
        allowed_value: {
          label: "Last 2 Years"
          value: "LY2LY"
        }
        default_value: "CY"
        view_label: "Period To Date and YoY Filters"
      }

      filter: date_range {
        view_label: "Period To Date and YoY Filters"
        label: "Date Range Filter"
        description: ""
        type:  date
        convert_tz: yes
        hidden: yes
      }

      filter: custom_date_period {
        view_label: "Period To Date and YoY Filters"
        label: "Custom Period (Date)"
        type: date
      }

      filter: pivot_period {
        view_label: "Period To Date and YoY Filters"
        label: "Apply Filter - MUST INCLUDE"
        type:  yesno
        sql:

              {% if period_to_date._in_query and previous_period_to_date._in_query %}

              {% if period_to_date._parameter_value == "PD" %}

              {% if previous_period_to_date._parameter_value == "CY" %}
              ${previous_full_day}
              {% elsif previous_period_to_date._parameter_value == "LY" %}
              ${previous_full_day_LY}
              {% elsif previous_period_to_date._parameter_value == "2LY" %}
              ${previous_full_day_2LY}
              {% elsif previous_period_to_date._parameter_value == "LY2LY" %}
              ${previous_full_day_LY} OR ${previous_full_day_2LY}


              {% elsif previous_period_to_date._parameter_value == "LW" %}
              ${previous_full_day_LW}
              {% elsif previous_period_to_date._parameter_value == "LM" %}
              ${previous_full_day_LM}


              {% endif %}

              {% elsif period_to_date._parameter_value == "WTD" %}

              {% if previous_period_to_date._parameter_value == "CY" %}
              ${week_to_date}
              {% elsif previous_period_to_date._parameter_value == "LY" %}
              ${week_to_date_LY}
              {% elsif previous_period_to_date._parameter_value == "2LY" %}
              ${week_to_date_2LY}
              {% elsif previous_period_to_date._parameter_value == "LY2LY" %}
              ${week_to_date_LY} OR ${week_to_date_2LY}
              {% endif %}

              {% elsif period_to_date._parameter_value == "MTD" %}

              {% if previous_period_to_date._parameter_value == "CY" %}
              ${month_to_date}
              {% elsif previous_period_to_date._parameter_value == "LY" %}
              ${month_to_date_LY}
              {% elsif previous_period_to_date._parameter_value == "2LY" %}
              ${month_to_date_2LY}
              {% elsif previous_period_to_date._parameter_value == "LY2LY" %}
              ${month_to_date_LY} OR ${month_to_date_2LY}
              {% endif %}

              {% elsif period_to_date._parameter_value == "YTD" %}

              {% if previous_period_to_date._parameter_value == "CY" %}
              ${year_to_date}
              {% elsif previous_period_to_date._parameter_value == "LY" %}
              ${year_to_date_LY}
              {% elsif previous_period_to_date._parameter_value == "2LY" %}
              ${year_to_date_2LY}
              {% elsif previous_period_to_date._parameter_value == "LY2LY" %}
              ${year_to_date_LY} OR ${year_to_date_2LY}
              {% endif %}

              {% elsif period_to_date._parameter_value == "CP" and custom_date_period._in_query %}

              {% if previous_period_to_date._parameter_value == "CY" %}
              ${current_period}
              {% elsif previous_period_to_date._parameter_value == "LY" %}
              ${current_period_LY}
              {% elsif previous_period_to_date._parameter_value == "2LY" %}
              ${current_period_2LY}
              {% elsif previous_period_to_date._parameter_value == "LY2LY" %}
              ${current_period_LY} OR ${current_period_2LY}
              {% endif %}

              {% endif %}

              {% else %}

              {% if period_to_date._parameter_value == "CP" %}
              {%  if custom_date_period._in_query %}
              ${current_period}
              {% else %}
              false
              {% endif %}
              {% elsif period_to_date._parameter_value == "PD" %}
              ${previous_full_day}
              {% elsif period_to_date._parameter_value == "WTD" %}
              ${week_to_date}
              {% elsif period_to_date._parameter_value == "MTD" %}
              ${month_to_date}
              {% elsif period_to_date._parameter_value == "YTD" %}
              ${year_to_date}
              {% endif %}
              {% endif %}     ;;


        }


        dimension: transaction_testing_do_not_use {
          type: date
          description: "Converts transaction_date to relative date (e.g. same year). Use this with Period Comparator for YoY comparison."
          sql:

                  {% if pivot_period._in_query and previous_period_to_date._is_filtered %}

                  CASE
                  WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM CURRENT_DATE()) - 1
                  THEN ${__target_date__} + 364
                  WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM CURRENT_DATE()) - 2
                  THEN ${__target_date__} + 728
                  ELSE ${__target_date__}
                  END

                  {% else %}

                  ${__target_date__}

                  {% endif %}

                  ;;
        }



        dimension: period_comparator{
          view_label: "Period To Date and YoY Filters"
          label: "Period Comparator"
          description: "Use with pivot_period (or it's actual name... TODO)"
          type: string
          order_by_field: transaction_year
          sql:
                  {% if pivot_period._is_filtered %}

                  {% if period_to_date._parameter_value == "PD" %}
                    CASE
                      WHEN ${__target_date__} < CURRENT_DATE() and ${__target_date__} > (CURRENT_DATE() - 7)
                        THEN "This Week"
                      WHEN ${__target_date__} < CURRENT_DATE() - 7 and ${__target_date__} > (CURRENT_DATE() - 14)
                        THEN "Last Week"
                      WHEN false
                        THEN "Last Month"
                      WHEN EXTRACT(YEAR FROM ${__target_date__} + 364) = EXTRACT(YEAR FROM CURRENT_DATE())
                        THEN "LY"
                      WHEN EXTRACT(YEAR FROM ${__target_date__} + 728) = EXTRACT(YEAR FROM CURRENT_DATE())
                        THEN "2LY"
                      ELSE "FAILED"
                    END

                  {% else %}

                  CASE
                  WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM CURRENT_DATE())
                  THEN "CY"
                  WHEN EXTRACT(YEAR FROM ${__target_date__} + 364) = EXTRACT(YEAR FROM CURRENT_DATE())
                  THEN "LY"
                  WHEN EXTRACT(YEAR FROM ${__target_date__} + 728) = EXTRACT(YEAR FROM CURRENT_DATE())
                  THEN "2LY"
                  ELSE "FAILED"
                  END

                  {% endif %}

                  {%else%}
                  "NULL"
                  {%endif%}

                  ;;

          }


          dimension: customer_cluster{
            type: string
            description: "Placed in Transactions due to potential permissions requirement on Customers"
            sql: ${customer_segmentation.cluster};;
          }

          dimension: customer_type {
            type: string
            description: "Placed in Transactions due to potential permissions requirement on Customers"
            sql: CASE WHEN ${customer_cluster} LIKE "T%" THEN "Trade" else "DIY" END ;;
          }



          measure: trade_net_sales {
            type: sum
            label: "Total Net Sales (Trade Only)"
            group_label: "Sales Measures"
            description: "Placed in Transactions due to potential permissions requirement on Customers"
            sql: CASE WHEN ${customer_type} = "Trade" THEN ${net_sales_value} else 0 END ;;
          }

          measure: diy_net_sales {
            type: sum
            label: "Total Net Sales (DIY Only)"
            group_label: "Sales Measures"
            description: "Placed in Transactions due to potential permissions requirement on Customers; Where is not %T then assuming trade to avoid dropping data"
            sql: CASE WHEN ${customer_type} != "Trade" THEN ${net_sales_value} else 0 END ;;
          }

          measure: trade_net_sales_mix {
            type: number
            label: "Total Net Sales Mix (Trade Only)"
            group_label: "Sales Measures"
            sql: ${trade_net_sales} / ${total_net_sales} ;;
            value_format: "##0.00%;(##0.00%)"
          }

          measure: diy_net_sales_mix {
            type: number
            label: "Total Net Sales Mix (DIY Only)"
            group_label: "Sales Measures"
            sql: ${diy_net_sales} / ${total_net_sales} ;;
            value_format: "##0.00%;(##0.00%)"
          }

          measure: trade_net_margin {
            type: sum
            label: "Total Margin inc (Trade Only)"
            group_label: "Margin Measures"
            description: "Placed in Transactions due to potential permissions requirement on Customers"
            sql: CASE WHEN ${customer_type} = "Trade" THEN ${margin_incl_funding} else 0 END ;;
          }

          measure: diy_net_margin {
            type: sum
            label: "Total Margin inc (DIY Only)"
            group_label: "Margin Measures"
            description: "Placed in Transactions due to potential permissions requirement on Customers; Where is not %T then assuming trade to avoid dropping data"
            sql: CASE WHEN ${customer_type} != "Trade" THEN ${margin_incl_funding} else 0 END ;;
          }


          measure: trade_net_units {
            type: sum
            label: "Total Net Units (Trade Only)"
            group_label: "Unit Measures"
            description: "Placed in Transactions due to potential permissions requirement on Customers"
            sql: CASE WHEN ${customer_type} = "Trade" THEN ${quantity} else 0 END ;;
          }

          measure: diy_net_units {
            type: sum
            label: "Total Net Units (DIY Only)"
            group_label: "Unit Measures"
            description: "Placed in Transactions due to potential permissions requirement on Customers; Where is not %T then assuming trade to avoid dropping data"
            sql: CASE WHEN ${customer_type} != "Trade" THEN ${quantity} else 0 END ;;
          }


#####

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
          }

          measure: margin_rate_promo {
            type: number
            group_label: "Margin Measures"
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
          }

          measure: margin_rate_core {
            type: number
            group_label: "Margin Measures"
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
          }

#########################################


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
          }


          dimension:  is_new_product {
            view_label: "Products"
            group_label: "Product Details"
            label: "Is New Product"
            type:  yesno
            sql:
                  (${product_first_sale_date.first_sale_date} + 182) <= ${__target_date__}    ;;
          }


        }
