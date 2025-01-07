view: ecrebo_discounts {

  derived_table: {
    sql:
       select
        t.productCode,
        t.parentOrderUID,
        sum(coalesce(grossSalesAdjusted, t.grossSalesValue)) grossSalesAdjusted,
        sum(coalesce(netSalesAdjusted, netSalesValue)) netSalesAdjusted,
        sum(coalesce(marginExclFundingAdjusted, t.marginExclFunding)) marginExclFundingAdjusted
       from `toolstation-data-storage.sales.transactions`  t
       left join `toolstation-data-storage.sales.ecreboDiscounts` ED
        on t.parentOrderUID = ED.parentOrderUID AND t.transactionUID = ED.transactionUID and t.productCode = ED.productCode
        group by all
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
    type: string
    sql: ${TABLE}.productCode ;;
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

  measure: gross_sales_adjusted {
    type: sum
    sql: ${gross_sales_adjusted_dim2};;
    value_format_name: gbp
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

  measure: net_sales_adjusted {
    type: sum
    sql: ${net_sales_adjusted_dim2};;
    value_format_name: gbp
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

  measure: margin_excl_funding {
    type: sum
    sql: ${margin_excl_funding_adjusted_dim2};;
    value_format_name: gbp
  }


}
