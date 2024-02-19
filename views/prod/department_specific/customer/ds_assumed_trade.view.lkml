include: "/views/prod/department_specific/customer/customers.view"
include: "/views/prod/department_specific/customer/customers.view"

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
    sql: date(2023,01,01);;
    hidden: yes
  }

  dimension: proba_Yes_final {
    label: "Probability (Assumed Trade)"
    type:  number
    sql: coalesce(mean_proba_Yes,0);;
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
    sql:${TABLE}.final_prediction = "true";;
    hidden: yes
  }

  dimension: final_prediction2 {
    type:  string
    label: "Customer Type"
    sql:
    CASE
    WHEN ${customers.is_trade} = true then "Trade"
    When ${customers.flags__customer_anonymous} = true then "DIY"
    When ${final_prediction} = true then "Assumed Trade"
    Else "DIY"
    END
    ;;
  }

  dimension: customer_type_pb {
    type:  string
    label: "Customer Type (PB)"
    sql:
    CASE
    WHEN ${customers.is_trade} = true then "Trade"
    When ${customers.flags__customer_anonymous} = true then "DIY"
    When ${final_prediction} = true then "Trade"
    Else "DIY"
    END
    ;;
  }


  measure: mean_proba_Yes_final {
    label: "Probability - Mean "
    type:  average
    sql:${proba_Yes_final} ;;
  }

}
