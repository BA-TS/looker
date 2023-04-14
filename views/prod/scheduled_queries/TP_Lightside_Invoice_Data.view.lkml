view: TP_Lightside_Invoice_Data {

  derived_table: {
    datagroup_trigger: ts_transactions_datagroup
    sql:
    select
    parentOrderUID,
    transactionDate,
    vatRate,
    netSalesValue,
    OrderValue
    from
    (
    select
    distinct parentOrderUID,
    row_number() over (partition by parentOrderUID) as row_num,
    transactionDate,
    vatRate,
    round(sum(netSalesValue),2) as netSalesValue,
    round(sum(grossSalesValue),2) as OrderValue,
    FROM `toolstation-data-storage.sales.transactions_tp` txn
    where isCancelled = 0 and productCode <> '85699' and date(transactionDate) = current_date() -1
    group by 1,3,4)
    where OrderValue != 0.0
    group by 1,2,3,4,5
    order by transactionDate desc;;
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension_group: transaction_date {
    type: time
    sql: ${TABLE}.transactionDate ;;
  }

  dimension: vat_rate {
    type: number
    sql: ${TABLE}.vatRate ;;
  }

  dimension: net_sales_value {
    type: number
    sql: ${TABLE}.netSalesValue ;;
  }

  dimension: order_value {
    type: number
    sql: ${TABLE}.OrderValue ;;
  }
}
