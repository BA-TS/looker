#include: "/views/prod/date/base_date_noCatalogue.view.lkml"
#include: "/views/prod/date/PoP.view.lkml"
include: "/views/**/*base*.view"

view: app_web_data {
  derived_table: {
    sql: with sub1 as ((SELECT distinct
        customerUID as customerID,
        parentOrderUID as OrderID,
        case when productUID is null then "NONE" else productUID end as productUID,
        upper(salesChannel) as salesChannel,
        timestamp(transactionDate) as Transaction,
        timestamp(PlacedDate) as Placed,
        Case
        when userUID like 'APP' then 'App'
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
        case when productUID is null then "NONE" else productUID end as productUID,
        upper(salesChannel) as salesChannel,
        timestamp(transactionDate) as Transaction,
        timestamp(PlacedDate) as Placed,
        Case
        when userUID like 'WWW' then 'Web'
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
                union distinct
        SELECT
        "NONE","NONE","NONE", null, null, null, null, null, null, null, null, null, null, null )
        select distinct row_number() over (order by (Transaction)) as P_K, * from sub1;;

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
        hidden: yes
        type: string
        sql:  ${TABLE}.customerID ;;
      }

      dimension: OrderID {
        hidden: yes
        description: "transaction ID"
        type:string
        sql: ${TABLE}.OrderID ;;
      }

  dimension: ProductUID {
    description: "ProductUID"
    hidden: yes
    type:string
    sql: ${TABLE}.ProductUID ;;
  }

  dimension: salesChannel {
    label: "Sales Channel"
    description: "salesChannel"
    type:string
    sql: ${TABLE}.salesChannel;;
  }

      dimension_group: transaction  {
        description: "transactiondate"
        type: time
        hidden: yes
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
    hidden: yes
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
        label: "App/Web"
        description: "If user used App or Web"
        type:  string
        sql:  ${TABLE}.App_web ;;
      }

      measure: Totalrevenue {
        view_label: "
      {% if _explore._name == 'GA4' %}
      Transaction Data
      {% else %}
      Measures
      {% endif %}"
        label: "Net Sale Revenue"
        description: "Revenue of order"
        type: sum
        value_format_name: gbp
        sql: ${TABLE}.revenue ;;
      }

      measure: revenue2 {
        view_label: "Measures"
        label: "Gross Revenue"
        description: "Revenue of order"
        type: sum
        value_format_name: gbp
        sql: ${TABLE}.revenue2 ;;
      }

      measure: AOV {
        view_label: "Measures"
        label: "AOV"
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
        view_label: "Measures"
        label: "Product Quantity"
        description: "Total products in order"
        type: sum
        sql:  ${TABLE}.Quantity ;;
      }

      measure: NetSaleValue {
        hidden: yes
        description: "Total value of order"
        type: sum
        value_format_name: gbp
        sql: ${TABLE}.NetSaleValue ;;
      }

      measure: Total_orders {
        view_label: "Measures"
        label: "Total Orders"
        description: "total orders"
        type: count_distinct
        sql: ${TABLE}.OrderID;;
      }

      measure: marginFunding_perc {
        view_label: "Measures"
        label: "Margin Rate (inc funding)"
        description: "margin percentage per order"
        type: number
        value_format_name: percent_2
        sql: sum(${TABLE}.MarginIncFunding)/SUM(${TABLE}.NetSaleValue) ;;
      }

      measure: marginfunding_by_order {
        view_label: "Measures"
        label: "Margin per order (inc funding)"
        description: "Margin by order"
        type: number
        value_format_name: gbp
        sql: sum(${TABLE}.MarginIncFunding)/(count(distinct(${TABLE}.OrderID))) ;;
      }

      measure: web_based_orders {
        hidden: yes
        description: "web based orders"
        type: count_distinct
        sql: ${TABLE}.OrderID ;;
        filters: [App_web: "Web" ]
      }

      measure: total_customers {
        view_label: "Measures"
        label: "Total Customers"
        type: count_distinct
        sql: ${CustomerID} ;;
        }

      measure: Total_MarginIncFunding {
        view_label: "Measures"
        label: "Total Margin (inc funding)"
        description: "sum of Margin"
        type: sum
        value_format_name: gbp
        sql: ${TABLE}.MarginIncFunding ;;
      }

      measure: Total_marginExclFunding {
        view_label: "Measures"
        label: "Total Margin (exc funding)"
        description: "sum of Margin"
        type: sum
        value_format_name: gbp
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
    hidden: yes
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
'Web' as app_web_sessions,
timestamp(PARSE_DATE('%Y%m%d', date)) as date,
device.deviceCategory,
trafficSource.medium as Medium,
channelGrouping,
count(distinct case when hits.eventInfo.eventCategory = "Web Vitals" then concat(fullVisitorID,visitStartTime) end)  as sessions,
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits
 WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
 group by 2,3,4,5


union distinct
SELECT distinct
    'App' as app_web_sessions,
    timestamp(PARSE_DATE('%Y%m%d', event_date)) as date,
    device.category,
    traffic_source.medium as Medium,
    `toolstation-data-storage.analytics_265133009.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
    COUNT(DISTINCT CASE
    WHEN event_name = 'session_start' THEN CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))
    END) AS sessions
    FROM `toolstation-data-storage.analytics_265133009.events_*`
     WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
    GROUP BY 2,3,4,5)
    Select distinct row_number() over () as P_K, sub1.* from sub1 ;;
    datagroup_trigger: ts_googleanalytics_datagroup
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
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: Medium {
    description: "Medium sessions"
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: deviceCategory {
    description: "deviceCategory"
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: channel_grouping {
    description: "channel_grouping sessions"
    type: string
    sql: ${TABLE}.channelGrouping ;;
  }


  dimension: sessions {
    description: "sessions"
    type: number
    sql: ${TABLE}.sessions ;;
  }


  measure: Sum_ofSessions {
    description: "Sum of sessions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.sessions ;;
  }


  #filter: session_date_filter {
    #hidden: no
    #type: date
    #datatype: date # Or your datatype. For writing the correct condition on date_column below
  #}

  filter: select_date_range {
    label: "Total Session Date Range"
    group_label: "Date Filter"
    view_label: "Date"
    type: date
    datatype: date
    convert_tz: yes
  }

}


view: EcommerceEvents {

  derived_table: {
    sql: with sub0 as (SELECT distinct
'Web' as app_web_sessions,
PARSE_DATE('%Y%m%d', date) as date,
device.deviceCategory,
channelGrouping,
trafficSource.medium as Medium,
case when regexp_contains(page.pagePath, ".*/p[0-9]*$") then "Product Detail Page" else "Other Page" end as Screen,
product.productSKU as item_id,
case when regexp_contains(hits.eventInfo.EventCategory, ".*OOS$") then hits.eventInfo.EventCategory
when (hits.eventInfo.EventAction in ("Purchase", "Add to Cart")) then hits.eventInfo.EventAction
else "Other Events" end as event_name,
count(distinct CASE when hits.eCommerceAction.action_type = "2" then (CONCAT(fullvisitorID, cast(visitId as STRING), date, hits.hitNumber)) end) as PDP_screenViews,
count(distinct(CONCAT(fullvisitorID, cast(visitId as STRING), date, hits.hitNumber))) as events,
sum(safe_divide(product.productRevenue,1000000)) as item_revenue,
sum(product.productQuantity) as ItemQ,
safe_divide(Product.ProductPrice,1000000) as Item_price
FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits left join unnest(product) as product
WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start session_date_filter %}) and FORMAT_DATE('%Y%m%d', {% date_end session_date_filter %})
AND {% condition session_date_filter %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
--and (hits.eventInfo.EventAction in ("Purchase", "Add to Cart") or regexp_contains(hits.eventInfo.EventCategory, ".*OOS$"))
group by 2,3,4,5,6,7,8,13
union distinct
SELECT distinct
    'App' as app_web_sessions,
    PARSE_DATE('%Y%m%d', event_date) as date,
    device.category,
    `toolstation-data-storage.analytics_265133009.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
    traffic_source.medium as Medium,
    case when (SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') = "product-detail-page" then "Product Detail Page" else "Other Page" end as screen,
    items.item_id as item_id,
    case when event_name in ('purchase', 'add_to_cart', 'out_of_stock') then event_name else "Other Event" end as event_name,
    count(distinct case when (SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'firebase_screen') = "product-detail-page" then CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING)) end) as PDP_screen_views,
    COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))) AS events,
    round(sum(items.item_revenue),2) as item_revenue,
    sum(items.quantity) as itemQ,
    items.price as Item_Price
    FROM `toolstation-data-storage.analytics_265133009.events_*` left join unnest(items) as items
     WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start session_date_filter %}) and FORMAT_DATE('%Y%m%d', {% date_end session_date_filter %})
