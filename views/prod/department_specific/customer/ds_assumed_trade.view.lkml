include: "/views/prod/department_specific/customer/customers.view"

view: ds_assumed_trade{
   derived_table: {
    sql:
    select distinct * from
    `toolstation-data-storage.customer.ds_assumed_trade_history_Looker_v2`
    ;;
    # datagroup_trigger: ts_daily_datagroup
   }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.Customer_UID;;
    hidden: yes
  }

  dimension: model_run_date {
    type: string
    sql: ${TABLE}.Score_End_Date;;
  }

  dimension: year {
    type:  number
    sql: 2023;;
    hidden: yes
  }

  dimension: today_last_year {
    required_access_grants: [lz_testing]
    type:  date
    sql: date(2023,01,01);;
    hidden: yes
  }

  dimension: proba_Yes_final {
    label: "Probability (Assumed Trade)"
    type:  number
    sql: ${TABLE}.Assumed_Trade_Probability;;
    value_format:"0.0%"
  }

  dimension: bucket_probability {
    type: tier
    style: interval
    label: "Probability Bucket (Assumed Trade)"
    tiers: [0,0.5,0.6,0.7,0.8,0.9,1]
    sql: ${proba_Yes_final} ;;
  }

  dimension: final_prediction {
    type:  yesno
    label: "Is Assumed Trade"
    sql:${proba_Yes_final} > 0.55 ;;
    hidden: yes
  }

  dimension: final_prediction2 {
    type:  string
    label: "Customer Type (Assumed Trade/Trade/DIY)"
    description: "Assumed Trade customers are customers who are currently DIY customerse but are predicted to be trade customers"
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

  dimension: customer_type_pb {
    type:  string
    label: "Customer Type (Combined Trade/DIY)"
    description: "Combined Trade includes existing trade customers and new assumed trade customers"
    sql:
    CASE
    WHEN ${customers.is_trade} = true then "Combined Trade"
    When ${customers.flags__customer_anonymous} = true then "DIY"
    When ${customers.customer__first_name} = "EBAY" AND ${customers.customer__last_name} = "USER" then "DIY"
    When ${final_prediction} = true then "Combined Trade"
    Else "DIY"
    END
    ;;
  }

  measure: mean_proba_Yes_final {
    required_access_grants: [lz_testing]
    hidden: yes
    label: "Probability - Mean "
    type:  average
    sql:${proba_Yes_final} ;;
  }
}
