#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: top10customersegments {
  derived_table: {
    sql: -- use existing base in `toolstation-data-storage.looker_persistent_tables.LR_9FA9Y1690848211647_base`
      -- use existing transactions in `toolstation-data-storage.looker_persistent_tables.LR_9FXJ01690854208028_transactions`
      -- Did not use base::daily_sales_summary_DATE; filter field base.select_date_range did not have the same filter value in the query ('Yesterday') as in the aggregate_table ('45 days ago for 59 days')
      -- Did not use base::daily_sales_summary_PD; filter field base.select_date_range was filtered in the query but not in the aggregate table
      -- Did not use base::daily_sales_summary_WTD; filter field base.select_date_range was filtered in the query but not in the aggregate table
      -- Did not use base::daily_sales_summary_MTD; filter field base.select_date_range was filtered in the query but not in the aggregate table
      -- Did not use base::daily_sales_summary_YTD; filter field base.select_date_range was filtered in the query but not in the aggregate table
      SELECT distinct
      row_number() over () as P_K,
          customer_segmentation.cluster  AS customer_segmentation_cluster,
          sum( transactions.netSalesValue  ) over (partition by  customer_segmentation.cluster) AS transactions_net_sales_by_customer_segment
      FROM `toolstation-data-storage.looker_persistent_tables.LR_9FA9Y1690848211647_base` AS base
      LEFT JOIN `toolstation-data-storage.looker_persistent_tables.LR_9FXJ01690854208028_transactions` AS transactions ON (DATE(timestamp(base.date))) = (DATE((DATE(transactions.transactionDate ))))
                AND
              (transactions.isCancelled = 0
                OR
              transactions.isCancelled IS NULL)

              AND (transactions.productCode NOT IN ('85699', '00053') OR transactions.productCode IS NULL)


                AND ((UPPER(transactions.salesChannel)) IS NOT NULL AND transactions.siteUID IS NOT NULL AND (initcap(transactions.productDepartment)) IS NOT NULL)

                AND
              UPPER(transactions.extranet_status) = 'SALE'
      LEFT JOIN `toolstation-data-storage.ts_analytics.ts_SCVFinal`  AS customer_segmentation ON transactions.customerUID = customer_segmentation.ucu_uid
      WHERE (((( (timestamp(base.date)) ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -1 DAY))) AND ( (timestamp(base.date)) ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -1 DAY), INTERVAL 1 DAY))))))

      ORDER BY  2 DESC
      LIMIT 10 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: P_K {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: customer_segmentation_cluster {
    type: string
    sql: ${TABLE}.customer_segmentation_cluster ;;
  }

  dimension: transactions_net_sales_by_customer_segment {
    type: number
    value_format_name: gbp
    sql: ${TABLE}.transactions_net_sales_by_customer_segment ;;
  }

  set: detail {
    fields: [
        customer_segmentation_cluster,
  transactions_net_sales_by_customer_segment
    ]
  }
}
