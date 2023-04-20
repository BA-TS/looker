view: cltv_customers {
  derived_table: {
    sql: select
        CUSTOMERUID,
        case when cluster like '%T%' then 'Trade' else 'DIY' end as customer_group,
        cluster,
        date(creationDate) as account_creationDate
        from
        `toolstation-data-storage.customer.allCustomers` a
        inner join `toolstation-data-storage.ts_analytics.ts_SCVFinal` t on a.customerUID=t.ucu_uid
        where cluster <> 'I';;
    datagroup_trigger:ts_transactions_datagroup
  }

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
