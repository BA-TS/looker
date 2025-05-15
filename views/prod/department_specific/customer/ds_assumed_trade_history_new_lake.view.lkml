view: ds_assumed_trade_history_new_lake {

  derived_table: {
    sql:
      WITH
      customers_distinct AS (
      SELECT DISTINCT * FROM
      `toolstation-data-storage.customer.ds_assumed_trade_history_v2`
      )

      SELECT
      DISTINCT row_number() over () AS prim_key,
      CASE WHEN Assumed_Trade_Probability>0.55 THEN 1 ELSE 0 END AS flag,
      Customer_UID,
      Assumed_Trade_Probability,
      Score_End_Date as Score_End_Date_raw,
      FROM customers_distinct
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

  dimension: Score_End_Date_raw{
    type: string
    sql: ${TABLE}.Score_End_Date_raw ;;
    hidden: yes
  }

  dimension: Score_End_Date{
    type: string
    sql: left(replace((cast(date(${Score_End_Date_raw}) as string)),"-",""),6) ;;
  }

  dimension: Dec_24_run{
    type: yesno
    sql: ${Score_End_Date}="202501" ;;
  }

  dimension: AT_monthly_run{
    label: "Date Filter - Has a Monthly Run"
    type: yesno
    sql: ${Score_End_Date} is not null ;;
    hidden: yes
  }

  dimension: Assumed_Trade_Probability {
    label: "Probability"
    type: number
    value_format_name: "percent_2"
    sql: ${TABLE}.Assumed_Trade_Probability ;;
    hidden: yes
  }

  measure: Assumed_Trade_Probability_STD {
    label: "Probability Std Dev"
    type: number
    value_format_name: "percent_2"
    sql: stddev_pop(${Assumed_Trade_Probability}) ;;
    hidden: yes
  }

  dimension: flag {
    label: "AT Flag"
    type: number
    sql: ${TABLE}.flag ;;
    hidden: yes
  }

  dimension: final_prediction {
    type:  yesno
    label: "Is Assumed Trade"
    sql:${flag} =1 ;;
  }

  dimension: final_prediction2 {
    type:  string
    label: "Customer Type New (Assumed Trade/Trade/DIY)"
    sql:
          CASE
          WHEN ${customers.is_trade} = true then "Trade"
          When ${customers.flags__customer_anonymous} = true then "DIY"
          When ${customers.customer__first_name} = "EBAY" AND ${customers.customer__last_name} = "USER" then "DIY"
          When ${final_prediction} = true then "Assumed Trade"
          Else "DIY"
          END
          ;;
  }

  measure: average_probability {
    type: average
    sql: ${Assumed_Trade_Probability} ;;
    value_format_name: "percent_2"
    hidden: yes
  }

  measure: number_of_positive_predictions {
    label:"Number of AT predictions"
    type: sum
    sql: ${flag} ;;
    hidden: yes
  }

  measure: total_number_of_predictions {
    type: count_distinct
    sql: ${prim_key} ;;
    hidden: yes
  }

  measure: number_of_negative_predictions {
    label:"Number of DIY predictions"
    type: number
    sql:${total_number_of_predictions} - ${number_of_positive_predictions}  ;;
    hidden: yes
  }
}
