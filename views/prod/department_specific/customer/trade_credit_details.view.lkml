view: trade_credit_details {
  fields_hidden_by_default: yes
  view_label: "Trade Credit"
  sql_table_name: `toolstation-data-storage.customer.tradeCreditDetails`;;

  dimension: main_trade_credit_account_uid {
    type: string
    sql: ${TABLE}.mainTradeCreditAccountUID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: account_id {
    label: "Account ID"
    type: string
    sql: ${TABLE}.accountID ;;
  }

  dimension: credit_limit {
    label: "Credit Limit"
    type: number
    sql: ${TABLE}.creditLimit ;;
    hidden: yes
  }

  dimension: remaining_balance {
    type: number
    sql: ${TABLE}.remainingBalance ;;
    hidden: yes
  }

  dimension_group: tc_account_created {
    label: "Account Created"
    type: time
    timeframes: [
      raw,
      date,
      time
    ]
    sql: ${TABLE}.tcAccountCreatedDate ;;
  }

  dimension: tc_account_name {
    label: "Account Name"
    type: string
    sql: ${TABLE}.tcAccountName ;;
  }

  dimension: has_trade_account {
    type: yesno
    view_label: "Customers"
    group_label: "Flags"
    label: "Has Trade Account?"
    sql:${account_id} IS NOT NULL;;
    hidden: yes
  }

  measure: total_credit_limit {
    label: "Credit Limit"
    type: sum
    sql: ${credit_limit} ;;
  }

  measure: total_remaining_balance {
    label: "Remaining Balance"
    type: sum
    sql: ${remaining_balance} ;;
  }
}
