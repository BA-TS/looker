view: app_web_data {

  derived_table: {
    sql: SELECT distinct
        customerUID as customerID,
        parentOrderUID as OrderID,
        timestamp(transactionDate) as TransactionDate,
        Case
        when userUID like 'APP' then 'App Trolley'
        end as App_Web,
        sum(netsalePrice) as NetSalePrice,
        sum(quantity) as Quantity,
        sum(netSalesValue) as NetSaleValue,
        SUM(netSalePrice * quantity) as revenue,
        sum(marginInclFunding) as Margin
        from `toolstation-data-storage.sales.transactions`
        where
        --date_diff(current_date (),date(transactionDate), day) <= 500 and
         transactionLineType = "Sale" and
        productCode not in ('85699','00053') and
        isCancelled = 0  and
       (userUID  = 'APP')
        group by 1,2,3,4

        union all

        select distinct
        customerUID as customerID,
        parentOrderUID as OrderID,
        timestamp(transactionDate) as TransactionDate,
        Case
        when userUID like 'WWW' then 'Web Trolley'
        end as App_Web,
        sum(netsalePrice) as NetSalePrice,
        sum(quantity) as Quantity,
        sum(netSalesValue) as NetSaleValue,
        SUM(netSalePrice * quantity) as revenue,
        sum(marginInclFunding) as Margin
        from `toolstation-data-storage.sales.transactions`
        where
        --date_diff(current_date (),date(transactionDate), day) <= 500 and
        transactionLineType = "Sale" and
        productCode not in ('85699','00053') and
        isCancelled = 0 and
        (userUID  = 'WWW')
        group by 1,2,3,4
        ;;

        }
      dimension: CustomerID {
        description: "customers for the last week"
        type: string
        sql:  ${TABLE}.customerID ;;
      }

      dimension: OrderID {
        description: "transaction ID"
        type:string
        sql: ${TABLE}.OrderID ;;
      }

      dimension_group: transactiondate  {
        description: "transactiondate"
        type: time
        timeframes: [raw,date]
        sql: ${TABLE}.transactiondate ;;
      }

  dimension_group: transactiondateTEST  {
    description: "transactiondate"
    type: time
    view_label: "_PoP"
    timeframes: [
      raw,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.transactiondate ;;
    convert_tz: no
  }

      dimension: App_web {
        description: "If user used App or Web"
        type:  string
        sql:  ${TABLE}.App_web ;;
      }

      dimension: revenue {
        description: "Revenue of order"
        type: number
        value_format_name: gbp
        sql: ${TABLE}.revenue ;;
      }

      measure: AOV {
        description: "Average Order value"
        type: number
        value_format_name: gbp
        sql: SUM(${TABLE}.NetSaleValue)/(count(distinct(${TABLE}.OrderID))) ;;
      }

      measure: NetSalePrice {
        description: "Total value of order"
        type: sum
        value_format_name: gbp
        sql: ${TABLE}.NetSalePrice ;;
        drill_fields: [transactiondateTEST_date]
      }

      measure: Quantity {
        description: "Total products in order"
        type: sum
        sql:  ${TABLE}.Quantity ;;
      }

      measure: NetSaleValue {
        description: "Total value of order"
        type: sum
        value_format_name: gbp
        sql: ${TABLE}.NetSaleValue ;;
      }

      measure: Total_orders {
        description: "total orders"
        type: count_distinct
        sql: ${TABLE}.OrderID;;
      }

      measure: margin_perc {
        description: "margin percentage per order"
        type: number
        value_format_name: percent_2
        sql: sum(${TABLE}.Margin)/SUM(${TABLE}.NetSaleValue) ;;
      }

      measure: margin_by_order {
        description: "Margin by order"
        type: number
        value_format_name: decimal_2
        sql: sum(${TABLE}.Margin)/(count(distinct(${TABLE}.OrderID))) ;;
      }

      measure: web_based_orders {
        description: "web based orders"
        type: count_distinct
        sql: ${TABLE}.OrderID ;;
        filters: [App_web: "Web Trolley" ]
      }

      measure: Total_Margin {
        description: "sum of Margin"
        type: sum
        value_format_name: decimal_2
        sql: ${TABLE}.Margin ;;
      }

      filter: current_date_range {
      type: date
      view_label: "_PoP"
      label: "1. Current Date Range"
      description: "Select the current date range you are interested in. Make sure any other filter on Event Date covers this period, or is removed."
      sql: ${TABLE}.transactiondate IS NOT NULL ;;
      }

  parameter: compare_to {
    view_label: "_PoP"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "2. Compare To:"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }

  ##- HIDDEN HELPER, Hamburger helper is a thing i've heard from american TV ##

  dimension: days_in_period {
    hidden:  yes
    view_label: "_PoP"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: DATE_DIFF( DATE({% date_start current_date_range %}), DATE({% date_end current_date_range %}),DAY) ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: "_PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
            DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL -${days_in_period} DAY)
            {% else %}
            DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL -1 {% parameter compare_to %} )
            {% endif %};;
  }

  dimension: period_2_end {
    hidden:  yes
    view_label: "_PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
            DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL -1 DAY)
            {% else %}
            DATE_ADD(DATE_ADD(DATE({% date_end current_date_range %}), INTERVAL -1 DAY), INTERVAL -1 {% parameter compare_to %})
            {% endif %};;
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${transactiondateTEST_raw} {% endcondition %}
            THEN DATE_DIFF(DATE({% date_start current_date_range %}), ${transactiondateTEST_date}, day) + 1
            WHEN ${transactiondateTEST_date} between ${period_2_start} and ${period_2_end}
            THEN DATE_DIFF( ${period_2_start}, ${transactiondateTEST_date}, day) + 1
            END
        {% else %} NULL
        {% endif %}
        ;;
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${transactiondateTEST_raw} {% endcondition %}
                THEN 1
                WHEN ${transactiondateTEST_date} between ${period_2_start} and ${period_2_end}
                THEN 2
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }

