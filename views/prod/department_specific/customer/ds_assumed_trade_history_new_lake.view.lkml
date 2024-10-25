view: ds_assumed_trade_history_new_lake {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    CASE WHEN Assumed_Trade_Probability>0.55 THEN 1 ELSE 0 END AS flag,
    *
    from
    `toolstation-data-storage.customer.ds_assumed_trade_history_v2`
    ;;
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
    sql: ${TABLE}.Customer_UID ;;
  }

  dimension: Score_End_Date{
    group_label: "Prediction History"
    type: date
    sql: ${TABLE}.Score_End_Date ;;
  }

  dimension: Assumed_Trade_Probability {
    group_label: "Prediction History"
    label: "Probability (History)"
    type: number
    value_format_name: "percent_2"
    sql: ${TABLE}.Assumed_Trade_Probability ;;
  }

  measure: Assumed_Trade_Probability_STD {
    group_label: "Prediction History"
    label: "Probability Std Dev"
    type: number
    value_format_name: "percent_2"
    sql: stddev_pop(${Assumed_Trade_Probability}) ;;
  }

  dimension: flag {
    group_label: "Prediction History"
    type: number
    sql: ${TABLE}.flag ;;
  }

  measure: average_probability {
    group_label: "Prediction History"
    type: average
    sql: ${Assumed_Trade_Probability} ;;
    value_format_name: "percent_2"
  }

  measure: number_of_positive_predictions {
    group_label: "Prediction History"
    type: sum
    sql: ${flag} ;;
  }

  measure: total_number_of_predictions {
    group_label: "Prediction History"
    type: count_distinct
    sql: ${customer_uid} ;;
  }

  measure: number_of_negative_predictions {
    group_label: "Prediction History"
    type: number
    sql: ${total_number_of_predictions}-${number_of_positive_predictions} ;;
  }
}
