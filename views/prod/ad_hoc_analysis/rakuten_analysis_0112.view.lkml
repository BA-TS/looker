view: rakuten_analysis_0112 {

  sql_table_name:`toolstation-data-storage.tmp.rakuten_transactions_customers`;;

  dimension: customerUID {
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
    label: "Customer UID"
    required_access_grants: [can_use_customer_information]
    hidden: yes
  }

  dimension: parent_order_UID {
    type: string
    sql: ${TABLE}.parentOrderUID ;;
    required_access_grants: [can_use_customer_information]
    hidden: yes
  }

  dimension: rakuten_transactionID {
    type: string
    sql: ${TABLE}.rakuten_transactionID ;;
    required_access_grants: [can_use_customer_information]
  }

  dimension: rakuten_transaction_date {
    type: date
    sql: ${TABLE}.rakuten_transaction_date ;;
    required_access_grants: [can_use_customer_information]
  }

  dimension: day_difference_rakuten{
    view_label: "Ad hoc"
    group_label: "Rakuten_0112"
    label: "Number of days between actual vs rakuten transactions"
    type: number
    sql: ${TABLE}.day_diff ;;
    required_access_grants: [can_use_customer_information]
  }

  dimension: customer_rakuten{
    view_label: "Ad hoc"
    group_label: "Rakuten_0112"
    type: yesno
    sql: case when ${customerUID} is not null then true else false end;;
    required_access_grants: [can_use_customer_information]
  }

  dimension: transaction_rakuten{
    view_label: "Ad hoc"
    group_label: "Rakuten_0112"
    type: yesno
    sql: case when ${parent_order_UID} is not null then true else false end;;
    required_access_grants: [can_use_customer_information]
  }
}
