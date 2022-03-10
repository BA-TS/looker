view: monthly_pendingOrders {
  derived_table: {
    datagroup_trigger: toolstation_transactions_datagroup

    sql:

DECLARE startDate DATE DEFAULT DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH);
DECLARE endDate DATE DEFAULT DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 DAY);

SELECT
    transactionUID,
    placedDate,
    transactionDate,
    'Pending' AS orderStatus,
    salesChannel,
    siteUID,
    paymentType,
    SUM(grossSalesValue) AS grossSales,
    SUM(netSalesValue) as netSales

FROM
    `toolstation-data-storage.sales.transactions`

WHERE
    DATE(placedDate) BETWEEN startDate AND endDate
        AND
    DATE(transactionDate) >= endDate

GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7

UNION DISTINCT

SELECT
    transactionUID,
    placedDate,
    transactionDate,
    status AS orderStatus,
    salesChannel,
    siteUID,
    paymentType,
    SUM(grossSalesValue) AS grossSales,
    SUM(netSalesValue) AS netSales
FROM
    `toolstation-data-storage.sales.transactions_incomplete`

WHERE
    DATE(placedDate) BETWEEN startDate AND endDate

GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7
    ;;
  }



  dimension: transaction_uid {
    type: string
    sql: ${TABLE}.transactionUID ;;
  }

  dimension_group: placed_date {
    type: time
    sql: ${TABLE}.placedDate ;;
  }

  dimension_group: transaction_date {
    type: time
    sql: ${TABLE}.transactionDate ;;
  }

  dimension: orderstatus {
    type: string
    sql: ${TABLE}.orderstatus ;;
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension: gross_sales {
    type: number
    sql: ${TABLE}.grossSales ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.netSales ;;
  }


}
