view: ecrebo_items {

  derived_table: {
    sql:
    SELECT
    DISTINCT row_number() over () AS prim_key,
    transactionUuid,
    itemSku,
    itemName,
    itemDiscount,
    itemSaleRefund
    FROM `toolstation-data-storage.ecrebo.ecreboItems`;;
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden:  yes
  }

  dimension: transactionUuid {
    type: string
    sql: ${TABLE}.transactionUuid ;;
    hidden:  yes
  }

  dimension: item_sku {
    label: "Item SKU"
    type: string
    sql: ${TABLE}.itemSku ;;
    hidden: yes
  }

  dimension: item_name {
    label: "Item SKU"
    type: string
    sql: ${TABLE}.itemName ;;
    hidden: yes
  }

  dimension: item_discount_dim {
    type: number
    sql: ${TABLE}.itemDiscount;;
    hidden: yes
  }

  dimension: item_sale_refund {
    type: string
    sql: ${TABLE}.itemSaleRefund ;;
  }

  dimension: is_order_ecrebo {
    group_label: "Is Ecrebo"
    label: "Item"
    type: yesno
    sql: ${item_sku} is not null ;;
  }

  measure: item_discount {
    type: average
    label: "Item Discount"
    sql: ${item_discount_dim} ;;
  }

}
