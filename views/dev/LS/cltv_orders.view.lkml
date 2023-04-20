view: cltv_orders {
  derived_table: {
    sql: SELECT
    CUSTOMERUID,
    PARENTORDERUID,
    date(transactiondate) as transactiondate,
    SUM(NETSALESVALUE) as netsales
    from `toolstation-data-storage.sales.transactions`
    where date(transactionDate)>= '2021-01-01'
    and transactionlinetype <> 'Charity'
    and iscancelled <> 0
    group by 1,2,3;;
  datagroup_trigger:ts_transactions_datagroup
  partition_keys: ["transactiondate"]
  cluster_keys: ["CUSTOMERUID"]
  }

  dimension: CUSTOMERUID {
    description: "Unique ID for each user that has ordered"
    type: string
    sql: ${TABLE}.CUSTOMERUID ;;
  }

  dimension: PARENTORDERUID {
    description: "transaction ID"
    type:string
    sql: ${TABLE}.PARENTORDERUID ;;
  }

  dimension: netsales {
    description: "netsales of transaction"
    type: number
    sql: ${TABLE}.netsales ;;
  }

  dimension_group: transactiondate  {
    description: "transactiondate"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.transactiondate ;;
  }

  measure: total_net_sales {
    description: "Sum of net sales"
    type: sum
    sql: ${netsales} ;;
  }
}