AND {% condition session_date_filter %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
    --and event_name in ('purchase', 'add_to_cart', 'out_of_stock')
    GROUP BY 2,3,4,5,6,7,8,13)
select distinct row_number() over () as P_K, * from sub0;;
    datagroup_trigger: ts_googleanalytics_datagroup
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
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: Medium {
    description: "Medium"
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: channelGrouping {
    description: "channelGrouping"
    type: string
    sql: ${TABLE}.channelGrouping ;;
  }

  dimension: deviceCategory {
    description: "deviceCategory"
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }


  dimension: event_name {
    description: "event_name"
    type: string
    sql: ${TABLE}.event_name;;
  }

  dimension: screen {
    description: "screen"
    type: string
    sql: ${TABLE}.screen;;
  }

  dimension: product_code{
    description: "product code"
    type: string
    sql: ${TABLE}.item_id;;
  }

  dimension: Events {
    description: "number of sessions with event"
    type: number
    sql: ${TABLE}.events;;
  }

  dimension: PDP_screenViews {
    description: "number of sessions with event"
    type: number
    sql: ${TABLE}.PDP_screenViews;;
  }

  dimension: item_revenue {
    description: "item_revenue"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.item_revenue ;;
  }

  dimension: Item_price {
    description: "Item_price"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Item_price ;;
  }

  dimension: Item_Quantity {
    description: "Item_Quantity"
    type: number
    sql: ${TABLE}.ItemQ ;;
  }

  measure: sumEvents {
    type: sum
    sql: ${TABLE}.events;;
  }

  # dimension: ProductUID {
  #   description: "ProductUID"
  #   type: string
  #   sql: ${TABLE}.ProductUID;;
  # }

  # dimension: productName {
  #   description: "productName"
  #   type: string
  #   sql: ${TABLE}.productName;;
  # }

  # dimension: productDepartment {
  #   description: "productDepartment"
  #   type: string
  #   sql: ${TABLE}.productDepartment;;
  # }

  # dimension: productSubdepartment {
  #   description: "productSubdepartment"
  #   type: string
  #   sql: ${TABLE}.productSubdepartment;;
  # }

  filter: session_date_filter {
    hidden: no
    type: date
    datatype: date # Or your datatype. For writing the correct condition on date_column below
  }
}

