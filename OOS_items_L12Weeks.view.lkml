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
where  _TABLE_Suffix between format_date("%Y%m%d", date_sub(current_date(), interval 2 week)) and format_date("%Y%m%d", date_sub(current_date(), interval 1 day)) and event_name in ("collection_OOS", "dual_OOS", "Delivery_OOS", "out_of_stock", "view_item")
group by all),

view_item as (select distinct date, item_id from sub1 where event_name in ("view_item") and screen_Type in ("product-detail-page")),

collection_OOS as (select distinct date as collect_date, item_id as COOS_itemID from sub1 where event_name in ("collection_OOS") and screen_Type in ("product-detail-page"))

select distinct view_item.*, COOS_itemID from view_item left join collection_OOS on view_item.date = collection_OOS.collect_date and view_item.item_id = collection_OOS.COOS_itemID
       ;;
   }
}
