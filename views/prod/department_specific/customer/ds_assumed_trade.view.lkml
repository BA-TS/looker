view: ds_assumed_trade{

  sql_table_name: `toolstation-data-storage.customer.ds_assumed_trade` ;;

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customer_uid_2023 ;;
    hidden: yes
  }

  dimension: year {
    label: "Probability"
    type:  number
    sql:${TABLE}.year_2023;;
    hidden: yes
  }

  dimension: mean_proba_Yes_final {
    label: "Assumed Trade Probability"
    type:  number
    sql: coalesce(proba_Yes_2023,0);;
  }

  dimension: final_prediction {
    type:  string
    sql:${TABLE}.prediction_2023;;
    hidden: yes
  }
}
