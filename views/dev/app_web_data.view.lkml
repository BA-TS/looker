#include: "/views/prod/date/base_date_noCatalogue.view.lkml"
#include: "/views/prod/date/PoP.view.lkml"

include: "/views/**/*base*.view"

view: app_web_data {

  derived_table: {
    sql: with sub1 as (SELECT distinct
        customerUID as customerID,
        parentOrderUID as OrderID,
        productUID as productUID,
        upper(salesChannel) as salesChannel,
        timestamp(transactionDate) as Transaction,
        timestamp(PlacedDate) as Placed,
        Case
        when userUID like 'APP' then 'App Trolley'
        end as App_Web,
        sum(netsalePrice) as NetSalePrice,
        sum(quantity) as Quantity,
        sum(netSalesValue) as NetSaleValue,
        SUM(netSalePrice * quantity) as revenue,
        SUM(grossSalesValue) as revenue2,
        sum(marginInclFunding) as MarginIncFunding,
        sum(marginExclFunding) as marginExclFunding
        from `toolstation-data-storage.sales.transactions`
        where
        --date_diff(current_date (),date(transactionDate), day) <= 500 and
         transactionLineType = "Sale" and
        productCode not in ('85699','00053') and
        isCancelled = 0  and
       (userUID  = 'APP')
        group by 1,2,3,4,5,6,7

        union all

        select distinct
        customerUID as customerID,
        parentOrderUID as OrderID,
        productUID as productUID,
        upper(salesChannel) as salesChannel,
        timestamp(transactionDate) as Transaction,
        timestamp(PlacedDate) as Placed,
        Case
        when userUID like 'WWW' then 'Web Trolley'
        end as App_Web,
        sum(netsalePrice) as NetSalePrice,
        sum(quantity) as Quantity,
        sum(netSalesValue) as NetSaleValue,
        SUM(netSalePrice * quantity) as revenue,
        SUM(grossSalesValue) as revenue2,
        sum(marginInclFunding) as MarginIncFunding,
        sum(marginExclFunding) as marginExclFunding
        from `toolstation-data-storage.sales.transactions`
        where
        --date_diff(current_date (),date(transactionDate), day) <= 500 and
        transactionLineType = "Sale" and
        productCode not in ('85699','00053') and
        isCancelled = 0 and
        (userUID  = 'WWW')
        group by 1,2,3,4,5,6,7)

        select distinct row_number() over (order by (Transaction)) as P_K, * from sub1
        ;;


    partition_keys: ["Transaction"]
    cluster_keys: ["salesChannel", "productUID"]

    datagroup_trigger: ts_transactions_datagroup

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

  dimension: ProductUID {
    description: "ProductUID"
    type:string
    sql: ${TABLE}.ProductUID ;;
  }

  dimension: salesChannel {
    description: "salesChannel"
    type:string
    sql: ${TABLE}.salesChannel;;
  }

      dimension_group: transaction  {
        description: "transactiondate"
        type: time
        timeframes: [
          raw,
          time,
          date,
          month_num
        ]
        sql: ${TABLE}.transaction ;;
      }

  dimension_group: Placed  {
    description: "Placeddate"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.Placed ;;
  }

  # dimension_group: transactiondateTEST  {
  #   description: "transactiondate"
  #   type: time
  #   view_label: "_PoP"
  #   timeframes: [
  #     raw,
  #     date,
  #     day_of_week,
  #     day_of_week_index,
  #     day_of_month,
  #     day_of_year,
  #     week,
  #     week_of_year,
  #     month,
  #     month_name,
  #     month_num,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.transactiondate ;;
  #   convert_tz: no
  # }

      dimension: App_web {
        description: "If user used App or Web"
        type:  string
        sql:  ${TABLE}.App_web ;;
      }

      measure: Totalrevenue {
        description: "Revenue of order"
        type: sum
        value_format_name: gbp
        sql: ${TABLE}.revenue ;;
      }

      dimension: revenue2 {
        description: "Revenue of order"
        type: number
        value_format_name: gbp
        sql: ${TABLE}.revenue2 ;;
      }

      measure: AOV {
        description: "Average Order value"
        type: number
        value_format_name: gbp
        sql: SUM(${TABLE}.NetSaleValue)/(count(distinct(${TABLE}.OrderID))) ;;
      }

      # measure: NetSalePrice {
      #   description: "Total value of order"
      #   type: sum
      #   value_format_name: gbp
      #   sql: ${TABLE}.NetSalePrice ;;
      #   drill_fields: [transactiondateTEST_date]
      # }

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

      measure: marginFunding_perc {
        description: "margin percentage per order"
        type: number
        value_format_name: percent_2
        sql: sum(${TABLE}.MarginIncFunding)/SUM(${TABLE}.NetSaleValue) ;;
      }

      measure: marginfunding_by_order {
        description: "Margin by order"
        type: number
        value_format_name: decimal_2
        sql: sum(${TABLE}.MarginIncFunding)/(count(distinct(${TABLE}.OrderID))) ;;
      }

      measure: web_based_orders {
        description: "web based orders"
        type: count_distinct
        sql: ${TABLE}.OrderID ;;
        filters: [App_web: "Web Trolley" ]
      }

      measure: Total_MarginIncFunding {
        description: "sum of Margin"
        type: sum
        value_format_name: decimal_2
        sql: ${TABLE}.MarginIncFunding ;;
      }

      measure: Total_marginExclFunding {
        description: "sum of Margin"
        type: sum
        value_format_name: decimal_2
        sql: ${TABLE}.marginExclFunding ;;
      }

      # filter: current_date_range {
      # type: date
      # view_label: "_PoP"
      # label: "1. Current Date Range"
      # description: "Select the current date range you are interested in. Make sure any other filter on Event Date covers this period, or is removed."
      # sql: ${TABLE}.transactiondate IS NOT NULL ;;
      # }

  dimension: transaction_date_filter {
    type: date
    datatype: date
    sql:

    {% if base.select_date_reference._parameter_value == "Placed" %} DATE(${TABLE}.Placed) {% else %} DATE(${TABLE}.transaction) {% endif %}

                ;;
  }

  dimension: event_raw {
    type: date_raw
    sql: ${TABLE}.transaction_raw ;;
    hidden: yes
  }



}















view: total_sessions {

  derived_table: {
    sql: with sub1 as (SELECT distinct
    'App Trolley' as app_web_sessions,
    PARSE_DATE('%Y%m%d', event_date) as date,
    traffic_source.medium as Medium,
    COUNT(DISTINCT CASE
    WHEN event_name = 'session_start' THEN CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))
    END) AS sessions
    FROM `toolstation-data-storage.analytics_265133009.events_*`
    WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() - 500
    and PARSE_DATE('%Y%m%d', event_date) >= current_date () - 500
    and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start session_date_filter %}) and FORMAT_DATE('%Y%m%d', {% date_end session_date_filter %})
    AND {% condition session_date_filter %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
    GROUP BY 1,2,3

    UNION ALL

    SELECT distinct
    'Web Trolley' as app_web_sessions,
    PARSE_DATE('%Y%m%d', date) as date,
    trafficSource.medium as Medium,
    SUM(totals.visits) as sessions
    FROM `toolstation-data-storage.4783980.ga_sessions_*`
    WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500
    and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start session_date_filter %}) and FORMAT_DATE('%Y%m%d', {% date_end session_date_filter %})
    AND {% condition session_date_filter %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
    GROUP BY 1,2,3)

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

  dimension: Medium {
    description: "Medium sessions"
    type: string
    sql: ${TABLE}.Medium ;;
  }


  dimension: sessions {
    description: "total sessions"
    type: number
    sql: ${TABLE}.sessions ;;
  }

  filter: session_date_filter {
    hidden: no
    type: date
    datatype: date # Or your datatype. For writing the correct condition on date_column below
  }
}

