view: suggested_byprovider_purchase {
  derived_table: {
    sql:
        with sub1 as (SELECT distinct
event_name,
concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS session_id,
min(event_timestamp) as event_timestamp,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key = 'page_location') as page,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key in ('provider', 'rec_provider')) as Provider,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key in ('location', 'rec_location')) as Location,
(SELECT distinct (value.string_value) FROM UNNEST(event_params) WHERE key in ('show_add_to_trolley', 'add_to_cart_click')) as show_click_ATC,
(SELECT distinct coalesce(value.string_value, cast(value.int_value as string)) FROM UNNEST(event_params) WHERE key = 'sku') as sku,
(SELECT distinct cast(value.string_value as string) FROM UNNEST(event_params) WHERE key = 'monetate_name') as monetate_name,
items.item_id,
items.quantity,
items.item_revenue,
ecommerce.transaction_id
FROM `toolstation-data-storage.analytics_251803804.events_*` left join unnest(items) as items
where
_table_suffix between format_date("%Y%m%d", date_trunc(date_sub(current_date(), interval 3 week),week(sunday))) and format_date("%Y%m%d", date_sub(current_date(), INTERVAL 1 day)) and
event_name in ("suggested_item_view", "suggested_item_click", "add_to_cart", "purchase", "monetate_experiment_decision") and concat(user_pseudo_id,(SELECT distinct cast(value.int_value as string) FROM UNNEST(event_params) WHERE key = 'ga_session_id')) is not null
group by all),

monetate_event as (select distinct session_id, min(event_timestamp) as event_timestamo from sub1 where REGEXP_CONTAINS(monetate_name, "\\[PROD\\][\t\n\f\r ]{1}\\[RECS\\][\t\n\f\r ]{1}\\[GOOGLE\\/BR\\/MONETATE\\].*") group by all),


suggest_view as (SELECT distinct
session_id,
min(event_timestamp) as event_timestamp,
page,
Provider,
Location,
show_click_ATC as show_ATC,
FROM sub1
where event_name in ("suggested_item_view")
group by all),

suggest_click as (SELECT distinct
session_id,
event_timestamp,
page,
Provider,
Location,
show_click_ATC as click_ATC,
sku,
#ep.key, min(ep.value.string_value) as value
FROM sub1
where event_name in ("suggested_item_click")
group by all),

ATC as (SELECT distinct
session_id,
event_timestamp,
page,
item_id,
quantity
FROM sub1
where event_name in ("add_to_cart")
group by all),

purchase as (SELECT distinct
session_id,
event_timestamp,
item_id,
quantity,
item_revenue,
transaction_id
FROM sub1
where event_name in ("purchase") and transaction_id not in ("(not set)")
group by all)

SELECT distinct row_number() over () as PK,

session_id,
timestamp_add(timestamp_micros(event_timestamp), interval 1 hour) as suggestView_time,
page,