# view: dim_date {

#   derived_table: {
#     sql: with sub1 as (SELECT distinct
# dateKey,
# fullDate,
# (fullDate - 1) as Yesterday,
# dayInYear,
# fiscalWeekOfYear,
# fiscalMonthOfYear,
# fiscalQuarter,
# fiscalYear,
# fiscalYearMonth,
# fiscalYearQuarter,
# fiscalYearWeek,
# (select distinct fiscalYearWeek from `toolstation-data-storage.ts_finance.dim_date` where fullDate = (current_date()-7)) as LastFiscalWeek
# FROM `toolstation-data-storage.ts_finance.dim_date`),

# year as (

#   with sub1 as (
#   select distinct fiscalYear from sub1 order by 1 asc)

#   select distinct  fiscalYear,
#   Lag(fiscalYear) over (order by fiscalYear asc) as PriorfiscalYear
#   from sub1
#   order by 1 desc
# ),

# fiscalQuarter as (

#   with sub1 as (
#   select distinct fiscalQuarter from sub1 order by 1 asc)

#   select distinct fiscalQuarter,
#   Lag(fiscalQuarter) over (order by fiscalQuarter asc) as PriorfiscalQuarter
#   from sub1
#   order by 1 desc
# ),

#   fiscalYearQuarter as (

