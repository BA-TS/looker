

view: cltv_orders {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
CUSTOMERUID,
PARENTORDERUID,
date(transactiondate) as transactiondate,
SUM(NETSALESVALUE) as netsales
from `toolstation-data-storage.sales.transactions`
where date(transactionDate)>= '2021-01-01'
group by 1,2,3
      ;;
datagroup_trigger:ts_transactions_datagroup
partition_keys: ["transactiondate"]
cluster_keys: ["CUSTOMERUID"]
  }

  # Define your dimensions and measures here, like this:
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




view: cltv_customers {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: select
        CUSTOMERUID,
        case when cluster like '%T%' then 'Trade' else 'DIY' end as customer_group,
        cluster,
        date(creationDate) as account_creationDate
        from
        `toolstation-data-storage.customer.allCustomers` a
        inner join `toolstation-data-storage.ts_analytics.ts_SCVFinal` t on a.customerUID=t.ucu_uid
        where cluster <> 'I'
  ;;
    datagroup_trigger:ts_transactions_datagroup
  }

  # Define your dimensions and measures here, like this:
  dimension: CUSTOMERUID {
    description: "Unique ID for each user that has ordered"
    type: string
    sql: ${TABLE}.CUSTOMERUID ;;
  }

  dimension: customer_group {
    description: "Trade or DIY"
    type:string
    sql: ${TABLE}.customer_group ;;
  }

  dimension: cluster {
    description: "Customer segmentation"
    type:string
    sql: ${TABLE}.cluster ;;
  }

  dimension_group: account_creationDate  {
    description: "account creation date"
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.account_creationDate ;;
  }
}
