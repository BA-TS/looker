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
  dimension: number_of_positive_predictions {
    label: "Customer Classification Number of Positive Predictions"
    description: ""
    type: number
  }

  dimension: number_of_negative_predictions {
    label: "Customer Classification Number of Negative Predictions"
    description: ""
    type: number
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    sql: ${TABLE}.customer_uid ;;
    description: ""
  }

  dimension: diy_to_at {
    type: yesno
    sql: ${customer_uid} is not null ;;
  }

}