#   with sub1 as (
#   select distinct fiscalYearQuarter from sub1 order by 1 asc)

#   select distinct fiscalYearQuarter,
#   Lag(fiscalYearQuarter) over (order by fiscalYearQuarter asc) as PriorfiscalYearQuarter
#   from sub1
#   order by 1 desc
# ),

#   fiscalYearMonth as (

#   with sub1 as (
#   select distinct fiscalYearMonth from sub1 order by 1 asc)

#   select distinct fiscalYearMonth,
#   Lag(fiscalYearMonth) over (order by fiscalYearMonth asc) as PriorfiscalYearMonth
#   from sub1
#   order by 1 desc
# ),

#     fiscalYearWeek as (

#   with sub1 as (
#   select distinct fiscalYearWeek from sub1 order by 1 asc)

#   select distinct fiscalYearWeek,
#   Lag(fiscalYearWeek) over (order by fiscalYearWeek asc) as PriorfiscalYearWeek
#   from sub1
#   order by 1 desc
# )

# select distinct sub1.*, year.PriorfiscalYear as PriorfiscalYear,
# fiscalYearQuarter.PriorfiscalYearQuarter as PriorfiscalQuarter,
# fiscalYearMonth.PriorfiscalYearMonth as PriorfiscalYearMonth,
# fiscalYearWeek.PriorfiscalYearWeek as PriorfiscalYearWeek
# from sub1
# left outer join year on sub1.fiscalYear = year.fiscalYear
# left outer join fiscalYearQuarter on sub1.fiscalYearQuarter = fiscalYearQuarter.fiscalYearQuarter
# left outer join fiscalYearMonth on sub1.fiscalYearMonth = fiscalYearMonth.fiscalYearMonth
#   left outer join fiscalYearWeek on sub1.fiscalYearWeek = fiscalYearWeek.fiscalYearWeek
#   Where sub1.fullDate = date(current_date());;
#   }

#   dimension: dateKey {
#     description: "Primary key for date"
#     type: number
#     primary_key: yes
#     hidden: yes
#     sql: ${TABLE}.datekey ;;
#   }

#   dimension_group: Current_Date {
#     description: "fullDate"
#     type: time
#     view_label: "Current_Date"
#     timeframes: [
#       raw,
#       date,
#       day_of_week,
#       day_of_week_index,
#       day_of_month,
#       day_of_year,
#       week,
#       week_of_year,
#       month,
#       month_name,
#       month_num,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.fullDate ;;
#     convert_tz: no
#   }

#   dimension_group: Yesterday {
#     description: "Yesterday_Date"
#     type: time
#     view_label: "Yesterday"
#     timeframes: [
#       raw,
#       date,
#       day_of_week,
#       day_of_week_index,
#       day_of_month,
#       day_of_year,
#       week,
#       week_of_year,
#       month,
#       month_name,
#       month_num,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.Yesterday ;;
#     convert_tz: no
#   }

#   dimension: dayInYear {
#     description: "dayInYear"
#     type: number
#     sql: ${TABLE}.dayInYear ;;
#   }

#   dimension: fiscalWeekOfYear {
#     description: "fiscalWeekOfYear"
#     type: number
#     sql: ${TABLE}.fiscalWeekOfYear ;;
#   }

#   dimension: fiscalMonthOfYear {
#     description: "fiscalMonthOfYear"
#     type: number
#     sql: ${TABLE}.fiscalMonthOfYear ;;
#   }

