view: bucketed_order_sales {
  view_label: "Order Sales Buckets"
  derived_table: {
    sql:
      WITH parent_order_sums AS (
        SELECT
          parentOrderUID,
          SUM(netSalesValue) AS total_netSalesValue
        FROM `sales.transactions`
        WHERE transactionlINEtype = 'Sale'
        GROUP BY parentOrderUID
      )
      SELECT
        parentOrderUID AS parent_order_uid,
        FLOOR(total_netSalesValue / 10) * 10 AS ten_bucket,
        FLOOR(total_netSalesValue / 100) * 100 AS oneHundred_bucket,
        CASE
          WHEN total_netSalesValue > 60 THEN 'Over 60'
          ELSE 'Under 60'
        END AS over_under_60
      FROM parent_order_sums
      ;;
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parent_order_uid ;;
    hidden:  yes
  }
  dimension: ten_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.ten_bucket;;
    label: "£10 Sales Buckets"
  }

  dimension: hundred_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.oneHundred_bucket ;;
    label: "£100 Buckets"
    hidden: yes
  }

  dimension: over_under_60 {
    type: string
    sql: ${TABLE}.over_under_60 ;;
    label: "Over or Under £60"
  }

  measure: num_transactions {
    type: count_distinct
    sql: ${TABLE}.parent_order_uid ;;
    hidden:  yes
  }
}
