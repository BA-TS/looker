view: rakuten_analysis_0112 {

  sql_table_name:`toolstation-data-storage.tmp.rakuten_transactions_customers`;;
  fields_hidden_by_default: yes

  dimension: customerUID {
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
    label: "Customer UID"
    hidden: yes
  }

  dimension: parent_order_UID {
    group_label: "Rakuten_0112"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
    hidden: yes
  }

  dimension: rakuten_transactionID {
    group_label: "Rakuten_0112"
    type: string
    sql: ${TABLE}.rakuten_transactionID ;;
  }

  dimension: rakuten_transaction_date {
    group_label: "Rakuten_0112"
    type: date
    sql: ${TABLE}.rakuten_transaction_date ;;
  }

  dimension: day_difference_rakuten{
    group_label: "Rakuten_0112"
    label: "Number of days between actual vs rakuten transactions"
    type: number
    sql: ${TABLE}.day_diff ;;
  }

  dimension: customer_rakuten{
    group_label: "Rakuten_0112"
    type: yesno
    sql: case when ${customerUID} is not null then true else false end;;
  }

  dimension: transaction_rakuten{
    group_label: "Rakuten_0112"
    type: yesno
    sql: case when ${parent_order_UID} is not null then true else false end;;
  }
}
