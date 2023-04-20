view: product_first_sale_date {
  derived_table: {
    sql:
      SELECT
        productCode,
        MIN(DATE(transactionDate)) AS first_sale_date
      FROM
        `toolstation-data-storage.sales.transactions`
      GROUP BY 1;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: product_code {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: first_sale_date {
    view_label: "Products"
    group_label: "Product Details"
    label: "First Sale Date"
    type: date
    datatype: date
    sql: ${TABLE}.first_sale_date ;;
    hidden: yes
  }

  dimension_group: first_sale_date_group {
    view_label: "Products"
    group_label: "Product Details"
    label: "First Sale"
    type: time
    timeframes: [year]
    sql: ${TABLE}.first_sale_date ;;
  }

  # dimension_group: active_from {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.activeFrom ;;
  # }
  # dimension_group: active_to {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.activeTo ;;
  # }
  # dimension_group: product_start {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.productStartDate ;;
  # }
  # dimension: is_active {
  #   type: number
  #   sql: ${TABLE}.isActive ;;
  # }
}
