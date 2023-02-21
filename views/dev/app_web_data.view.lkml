include: "/views/prod/date/Period_over_period_RJ_test.view"

view: app_web_data {

  derived_table: {
    sql: with sub1 as (SELECT distinct
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
        group by 1,2,3,4)

        select distinct row_number() over (order by (transactionDate)) as P_K, * from sub1
        ;;

        }

      dimension: P_K {
        description: "Primary key"
        type: number
        primary_key: yes
        hidden: yes
        sql: ${TABLE}.P_K ;;
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

# view: baseTEST {

#   derived_table: {
#     sql:

#     select date
#     from UNNEST(GENERATE_DATE_ARRAY('2015-01-01', date(extract(year from current_date), 12, 31))) date

#       ;;
#     datagroup_trigger: ts_daily_datagroup
#   }

#   extends: [period_over_period_rj_test]


#   dimension: combined_day_name {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Day Name"
#     sql: ${dynamic_day_name} ;;
#     can_filter: no
#     hidden: no
#   }

#   dimension: combined_month_number {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Month Number"
#     sql: ${dynamic_month_number} ;;
#     can_filter: yes
#     hidden: no
#   }

#   # dynamic_month_number

#   dimension: combined_day_of_week {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Day of Week"
#     sql: ${dynamic_day_of_week} ;;
#     can_filter: no
#     hidden: no #! check this for fiscal/calendar switch
#   }

#   dimension: combined_month_name {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Month Name"
#     sql: ${dynamic_month_name} ;;
#     can_filter: no
#     hidden: no
#   }

#   # dimension: combined_month_number {
#   #   group_label: "Dates"
#   #   label: "Month Number"
#   #   sql: ${dynamic_month_number} ;;
#   #   can_filter: no
#   #   hidden: no
#   # }

#   dimension: combined_week {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Week"
#     type: string
#     sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_week} {% else %} ${dynamic_fiscal_week} {% endif %} ;;
#     hidden: no
#   }




#   dimension: separate_month {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Month (Only)"
#     type: string
#     sql: {% if select_date_type._parameter_valuie == "Calendar" %} ${dynamic_actual_month_only} {% else %} ${dynamic_fiscal_month_only} {% endif %} ;;
#     hidden: no
#   }





#   dimension: combined_month {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Month"
#     type: string
#     sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_month} {% else %} ${dynamic_fiscal_month} {% endif %} ;;
#     hidden: no
#   }

#   dimension: combined_quarter {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Quarter"
#     type: string
#     sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_quarter} {% else %} ${dynamic_fiscal_quarter} {% endif %} ;;
#     hidden: no
#   }

#   dimension: combined_half {
#     hidden: yes
#   }

#   dimension: combined_year {
#     view_label: "Date"
#     group_label: "Dates"
#     label: "Year"
#     type: number
#     sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_year} {% else %} ${dynamic_fiscal_year} {% endif %} ;;
#     hidden: no
#   }

#   dimension_group: base_date {
#     type: time
#     timeframes: [raw, date, year, month_num]
#     sql:

#     timestamp(${TABLE}.date)

#           ;;
#     hidden: yes
#   }

#   dimension: base_date_pk {
#     primary_key: yes
#     type: date
#     sql:

#     date(${TABLE}.date)

#           ;;
#     hidden: yes
#   }

#   # DATE v2 #

#   dimension: dynamic_day_of_week {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Day of Week"
#     type: number
#     sql: ${calendar_completed_date.day_in_week} ;;
#     hidden: yes
#   }
#   dimension: dynamic_day_name {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Day Name"
#     type: string
#     sql: ${calendar_completed_date.day_name_in_week} ;;
#     hidden: yes
#   }
#   dimension: dynamic_actual_week {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Week Number"
#     type: number
#     sql:

#     {% if pivot_dimension._in_query %}
#       ${dynamic_actual_year}
#       ||
#       LPAD(CAST(${calendar_completed_date.week_in_year} AS STRING), 2, "0")
#     {% else %}
#       ${calendar_completed_date.calendar_year}
#       ||
#       LPAD(CAST(${calendar_completed_date.week_in_year} AS STRING), 2, "0")
#     {% endif %}
#     ;;
#     hidden: yes
#   }
#   dimension: dynamic_fiscal_week {
#     view_label: "Date"
#     group_label: "Fiscal"
#     label: "Fiscal Week"
#     type: string
#     sql:

#     {% if pivot_dimension._in_query  %}

#             ${dynamic_fiscal_year}

#       ||

#       LPAD(CAST(${calendar_completed_date.fiscal_week_of_year} AS STRING),2,"0")

#       {% else %}

#       ${calendar_completed_date.fiscal_year}

#       ||

#       LPAD(CAST(${calendar_completed_date.fiscal_week_of_year} AS STRING),2,"0")

#       {% endif %}

#       ;;
#     hidden: yes
#   }
#   dimension: dynamic_month_number {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Month Number"
#     type: number
#     sql: ${calendar_completed_date.month_in_year} ;;
#     hidden: yes
#   }
#   dimension: dynamic_month_name {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Month Name"
#     type: string
#     sql: ${calendar_completed_date.month_name_in_year} ;;
#     hidden: yes
#   }












#   dimension: dynamic_actual_month_only {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Month Only"
#     type: string
#     sql:

#     {% if pivot_dimension._in_query  %}

#             LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

#       {% else %}

#       LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

#       {% endif %}

#       ;;
#     hidden: yes
#   }

#   dimension: dynamic_fiscal_month_only {
#     view_label: "Date"
#     group_label: "Fiscal"
#     label: "Month Only"
#     type: string
#     sql:

#     {% if pivot_dimension._in_query  %}


#       LPAD(CAST(${calendar_completed_date.fiscal_month_of_year} AS STRING),2,"0")

#       {% else %}


#       LPAD(CAST(${calendar_completed_date.fiscal_month_of_year} AS STRING),2,"0")

#       {% endif %}

#       ;;
#     hidden: yes
#   }























#   dimension: dynamic_actual_month {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Year Month"
#     type: string
#     sql:

#     {% if pivot_dimension._in_query  %}

#             ${dynamic_actual_year}

#       ||

#       "-"

#       ||

#       LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

#       {% else %}

#       ${calendar_completed_date.calendar_year}

#       ||

#       "-"

#       ||

#       LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

#       {% endif %}

#       ;;
#     hidden: yes
#   }

#   dimension: dynamic_fiscal_month {
#     view_label: "Date"
#     group_label: "Fiscal"
#     label: "Fiscal Month"
#     type: string
#     sql:

#     {% if pivot_dimension._in_query  %}

#             ${dynamic_fiscal_year}

#       ||

#       "-"

#       ||

#       LPAD(CAST(${calendar_completed_date.fiscal_month_of_year} AS STRING),2,"0")

#       {% else %}

#       ${calendar_completed_date.fiscal_year}

#       ||

#       "-"

#       ||

#       LPAD(CAST(${calendar_completed_date.fiscal_month_of_year} AS STRING),2,"0")

#       {% endif %}

#       ;;
#     hidden: yes
#   }
#   dimension: dynamic_actual_quarter {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Quarter"
#     type: number
#     sql:

#     {% if pivot_dimension._in_query %}
#     ${dynamic_actual_year}
#       ||
#       "Q"
#       ||
#       LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING), 2, "0")
#     {% else %}
#       ${calendar_completed_date.calendar_year}
#       ||
#       "Q"
#       ||
#       LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING), 2, "0")

#       {% endif %}

#       ;;
#     hidden: yes
#   }
#   dimension: dynamic_fiscal_quarter {
#     view_label: "Date"
#     group_label: "Fiscal"
#     label: "Fiscal Quarter"
#     type: string
#     sql:

#     {% if pivot_dimension._in_query  %}

#             ${dynamic_fiscal_year}

#       ||

#       "Q"

#       ||

#       LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING),2,"0")

#       {% else %}

#       ${calendar_completed_date.fiscal_year}

#       ||

#       "Q"

#       ||

#       LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING),2,"0")

#       {% endif %}


#       ;;
#     hidden: yes
#   }



#   dimension: dynamic_half_number {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Half"
#     type: number
#     hidden: yes
#     sql:

#     {% if pivot_dimension._in_query  %}

#             ${dynamic_actual_year}

#       ||

#       "H"

#       ||

#       case when ${calendar_completed_date.calendar_quarter} in (1,2) then 1 else 2 end

#       {% else %}

#       ${calendar_completed_date.calendar_year}

#       ||

#       "H"

#       ||

#       case when ${calendar_completed_date.calendar_quarter} in (1,2) then 1 else 2 end

#       {% endif %}



#       ;;
#   }
#   dimension: dynamic_fiscal_half {
#     view_label: "Date"
#     group_label: "Fiscal"
#     label: "Fiscal Half"
#     type: string
#     hidden: yes
#     sql:

#     {% if pivot_dimension._in_query  %}


#       ${dynamic_fiscal_year}

#       ||

#       "H"

#       ||

#       ${dynamic_half_number}

#       {% else %}

#       ${calendar_completed_date.fiscal_year}

#       ||

#       "H"

#       ||

#       ${dynamic_half_number}

#       {% endif %}


#       ;;
#   }

#   dimension: dynamic_fiscal_year {
#     view_label: "Date"
#     group_label: "Fiscal"
#     label: "Fiscal Year"
#     type: number
#     sql:

#     ${calendar_completed_date.fiscal_year}

#           {% if pivot_dimension._in_query  %}
#                 +
#               CASE
#                 WHEN ${calendar_completed_date.fiscal_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 1
#                   THEN 1
#                 WHEN ${calendar_completed_date.fiscal_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 2
#                   THEN 2
#                 ELSE 0
#               END
#           {% endif %}

#       ;;
#     hidden: yes
#   }

#   dimension: dynamic_actual_year {
#     view_label: "Date"
#     group_label: "Calendar"
#     label: "Year"
#     type: number
#     sql:

#     ${base_date_year}
#     {% if pivot_dimension._in_query  %}
#       +
#     CASE
#       WHEN ${base_date_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 1
#         THEN 1
#       WHEN ${base_date_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 2
#         THEN 2
#       ELSE 0
#     END
#     {% endif %}

#       ;;
#     hidden: yes
#   }







#   measure: count_of_dates {
#     type: count_distinct
#     sql: ${base_date_date} ;;
#     hidden: yes # only used by Data Tests
#   }

# }

# view: calendar {

#   fields_hidden_by_default: yes

#   sql_table_name:

#   `toolstation-data-storage.ts_finance.dim_date`

#       ;;

#   dimension: date{
#     type: date
#     primary_key: yes
#     sql: ${TABLE}.fullDate ;;
#   }
#   dimension: calendar_quarter {
#     group_label: "Calendar"
#     type: number
#     sql: ${TABLE}.calendarQuarter ;;
#   }
#   dimension: calendar_year {
#     group_label: "Calendar"
#     type: number
#     sql: ${TABLE}.calendarYear ;;
#   }
#   dimension: calendar_year_month {
#     group_label: "Calendar"
#     type: string
#     sql: ${TABLE}.calendarYearMonth ;;
#   }
#   dimension: calendar_year_quarter {
#     group_label: "Calendar"
#     type: string
#     sql: ${TABLE}.calendarYearQuarter ;;
#   }
#   dimension: date_key {
#     group_label: "Date"
#     type: number
#     sql: ${TABLE}.dateKey ;;
#   }
#   dimension: date_name {
#     group_label: "Date"
#     type: string
#     sql: ${TABLE}.dateName ;;
#   }
#   dimension: date_name_eu {
#     group_label: "Date"
#     type: string
#     sql: ${TABLE}.dateNameEU ;;
#   }
#   dimension: date_name_usa {
#     group_label: "Date"
#     type: string
#     sql: ${TABLE}.dateNameUSA ;;
#   }
#   dimension: day_in_month {
#     group_label: "Day"
#     type: number
#     sql: ${TABLE}.dayInMonth ;;
#   }
#   dimension: day_in_week {
#     group_label: "Day"
#     type: number
#     sql: ${TABLE}.dayInWeek ;;
#   }
#   dimension: day_in_year {
#     group_label: "Day"
#     type: number
#     sql: ${TABLE}.dayInYear ;;
#   }
#   dimension: day_name_in_week {
#     group_label: "Day"
#     type: string
#     sql: ${TABLE}.dayNameInWeek ;;
#   }
#   dimension: fiscal_month_of_year {
#     group_label: "Fiscal"
#     type: number
#     sql: ${TABLE}.fiscalMonthOfYear ;;
#   }
#   dimension: fiscal_quarter {
#     group_label: "Fiscal"
#     type: number
#     sql: ${TABLE}.fiscalQuarter ;;
#   }
#   dimension: fiscal_week_of_year {
#     group_label: "Fiscal"
#     type: number
#     sql: ${TABLE}.fiscalWeekOfYear ;;
#   }
#   dimension: fiscal_year {
#     group_label: "Fiscal"
#     type: number
#     sql: ${TABLE}.fiscalYear ;;
#   }
#   dimension: fiscal_year_month {
#     group_label: "Fiscal"
#     type: string
#     sql: ${TABLE}.fiscalYearMonth ;;
#   }
#   dimension: fiscal_year_quarter {
#     group_label: "Fiscal"
#     type: string
#     sql: ${TABLE}.fiscalYearQuarter ;;
#   }
#   dimension: fiscal_year_week {
#     label: "Fiscal Week"
#     type: string
#     sql: ${TABLE}.fiscalYearWeek ;;
#     can_filter: no
#   }
#   dimension: holiday_name {
#     group_label: "Holiday"
#     type: string
#     sql: ${TABLE}.holidayName ;;
#     hidden: no
#   }
#   dimension: holiday_name_scotland {
#     group_label: "Holiday"
#     type: string
#     sql: ${TABLE}.holidayNameScotland ;;
#     hidden: no
#   }
#   dimension: is_holiday {
#     group_label: "Flags"
#     type: yesno
#     sql: ${TABLE}.isHoliday = 1;;
#     hidden: no
#   }
#   dimension: is_holiday_scotland {
#     group_label: "Flags"
#     type: yesno
#     sql: ${TABLE}.isHolidayScotland = 1;;
#     hidden: no
#   }
#   dimension: is_last_day_of_month {
#     group_label: "Flags"
#     type: yesno
#     sql: ${TABLE}.isLastDayOfMonth = 1 ;;
#     hidden: no
#   }
#   dimension: is_first_day_of_month {
#     group_label: "Flags"
#     type: yesno
#     sql: ${TABLE}.dayInMonth = 1 ;;
#     hidden: no
#   }
#   dimension: is_weekend {
#     group_label: "Flags"
#     type: yesno
#     sql: ${TABLE}.isWeekend = 1;;
#     hidden: no
#   }
#   dimension: month_in_year {
#     group_label: "Calendar"
#     type: number
#     sql: ${TABLE}.monthInYear ;;
#   }
#   dimension: month_name_in_year {
#     group_label: "Calendar"
#     type: string
#     sql: ${TABLE}.monthNameInYear ;;
#   }
#   dimension: week_in_year {
#     group_label: "Calendar"
#     type: number
#     sql: ${TABLE}.weekInYear ;;
#   }

# }
