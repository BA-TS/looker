view: bucketed_order_sales {
  view_label: "Buckets"
  derived_table: {
    sql:
    WITH parent_order_sums AS (
        SELECT
          parentOrderUID,
          SUM(grossSalesValue) AS total_grossSalesValue
        FROM `sales.transactions`
        WHERE transactionlINEtype = 'Sale'
        GROUP BY parentOrderUID
      )
      SELECT
        parentOrderUID AS parent_order_uid,
        CASE
          WHEN total_grossSalesValue  >= 50 THEN 51  -- Assigning 51+ to represent "Over 50"
          ELSE FLOOR(total_grossSalesValue / 5) * 5
        END AS five_bucket,
        FLOOR(total_grossSalesValue / 10) * 10 AS ten_bucket,
        FLOOR(total_grossSalesValue / 20) * 20 AS twenty_bucket,
        FLOOR(total_grossSalesValue / 50) * 50 AS fifty_bucket,
        FLOOR(total_grossSalesValue / 100) * 100 AS oneHundred_bucket,
        CASE
          WHEN total_grossSalesValue > 60 THEN 'Over 60'
          ELSE 'Under 60'
        END AS over_under_60,
        CASE
          WHEN total_grossSalesValue > 25 THEN 'Over 25'
          ELSE 'Under 25'
        END AS over_under_25,
        CASE
          WHEN total_grossSalesValue > 10 THEN 'Over 10'
          ELSE 'Under 10'
        END AS over_under_10,
                CASE
          WHEN total_grossSalesValue > 30 THEN 'Over 30'
          ELSE 'Under 30'
        END AS over_under_30,
                CASE
          WHEN total_grossSalesValue > 40 THEN 'Over 40'
          ELSE 'Under 40'
        END AS over_under_40
      FROM parent_order_sums
      ;;
      datagroup_trigger: ts_daily_datagroup
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parent_order_uid ;;
    hidden:  yes
  }

  dimension: five_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.five_bucket;;
    label: "£5 Sales Buckets"
    group_label: "Sales Increments (Gross)"
  }

  dimension: ten_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.ten_bucket;;
    label: "£10 Sales Buckets"
    group_label: "Sales Increments (Gross)"
  }

  dimension: twenty_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.twenty_bucket;;
    label: "£20 Sales Buckets"
    group_label: "Sales Increments (Gross)"
  }

  dimension: fifty_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.fifty_bucket;;
    label: "£50 Sales Buckets"
    group_label: "Sales Increments (Gross)"
  }

  dimension: hundred_bucket {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.oneHundred_bucket ;;
    label: "£100 Buckets"
    group_label: "Sales Increments (Gross)"
  }

  dimension: over_under_25 {
    type: string
    sql: ${TABLE}.over_under_25 ;;
    label: "Over or Under £25"
    group_label: "Sales Over/Under (Gross)"
  }

  dimension: over_under_40 {
    type: string
    sql: ${TABLE}.over_under_40 ;;
    label: "Over or Under £40"
    group_label: "Sales Over/Under (Gross)"
  }

  dimension: over_under_30 {
    type: string
    sql: ${TABLE}.over_under_30 ;;
    label: "Over or Under £30"
    group_label: "Sales Over/Under (Gross)"
  }

  dimension: over_under_60 {
    type: string
    sql: ${TABLE}.over_under_60 ;;
    label: "Over or Under £60"
    group_label: "Sales Over/Under (Gross)"
  }

  measure: num_transactions {
    type: count_distinct
    sql: ${TABLE}.parent_order_uid ;;
    hidden:  yes
  }
}
