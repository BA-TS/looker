view: Sage_Sales {
  derived_table: {

    datagroup_trigger: ts_transactions_datagroup


    sql: SELECT
        completedDate,
        siteUID,
        round(SUM(grossSales), 2)AS grossSales,
        round(SUM(netSales), 2) AS netSales,
        round(SUM(VAT), 2) AS VAT
      FROM (
        SELECT
          DATE(transactionDate) AS completedDate,
          CASE
            WHEN salesChannel = 'Dropship' THEN 'WW'
            WHEN salesChannel LIKE 'Epos%' THEN siteUID
            WHEN siteUID = 'XC' THEN REGEXP_EXTRACT(orderspecialrequests,r"Site: (.{2})")
          ELSE
          siteUID
        END
          AS siteUID,
          transactionUID,
          CASE
            WHEN salesChannel LIKE 'Epos%' THEN 'EPOS'
          ELSE
          UPPER(salesChannel)
        END
          AS salesChannel,
          ROUND(SUM(grossSalesValue),2) AS grossSales,
          ROUND(SUM(netSalesValue),2) AS netSales,
          ROUND(ROUND(SUM(grossSalesValue),2)-ROUND(SUM(netSalesValue),2),2) AS VAT
        FROM
          `toolstation-data-storage.sales.transactions` txn
        WHERE
          DATE(txn.transactionDate) >= DATE_SUB(current_Date,INTERVAL 7 day)
          AND paymentType <> 'account'
        GROUP BY
          1,
          2,
          3,
          4

      )
      GROUP BY
      1,
      2
      ORDER BY
      1, 2
      ;;
  }



  dimension: completed_date {
    type: date
    datatype: date
    sql: ${TABLE}.completedDate ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: gross_sales {
    type: number
    sql: ${TABLE}.grossSales ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.netSales ;;
  }

  dimension: vat {
    type: number
    sql: ${TABLE}.VAT ;;
  }


}
