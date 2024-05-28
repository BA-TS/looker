view: oos_items_l12weeks {
   derived_table: {
     sql: with sub1 as (SELECT distinct date,session_id, screen_name,

CASE when regexp_contains(page_location,".*/p([0-9]*)$") then "product-detail-page"
when regexp_contains(page_location, ".*/p[0-9]*[^0-9a-zA-Z]") then "product-detail-page"
when regexp_contains(page_location,".*/c([0-9]*)$") then "product-listing-page"
when regexp_contains(page_location, ".*/c[0-9]*[^0-9a-zA-Z]") then "product-listing-page"
else screen_name end as screen_Type,
event_name,
case
when event_name = "collection_OOS" and platform = "Web" then "Collection"
when event_name = "dual_OOS" and platform = "Web" then "Dual"
when event_name = "Delivery_OOS" and platform = "Web" then "Delivery"
when event_name = "out_of_stock" and platform = "Web" then null
when event_name in ("MegaMenu") then label_2
when key_1 is null and label_1 is not null then "action"
else key_1 end as key1,
label_1,
aw.item_id
FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` aw
where  _TABLE_Suffix between format_date("%Y%m%d", date_sub(current_date(), interval 12 week)) and format_date("%Y%m%d", current_date()) and event_name in ("collection_OOS", "dual_OOS", "Delivery_OOS", "out_of_stock", "view_item")
group by all),

view_item as (select distinct date, count(distinct session_id) as sessions from sub1 where event_name in ("view_item") and screen_Type in ("product-detail-page") group by 1),

collection_OOS as (select distinct date as collect_date, count(distinct session_id) as COOS_sessions from sub1 where event_name in ("collection_OOS") and screen_Type in ("product-detail-page")
group by 1),

delivery_OOS as (select distinct date as delivery_date, count(distinct session_id) as delOOS_sessions from sub1 where event_name in ("Delivery_OOS") and screen_Type in ("product-detail-page")
group by 1),

dual_OOS as (select distinct date as dual_date, count(distinct session_id) as dual_sessions from sub1 where event_name in ("dual_OOS") and screen_Type in ("product-detail-page") group by 1)

select distinct row_number() over () as P_K, view_item.*, COOS_sessions,  delOOS_sessions, dual_sessions
from view_item
left join collection_OOS on view_item.date = collection_OOS.collect_date
left join delivery_OOS on view_item.date = delivery_OOS.delivery_date
left join dual_OOS on view_item.date = dual_OOS.dual_date
       ;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 8;;
   }

  dimension: PK {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.P_K ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.date ;;
  }

  measure: PDP_items {
    group_label: "Product Unavailability"
    label: "PDP sessions"
    type: sum
    sql: ${TABLE}.sessions ;;
  }

  measure: Collect_OOS_items {
    group_label: "Product Unavailability"
    label: "Collection OOS Sessions"
    type: sum
    sql: ${TABLE}.COOS_sessions ;;
  }

  measure: Delivery_OOS_items {
    group_label: "Product Unavailability"
    label: "Delivery OOS Sessions"
    type: sum
    sql: ${TABLE}.delOOS_sessions ;;
  }

  measure: Dual_OOS_items {
    group_label: "Product Unavailability"
    label: "Dual OOS Sessions"
    type: sum
    sql: ${TABLE}.dual_sessions ;;
  }

  measure: Collect_OOS_rate {
    group_label: "Product Unavailability"
    label: "Collection OOS Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${Collect_OOS_items},${PDP_items}) ;;
}

measure: delivery_OOS_rate {
  group_label: "Product Unavailability"
  label: "Delivery OOS Rate"
  type: number
  value_format_name: percent_2
  sql: safe_divide(${Delivery_OOS_items},${PDP_items}) ;;
}

  measure: dual_OOS_rate {
    group_label: "Product Unavailability"
    label: "Dual OOS Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${Dual_OOS_items},${PDP_items}) ;;
  }

}
