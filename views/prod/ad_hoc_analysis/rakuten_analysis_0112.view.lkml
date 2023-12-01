view: rakuten_analysis_0112 {

  sql_table_name:`toolstation-data-storage.tmp.rakuten_transactions_customers`;;

  dimension: customerUID {
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
    label: "Customer UID"
    required_access_grants: [can_use_customer_information]
  }

  dimension: customer_rakuten_analysis{
    view_label: "Customers"
    type: yesno
    sql: case when ${customerUID} is not null then true else false end;;
    required_access_grants: [can_use_customer_information]
  }

}
