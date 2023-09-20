
view: assumed_trade_customers {

  sql_table_name: `toolstation-data-storage.customer.assumed_trade_customers` ;;

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.CustomerUID ;;
    label: "customerUid_test"
    hidden: yes

  }

  dimension: is_assumed_trade_customer {
    description: "A customer who has been classified as a 'Assumed Trade' customer. Please note that this is a dynamic field which is updated constantly, so values may vary."
    group_label: "Flags"
    label: "Is Assumed Trade"
    type:  yesno
    sql:${assumed_trade_customers.customer_uid} is not null;;
  }

}
