view: monthly_pendingOrders {
  derived_table: {
    datagroup_trigger: ts_daily_datagroup

    sql:


select * from(
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
   date(placedDate) between DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH) and DATE_TRUNC(date(current_date), month) - 1
   and date(transactionDate) >= DATE_TRUNC(date(current_date), month)
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
   where date(placedDate) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH)
   and date(placedDate) < DATE_TRUNC(date(current_date), month)
group by 1,2,3,4,5,6,7
)
where orderstatus = "Pending"
order by placedDate

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