## ------- HIDING FIELDS  FROM ORIGINAL VIEW FILE  -------- ##

  dimension_group: created {hidden: yes}
  dimension: ytd_only {hidden:yes}
  dimension: mtd_only {hidden:yes}
  dimension: wtd_only {hidden:yes}


  ## ---------------------- TO CREATE FILTERED MEASURES ---------------------------- ##

  dimension: period_filtered_measures {
    hidden: yes
    description: "We just use this for the filtered measures"
    type: string
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${transactiondateTEST_raw} {% endcondition %} THEN 'this'
                WHEN ${transactiondateTEST_date} between ${period_2_start} and ${period_2_end} THEN 'last' END
            {% else %} NULL {% endif %} ;;
  }

  ## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL ${day_in_period} - 1 DAY) ;;
    view_label: "_PoP"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      month,
      month_name,
      month_num,
      year]
  }


  dimension: period {
    view_label: "_PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    order_by_field: order_for_period
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${transactiondateTEST_raw} {% endcondition %}
                THEN 'This {% parameter compare_to %}'
                WHEN ${transactiondateTEST_date} between ${period_2_start} and ${period_2_end}
                THEN 'Last {% parameter compare_to %}'
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }

  # Filtered dimensions

  measure: current_period_sales {
    view_label: "_PoP"
    type: sum
    sql: ${TABLE}.revenue;;
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_sales {
    view_label: "_PoP"
    type: sum
    sql: ${TABLE}.revenue;;
    filters: [period_filtered_measures: "last"]
  }

  measure: sales_pop_change {
    view_label: "_PoP"
    label: "Total Sales period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_sales} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_sales} / NULLIF(${previous_period_sales} ,0)) - 1 END ;;
    value_format_name: percent_2
  }


    }