#   dimension: fiscalQuarter {
#     description: "fiscalQuarter"
#     type: number
#     sql: ${TABLE}.fiscalQuarter ;;
#   }

#   dimension: fiscalYear {
#     description: "fiscalYear"
#     type: number
#     sql: ${TABLE}.fiscalYear ;;
#   }

#   dimension: fiscalYearMonth {
#     description: "fiscalYearMonth"
#     type: string
#     sql: ${TABLE}.fiscalYearMonth ;;
#   }

#   dimension: fiscalYearQuarter {
#     description: "fiscalYearQuarter"
#     type: string
#     sql: ${TABLE}.fiscalYearQuarter;;
#   }

#   dimension: fiscalYearWeek {
#     description: "fiscalYearWeek"
#     type: string
#     sql: ${TABLE}.fiscalYearWeek ;;
#   }

#   dimension: LastFiscalWeek {
#     description: "LastFiscalWeek"
#     type: string
#     sql: ${TABLE}.LastFiscalWeek ;;
#   }

#   dimension: PriorfiscalYear {
#     description: "PriorfiscalYear"
#     type: number
#     sql: ${TABLE}.PriorfiscalYear ;;
#   }

#   dimension: PriorfiscalQuarter {
#     description: "PriorfiscalQuarter"
#     type: string
#     sql: ${TABLE}.PriorfiscalQuarter ;;
#   }

#   dimension: PriorfiscalYearMonth {
#     description: "PriorfiscalYearMonth"
#     type: string
#     sql: ${TABLE}.PriorfiscalYearMonth ;;
#   }

#   dimension: PriorfiscalYearWeek {
#     description: "PriorfiscalYearWeek"
#     type: string
#     sql: ${TABLE}.PriorfiscalYearWeek ;;
#   }

# }

