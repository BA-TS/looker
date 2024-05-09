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

view_item as (select distinct date, item_id from sub1 where event_name in ("view_item") and screen_Type in ("product-detail-page")),

collection_OOS as (select distinct date as collect_date, item_id as COOS_itemID from sub1 where event_name in ("collection_OOS") and screen_Type in ("product-detail-page")),

delivery_OOS as (select distinct date as delivery_date, item_id as deliveryOOS_itemID from sub1 where event_name in ("Delivery_OOS") and screen_Type in ("product-detail-page")),

dual_OOS as (select distinct date as dual_date, item_id as dualOOS_itemID from sub1 where event_name in ("dual_OOS") and screen_Type in ("product-detail-page"))

select distinct row_number() over () as P_K, view_item.*, COOS_itemID, delivery_OOS.deliveryOOS_itemID, dual_OOS.dualOOS_itemID  from view_item
left join collection_OOS on view_item.date = collection_OOS.collect_date and view_item.item_id = collection_OOS.COOS_itemID
left join delivery_OOS on view_item.date = delivery_OOS.delivery_date and view_item.item_id = delivery_OOS.deliveryOOS_itemID
left join dual_OOS on view_item.date = dual_OOS.dual_date and view_item.item_id = dual_OOS.dualOOS_itemID
       ;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 7;;
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

  dimension: PDPitem_id {
    hidden: yes
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: Collection_OOS_itemID {
    hidden: yes
    type: string
    sql: ${TABLE}.COOS_itemID ;;
  }

  dimension: delivery_OOS_itemID {
    hidden: yes
    type: string
    sql: ${TABLE}.deliveryOOS_itemID ;;
  }

  dimension: dualOOS_itemID {
    hidden: yes
    type: string
    sql: ${TABLE}.dualOOS_itemID ;;
  }

  measure: PDP_items {
    group_label: "Product Unavailability"
    label: "PDP Product Code"
    type: count_distinct
    sql: ${PDPitem_id} ;;
  }

  measure: Collect_OOS_items {
    group_label: "Product Unavailability"
    label: "Collection OOS"
    type: count_distinct
    sql: ${Collection_OOS_itemID} ;;
  }

  measure: Delivery_OOS_items {
    group_label: "Product Unavailability"
    label: "Delivery OOS"
    type: count_distinct
    sql: ${delivery_OOS_itemID} ;;
  }

  measure: Dual_OOS_items {
    group_label: "Product Unavailability"
    label: "Dual OOS"
    type: count_distinct
    sql: ${dualOOS_itemID} ;;
  }
}
