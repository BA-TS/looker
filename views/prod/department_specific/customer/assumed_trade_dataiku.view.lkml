
view: assumed_trade_dataiku {

  sql_table_name: `toolstation-data-storage.looker_custom_tables.dataiku_assumed_trade_outputs` ;;

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customer_uid ;;
    label: "CUSTOMER_UID"
    hidden: yes
  }

  dimension: mean_proba_Yes {
    view_label: "Customer Classification"
    label: "Assumed Trade Probability"
    type:  number
    sql:${TABLE}.mean_proba_Yes;;
  }

  dimension: final_prediction {
    view_label: "Customer Classification"
    type:  number
    sql:${TABLE}.final_prediction;;
  }
}
