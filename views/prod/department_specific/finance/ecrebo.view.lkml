view: ecrebo {

  derived_table: {
    sql:
    SELECT
    DISTINCT row_number() over () AS prim_key,
    parentOrderUID,
    et.datetime as datetime,
    et.storeid,
    issuanceRedemption,
    campaignUuid,
    campaignName,
    discount,
    itemSku,
    --itemName,
    itemDiscount,
    itemSaleRefund
    FROM `toolstation-data-storage.ecrebo.ecreboCoupons` AS ec
    LEFT JOIN `toolstation-data-storage.ecrebo.ecreboItems` AS ei
    using (transactionUuid)
    LEFT JOIN `toolstation-data-storage.ecrebo.ecreboTransactions` AS et
    using (transactionUuid);;
  }
      # left join toolstation-data-storage.ecrebo.ecreboCampaignHeirarchy eh
    # using (campaignName)

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden:  yes
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parentOrderUID ;;
    hidden:  yes
  }

  dimension_group: ecrebo {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.datetime ;;
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.storeid ;;
  }

  dimension: issuance_redemption {
    type: string
    sql: ${TABLE}.issuanceRedemption ;;
  }

  dimension: campaignUuid {
    type: string
    sql: ${TABLE}.campaignUuid ;;
    hidden: yes
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaignName ;;
  }

  # dimension: campaign_group {
  #   type: string
  #   sql: ${TABLE}.campaignGroup  ;;
  # }

  dimension: discount {
    type: number
    sql: ${TABLE}.discount ;;
  }

  dimension: item_sku {
    label: "Item SKU"
    type: string
    sql: ${TABLE}.itemSku ;;
    hidden: yes
  }

  dimension: item_discount {
    type: number
    sql: ${TABLE}.itemDiscount;;
  }

  dimension: item_sale_refund {
    type: string
    sql: ${TABLE}.itemSaleRefund ;;
  }

  measure: number_of_store_ids {
    label: "Number of Store IDs"
    type: count_distinct
    sql: ${store_id} ;;
  }

  measure: number_of_ecrebo_campaigns {
    type: count_distinct
    sql: ${campaignUuid} ;;
  }

  measure: average_item_discount {
    type: average
    sql: ${item_discount} ;;
  }

  measure: average_discount {
    type: average
    sql: ${discount} ;;
  }
}

# view: ecrebo {

#   derived_table: {
#     sql:
#             WITH ecrebo_cte as (

#                     SELECT DISTINCT
#                       DATE(et.datetime) as date,
#                       ec.campaign_id,
#                       ec.campaign_name,
#                       et.transaction_uuid,
#                       et.receipt_id,
#                       #ts1.parentOrderUID,
#                       #OrderID,
#                       coalesce(ts1.parentOrderUID,OrderID) as ParentOrderUID
#                     FROM
#                       `toolstation-data-storage.sales.ecreboTransactions` et
#                       JOIN
#                       `toolstation-data-storage.sales.ecreboCoupons` ec ON  et.transaction_uuid=ec.transaction_uuid
#                       left JOIN
#                       `toolstation-data-storage.sales.TrolleySales` ts1 ON et.transaction_uuid = ts1.trolleyUID
#                       left join (
#                   select distinct ParentOrderUID as OrderID from `toolstation-data-storage.sales.transactions`
#                       union distinct
#                       select distinct ParentOrderUID as OrderID from `toolstation-data-storage.sales.transactions_incomplete`) on regexp_extract(et.receipt_id,"^.{0,11}") = OrderID
#                     WHERE
#                       ec.campaign_id IS NOT NULL and ec.issuance_redemption = 'r'
#                     ),

#     tr as (select distinct date(transactionDate) as TransactionDate, date(PlacedDate) as PlacedDate,
#     parentOrderUID,productCode,transactionLineType,NetSalesValue, marginInclFunding
#     from `toolstation-data-storage.sales.transactions`
#     union distinct
#     select distinct date(transactionDate) as TransactionDate, date(PlacedDate) as PlacedDate,
#     parentOrderUID,productCode,transactionLineType,NetSalesValue, marginInclFunding
#     from `toolstation-data-storage.sales.transactions_incomplete`)

# SELECT
#   ecrebo_cte.campaign_id,
#   ecrebo_cte.campaign_name,
#   CASE
#     WHEN STRPOS(campaign_id, ' ') > 0 THEN campaign_id
#     ELSE campaign_name
#   END AS new_campaign_name,
#   TransactionDate,
#   PlacedDate,
#     ecrebo_cte.parentOrderUID,
#   SUM(CASE WHEN tr.transactionLineType = 'Marketing' AND productCode IN ('00021','00027') THEN tr.netSalesValue ELSE 0 END) as code21_27Value,
#   SUM(CASE WHEN tr.transactionLineType = 'Sale' THEN tr.netSalesValue ELSE 0 END) as salesLineOnlyNetSalesValue,
#   SUM(tr.netSalesValue) as NetSalesValue,
#   SUM(tr.marginInclFunding) as orderMarginInclFunding
# FROM
#   tr
#   JOIN
#   ecrebo_cte ON tr.parentOrderUID=ecrebo_cte.parentOrderUID
#   GROUP BY 1,2,3,4,5,6;;
#     datagroup_trigger: ts_transactions_datagroup
#   }

#   dimension: ecrebo_date_filter {
#     type: date
#     datatype: date
#     sql: ${TABLE}.PlacedDate;;
#     hidden:  yes
#   }

#   dimension: TransactionDate {
#     type: date
#     datatype: date
#     sql: ${TABLE}.TransactionDate;;
#     hidden:  yes
#   }

#   dimension: parent_order_uid {
#     group_label: "Order ID"
#     label: "Parent Order UID"
#     type: string
#     sql: ${TABLE}.parentOrderUID ;;
#     hidden:  yes
#   }

#   dimension: campaign_id {
#     group_label: "Campaign"
#     label: "Campaign ID"
#     type: string
#     sql: ${TABLE}.campaign_id ;;
#   }

#   dimension: campaign_name {
#     group_label: "Campaign"
#     label: "Campaign Name"
#     type: string
#     sql: ${TABLE}.campaign_name ;;
#   }

#   dimension: campaign {
#     group_label: "Campaign"
#     label: "Campaign"
#     type: string
#     sql: ${TABLE}.new_campaign_name ;;
#   }
# #         measure: ecrebo_marketing_vouchers {
# #           label: "Ecrebo Marketing Vouchers"
# #           type:  sum
# #           view_label: "Measures"
# #           group_label: "Marketing"
# #           sql: ${code21_27Value} ;;
# #           value_format_name: gbp
# # }
# }
