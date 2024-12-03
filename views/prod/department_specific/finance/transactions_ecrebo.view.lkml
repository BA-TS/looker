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

  dimension: basket_discount {
    type: number
    sql: ${TABLE}.basketDiscount ;;
    value_format_name: gbp
  }

  dimension: basket_promotion {
    type: string
    sql: ${TABLE}.basketPromotion ;;
  }

  dimension: product_code {
    type: number
    sql: ${TABLE}.productCode;;
    hidden: yes
  }

  dimension: COGS {
    type: number
    sql: ${TABLE}.COGS;;
    value_format_name: gbp
  }

  dimension: gross_sales_unadjusted {
    type: number
    sql: ${TABLE}.grossSalesUnadjusted;;
    value_format_name: gbp
  }

  dimension: net_sales_unadjusted {
    type: number
    sql: ${TABLE}.netSalesUnadjusted;;
    value_format_name: gbp
  }

  dimension: margin_excl_funding {
    type: number
    sql: ${TABLE}.marginExclFunding;;
    value_format_name: gbp
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity;;
    value_format_name: decimal_0
  }

  dimension: item_discount  {
    type: number
    sql: ${TABLE}.itemDiscount;;
    value_format_name: gbp
  }

  dimension: item_promotion_applied {
    type: number
    sql: ${TABLE}.itemPromotionApplied;;
    value_format_name: gbp
  }

  dimension: basket_promotion_discount {
    type: number
    sql: ${TABLE}.basketPromotionDiscount;;
    value_format_name: gbp
  }

  dimension:gross_sales_adjusted  {
    type: number
    sql: ${TABLE}.grossSalesAdjusted;;
    value_format_name: gbp
  }

  dimension: net_sales_adjusted {
    type: number
    sql: cast(${TABLE}.netSalesAdjusted as decimal);;
    value_format_name:gbp
  }

  dimension: margin_excl_funding_adjusted {
    type: number
    sql: ${TABLE}.marginExclFundingAdjusted;;
    value_format_name: gbp
  }

  # dimension: item_discount_dim {
  #   type: number
  #   sql: ${TABLE}.itemDiscount;;
  #   hidden: yes
  # }

  # measure: discount {
  #   type: average
  #   label: "Average Discount"
  #   sql: ${discount_dim} ;;
  #   value_format_name:  "gbp"
  # }

  # measure: total_discount {
  #   type: sum
  #   label: "Total Discount"
  #   sql: ${discount_dim} ;;
  #   value_format_name:  "gbp"
  # }
}