view: dim_date {

  derived_table: {
    sql: with sub1 as (SELECT distinct
dateKey,
fullDate,
(fullDate - 1) as Yesterday,
dayInYear,
fiscalWeekOfYear,
fiscalMonthOfYear,
fiscalQuarter,
fiscalYear,
fiscalYearMonth,
fiscalYearQuarter,
fiscalYearWeek,
(select distinct fiscalYearWeek from `toolstation-data-storage.ts_finance.dim_date` where fullDate = (current_date()-7)) as LastFiscalWeek
 FROM `toolstation-data-storage.ts_finance.dim_date`),

 year as (

   with sub1 as (
   select distinct fiscalYear from sub1 order by 1 asc)

   select distinct  fiscalYear,
   Lag(fiscalYear) over (order by fiscalYear asc) as PriorfiscalYear
   from sub1
   order by 1 desc
 ),

 fiscalQuarter as (

   with sub1 as (
   select distinct fiscalQuarter from sub1 order by 1 asc)

   select distinct fiscalQuarter,
   Lag(fiscalQuarter) over (order by fiscalQuarter asc) as PriorfiscalQuarter
   from sub1
   order by 1 desc
 ),

  fiscalYearQuarter as (

   with sub1 as (
   select distinct fiscalYearQuarter from sub1 order by 1 asc)

   select distinct fiscalYearQuarter,
   Lag(fiscalYearQuarter) over (order by fiscalYearQuarter asc) as PriorfiscalYearQuarter
   from sub1
   order by 1 desc
 ),

   fiscalYearMonth as (

   with sub1 as (
   select distinct fiscalYearMonth from sub1 order by 1 asc)

   select distinct fiscalYearMonth,
   Lag(fiscalYearMonth) over (order by fiscalYearMonth asc) as PriorfiscalYearMonth
   from sub1
   order by 1 desc
 ),

    fiscalYearWeek as (

   with sub1 as (
   select distinct fiscalYearWeek from sub1 order by 1 asc)

   select distinct fiscalYearWeek,
   Lag(fiscalYearWeek) over (order by fiscalYearWeek asc) as PriorfiscalYearWeek
   from sub1
   order by 1 desc
 )

 select distinct sub1.*, year.PriorfiscalYear as PriorfiscalYear,
fiscalYearQuarter.PriorfiscalYearQuarter as PriorfiscalQuarter,
fiscalYearMonth.PriorfiscalYearMonth as PriorfiscalYearMonth,
fiscalYearWeek.PriorfiscalYearWeek as PriorfiscalYearWeek
 from sub1
 left outer join year on sub1.fiscalYear = year.fiscalYear
 left outer join fiscalYearQuarter on sub1.fiscalYearQuarter = fiscalYearQuarter.fiscalYearQuarter
 left outer join fiscalYearMonth on sub1.fiscalYearMonth = fiscalYearMonth.fiscalYearMonth
  left outer join fiscalYearWeek on sub1.fiscalYearWeek = fiscalYearWeek.fiscalYearWeek
  Where sub1.fullDate = date(current_date());;
  }

  dimension: dateKey {
    description: "Primary key for date"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.datekey ;;
  }

  dimension_group: Current_Date {
    description: "fullDate"
    type: time
    view_label: "Current_Date"
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

  dimension_group: Yesterday {
    description: "Yesterday_Date"
    type: time
    view_label: "Yesterday"
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
    sql: ${TABLE}.Yesterday ;;
    convert_tz: no
  }

  dimension: dayInYear {
    description: "dayInYear"
    type: number
    sql: ${TABLE}.dayInYear ;;
  }

  dimension: fiscalWeekOfYear {
    description: "fiscalWeekOfYear"
    type: number
    sql: ${TABLE}.fiscalWeekOfYear ;;
  }

  dimension: fiscalMonthOfYear {
    description: "fiscalMonthOfYear"
    type: number
    sql: ${TABLE}.fiscalMonthOfYear ;;
  }

  dimension: fiscalQuarter {
    description: "fiscalQuarter"
    type: number
    sql: ${TABLE}.fiscalQuarter ;;
  }

  dimension: fiscalYear {
    description: "fiscalYear"
    type: number
    sql: ${TABLE}.fiscalYear ;;
  }

  dimension: fiscalYearMonth {
    description: "fiscalYearMonth"
    type: string
    sql: ${TABLE}.fiscalYearMonth ;;
  }

  dimension: fiscalYearQuarter {
    description: "fiscalYearQuarter"
    type: string
    sql: ${TABLE}.fiscalYearQuarter;;
  }

  dimension: fiscalYearWeek {
    description: "fiscalYearWeek"
    type: string
    sql: ${TABLE}.fiscalYearWeek ;;
  }

  dimension: LastFiscalWeek {
    description: "LastFiscalWeek"
    type: string
    sql: ${TABLE}.LastFiscalWeek ;;
  }

  dimension: PriorfiscalYear {
    description: "PriorfiscalYear"
    type: number
    sql: ${TABLE}.PriorfiscalYear ;;
  }

  dimension: PriorfiscalQuarter {
    description: "PriorfiscalQuarter"
    type: string
    sql: ${TABLE}.PriorfiscalQuarter ;;
  }

  dimension: PriorfiscalYearMonth {
    description: "PriorfiscalYearMonth"
    type: string
    sql: ${TABLE}.PriorfiscalYearMonth ;;
  }

  dimension: PriorfiscalYearWeek {
    description: "PriorfiscalYearWeek"
    type: string
    sql: ${TABLE}.PriorfiscalYearWeek ;;
  }

}

view: digital_budget {

  derived_table: {
    sql:  SELECT distinct row_number() over () as P_K, rf1.*, db23.Budgeted_Sales as Budget
FROM `toolstation-data-storage.digitalreporting.rf1_digital_budget_2023` as rf1
inner join `toolstation-data-storage.digitalreporting.Digital_Budget_2023` as db23
on rf1.Date = db23.Date
order by 2 asc;;
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

  dimension: Week {
    description: "Week"
    type: number
    sql: ${TABLE}.Week ;;
  }

  dimension: Month {
    description: "Month"
    type: number
    sql: ${TABLE}.Month ;;
  }

  dimension: CLICK_COLLECT_RF1 {
    description: "click collect rf1 for each date"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.CLICK___COLLECT ;;
  }

  dimension: Dropship_RF1 {
    description: "dropship rf1 for each date"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.DROPSHIP ;;
  }

  dimension: WEB_RF1 {
    description: "web rf1 for each date"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.WEB ;;
  }

  dimension: Total_RF1 {
    description: "total rf1 for each date"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Total ;;
  }

  dimension: Budget {
    description: "budget for each date"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Budget ;;
  }

}

view: payment_type {
  derived_table: {
    sql: SELECT distinct row_number () over () as P_K, PaymentType, extract(date from transactionDate) as date, count(distinct ParentOrderUID) over (partition by PaymentType, extract(date from transactionDate)) as Orders, SUM(netSalePrice * quantity) over (partition by PaymentType,extract(date from transactionDate)) as revenueDaily_PaymentType
FROM `toolstation-data-storage.sales.transactions`
order by date desc; ;;
  }

  dimension: P_K {
    description: "Primary key for date"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: PaymentType {
    description: "PaymentType"
    type: string
    sql: ${TABLE}.PaymentType ;;
  }

  dimension_group: Date {
    description: "date"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.Date ;;
  }

  dimension: Orders {
    description: "ParentOrders"
    type: number
    sql: ${TABLE}.Orders ;;
  }

  dimension: revenueDaily_PaymentType {
    description: "revenueDaily_PaymentType"
    type: number
    sql: ${TABLE}.revenueDaily_PaymentType ;;
  }

}

view: Mobile_app {
  derived_table: {
    sql:SELECT distinct
    row_number() over () as P_K,
    date(PARSE_DATE('%Y%m%d', event_date)) as date,
    user_pseudo_id,
    traffic_source.medium as Medium,
    case WHEN event_name = 'session_start' THEN CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))
  END AS session_start,
    IF(event_name IN ('first_visit', 'first_open'), user_pseudo_id, null) AS is_new_user,
    case when event_name IN ('in_app_purchase', 'purchase') then user_pseudo_id else null end AS usersWhoPurchased,
    case when event_name IN ('in_app_purchase', 'purchase') then
    CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING)) else null end AS TotalSessions_Purchases,
    case when event_name = "purchase" AND ecommerce.transaction_ID is not null and ecommerce.transaction_ID != "(not set)" then ecommerce.transaction_ID  end as TransactionIDS,
    case when event_name IN ('in_app_purchase', 'purchase') then (ecommerce.purchase_revenue) end as purchase_revenue,
    case when event_name IN ('in_app_purchase', 'purchase') then (user_ltv.revenue) end as Average_userSpend
    FROM `toolstation-data-storage.analytics_265133009.events_*`
    where _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start date_filter %}) and FORMAT_DATE('%Y%m%d', {% date_end date_filter %})
    AND {% condition date_filter %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
    ORDER BY 2 ASC
          ;;
  }

  dimension: P_K {
    description: "Primary key"
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

  dimension: Medium {
    description: "Medium of session"
    type:  string
    sql: ${TABLE}.Medium ;;
  }

  dimension: User_ID {
    description: "Users"
    type: string
    sql: ${TABLE}.user_pseudo_id;;
  }

  dimension: New_User_ID {
    description: "New is_new_user"
    type: string
    sql: ${TABLE}.is_new_user;;
  }

  dimension: Sessions_start {
    description: "GA session ID where event session_start"
    type: string
    sql: ${TABLE}.session_start;;
  }

  #TotalSessions_Purchases

  dimension: User_ID_Purchasing {
    description: "usersWhoPurchased"
    type: string
    sql: ${TABLE}.usersWhoPurchased;;
  }

  dimension: Sessions_Purchasing {
    description: "TotalSessions_Purchases"
    type: string
    sql: ${TABLE}.TotalSessions_Purchases;;
  }

  dimension: Transaction_IDS {
    description: "TransactionIDS"
    type: string
    sql: ${TABLE}.TransactionIDS;;
  }

  dimension: purchase_revenue {
    description: "purchase_revenue"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.purchase_revenue ;;
  }

  dimension: Average_userSpend {
    description: "Average_userSpend"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Average_userSpend ;;
  }

  filter: date_filter {
    hidden: yes
    type: date
    datatype: date # Or your datatype. For writing the correct condition on date_column below
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
