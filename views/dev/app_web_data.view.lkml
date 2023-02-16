view: app_web_data {

  derived_table: {
    sql: SELECT distinct
        customerUID as customerID,
        parentOrderUID as OrderID,
        date(transactionDate) as TransactionDate,
        Case
        when userUID like 'APP' then 'App Trolley'
        end as App_Web,
        sum(netsalePrice) as NetSalePrice,
        sum(quantity) as Quantity,
        sum(netSalesValue) as NetSaleValue,
        SUM(netSalePrice * quantity) as revenue,
        sum(marginInclFunding) as Margin
        from `toolstation-data-storage.sales.transactions`
        where date_diff(current_date (),date(transactionDate), day) <= 500
        and transactionLineType = "Sale"
        and productCode not in ('85699','00053')
        and isCancelled = 0
        and (userUID  = 'APP')
        group by 1,2,3,4

        union all

        select distinct
        customerUID as customerID,
        parentOrderUID as OrderID,
        date(transactionDate) as TransactionDate,
        Case
        when userUID like 'WWW' then 'Web Trolley'
        end as App_Web,
        sum(netsalePrice) as NetSalePrice,
        sum(quantity) as Quantity,
        sum(netSalesValue) as NetSaleValue,
        SUM(netSalePrice * quantity) as revenue,
        sum(marginInclFunding) as Margin
        from `toolstation-data-storage.sales.transactions`
        where date_diff(current_date (),date(transactionDate), day) <= 500
        and transactionLineType = "Sale"
        and productCode not in ('85699','00053')
        and isCancelled = 0
        and (userUID  = 'WWW')
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
   fiscalYearMonth,
   fiscalYear,
    current_date() as today,
    format_date('%Y-%m-%d', current_date()-1) as yesterday,
    format_date('%Y-%m-%d', current_date()-7) as LastWeek,
    format_date('%Y-%m-%d',DATE_SUB(current_date(), INTERVAL 1 month)) as lastMonth,
    format_date('%Y-%m-%d',DATE_SUB(current_date(), INTERVAL 1 Year)) as lastYear,
    format_date('%Y-%m-%d',DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 Week),INTERVAL 1 year)) as lastWeekLastYear,
    format_date('%Y-%m-%d',DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 month),INTERVAL 1 year)) as LastMonthLastYear,
    FROM `toolstation-data-storage.ts_finance.dim_date`
    where (date_diff(current_date(), fullDate, day) <= 15 and date_diff(current_date(), fullDate, day) >= 0)
    or format_date('%Y-%m-%d',fullDate) = format_date('%Y-%m-%d', current_date()-1)
    or format_date('%Y-%m-%d',fullDate) = format_date('%Y-%m-%d', current_date()-7)
    or format_date('%Y-%m-%d',fullDate) = format_date('%Y-%m-%d',DATE_SUB(current_date(), INTERVAL 1 month))
    or format_date('%Y-%m-%d',fullDate) = format_date('%Y-%m-%d',DATE_SUB(current_date(), INTERVAL 1 Year))
    or format_date('%Y-%m-%d',fullDate) = format_date('%Y-%m-%d',DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 Week),INTERVAL 1 year))
    or format_date('%Y-%m-%d',fullDate) = format_date('%Y-%m-%d',DATE_SUB(DATE_SUB(current_date(), INTERVAL 1 month),INTERVAL 1 year))
    order by fullDate DESC;;
  }

  dimension: dateKey {
    description: "Primary key for date"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.datekey ;;
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
    description: "fullDatedate"
    type: time
    view_label: "fullDate_PoP"
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

  dimension_group: YesterdayTEST  {
    description: "Yesterdaydate"
    type: time
    view_label: "Yesterday_PoP"
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
    sql: ${TABLE}.yesterday ;;
    convert_tz: no
  }

  dimension_group: LastWeekTEST  {
    description: "LastWeekdate"
    type: time
    view_label: "LastWeek_PoP"
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
    sql: ${TABLE}.LastWeek ;;
    convert_tz: no
  }

  dimension_group: lastMonthTEST  {
    description: "lastMonthdate"
    type: time
    view_label: "lastMonth_PoP"
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
    sql: ${TABLE}.lastMonth ;;
    convert_tz: no
  }
  dimension_group: lastYearTEST  {
    description: "lastYeardate"
    type: time
    view_label: "lastYear_PoP"
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
    sql: ${TABLE}.lastYear ;;
    convert_tz: no
  }

  dimension_group: lastWeekLastYearTEST  {
    description: "lastWeekLastYeardate"
    type: time
    view_label: "lastWeekLastYear_PoP"
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
    sql: ${TABLE}.lastWeekLastYear ;;
    convert_tz: no
  }

  dimension_group: LastMonthLastYearTEST  {
    description: "LastMonthLastYeardate"
    type: time
    view_label: "LastMonthLastYear_PoP"
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
    sql: ${TABLE}.LastMonthLastYear ;;
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
