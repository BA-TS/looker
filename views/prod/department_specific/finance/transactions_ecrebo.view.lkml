view: transactions_ecrebo {

  derived_table: {
    sql:
    SELECT
    DISTINCT row_number() over () AS prim_key,
    *
    FROM `toolstation-data-storage.sales.transactionsEcrebo`
    ;;
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

  dimension: product_code {
    type: number
    sql: ${TABLE}.productCode;;
    hidden: yes
  }

  dimension: basket_promotion {
    type: string
    sql: ${TABLE}.basketPromotion ;;
  }

  dimension: item_promotion_applied {
    type: number
    sql: ${TABLE}.itemPromotionApplied;;
    value_format_name: gbp
  }
  # -------------------------------------
  # dimension: basket_discount_dim {
  #   type: number
  #   sql: ${TABLE}.basketDiscount ;;
  #   value_format_name: gbp
  #   hidden: yes
  # }

  # dimension: COGS_dim {
  #   type: number
  #   sql: ${TABLE}.COGS;;
  #   value_format_name: gbp
  #   hidden: yes
  # }

  dimension: quantity_dim {
    type: number
    sql: ${TABLE}.quantity;;
    value_format_name: decimal_0
    hidden: yes
  }

  dimension: item_discount_dim  {
    type: number
    sql: ${TABLE}.itemDiscount;;
    value_format_name: gbp
    hidden: yes
  }

  # dimension: basket_promotion_discount_dim {
  #   type: number
  #   sql: ${TABLE}.basketPromotionDiscount;;
  #   value_format_name: gbp
  #   hidden: yes
  # }

  # -------------------
  # measure: basket_discount {
  #   type: sum
  #   sql: ${basket_discount_dim};;
  #   value_format_name: gbp
  #   hidden: yes
  # }

  # measure: COGS {
  #   type: sum
  #   sql: ${COGS_dim};;
  #   value_format_name: gbp
  # }

  measure: quantity {
    type: sum
    sql: ${quantity_dim};;
    value_format_name: decimal_0
  }

  measure: item_discount  {
    type: sum
    sql: ${item_discount_dim};;
    value_format_name: gbp
    hidden: yes
  }

  # measure: basket_promotion_discount {
  #   type: sum
  #   sql: ${basket_promotion_discount_dim};;
  #   value_format_name: gbp
  # }
}
