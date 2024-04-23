include: "/views/**/*transactions.view"

view: clickCollect {
  derived_table: {
    sql:
    select a.transactionUID, orderCollectedDate
    FROM `toolstation-data-storage.sales.transactions` a
    inner join
    (select distinct transactionUID, max(orderCollectedDate) as orderCollectedDate from `toolstation-data-storage.sales.clickCollectCollectionTimes` group by transactionUID) b
    on a.transactionUID = b.transactionUID
    WHERE a.salesChannel = 'Click & Collect';;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: transactionUID {
    type: string
    sql: ${TABLE}.transactionUID ;;
    hidden: yes
  }

  dimension_group: orderCollected{
      type: time
      timeframes: [
        raw,
        time,
        date
      ]
    sql: timestamp(${TABLE}.orderCollectedDate) ;;
  }

  dimension: minutes_to_pick {
    type: number
    sql: timestamp_diff(${transactions.transaction_raw},${transactions.placed_raw},minute);;
  }

  dimension: minutes_to_collect {
    type: number
    sql:timestamp_diff(${orderCollected_raw}, ${transactions.placed_raw}, minute) ;;
  }
}
