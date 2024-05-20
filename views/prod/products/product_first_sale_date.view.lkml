view: product_first_sale_date {
  derived_table: {
    sql:
      SELECT
      productCode,
      MIN(DATE(transactionDate)) AS first_sale_date
      FROM `toolstation-data-storage.sales.transactions`
      GROUP BY 1;;
      datagroup_trigger: ts_weekly_datagroup
  }

  dimension: product_code {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: first_sale_date {
    group_label: "Product Details"
    label: "First Sale Date"
    type: date
    datatype: date
    sql: ${TABLE}.first_sale_date ;;
    hidden: yes
  }

  dimension_group: first_sale_date_group {
    group_label: "Product Details"
    label: "First Sale"
    type: time
    datatype: date
    timeframes: [year]
    sql: ${TABLE}.first_sale_date ;;
  }
}
