
view: trade_credit_details {

  required_access_grants: [can_use_customer_information]

  view_label: "Customers"
  sql_table_name: `toolstation-data-storage.customer.tradeCreditDetails`;;

  dimension: account_id {
    group_label: "Trade Credit"
    type: string
    sql: ${TABLE}.accountID ;;
  }

  dimension: credit_limit {
    group_label: "Trade Credit"
    type: number
    sql: ${TABLE}.creditLimit ;;
  }

  dimension: main_trade_credit_account_uid {
    type: string
    sql: ${TABLE}.mainTradeCreditAccountUID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: remaining_balance {
    type: number
    sql: ${TABLE}.remainingBalance ;;
    hidden: yes
  }

  measure: total_remaining_balance {
    group_label: "Trade Credit"
    label: "Remaining Balance"
    type: sum
    sql: ${remaining_balance} ;;
  }

  dimension_group: tc_account_created {
    group_label: "Trade Credit"
    label: "Account Created"
    type: time
    timeframes: [
      raw,
      date,
    ]
    sql: ${TABLE}.tcAccountCreatedDate ;;
  }

  dimension: tc_account_name {
    type: string
    sql: ${TABLE}.tcAccountName ;;
    hidden: yes
  }

}
