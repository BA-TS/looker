view: assumed_trade_dataiku {

  sql_table_name: `toolstation-data-storage.tmp.dataiku_assumed_trade_outputs` ;;

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.CUSTOMER_UID ;;
    hidden: yes
  }

  dimension: mean_proba_Yes {
    label: "Probability"
    type:  number
    sql:${TABLE}.mean_proba_Yes;;
    hidden: yes
  }

  dimension: mean_proba_Yes_final {
    label: "Probability"
    type:  number
    sql: coalesce(mean_proba_Yes,0);;
  }

  dimension: final_prediction {
    type:  string
    sql:${TABLE}.final_prediction;;
    hidden: yes
  }

  dimension: mean_proba_tier {
    label: "Assumed Trade Probability Tier"
    type: tier
    tiers: [0,0.51,0.6,0.7,0.8,0.9]
    sql: ${mean_proba_Yes_final} ;;
  }
}