view: total_sessions {

  derived_table: {
    sql: with sub1 as (SELECT distinct
    'App Trolley' as app_web_sessions,
    PARSE_DATE('%Y%m%d', event_date) as date,
    COUNT(DISTINCT CASE
    WHEN event_name = 'session_start' THEN CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))
    END) AS sessions
    FROM `toolstation-data-storage.analytics_265133009.events_*`
    WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() - 500
    and PARSE_DATE('%Y%m%d', event_date) >= current_date () - 500
    GROUP BY 1,2

    UNION ALL

    SELECT distinct
    'Web Trolley' as app_web_sessions,
    PARSE_DATE('%Y%m%d', date) as date,
    SUM(totals.visits) as sessions
    FROM `toolstation-data-storage.4783980.ga_sessions_*`
    WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500
    GROUP BY 1,2)

    select distinct row_number() over (order by date,app_web_sessions) as P_K, * from sub1

    ;;
    }

  dimension: P_K {
    description: "Primary key"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }


  dimension: app_web_sessions {
    description: "Web or App sessions"
    type: string
    sql: ${TABLE}.app_web_sessions ;;
  }

  dimension_group: date {
    description: "Date of sessions"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: sessions {
    description: "total sessions"
    type: number
    sql: ${TABLE}.sessions ;;
  }
}

view: dim_date {

  derived_table: {
    sql: SELECT distinct
   dateKey,
   fullDate,
   fiscalYearWeek,
  (select distinct fiscalYearWeek from `toolstation-data-storage.ts_finance.dim_date` where fullDate = (current_date()-7)) as LastFiscalWeek,
   fiscalYearMonth,
   fiscalYear,
    current_date() as today,
    (current_date()-1) as yesterday,
    (current_date()-7) as LastWeek,
    (DATE_SUB(current_date(), INTERVAL 1 month)) as lastMonth,
    (DATE_SUB(current_date(), INTERVAL 1 Year)) as lastYear,
    (DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 Week),INTERVAL 1 year)) as lastWeekLastYear,
    (DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 month),INTERVAL 1 year)) as LastMonthLastYear,
    FROM `toolstation-data-storage.ts_finance.dim_date`
    where (date_diff(current_date(), fullDate, day) <= 15 and date_diff(current_date(), fullDate, day) >= 0)
    or (fullDate) = (current_date()-1)
    or (fullDate) = (current_date()-7)
    or (fullDate) = (DATE_SUB(current_date(), INTERVAL 1 month))
    or (fullDate) = (DATE_SUB(current_date(), INTERVAL 1 Year))
    or (fullDate) = (DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 Week),INTERVAL 1 year))
    or (fullDate) = (DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 month),INTERVAL 1 year))
    order by fullDate DESC;;
  }

  dimension: dateKey {
    description: "Primary key for date"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.datekey ;;
  }

  dimension: fiscalYearWeek {
    description: "fiscalYearWeek"
    type: string
    sql: ${TABLE}.fiscalYearWeek ;;
  }

  dimension: LastfiscalWeek {
    description: "LastfiscalWeek"
    type: string
    sql: ${TABLE}.LastfiscalWeek ;;
  }

  dimension: fiscalYearMonth {
    description: "fiscalYearMonth"
    type: string
    sql: ${TABLE}.fiscalYearMonth ;;
  }
  dimension: fiscalYear {
    description: "fiscalYear"
    type: string
    sql: ${TABLE}.fiscalYear;;
  }

  dimension_group: todayTEST  {
    description: "todaydate"
    type: time
    view_label: "today_PoP"
    timeframes: [
      raw,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.today ;;
    convert_tz: no
  }

  dimension_group: fullDateTEST  {
    description: "fullDate"
    type: time
    view_label: "fullDate"
    timeframes: [
      raw,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.fullDate ;;
    convert_tz: no
  }
}

view: digital_budget {

  derived_table: {
    sql:  select distinct row_number() over (order by date,Budgeted_Sales) as P_K, Date, Budgeted_Sales
    from `toolstation-data-storage.digitalreporting.Digital_Budget_2023` ;;
  }

  dimension: P_K {
    description: "Primary key for date"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension_group: Date {
    description: "date"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.Date ;;
  }

  dimension: Budgeted_Sales {
    description: "budget for each date"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Budgeted_Sales ;;
  }
}
