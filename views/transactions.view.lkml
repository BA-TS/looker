include: "/custom_views/**/*.view"

view: transactions {
  sql_table_name: `sales.transactions`
    ;;
  # drill_fields: [transaction_uid]

  extends: [pop_date_comparison]

  dimension: event_raw {
    type: date_raw
    sql: ${transaction_raw} ;;
    hidden: yes
  }

  dimension: order_line_key {
    primary_key:  yes
    type:  string
    sql: concat(${parent_order_uid},${product_uid},${transaction_line_type}) ;;
    hidden:  yes
  }

  dimension: parent_order_uid {
    label: "Parent Order UID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: transaction_uid {
    label: "Transaction UID"
    type: string
    sql: ${TABLE}.transactionUID ;;
  }

  dimension: cogs {
    type: number
    sql: ${TABLE}.COGS ;;
    hidden:  yes
  }

  dimension: customer_uid {
    label: "Customer UID"
    type: string
    sql: ${TABLE}.customerUID ;;
  }

  dimension: delivery_address_uid {
    label: "Delivery Address UID"
    type: string
    sql: ${TABLE}.deliveryAddressUID ;;
  }

  dimension: fulfillment_channel {
    type: string
    sql: ${TABLE}.fulfillmentChannel ;;
    hidden:  yes
  }

  dimension: gross_sale_price {
    label: "Gross Sale Price"
    type: number
    sql: ${TABLE}.grossSalePrice ;;
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

  dimension: is_lfl {
    label: "Is LFL"
    type: number
    sql: ${TABLE}.isLFL ;;
  }

  dimension: is_mature {
    label: "Is Mature"
    type: number
    sql: ${TABLE}.isMature ;;
  }

  dimension: is_open18_months {
    label: "Is Open 18 Months"
    type: number
    sql: ${TABLE}.isOpen18Months ;;
  }

  dimension: is_originating_lfl {
    label: "Is Originating LFL"
    type: number
    sql: ${TABLE}.isOriginatingLFL ;;
  }

  dimension: is_originating_mature {
    label: "Is Originating Mature"
    type: number
    sql: ${TABLE}.isOriginatingMature ;;
  }

  dimension: is_originating_open18_months {
    label: "Is Originating Open (18 Months)"
    type: number
    sql: ${TABLE}.isOriginatingOpen18Months ;;
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
    type: string
    sql: ${TABLE}.originatingSiteUID ;;
  }

  dimension: payment_type {
    label: "Payment Type"
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension_group: placed {
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

  dimension: product_code {
    label: "Product Code"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: product_uid {
    label: "Product UID"
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    hidden:  yes
  }

  dimension: row_id {
    type: number
    sql: ${TABLE}.rowID ;;
    hidden:  yes
  }

  dimension: sales_channel {
    label: "Sales Channel"
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  dimension: site_uid {
    label: "Site UID"
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension_group: transaction {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      day_of_week_index
    ]
    sql: ${TABLE}.transactiondate ;;
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

  dimension: user_uid {
    label: "User UID"
    type: string
    sql: ${TABLE}.userUID ;;
  }

  dimension: vat_rate {
    label: "VAT Rate"
    type: number
    sql: ${TABLE}.vatRate ;;
  }

  measure: total_net_sales {
    label: "Total Net Sales"
    group_label: "Sales Measures"
    type:  sum
    sql: ${net_sales_value} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: total_gross_sales {
    label: "Total Gross Sales"
    group_label: "Sales Measures"
    type:  sum
    sql: ${gross_sales_value} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"

  }

  measure: total_cogs {
    label: "Total COGS"
    type:  sum
    sql: ${cogs} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: total_margin_excl_funding {
    label: "Total Margin (Excluding Funding)"
    type:  sum
    sql: ${margin_excl_funding} ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"

  }

  measure: total_margin_incl_funding {
    label: "Total Margin (Including Funding)"
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

  measure: net_sales_AOV {
    label: "Net Sales AOV"
    type:  number
    sql: (sum(${net_sales_value})/count(distinct ${parent_order_uid})) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: gross_sales_AOV {
    label: "Gross Sales AOV"
    type:  number
    sql: (sum(${gross_sales_value})/count(distinct ${parent_order_uid})) ;;
    value_format: "\£#,##0.00;(\£#,##0.00)"
  }

  measure: transactions {
    label: "Number of Transactions"
    type: count_distinct
    sql: ${parent_order_uid} ;;
    value_format: "#,##0;(#,##0)"
  }

  ############################################
               # CJG TESTING #


  measure: total_margin_rate_excl_funding {
    label: "Total Margin Rate (Excluding Funding)"
    type:  number
    sql: ${total_margin_excl_funding} / ${total_net_sales} ;;
    value_format: "##0.00%;(##0.00%)"

  }

  measure: total_margin_rate_incl_funding {
    label: "Total Margin Rate (Including Funding)"
    type:  number
    sql: ${total_margin_incl_funding} / ${total_net_sales} ;;
    value_format: "0.00%;(0.00%)"
  }



######################################### ROX
















  filter: date_range {
    view_label: "Period To Date and YoY Filters"
    label: "Date Range Filter"
    description: ""
    type:  date
    convert_tz: yes
  }

  dimension: range_CY {
    label: "Range CY"
    type: yesno
    sql:
    WHEN ${transaction_raw} BETWEEN {% date_start date_range %} and {% date_end date_range %}
  ;;
    hidden: yes
  }

  dimension: range_LY {

    label: "Range LY"
    type: yesno
    sql:
    WHEN ${transaction_raw} BETWEEN ({% date_start date_range%} - 364) and ({% date_end date_range %} - 364)
  ;;
    hidden: yes
  }

  dimension: range_2LY {
    label: "Range 2LY"
    type:  yesno
    sql:
    WHEN ${transaction_raw} BETWEEN ({% date_start date_range%} - (364*2)) and ({% date_end date_range %} - (364*2))
  ;;
  }









  dimension: __target_date__ {
    sql: ${transaction_date} ;;
  }











#########################################


  # PREVIOUS PERIOD


  # PREVIOUS DAY

  dimension: previous_full_day {
    description: "PFD looks at the 'yesterday'"
    type: yesno
    sql:

    ${__target_date__} = (CURRENT_DATE() - 1)

    ;;
    hidden: yes
  }

  dimension: previous_full_day_LY {
    description: "PFD looks at the 'yesterday' and same day last year"
    type: yesno
    sql:

    ${previous_full_day}

    OR

    ${__target_date__} = (CURRENT_DATE() - 1 - 364)
    ;;
    hidden: yes

  }

  dimension: previous_full_day_2LY {
    description: "PFD looks at the 'yesterday' and same day 2 years"
    type: yesno
    sql:

    ${previous_full_day}

    OR

    ${__target_date__} = (CURRENT_DATE() - 1 - (364*2))

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
      ${__target_date__} > CURRENT_DATE() - EXTRACT(DAY FROM CURRENT_DATE())
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
      ${__target_date__} > DATE(EXTRACT(YEAR FROM CURRENT_DATE()),1,1)
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

         ${__target_date__} < DATE(EXTRACT(YEAR FROM CURRENT_DATE())-1,EXTRACT(MONTH FROM CURRENT_DATE()),EXTRACT(DAY FROM CURRENT_DATE()))
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


  #####


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
      label: "Current Year"
      value: "CY"
    }
    allowed_value: {
      label: "Previous Year"
      value: "LY"
    }
    allowed_value: {
      label: "Previous 2 Year"
      value: "2LY"
    }
    default_value: "CY"
    view_label: "Period To Date and YoY Filters"
  }


  filter: pivot_period {
    view_label: "Period To Date and YoY Filters"
    label: "Apply Filter"
    description: ""
    type:  yesno
    sql:

    {% if period_to_date._in_query and previous_period_to_date._in_query %}

      {% if period_to_date._parameter_value == "CP" %}

        true

      {% elsif period_to_date._parameter_value == "PD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}
          ${previous_full_day}
        {% elsif previous_period_to_date._parameter_value == "LY" %}
          ${previous_full_day_LY}
        {% elsif previous_period_to_date._parameter_value == "2LY" %}
          ${previous_full_day_2LY}
        {% endif %}

      {% elsif period_to_date._parameter_value == "WTD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}
          ${week_to_date}
        {% elsif previous_period_to_date._parameter_value == "LY" %}
          ${week_to_date_LY}
        {% elsif previous_period_to_date._parameter_value == "2LY" %}
          ${week_to_date_2LY}
        {% endif %}

      {% elsif period_to_date._parameter_value == "MTD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}
          ${month_to_date}
        {% elsif previous_period_to_date._parameter_value == "LY" %}
          ${month_to_date_LY}
        {% elsif previous_period_to_date._parameter_value == "2LY" %}
          ${month_to_date_2LY}
        {% endif %}

      {% elsif period_to_date._parameter_value == "YTD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}
          ${year_to_date}
        {% elsif previous_period_to_date._parameter_value == "LY" %}
          ${year_to_date_LY}
        {% elsif previous_period_to_date._parameter_value == "2LY" %}
          ${year_to_date_2LY}
        {% endif %}

      {% elsif period_to_date._parameter_value == "CP" %}
        NULL
      {% endif %}

    {% else %}

      {% if period_to_date._parameter_value == "CP" %}
        true
      {% elsif period_to_date._parameter_value == "PD" %}
        ${previous_full_day}
      {% elsif period_to_date._parameter_value == "WTD" %}
        ${week_to_date}
      {% elsif period_to_date._parameter_value == "MTD" %}
        ${month_to_date}
      {% elsif period_to_date._parameter_value == "YTD" %}
        ${year_to_date}
      {% endif %}

    {% endif %}

    ;;

  }


}
