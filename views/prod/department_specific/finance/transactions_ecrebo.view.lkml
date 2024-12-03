view: transactions_ecrebo {

  derived_table: {
    sql:
    SELECT
    DISTINCT row_number() over () AS prim_key,
    *
    FROM `toolstation-data-storage.sales.transactionsEcrebo`
    ;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 7;;
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

  dimension: basket_discount_dim {
    type: number
    sql: ${TABLE}.basketDiscount ;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: COGS_dim {
    type: number
    sql: ${TABLE}.COGS;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: gross_sales_unadjusted_dim {
    type: number
    sql: ${TABLE}.grossSalesUnadjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: net_sales_unadjusted_dim {
    type: number
    sql: ${TABLE}.netSalesUnadjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: margin_excl_funding_dim {
    type: number
    sql: ${TABLE}.marginExclFunding;;
    value_format_name: gbp
    hidden: yes
  }

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

  dimension: basket_promotion_discount_dim {
    type: number
    sql: ${TABLE}.basketPromotionDiscount;;
    value_format_name: gbp
    hidden: yes
  }

  dimension:gross_sales_adjusted_dim  {
    type: number
    sql: ${TABLE}.grossSalesAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: net_sales_adjusted_dim {
    type: number
    sql: ${TABLE}.netSalesAdjusted;;
    value_format_name:gbp
    hidden: yes
  }

  dimension: margin_excl_funding_adjusted_dim {
    type: number
    sql: ${TABLE}.marginExclFundingAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  # -------------------
  measure: basket_discount {
    type: sum
    sql: ${basket_discount_dim};;
    value_format_name: gbp
  }

  measure: COGS {
    type: sum
    sql: ${COGS_dim};;
    value_format_name: gbp
  }

  measure: gross_sales_unadjusted {
    type: sum
    sql: ${gross_sales_unadjusted_dim};;
    value_format_name: gbp
  }

  measure: net_sales_unadjusted {
    type: sum
    sql: ${net_sales_unadjusted_dim};;
    value_format_name: gbp
  }

  measure: margin_excl_funding {
    type: sum
    sql: ${margin_excl_funding_dim};;
    value_format_name: gbp
  }

  measure: quantity {
    type: sum
    sql: ${quantity_dim};;
    value_format_name: decimal_0
  }

  measure: item_discount  {
    type: sum
    sql: ${item_discount_dim};;
    value_format_name: gbp
  }

  measure: basket_promotion_discount {
    type: sum
    sql: ${basket_promotion_discount_dim};;
    value_format_name: gbp
  }

  measure:gross_sales_adjusted  {
    type: sum
    sql: ${gross_sales_adjusted_dim};;
    value_format_name: gbp
  }

  measure: net_sales_adjusted {
    type: sum
    sql: ${net_sales_adjusted_dim};;
    value_format_name:gbp
  }

  measure: margin_excl_funding_adjusted {
    type: sum
    sql: ${margin_excl_funding_adjusted_dim};;
    value_format_name: gbp
  }


}
