view: trade_credit_ids {
  view_label: "Trade Credit"
  sql_table_name: `toolstation-data-storage.customer.tradeCreditIDs`;;
  required_access_grants: [can_use_customer_information]

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: main_trade_credit_account_uid {
    label: "Account UID"
    type: string
    sql: ${TABLE}.mainTradeCreditAccountUID ;;
    hidden: yes #17/3/22
  }
}
