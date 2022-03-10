view: monthly_pendingOrders {
  derived_table: {
    datagroup_trigger: toolstation_transactions_datagroup

    sql: declare startDate DATE;
      declare endDate DATE;

      set startDate = date_trunc(date_sub(current_date, interval 1 month), month);
      set endDate = DATE_TRUNC(CURRENT_DATE(), MONTH);

      select
          transactionUID,
          placedDate,
          transactionDate,
          'Pending' as orderstatus,
          salesChannel,
          siteUID,
          paymentType,
          sum(grossSalesValue) as grossSales,
          sum(netSalesValue) as netSales
      from sales.transactions
         where
         date(placedDate) between startDate and endDate - 1
         and date(transactionDate) >= endDate
      group by 1,2,3,4,5,6,7

      union distinct

      select
          transactionUID,
          placedDate,
          transactionDate,
          status,
          salesChannel,
          siteUID,
          paymentType,
          sum(grossSalesValue) as grossSales,
          sum(netSalesValue) as netSales
      from `toolstation-data-storage.sales.transactions_incomplete`
         where date(placedDate) >= startDate
         and date(placedDate) < endDate
      group by 1,2,3,4,5,6,7
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
