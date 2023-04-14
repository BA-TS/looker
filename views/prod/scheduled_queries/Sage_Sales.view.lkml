view: Sage_Sales {
  derived_table: {

    datagroup_trigger: ts_transactions_datagroup

    sql: SELECT
    date(transactionDate) as completedDate,
    case
    when salesChannel = 'Dropship' then 'WW'
    when salesChannel like 'Epos%' then siteUID
    when siteUID = 'XC' then regexp_extract(orderspecialrequests,r"Site: (.{2})")
    else siteUID
    end as siteUID,
    transactionUID,
    case when salesChannel like 'Epos%' then 'EPOS' else upper(salesChannel) end as salesChannel,
    round(sum(grossSalesValue),2) as grossSales,
    round(sum(netSalesValue),2) as netSales,
    round(round(sum(grossSalesValue),2)-round(sum(netSalesValue),2),2) as VAT
    FROM `toolstation-data-storage.sales.transactions` txn
    where date(txn.transactionDate) >= date_sub(current_Date,interval 30 day)
    and paymentType <> 'account'
    group by 1,2,3,4
    order by 1,2;;
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

  dimension: transaction_uid {
    type: string
    sql: ${TABLE}.transactionUID ;;
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.salesChannel ;;
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
