include: "/views/**/*transactions.view"

view: clickCollect {

  derived_table: {
    sql:
    select distinct transactionUID,
    max(orderCollectedDate) as orderCollectedDate,
    row_number() over () as P_K,
    from `toolstation-data-storage.sales.clickCollectCollectionTimes`
    group by 1;;

    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: P_K {
    type: number
    sql: ${TABLE}.P_K ;;
    hidden: yes
    primary_key: yes
  }

  dimension: transactionUID {
    type: string
    sql: ${TABLE}.transactionUID ;;
    hidden: yes
  }

  dimension_group: order_collected{
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
    sql:
    case when (TIME(${transactions.transaction_raw}) BETWEEN "07:00:00" AND "16:59:59") then
    timestamp_diff(${transactions.transaction_raw},${transactions.placed_raw},minute)
    else null end;;
    hidden: yes
  }

  dimension: minutes_to_collect {
    type: number
    sql:
    case when (TIME(${transactions.transaction_raw}) BETWEEN "07:00:00" AND "16:59:59") then
    timestamp_diff(${order_collected_raw}, ${transactions.placed_raw}, minute)
    else null end ;;
   hidden:yes
  }

  dimension: minutes_to_collect_buckets {
    group_label: "Buckets"
    type: tier
    tiers: [0,30,60,120,180,240,300,360,420,480]
    style: integer
    sql: ${minutes_to_collect} ;;
  }

  dimension: days_to_collect {
    type: number
    sql:
    date_diff(${order_collected_date}, ${transactions.placed_date}, day) ;;
    hidden: yes
  }

  dimension: collected_same_day {
    group_label: "Flags"
    type: yesno
    sql: ${days_to_collect}=1;;
  }

  dimension: not_collected_same_day {
    group_label: "Flags"
    type: yesno
    sql: ${days_to_collect}>1;;
  }

  dimension: days_to_collect_buckets {
    group_label: "Buckets"
    type: tier
    tiers: [0,1,2,3,7]
    style: integer
    sql: ${minutes_to_collect} ;;
    }

  measure: total_minutes_to_pick {
    type: sum
    sql: ${minutes_to_pick};;
    hidden: yes
  }

  measure: minutes_to_pick_per_transaction {
    type: number
    sql: safe_divide(${total_minutes_to_pick},${transactions.number_of_transactions});;
    value_format: "#,##0.0"
 }

  measure: total_minutes_to_collect {
    type: sum
    sql: ${minutes_to_collect};;
    hidden: yes
  }

  measure: minutes_to_collect_per_transaction {
    type: number
    sql: safe_divide(${total_minutes_to_collect},${transactions.number_of_transactions});;
    value_format: "#,##0.0"
  }

  measure: total_days_to_collect {
    type: sum
    sql: ${days_to_collect};;
    hidden: yes
  }

  measure: days_to_collect_per_transaction {
    type: number
    sql: safe_divide(${total_days_to_collect},${transactions.number_of_transactions});;
    value_format: "#,##0.0"
  }

  measure:total_uncollected_orders_end_of_day{
    type: count_distinct
    sql: case when ${not_collected_same_day}=true then ${transactionUID} else null end;;
    value_format: "#,##0"
  }

  measure:total_collected_orders_end_of_day{
    type: count_distinct
    sql: case when ${collected_same_day}=true then ${transactionUID} else null end;;
    value_format: "#,##0"
  }

  measure:percentage_orders_collected_same_day{
    label: "% Orders Collected Same Day"
    type: number
    sql: safe_divide(${total_collected_orders_end_of_day},(${total_collected_orders_end_of_day}+${total_uncollected_orders_end_of_day}));;
    value_format: "0.0%"
  }

}
