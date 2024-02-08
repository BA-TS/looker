view: ds_assumed_trade{

  sql_table_name: `toolstation-data-storage.customer.ds_assumed_trade` ;;

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customer_uid;;
    hidden: yes
  }

  dimension: year {
    type:  number
    sql: 2023;;
    hidden: yes
  }

  dimension: today_last_year {
    required_access_grants: [lz_testing]
    type:  date
    sql: current_Date()-365;;
  }

  dimension: proba_Yes_final {
    label: "Probability"
    type:  number
    sql: coalesce(mean_proba_Yes,0);;
    value_format:"0.0%"
  }

  dimension: final_prediction {
    type:  yesno
    label: "Is Assumed Trade"
    sql:${TABLE}.final_prediction = "true";;
  }

  measure: mean_proba_Yes_final {
    label: "Probability - Mean "
    type:  average
    sql:${proba_Yes_final} ;;
  }

}
