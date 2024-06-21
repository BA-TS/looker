view: ds_assumed_trade_history {

  required_access_grants: [lz_testing]

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    extract (date from Score_End_Date) as Score_End_Date,
    customers_customer_uid,
    Assumed_Trade_Probability,
    CASE WHEN Assumed_Trade_Probability>0.55 THEN 1 ELSE 0 END AS flag,
    from
    `toolstation-data-storage.customer.ds_assumed_trade_history_Looker` ;;
  }

  dimension:  prim_key{
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.prim_key ;;
  }

  dimension: customer_uid {
    type: string
    hidden: yes
    sql: ${TABLE}.customers_customer_uid ;;
  }

  dimension: Score_End_Date{
    group_label: "Assumed Trade History"
    type: date
    sql: ${TABLE}.Score_End_Date ;;
  }

  dimension: Assumed_Trade_Probability {
    group_label: "Assumed Trade History"
    type: number
    sql: ${TABLE}.Assumed_Trade_Probability ;;
  }

  dimension: flag {
    group_label: "Assumed Trade History"
    type: number
    sql: ${TABLE}.flag ;;
  }

  measure: avg_probability {
    group_label: "Assumed Trade History"
    type: average
    sql: ${Assumed_Trade_Probability} ;;
  }

  measure: number_of_yes {
    group_label: "Assumed Trade History"
    type: number
    sql: ${flag} ;;
  }
}
