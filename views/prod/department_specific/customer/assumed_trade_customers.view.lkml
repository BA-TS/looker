
view: assumed_trade_customers {

  sql_table_name: `toolstation-data-storage.customer.assumed_trade_customers` ;;

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.CustomerUID ;;
    label: "customerUid_test"
    hidden: yes

  }

  dimension: is_assumed_trade_customer {
    description: "If a customer who has ever been classified as an 'Assumed Trade' customer since 2015."
    view_label: "Customer Classification"
    group_label: "Flags"
    label: "Is Assumed Trade"
    type:  yesno
    sql:${assumed_trade_customers.customer_uid} is not null;;
    hidden: yes
  }

}
