view: ecrebo_discounts {

  derived_table: {
    sql:
       select
      DISTINCT row_number() over () AS prim_key,
        t.productCode,
        t.parentOrderUID,
        t.transactionLineType,
        --t.transactionDate,
        sum(coalesce(grossSalesAdjusted, t.grossSalesValue)) grossSalesAdjusted,
        sum(coalesce(netSalesAdjusted, netSalesValue)) netSalesAdjusted,
        sum(coalesce(marginExclFundingAdjusted, t.marginExclFunding)) marginExclFundingAdjusted,
        sum(coalesce(marginInclFundingAdjusted, t.marginInclFunding)) marginInclFundingAdjusted,
        sum(itemDiscount) itemDiscount,
        sum(ED.COGS) COGS,
        sum(total_basket_discount) basketDiscount,
        sum(`basketPromotionDiscounts`[SAFE_OFFSET(0)].discount_amount) basketPromotionDiscount
       from `toolstation-data-storage.sales.transactions`  t
       left join `toolstation-data-storage.sales.ecreboDiscounts` ED
        on t.parentOrderUID = ED.parentOrderUID AND t.transactionUID = ED.transactionUID and t.productCode = ED.productCode
        and t.transactionLineType = ED.transactionLineType
        where t.productCode NOT IN ('85699', '00053','44842')
        group by all
    ;;
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden:  yes
  }


  dimension_group: transaction {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
    ]
    # datatype: date
    sql: ${TABLE}.transactionDate ;;
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parentOrderUID ;;
    hidden:  yes
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
    hidden:  yes
  }

  dimension: transaction_line_type {
    type: string
    sql: ${TABLE}.transactionLineType ;;
    hidden:  yes
  }

  dimension: gross_sales_adjusted_dim {
    type: number
    sql: ${TABLE}.grossSalesAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: gross_sales_adjusted_dim2 {
    type: number
    sql: coalesce(${gross_sales_adjusted_dim},${transactions.gross_sales_value});;
    value_format_name: gbp
    hidden: yes
  }

  dimension: net_sales_adjusted_dim {
    type: number
    sql: ${TABLE}.netSalesAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: net_sales_adjusted_dim2 {
    type: number
    sql: coalesce(${net_sales_adjusted_dim},${transactions.net_sales_value});;
    value_format_name: gbp
    hidden: yes
  }

  dimension: item_discount_dim  {
    type: number
    sql: ${TABLE}.itemDiscount;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: margin_excl_funding_adjusted_dim {
    type: number
    sql: ${TABLE}.marginExclFundingAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: margin_excl_funding_adjusted_dim2 {
    type: number
    sql: coalesce(${margin_excl_funding_adjusted_dim},${transactions.margin_incl_funding});;
    value_format_name: gbp
    hidden: yes
  }

  dimension: margin_incl_funding_adjusted_dim {
    type: number
    sql: ${TABLE}.marginInclFundingAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: margin_incl_funding_adjusted_dim2 {
    type: number
    sql: coalesce(${margin_incl_funding_adjusted_dim},${transactions.margin_incl_funding});;
    value_format_name: gbp
    hidden: yes
  }

  dimension: COGS_dim {
    type: number
    sql: ${TABLE}.COGS;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: basket_discount_dim {
    type: number
    sql: ${TABLE}.basketDiscount ;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: basket_promotion_discount_dim {
    type: number
    sql: ${TABLE}.basketPromotionDiscount;;
    value_format_name: gbp
    hidden: yes
  }

  # --------------------------
  measure: gross_sales_adjusted {
    type: sum
    sql: ${gross_sales_adjusted_dim2};;
    value_format_name: gbp
  }

  measure: net_sales_adjusted {
    type: sum
    sql: ${net_sales_adjusted_dim2};;
    value_format_name: gbp
  }

  measure: margin_excl_funding {
    type: sum
    sql: ${margin_excl_funding_adjusted_dim2};;
    value_format_name: gbp
  }

  measure: margin_incl_funding {
    type: sum
    sql: ${margin_incl_funding_adjusted_dim2};;
    value_format_name: gbp
  }

  measure: item_discount  {
    label: "Item Discount (Gross)"
    type: sum
    sql: ${item_discount_dim};;
    value_format_name: gbp
  }

  measure: COGS {
    type: sum
    sql: ${COGS_dim};;
    value_format_name: gbp
  }

  measure: basket_discount {
    type: sum
    sql: ${basket_discount_dim};;
    value_format_name: gbp
    hidden: yes
  }

  measure: basket_promotion_discount {
    label: "Basket Promotion Discount (Gross)"
    type: sum
    sql: ${basket_promotion_discount_dim};;
    value_format_name: gbp
  }
}
