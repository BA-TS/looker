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
    transactionUuid,
--    itemSku,
    --itemName,
  --  itemDiscount,
    --itemSaleRefund
    FROM `toolstation-data-storage.ecrebo.ecreboCoupons` AS ec
    --LEFT JOIN `toolstation-data-storage.ecrebo.ecreboItems` AS ei
    --using (transactionUuid)
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

  dimension: transactionUuid {
    type: string
    sql: ${TABLE}.transactionUuid ;;
    hidden:  yes
  }

  dimension: is_order_ecrebo {
    type: yesno
    sql: ${parent_order_uid} is not null ;;
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

  dimension: discount_dim {
    type: number
    sql: ${TABLE}.discount ;;
    hidden: yes
  }

  dimension: item_discount_dim {
    type: number
    sql: ${TABLE}.itemDiscount;;
    hidden: yes
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

  measure: discount {
    type: average
    sql: ${discount_dim} ;;
  }
}
