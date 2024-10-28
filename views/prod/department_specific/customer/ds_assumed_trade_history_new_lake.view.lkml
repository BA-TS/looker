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
      Assumed_Trade_Probability,
      Score_End_Date as Score_End_Date_raw,
      *
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
    group_label: "Prediction History"
    type: string
    sql: ${TABLE}.Score_End_Date_raw ;;
  }

  dimension: Score_End_Date{
    group_label: "Prediction History"
    type: string
    sql: cast(FORMAT_DATE('%Y-%m',${Score_End_Date_raw}) as string);;
    # sql: left(cast(${Score_End_Date_raw} as string),7) ;;
  }

  dimension: AT_monthly_run{
    group_label: "Prediction History"
    label: "Monthly AT run"
    type: yesno
    sql: ${Score_End_Date} is not null ;;
  }

  dimension: Assumed_Trade_Probability {
    group_label: "Prediction History"
    label: "Probability"
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
    label: "Is Assumed Trade"
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
    label:"Number of AT predictions"
    group_label: "Prediction History"
    type: count_distinct
    sql: case when ${flag}=1 then ${prim_key} else null end  ;;
  }

  measure: total_number_of_predictions {
    group_label: "Prediction History"
    type: count_distinct
    sql: ${customer_uid} ;;
  }

  measure: number_of_negative_predictions {
    group_label: "Prediction History"
    label:"Number of DIY predictions"
    type: count_distinct
    sql: case when ${flag}=0 then ${prim_key} else null end  ;;
  }
}