case when regexp_contains(page, ".*\\/p[0-9]{5}$|.*\\/p[0-9]{5}[^A-Za-z0-9]|.*\\/p[A-Z]{2}[0-9]{3}$|.*\\/p[A-Z]{2}[0-9]{3}[^A-Za-z0-9]") then "product-detail-page"
else
(case when regexp_contains(page, ".*\\/c[0-9]*$|.*\\/c[0-9]*[^A-Za-z0-9]") then "product-listing-page"
else
(case when regexp_contains(page, ".*\\/search\\?q\\=.*") then "search"
else
(case when regexp_contains(page, ".*toolstation\\.com\\/$|.*toolstation\\.com$|.*toolstation\\.com\\/[^A-Za-z0-9]|.*toolstation\\.com\\/[^A-Za-z0-9]") then "Homepage"
else
(case when regexp_contains(page, ".*\\/brands\\/.*|.*\\/brands$") then "Brands Page"
else
(case when regexp_contains(page, ".*\\/campaign\\/.*") then "Campaign Page"
else
(case when regexp_contains(page, ".*\\/branches.*") then "Branch Page"
else
(case when regexp_contains(page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*$|.*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\?.*") then coalesce(regexp_extract(page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)$"), regexp_extract(page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)\\?.*"))
else

(case when regexp_contains(page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/[a-zA-Z0-9\\-]*$|.*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/[a-zA-Z0-9\\-]*[^A-Za-z0-9]*") then coalesce(concat(regexp_extract(page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)\\/[a-zA-Z0-9\\-]*$"), "-", regexp_extract(page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/([a-zA-Z0-9\\-]*)$")), concat(regexp_extract(page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)\\/[a-zA-Z0-9\\-]*[^A-Za-z0-9]*"), "-", regexp_extract(page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/([a-zA-Z0-9\\-]*)[^A-Za-z0-9]*")))

else

"other" end) end) end) end) end) end) end) end) end as Page_type,

Provider,
Location,
show_ATC,
suggestClick_ID,
timestamp_add(timestamp_micros(clickTime), interval 1 hour) as clickTime,
SuggestClick_Location,
suggestClick_provider,
sku,
click_ATC,
timestamp_add(timestamp_micros(ATCTime), interval 1 hour) as ATCTime,
ATCsess,
ATC_page,
case when regexp_contains(ATC_page, ".*\\/p[0-9]{5}$|.*\\/p[0-9]{5}[^A-Za-z0-9]|.*\\/p[A-Z]{2}[0-9]{3}$|.*\\/p[A-Z]{2}[0-9]{3}[^A-Za-z0-9]") then "product-detail-page"
else
(case when regexp_contains(ATC_page, ".*\\/c[0-9]*$|.*\\/c[0-9]*[^A-Za-z0-9]") then "product-listing-page"
else
(case when regexp_contains(ATC_page, ".*\\/search\\?q\\=.*") then "search"
else
(case when regexp_contains(ATC_page, ".*toolstation\\.com\\/$|.*toolstation\\.com$|.*toolstation\\.com\\/[^A-Za-z0-9]|.*toolstation\\.com\\/[^A-Za-z0-9]") then "Homepage"
else
(case when regexp_contains(ATC_page, ".*\\/brands\\/.*|.*\\/brands$") then "Brands Page"
else
(case when regexp_contains(ATC_page, ".*\\/campaign\\/.*") then "Campaign Page"
else
(case when regexp_contains(ATC_page, ".*\\/branches.*") then "Branch Page"
else
(case when regexp_contains(ATC_page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*$|.*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\?.*") then coalesce(regexp_extract(page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)$"), regexp_extract(ATC_page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)\\?.*"))
else

(case when regexp_contains(ATC_page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/[a-zA-Z0-9\\-]*$|.*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/[a-zA-Z0-9\\-]*[^A-Za-z0-9]*") then coalesce(concat(regexp_extract(ATC_page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)\\/[a-zA-Z0-9\\-]*$"), "-", regexp_extract(page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/([a-zA-Z0-9\\-]*)$")), concat(regexp_extract(page, ".*toolstation\\.com\\/([a-zA-Z0-9\\-]*)\\/[a-zA-Z0-9\\-]*[^A-Za-z0-9]*"), "-", regexp_extract(page, ".*toolstation\\.com\\/[a-zA-Z0-9\\-]*\\/([a-zA-Z0-9\\-]*)[^A-Za-z0-9]*")))

else

"other" end) end) end) end) end) end) end) end) end as ATC_Page_type,
ATCitemID,
Quantity,
purchaseID,
purchaseITemID,
PurchaseQuant,
revenue,
transaction_id,
timediff,
timeORder



 from

(SELECT distinct *, row_number() over (partition by page, session_id, sku, Provider,
Location, show_ATC order by timediff asc) as timeORder from

(SELECT distinct suggest_view.*, suggest_click.session_id  as suggestClick_ID, suggest_click.event_timestamp as clickTime, suggest_click.Location as SuggestClick_Location, suggest_click.provider as suggestClick_provider, suggest_click.sku, suggest_click.click_ATC, ATC.event_timestamp as ATCTime, ATC.session_id as ATCsess, ATC.page as ATC_page, ATC.item_ID as ATCitemID, ATC.quantity as Quantity,
purchase.session_id as purchaseID, purchase.item_id as purchaseITemID, purchase.quantity as PurchaseQuant, purchase.item_revenue as revenue, purchase.transaction_id,

timestamp_diff(timestamp_MICROS(ATC.event_timestamp),timestamp_MICROS(suggest_click.event_timestamp), microsecond) as timediff
from monetate_event
inner join suggest_view on monetate_event.session_id = suggest_view.session_id and suggest_view.event_timestamp > monetate_event.event_timestamo
left join suggest_click on
suggest_view.session_id = suggest_click.session_id and suggest_view.page = suggest_click.page and suggest_view.Location = suggest_click.Location and suggest_view.event_timestamp < suggest_click.event_timestamp
left join ATC on suggest_click.session_id = ATC.session_id and suggest_click.sku = ATC.item_id and suggest_click.event_timestamp < ATC.event_timestamp
left join purchase on ATC.session_id = purchase.session_id and ATC.item_id = purchase.item_id and ATC.event_timestamp < purchase.event_timestamp))
where timeORder = 1
order by purchaseID desc;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 13;;
  }


  dimension: PK {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.PK ;;
  }

  dimension: suggestView_session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: suggest_viewdate {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.suggestView_time ;;
  }


  dimension: suggestV_page {
    hidden: yes
    type: string
    sql: ${TABLE}.page ;;
  }

  dimension: SuggestVPage_type {
    hidden: yes
    type: string
    sql: ${TABLE}.Page_type ;;
  }

  dimension: Provider {
    type: string
    sql: ${TABLE}.Provider ;;
    label: "Provider"
  }

  dimension: Location {
    type: string
    sql: case when ${TABLE}.Location in ("pdpSlot1") then "Related Products" else
    (case when ${TABLE}.Location in ("pdpSlot2") then "Similar Items" else ${TABLE}.Location end) end;;
    label: "Location"
  }

  dimension: show_ATC {
    hidden: yes
    type: string
    sql: ${TABLE}.show_ATC ;;
  }

  dimension: suggestClick_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.suggestClick_ID ;;
  }

  dimension_group: suggestClick_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.clickTime ;;
  }

  dimension: suggestClick_provider {
    hidden: yes
    type: string
    sql: ${TABLE}.suggestClick_provider ;;
  }

  dimension: SuggestClick_Location {
    hidden: yes
    type: string
    sql: ${TABLE}.SuggestClick_Location ;;
  }

  dimension: sku{
    hidden: yes
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: click_ATC {
    hidden: yes
    type: string
    sql: ${TABLE}.click_ATC ;;
  }

  dimension: ATC_sess {
    hidden: yes
    type: string
    sql: ${TABLE}.ATCsess;;
  }

  dimension_group: ATC_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.ATCTime ;;
  }

  dimension: ATC_page {
    hidden: yes
    type: string
    sql: ${TABLE}.ATC_page ;;
  }

  dimension: ATC_Page_type {
    hidden: yes
    type: string
    sql: ${TABLE}.ATC_Page_type ;;
  }

  dimension: ATCitemID {
    hidden: yes
    type: string
    sql: ${TABLE}.ATCitemID ;;
  }

  dimension: ATC_quant {
    hidden: yes
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  dimension: purchaseID {
    hidden: yes
    type: string
    sql: ${TABLE}.purchaseID;;
  }

  dimension: purchaseITemID {
    hidden: yes
    type: string
    sql: ${TABLE}.purchaseITemID ;;
  }

  dimension: PurchaseQuant {
    hidden: yes
    type: number
    sql: ${TABLE}.PurchaseQuant ;;
  }


  dimension: revenue {
    hidden: yes
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: timediff {
    hidden: yes
    type: number
    sql: ${TABLE}.timediff ;;
  }

  dimension: timeOrder {
    hidden: yes
    type: number
    sql: ${TABLE}.timeOrder ;;
  }

  dimension: transaction_id {
    hidden: yes
    type: string
    sql: ${TABLE}.transaction_id ;;
  }
  ################### Measures #########################

  measure: suggest_viewSessions {
    type: count_distinct
    sql: ${suggestView_session_id} ;;
    label: "Suggest View Sessions"
  }

  measure: show_ATC_yesno {
    type: yesno
    sql: ${show_ATC} = "true" ;;
    label: "Add to Cart option?"
  }

  measure: suggest_clickSessions {
    type: count_distinct
    sql: ${suggestClick_ID} ;;
    label: "Suggest Click Sessions"
  }

  measure: add_toCart_sessions {
    type: count_distinct
    sql: ${ATC_sess} ;;
    label: "Add to Cart Sessions"
  }

  measure: ATC_quanity {
    type: sum
    sql: ${ATC_quant} ;;
    label: "ATC Quantity"
  }

  measure: purchase_sessions {
    type: count_distinct
    sql: ${purchaseID} ;;
    label: "Purchase Sessions"
  }

  measure: purchase_quantity {
    type: sum
    sql: ${PurchaseQuant} ;;
    label: "Purchase Quantity"
  }

  measure: purchase_revenue {
    type: sum
    value_format_name: gbp
    sql: ${revenue} ;;
    label: "Gross Revenue"
  }

  measure: ORders {
    type: count_distinct
    sql: ${transaction_id} ;;
    label: "Orders"
  }





}
