view: ecrebo {

  derived_table: {
    sql:
    SELECT
    DISTINCT row_number() over () AS prim_key,
    parentOrderUID,
    et.storeid,
    issuanceRedemption,
    campaignUuid,
    ec.campaignName AS campaignName,
    campaignGroup,
    discount,
    transactionUuid,
    FROM `toolstation-data-storage.ecrebo.ecreboCoupons` AS ec
    LEFT JOIN `toolstation-data-storage.ecrebo.ecreboTransactions` AS et
    using (transactionUuid)
    LEFT JOIN `toolstation-data-storage.ecrebo.ecreboHeirarchy` AS eh
    using (campaignName)
    ;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 10;;
  }

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
    group_label: "Is Ecrebo"
    label: "Order"
    type: yesno
    sql: ${parent_order_uid} is not null ;;
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

  dimension: campaign_group {
    type: string
    sql: ${TABLE}.campaignGroup ;;
  }

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
    label: "Number of Campaigns"
    type: count_distinct
    sql: ${campaignUuid} ;;
  }

  measure: number_of_campaigns_groups {
    type: count_distinct
    sql: ${campaign_group} ;;
  }

  measure: discount {
    type: average
    label: "Average Discount"
    sql: ${discount_dim} ;;
    value_format_name:  "gbp"
  }

  measure: total_discount {
    type: sum
    label: "Total Discount"
    sql: ${discount_dim} ;;
    value_format_name:  "gbp"
  }

  measure: count_issuance_redemption_r {
    type: sum
    sql: CASE WHEN ${issuance_redemption} = 'r' THEN 1 ELSE NULL END ;;
  }

  measure: count_issuance_redemption_i {
    type: sum
    sql: CASE WHEN ${issuance_redemption} = 'i' THEN 1 ELSE NULL END ;;
  }



}
