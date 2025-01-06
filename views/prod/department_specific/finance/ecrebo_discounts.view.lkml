view: ecrebo_discounts {

  derived_table: {
    sql:
    SELECT
    DISTINCT row_number() over () AS prim_key,
    parentOrderUID,
    transactionUID,
    grossSalesUnadjusted
    FROM `toolstation-data-storage.sales.ecreboDiscounts`
    ;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 7;;
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden:  yes
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

  measure: gross_sales_unadjusted {
    type: sum
    sql: ${gross_sales_unadjusted_dim};;
    value_format_name: gbp
    hidden: yes
  }

  measure: net_sales_unadjusted {
    type: sum
    sql: ${net_sales_unadjusted_dim};;
    value_format_name: gbp
    hidden: yes
  }

  measure: margin_excl_funding {
    type: sum
    sql: ${margin_excl_funding_dim};;
    value_format_name: gbp
    hidden: yes
  }


}
