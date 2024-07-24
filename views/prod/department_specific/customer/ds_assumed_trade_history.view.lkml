view: ds_assumed_trade_history {

  required_access_grants: [lz_testing]

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    Score_End_Date,
    customers_customer_uid,
    Assumed_Trade_Probability,
    CASE WHEN Assumed_Trade_Probability>0.55 THEN 1 ELSE 0 END AS flag,
    from
    `toolstation-data-storage.customer.ds_assumed_trade_history`
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
    sql: ${TABLE}.customers_customer_uid ;;
  }

  dimension: Score_End_Date{
    group_label: "Prediction History"
    type: date
    sql: ${TABLE}.Score_End_Date ;;
    hidden: yes
  }

  dimension: Assumed_Trade_Probability {
    group_label: "Prediction History"
    label: "Assumed Trade Probability History"
    type: number
    value_format_name: "percent_2"
    sql: ${TABLE}.Assumed_Trade_Probability ;;
  }

  dimension: flag {
    group_label: "Prediction History"
    type: number
    sql: ${TABLE}.flag ;;
    hidden: yes
  }

  measure: Assumed_Trade_Probability_STD {
    group_label: "Prediction History"
    label: "Assumed Trade Probability Std Dev"
    type: number
    value_format_name: "percent_2"
    sql: stddev_pop(${Assumed_Trade_Probability}) ;;
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
    sql: ${Assumed_Trade_Probability} ;;
  }
}
