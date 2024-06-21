view: ds_assumed_trade_history {

  derived_table: {
    sql:
    select
    extract (date from Score_End_Date) as Score_End_Date,
    customers_customer_uid,
    Assumed_Trade_Probability
    from
    `toolstation-data-storage.customer.ds_assumed_trade_history_Looker` ;;
  }

  dimension:  Score_End_Date{
    type: date
    sql: ${TABLE}.Score_End_Date ;;
  }

  dimension: customers_customer_uid {
    type: string
    sql: ${TABLE}.customers_customer_uid ;;
  }

  dimension: Assumed_Trade_Probability {
    type: number
    sql: ${TABLE}.Assumed_Trade_Probability ;;
  }

}
