view: order_shippingmethod_l12weeks {
   derived_table: {
     sql: with sub1 as (SELECT distinct date, Platform, transactions.OrderID, transactions.productCode
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw left join unnest(transactions) as transactions
where ((aw.item_id = transactions.productCode) or (aw.item_id is not null and transactions.productCode is null) or (aw.item_id is null and transactions.productCode is null))

and _TABLE_Suffix between format_date("%Y%m%d", date_sub(current_date(), interval 12 week)) and format_date("%Y%m%d", current_date())
group by all),

delivery as (select distinct OrderID as delivered, productCode as deliveredCode from sub1 where productCode in ('00050', '00051', '00040', '00041', '00003', '00002', '00014', '00015', '00007', '00008', '00004', '00009', '00005', '00033', '00010', '00052', '00042', '00016', '00013', '00035')),

collection as (select distinct OrderID as collected, productCode as collectedCode from sub1 where productCode in ('00037', '00006'))

select distinct row_number() over () as PK, date, Platform, sub1.OrderID, deliveredCode, collectedCode
from sub1
left join delivery on sub1.ORderID = delivery.delivered
left join collection on sub1.ORderID = collection.collected
       ;;

  sql_trigger_value: SELECT EXTRACT(dayofweek FROM CURRENT_DATEtime()) between 2 and 6 and extract(hour from current_datetime()) = 13
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 7 and extract(hour from current_datetime()) = 16
or EXTRACT(dayofweek FROM CURRENT_DATEtime()) = 1 and extract(hour from current_datetime()) = 16;;
}

dimension: PK {
  primary_key: yes
  hidden: yes
  type: number
  sql: ${TABLE}.PK ;;
}

dimension_group: date {
  hidden: yes
  type: time
  timeframes: [raw,date]
  sql: ${TABLE}.date ;;
}

dimension: Platform {
  hidden: yes
  type: string
  sql: ${TABLE}.Platform ;;
}

  dimension: OrderID{
    hidden: yes
    type: string
    sql: ${TABLE}.OrderID ;;
  }

  dimension: deliveredCode{
    hidden: yes
    type: string
    sql: ${TABLE}.deliveredCode ;;
  }

  dimension: collectedCode{
    hidden: yes
    type: string
    sql: ${TABLE}.collectedCode ;;
  }

  measure: all_orders {
    hidden: yes
    type: count_distinct
    sql: ${OrderID} ;;
  }

  measure: delivered_orders {
    group_label: "Orders by Shipping Method"
    label: "Delivered Orders"
    type: count_distinct
    sql: ${OrderID} ;;
    filters: [deliveredCode: "-NULL"]
  }
  measure: collected_orders {
    group_label: "Orders by Shipping Method"
    label: "Collected Orders"
    type: count_distinct
    sql: ${OrderID} ;;
    filters: [collectedCode: "-NULL"]
  }

  measure: delivered_perc {
    group_label: "Orders by Shipping Method"
    label: "Delivered Orders %"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${delivered_orders},${all_orders}) ;;
  }

  measure: collected_perc {
    group_label: "Orders by Shipping Method"
    label: "Collected Orders %"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${collected_orders},${all_orders}) ;;
  }


}
