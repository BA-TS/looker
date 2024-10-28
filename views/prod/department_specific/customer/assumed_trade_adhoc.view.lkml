view: assumed_trade_adhoc {
  derived_table: {
    explore_source: base {
      column: number_of_positive_predictions { field: ds_assumed_trade_history_new_lake.number_of_positive_predictions }
      column: number_of_negative_predictions { field: ds_assumed_trade_history_new_lake.number_of_negative_predictions }
      column: customer_uid { field: customers.customer_uid }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "NOT NULL"
      }
      filters: {
        field: ds_assumed_trade_paul_test.final_prediction2
        value: "Assumed Trade"
      }
      filters: {
        field: ds_assumed_trade.final_prediction2
        value: "DIY"
      }
      filters: {
        field: calendar_completed_date.calendar_year
        value: "2023,2024"
      }
      filters: {
        field: calendar_completed_date.month_in_year
        value: "<=9"
      }
    }
  }

  dimension: number_of_AT_predictions {
    group_label: "DIY to AT Analysis"
    label: "Number of AT Predictions"
    type: number
    sql: ${TABLE}.number_of_positive_predictions ;;
    hidden: yes
  }

  # dimension: number_of_AT_predictions_tier {
  #   group_label: "DIY to AT Analysis"
  #   type: tier
  #   style: integer
  #   tiers: [0,2,6,10]
  #   sql: ${number_of_AT_predictions} ;;
  # }

  dimension: number_of_DIY_predictions {
    group_label: "DIY to AT Analysis"
    label: "Number of DIY Predictions"
    type: number
    sql: ${TABLE}.number_of_negative_predictions ;;
    hidden: yes
  }

  # dimension: number_of_DIY_predictions_tier {
  #   group_label: "DIY to AT Analysis"
  #   type: tier
  #   tiers: [0,2,6,10]
  #   style: integer
  #   sql: ${number_of_DIY_predictions} ;;
  # }

  dimension: percentage_of_AT_predictions {
    group_label: "DIY to AT Analysis"
    label: "AT Predictions %"
    type: number
    value_format_name: percent_2
    sql: safe_divide(${number_of_AT_predictions},(${number_of_AT_predictions}+${number_of_DIY_predictions})) ;;
  }

  dimension: percentage_of_AT_predictions_tier {
    group_label: "DIY to AT Analysis"
    label: "AT Predictions % Tier "
    type: string
    sql:
    CASE
      WHEN ${percentage_of_AT_predictions}<= 0.2 THEN "0-20%"
      WHEN ${percentage_of_AT_predictions}> 0.2 and ${percentage_of_AT_predictions}<=0.4 THEN "20-40%"
      WHEN ${percentage_of_AT_predictions}> 0.4 and ${percentage_of_AT_predictions}<= 0.6 THEN "40-60%"
      WHEN ${percentage_of_AT_predictions}> 0.6 and ${percentage_of_AT_predictions}<=0.8 THEN "60-80%"
      WHEN ${percentage_of_AT_predictions}> 0.8 THEN "80-100%"
      ELSE "Unknown"
      END ;;
  }

  dimension: customer_uid {
    group_label: "DIY to AT Analysis"
    label: "Customers Customer UID"
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: diy_to_at {
    group_label: "DIY to AT Analysis"
    label: "DIY to AT Customers"
    type: yesno
    sql: ${customer_uid} is not null ;;
  }
}
