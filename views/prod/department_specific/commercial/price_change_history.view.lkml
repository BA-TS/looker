view: price_change_history {

  derived_table: {
    sql:
    SELECT distinct row_number() over () as P_K,
    *
    from `toolstation-data-storage.pricing.price_change_history_Mastertable`
    ;;
  }

  dimension: P_K {
    description: "Primary Key"
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension_group: new_start {
    type: time
    timeframes: [date,raw]
    hidden: yes
    sql: ${TABLE}.newstartdate ;;
  }

  dimension_group: new_end {
    type: time
    timeframes: [date,raw]
    hidden: yes
    sql: ${TABLE}.newenddate ;;
  }

  dimension: product_code {
    hidden: yes
    type: string
    sql: ${TABLE}.productcode ;;
  }

  dimension: price_flag_level_1 {
    group_label: "Price Change History"
    type: string
    sql: ${TABLE}.PriceFlagLevel1;;
  }

  dimension: price_flag_level_2 {
    group_label: "Price Change History"
    type: string
    sql: ${TABLE}.PriceFlagLevel2;;
  }

  dimension: KVIFlag {
    group_label: "Price Change History"
    label: "KVI Flag"
    type: string
    sql: ${TABLE}.KVIFlag;;
  }

}
