view: ecrebo_discounts {

  derived_table: {
    sql:
    SELECT
    DISTINCT row_number() over () AS prim_key,
    parentOrderUID,
    productCode,
    grossSalesAdjusted,
    netSalesAdjusted,
    marginExclFundingAdjusted
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

  dimension: net_sales_adjusted_dim {
    type: number
    sql: ${TABLE}.netSalesAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  dimension: margin_excl_funding_adjusted_dim {
    type: number
    sql: ${TABLE}.marginExclFundingAdjusted;;
    value_format_name: gbp
    hidden: yes
  }

  # measure: gross_sales_adjusted_raw {
  #   type: sum
  #   sql: ${gross_sales_adjusted_dim};;
  #   value_format_name: gbp
  #   hidden: yes
  # }

  # measure: gross_sales_adjusted {
  #   type: number
  #   sql: coalesce(${gross_sales_adjusted_raw},${transactions.total_gross_sales});;
  #   value_format_name: gbp
  # }

  # measure: net_sales_adjusted_raw {
  #   type: sum
  #   sql: ${net_sales_adjusted_dim};;
  #   value_format_name: gbp
  #   required_access_grants: [lz_only]
  # }

  # measure: net_sales_adjusted {
  #   type: number
  #   sql: coalesce(${net_sales_adjusted_raw},${transactions.total_net_sales});;
  #   value_format_name: gbp
  # }

  measure: margin_excl_funding_raw {
    type: sum
    sql: ${margin_excl_funding_adjusted_dim};;
    value_format_name: gbp
    hidden: yes
  }

  measure: margin_excl_funding {
    type: number
    sql: coalesce(${margin_excl_funding_raw},${transactions.total_margin_excl_funding});;
    value_format_name: gbp
  }

}
