view: bucketed_order_sales_department {
  view_label: "Buckets"
  derived_table: {
    sql:
    WITH parent_order_sums AS (
        SELECT
          parentOrderUID,
          productDepartment,
          SUM(netSalesValue) AS total_netSalesValue
        FROM `sales.transactions` s
        LEFT JOIN `range.products_current` r ON s.productCode=r.productCode
        WHERE transactionlINEtype = 'Sale'
        GROUP BY parentOrderUID,productDepartment
      )
      SELECT
        parentOrderUID AS parent_order_uid,
        productDepartment,
        FLOOR(total_netSalesValue / 5) * 5 AS five_bucket,
        FLOOR(total_netSalesValue / 10) * 10 AS ten_bucket,
        FLOOR(total_netSalesValue / 20) * 20 AS twenty_bucket,
        FLOOR(total_netSalesValue / 50) * 50 AS fifty_bucket,
        FLOOR(total_netSalesValue / 100) * 100 AS oneHundred_bucket,
        CASE
          WHEN total_netSalesValue > 60 THEN 'Over 60'
          ELSE 'Under 60'
        END AS over_under_60,
        CASE
          WHEN total_netSalesValue > 25 THEN 'Over 25'
          ELSE 'Under 25'
        END AS over_under_25,
        CASE
          WHEN total_netSalesValue > 10 THEN 'Over 10'
          ELSE 'Under 10'
        END AS over_under_10
      FROM parent_order_sums

      ;;
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parent_order_uid ;;
    hidden:  yes
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.productDepartment ;;
    hidden:  yes
  }

  dimension: five_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.five_bucket;;
    label: "£5 Sales Buckets"
    group_label: "Sales Increments (Dep)"
  }

  dimension: ten_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.ten_bucket;;
    label: "£10 Sales Buckets"
    group_label: "Sales Increments (Dep)"
  }

  dimension: twenty_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.twenty_bucket;;
    label: "£20 Sales Buckets"
    group_label: "Sales Increments (Dep)"
  }

  dimension: fifty_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.fifty_bucket;;
    label: "£50 Sales Buckets"
    group_label: "Sales Increments (Dep)"
  }

  dimension: hundred_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.oneHundred_bucket ;;
    label: "£100 Buckets"
    group_label: "Sales Increments (Dep)"
  }

  dimension: over_under_25 {
    type: string
    sql: ${TABLE}.over_under_25 ;;
    label: "Over or Under £25"
    group_label: "Sales Over/Under (Dep)"
  }

  dimension: over_under_60 {
    type: string
    sql: ${TABLE}.over_under_60 ;;
    label: "Over or Under £60"
    group_label: "Sales Over/Under (Dep)"
  }

  measure: num_transactions {
    type: count_distinct
    sql: ${TABLE}.parent_order_uid ;;
    hidden:  yes
  }
}
