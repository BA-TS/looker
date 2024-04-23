view: clickCollect {
  derived_table: {
    sql:
    select distinct transactionUID, max(orderCollectedDate) as orderCollectedDate from `toolstation-data-storage.sales.clickCollectCollectionTimes`
    group by transactionUID ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: transactionUID {
    type: string
    sql: ${TABLE}.transactionUID ;;
    hidden: yes
  }

  dimension: date {
    type: date
    sql: ${TABLE}.orderCollectedDate ;;
    hidden: yes
  }
}