view: digital_budget {

  derived_table: {
    sql:  SELECT distinct row_number() over () as P_K, timestamp(rf1.Date) as date,
rf1.Week,
rf1.Month,
rf1.CLICK___COLLECT,
rf1.DROPSHIP,
rf1.WEB,
rf1.Total , db23.Budgeted_Sales as Budget
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
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.Date ;;
  }

  dimension: Week {
    description: "Week"
    type: number
    hidden: yes
    sql: ${TABLE}.Week ;;
  }

  dimension: Month {
    description: "Month"
    type: number
    hidden: yes
    sql: ${TABLE}.Month ;;
  }

  dimension: CLICK_COLLECT_RF1 {
    description: "click collect rf1 for each date"
    group_label: "Digital"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.CLICK___COLLECT ;;
  }

  dimension: Dropship_RF1 {
    description: "dropship rf1 for each date"
    group_label: "Digital"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.DROPSHIP ;;
  }

  dimension: WEB_RF1 {
    description: "web rf1 for each date"
    group_label: "Digital"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.WEB ;;
  }

  dimension: Total_RF1 {
    description: "total rf1 for each date"
    group_label: "Digital"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Total ;;
  }

  dimension: Budget {
    description: "budget for each date"
    group_label: "Digital"
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
    hidden: yes
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

  view: currentRetailPrice {
    derived_table: {
      sql:SELECT distinct row_number() over () as P_K,
      * from `toolstation-data-storage.range.currentRetailPrice` ;;
      }

    dimension: P_K {
      description: "Primary key"
      type: number
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.P_K ;;
    }

    dimension: Product_ID {
      description: "productUID"
      type: string
      hidden: yes
      sql: ${TABLE}.productUID;;
    }

    dimension: retailBasePrice {
      description: "Retail Base Price"
      label: "Retail Base Price"
      group_label: "Current Retail Price"
      type: number
      value_format_name: gbp
      sql: ${TABLE}.retailBasePrice ;;
    }

    dimension: baseVAT {
      description: "baseVAT"
      label: "Base VAT"
      group_label: "Current Retail Price"
      type: number
      value_format_name: decimal_1
      sql: ${TABLE}.baseVAT ;;
    }

  }

view: TalkSport_BrandFunnel {
  derived_table: {
    sql:
    SELECT distinct row_number() over () as P_K,* FROM `toolstation-data-storage.digitalreporting.TalkSport_BrandFunnels`;;
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
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.Date ;;
  }

  dimension: Brand_Funnel {
    description: "Brand_Funnel"
    type: string
    sql: ${TABLE}.Brand_Funnel;;
  }

  dimension: Perc {
    description: "Perc"
    type: number
    sql: ${TABLE}.Perc;;
  }

  dimension: CustomerType {
    description: "CustomerType"
    type: string
    sql: ${TABLE}.CustomerType;;
  }
}

view: TalkSport_Customers {
  derived_table: {
    sql:
    SELECT distinct row_number() over () as P_K,* FROM `toolstation-data-storage.digitalreporting.TalkSport_TotalCustomers`;;
  }

  dimension: P_K {
    description: "Primary key"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: Week_Number {
    description: "Week_Number"
    type: string
    sql: ${TABLE}.Week_Number;;
  }

  dimension: DIY_actual_customers {
    description: "DIY__actual_"
    type: number
    sql: ${TABLE}.DIY__actual_;;
  }

  dimension: Trade_actual_customers {
    description: "Trade__actual_"
    type: number
    sql: ${TABLE}.Trade__actual_;;
  }

  dimension: DIY_budget_customers {
    description: "DIY__budget_"
    type: number
    sql: ${TABLE}.DIY__budget_;;
  }

  dimension: Trade_budget_customers {
    description: "Trade__budget_"
    type: number
    sql: ${TABLE}.Trade__budget_;;
  }

}


view: TalkSport_SOV_vs_Cost {
  derived_table: {
    sql:
    SELECT distinct row_number() over () as P_K,* FROM `toolstation-data-storage.digitalreporting.SOV_vs_Costs`;;
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
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.Date ;;
  }

  dimension: competitor {
    description: "competitor"
    type: string
    sql: ${TABLE}.competitor ;;
  }

  dimension: SOV {
    description: "SOV"
    type: number
    sql: ${TABLE}.SOV ;;
  }
}


view: NonEcommerceEvents {

  derived_table: {

    sql: with sub1 as (SELECT distinct
      'Web' as app_web_sessions,
      PARSE_DATE('%Y%m%d', date) as date,
      device.deviceCategory,
      trafficSource.medium as Medium,
      channelGrouping,
      case when hits.eventInfo.EventCategory = "Videoly" then hits.eventInfo.EventAction end as event,
      count(distinct case when hits.eventInfo.EventCategory = "Videoly" and cd.index = 14 then concat(fullVisitorId,cast(cd.value as string)) end) as event_count,
      FROM `toolstation-data-storage.4783980.ga_sessions_*`, unnest (hits) as hits, unnest(hits.customDimensions) as cd
       WHERE PARSE_DATE('%Y%m%d', date)  >= current_date() -500
      and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start event_date_filter %}) and FORMAT_DATE('%Y%m%d', {% date_end event_date_filter %})
      AND {% condition event_date_filter %} date(PARSE_DATE('%Y%m%d', date)) {% endcondition %}
       group by 2,3,4,5, hits.eventInfo.EventCategory, hits.eventInfo.EventAction


      union distinct
      SELECT distinct
      'App' as app_web_sessions,
    PARSE_DATE('%Y%m%d', event_date) as date,
    device.category,
    traffic_source.medium as Medium,
    `toolstation-data-storage.analytics_265133009.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
    case when event_name in ("videoly") and ep.key in ("action") then ep.value.string_value
   when event_name in ("videoly") and ep.key in ("video_percent") then concat(ep.key, "-",cast(ep.value.int_value as string)) end as event_info,
    COUNT(DISTINCT CASE
    WHEN event_name = 'videoly' and ep.key in ("action","video_percent") THEN CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))
    END) AS events
    FROM `toolstation-data-storage.analytics_265133009.events_*`, unnest(event_params) as ep
      WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
      and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start event_date_filter %}) and FORMAT_DATE('%Y%m%d', {% date_end event_date_filter %})
      AND {% condition event_date_filter %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
      GROUP BY 2,3,4,5, event_name, ep.key, ep.value.string_value, ep.value.int_value)
      Select distinct row_number() over () as P_K, sub1.* from sub1 ;;
    #datagroup_trigger: ts_googleanalytics_datagroup
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
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: Medium {
    description: "Medium sessions"
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: deviceCategory {
    description: "deviceCategory"
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: channel_grouping {
    description: "channel_grouping sessions"
    type: string
    sql: ${TABLE}.channelGrouping ;;
  }

  dimension: event {
    description: "non ecommerce event"
    type: string
    sql: ${TABLE}.event ;;
  }


  dimension: event_count {
    description: "event_count"
    type: number
    sql: ${TABLE}.event_count ;;
  }


  filter: event_date_filter {
    hidden: no
    type: date
    datatype: date
  }

}


view: total_sessionsGA4 {

  derived_table: {

    sql: with sub1 as (SELECT distinct
    'Web' as app_web_sessions,
    timestamp(PARSE_DATE('%Y%m%d', event_date)) as date,
    device.category as deviceCategory,
    case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
      case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
    `toolstation-data-storage.analytics_251803804.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
    COUNT(DISTINCT CASE
    WHEN event_name = 'session_start' THEN CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))
    END) AS sessions
    FROM `toolstation-data-storage.analytics_251803804.events_*`
       WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
      and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
      AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
       group by 2,3,4,5,6


      union distinct
      SELECT distinct
      'App' as app_web_sessions,
      timestamp(PARSE_DATE('%Y%m%d', event_date)) as date,
      device.category,
      case when traffic_source.medium is null then "null" else traffic_source.medium end as Medium,
      case when traffic_source.name is null then "null" else traffic_source.name end as Campaign_name,
      `toolstation-data-storage.analytics_265133009.channel_grouping`(traffic_source.source, traffic_source.medium, traffic_source.name) as channel_grouping,
      COUNT(DISTINCT CASE
      WHEN event_name = 'session_start' THEN CONCAT(user_pseudo_id, CAST(event_timestamp AS STRING))
      END) AS sessions
      FROM `toolstation-data-storage.analytics_265133009.events_*`
      WHERE PARSE_DATE('%Y%m%d', event_date)  >= current_date() -500
      and _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', {%date_start select_date_range %}) and FORMAT_DATE('%Y%m%d', {% date_end select_date_range %})
      AND {% condition select_date_range %} date(PARSE_DATE('%Y%m%d', event_date)) {% endcondition %}
      GROUP BY 2,3,4,5,6)
      Select distinct row_number() over () as P_K, sub1.*,
      sum(sessions) over (partition by date) as TotalDailySessions,
      sum(sessions) over (partition by date,app_web_sessions) as DailySessions from sub1 ;;
    datagroup_trigger: ts_googleanalytics_datagroup
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
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  dimension: Medium {
    description: "Medium sessions"
    type: string
    sql: ${TABLE}.Medium ;;
  }

  dimension: Campaign_name {
    description: "Campaign_name"
    type: string
    sql: ${TABLE}.Campaign_name ;;
  }

  dimension: deviceCategory {
    description: "deviceCategory"
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: channel_grouping {
    description: "channel_grouping sessions"
    type: string
    sql: ${TABLE}.channel_grouping ;;
  }


  dimension: sessions {
    description: "sessions"
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: TotalDailySessions {
    description: "TotalDailySessions"
    type: number
    sql: ${TABLE}.TotalDailySessions ;;
  }

  dimension: DailySessions {
    description: "DailySessions"
    type: number
    sql: ${TABLE}.DailySessions ;;
  }

  measure: Sum_ofSessions {
    description: "Sum of sessions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.sessions ;;
  }

  filter: select_date_range {
    label: "Total SessionGA4 Date Range"
    group_label: "Date Filter"
    view_label: "Date"
    type: date
    datatype: date
    convert_tz: yes
  }

}
