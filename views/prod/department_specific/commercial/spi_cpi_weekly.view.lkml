view: spi_cpi_weekly{

  derived_table: {
    sql:
    SELECT
    dims.fiscalYearWeek as fiscalYearWeek,
    dims.productCode as productCode,
    sum(metrics.cy_netSales) as cy_netSales,
    sum(metrics.ly_netSales) as ly_netSales,
    sum(metrics.cy_unitsSOLD) as cy_unitsSOLD,
    sum(metrics.ly_unitsSOLD) as ly_unitsSOLD,
    row_number() OVER(ORDER BY dims.productCode) AS prim_key
    FROM `toolstation-data-storage.financeReporting.DS_DAILY_SPI_CPI`
    Where dims.productCode not in ("00053", "44842","85699")
    group by 1, 2
    ;;
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension: productCode {
    type: string
    sql: ${TABLE}.productCode;;
    hidden: yes
  }

  dimension: fiscal_year_week {
    type: string
    sql: CAST(${TABLE}.fiscalYearWeek as string);;
    hidden: yes
  }

  dimension: cy_netSales {
    type: number
    label: "CY Net Sales"
    sql: coalesce(${TABLE}.cy_netSales,0);;
    value_format_name: gbp
    hidden: yes
  }

  dimension: ly_netSales {
    type: number
    sql: coalesce(${TABLE}.ly_netSales,0);;
    value_format_name: gbp
    hidden: yes
  }

  dimension: cy_unitsSOLD {
    type: number
    sql: coalesce(${TABLE}.cy_unitsSOLD,0);;
    hidden: yes
  }

  dimension: ly_unitsSOLD {
    type: number
    sql: coalesce(${TABLE}.ly_unitsSOLD,0);;
    hidden: yes
  }

  measure: cy_unitsSOLD_total {
    type: sum
    group_label: "CY"
    label: "CY Units Sold"
    sql: ${cy_unitsSOLD};;
    value_format: "#,##0"
  }

  measure: ly_unitsSOLD_total {
    type: sum
    group_label: "LY"
    label: "LY Units Sold"
    sql: ${ly_unitsSOLD};;
    value_format: "#,##0"
  }

  measure: cy_netSales_total {
    type: sum
    group_label: "CY"
    sql: ${cy_netSales};;
    label: "CY Net Sales"
    value_format_name: gbp
  }

  measure: ly_netSales_total {
    type: sum
    group_label: "LY"
    sql: ${ly_netSales};;
    label: "LY Net Sales"
    value_format_name: gbp
  }

  # measure: cy_asp {
  #   label: "CY ASP"
  #   group_label: "CY"
  #   description: "Net Sales AOV / Average Units"
  #   type: number
  #   sql: COALESCE(SAFE_DIVIDE(${cy_netSales_total}, ${cy_unitsSOLD_total}),0) ;;
  #   value_format_name: gbp
  # }

  # measure: ly_asp {
  #   label: "LY ASP"
  #   group_label: "LY"
  #   description: "Net Sales AOV / Average Units"
  #   type: number
  #   sql: COALESCE(SAFE_DIVIDE(${ly_netSales_total}, ${ly_unitsSOLD_total}),0) ;;
  #   value_format_name: gbp
  # }
}
