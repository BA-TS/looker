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
"Completed" as status,
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
group by 1,2,3,4,5,6,7,8
union distinct

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
"Completed" as status,
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
group by 1,2,3,4,5,6,7,8
 union distinct
SELECT distinct
customerUID as customerID,
parentOrderUID as OrderID,
productUID,
upper(salesChannel) as salesChannel,
timestamp(transactionDate) as Transaction,
timestamp(PlacedDate) as Placed,
Case
when userUID like 'APP' then 'App'
end as App_Web,
status,
sum(netsalePrice) as NetSalePrice,
sum(quantity) as Quantity,
sum(netSalesValue) as NetSaleValue,
SUM(netSalePrice * quantity) as revenue,
SUM(grossSalesValue) as revenue2,
sum(marginInclFunding) as MarginIncFunding,
sum(marginExclFunding) as marginExclFunding
from `toolstation-data-storage.sales.transactions_incomplete`
where
transactionLineType = "Sale" and
productCode not in ('85699','00053') and
(userUID  = 'APP')
group by 1,2,3,4,5,6,7,8
union distinct
SELECT distinct
customerUID as customerID,
parentOrderUID as OrderID,
productUID,
upper(salesChannel) as salesChannel,
timestamp(transactionDate) as Transaction,
timestamp(PlacedDate) as Placed,
Case
when userUID like 'WWW' then 'Web'
end as App_Web,
status,
sum(netsalePrice) as NetSalePrice,
sum(quantity) as Quantity,
sum(netSalesValue) as NetSaleValue,
SUM(netSalePrice * quantity) as revenue,
SUM(grossSalesValue) as revenue2,
sum(marginInclFunding) as MarginIncFunding,
sum(marginExclFunding) as marginExclFunding
from `toolstation-data-storage.sales.transactions_incomplete`
where
transactionLineType = "Sale" and
productCode not in ('85699','00053') and
(userUID  = 'WWW')
group by 1,2,3,4,5,6,7,8
) )
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
    description: "sales Channel used to fulfil order"
    type:string
    sql: ${TABLE}.salesChannel;;
  }

  dimension: status {
    label: "Status"
    description: "status of order"
    type:string
    sql: ${TABLE}.status;;
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


      dimension: App_web {
        label: "App/Web"
        description: "If user used App or Web"
        type:  string
        sql:  ${TABLE}.App_web ;;
      }

      measure: Totalrevenue {
        view_label: "
      {% if _explore._name == 'GA4' %}
      Digital Transactions
      {% else %}
      Measures
      {% endif %}"
        group_label: "Measures"
        label: "Net Sale Revenue"
        description: "Net Revenue of order"
        type: number
        value_format_name: gbp
        sql: sum(${TABLE}.revenue) * 0.9973 ;;
      }

      measure: revenue2 {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Gross Revenue"
        description: "Gross Revenue of order"
        type: number
        value_format_name: gbp
        sql: sum(${TABLE}.revenue2) * 0.9973 ;;
      }

      measure: AOV {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "AOV"
        description: "Average Order value"
        type: number
        value_format_name: gbp
        sql: (SUM(${TABLE}.NetSaleValue) * 0.9973)/((count(distinct(${TABLE}.OrderID))) * 0.9973) ;;
      }

      # measure: NetSalePrice {
      #   description: "Total value of order"
      #   type: sum
      #   value_format_name: gbp
      #   sql: ${TABLE}.NetSalePrice ;;
      #   drill_fields: [transactiondateTEST_date]
      # }

      measure: Quantity {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Product Quantity"
        description: "Total products in order"
        type: number
        value_format_name: decimal_0
        sql:  sum(${TABLE}.Quantity) * 0.9973 ;;
      }

      measure: NetSaleValue {
        hidden: yes
        description: "Total value of order"
        type: number
        value_format_name: gbp
        sql: sum(${TABLE}.NetSaleValue) * 0.9973 ;;
      }

      measure: Total_orders {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Total Orders"
        description: "total orders"
        type: number
        value_format_name: decimal_0
        sql: count(distinct ${TABLE}.OrderID) * 0.9973;;
      }

      measure: marginFunding_perc {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Margin Rate (inc funding)"
        description: "margin percentage per order"
        type: number
        value_format_name: percent_2
        sql: (sum(${TABLE}.MarginIncFunding) * 0.9973)/(SUM(${TABLE}.NetSaleValue) * 0.9973);;
      }

      measure: marginfunding_by_order {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Margin per order (inc funding)"
        description: "Margin inc funding by order"
        type: number
        value_format_name: gbp
        sql: (sum(${TABLE}.MarginIncFunding) * 0.9973)/((count(distinct(${TABLE}.OrderID))) * 0.9973);;
      }

      measure: web_based_orders {
        hidden: yes
        description: "web based orders"
        type: count_distinct
        sql: ${TABLE}.OrderID ;;
        filters: [App_web: "Web" ]
      }

      measure: total_customers {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Total Customers"
        description: "Total Customers who made Order"
        type: count_distinct
        value_format_name: decimal_0
        sql: ${CustomerID} ;;
        }

      measure: Total_MarginIncFunding {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Total Margin (inc funding)"
        description: "sum of Margin inc funding"
        type: number
        value_format_name: gbp
        sql: sum(${TABLE}.MarginIncFunding) * 0.9973 ;;
      }

      measure: Total_marginExclFunding {
        view_label: "
        {% if _explore._name == 'GA4' %}
        Digital Transactions
        {% else %}
        Measures
        {% endif %}"
        group_label: "Measures"
        label: "Total Margin (excl funding)"
        description: "sum of Margin excluding funding"
        type: number
        value_format_name: gbp
        sql: sum(${TABLE}.marginExclFunding) * 0.9973;;
      }


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
