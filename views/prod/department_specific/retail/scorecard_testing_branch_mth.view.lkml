view: scorecard_testing_branch_mth {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention`;;

  dimension: siteUID {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    sql: ${TABLE}.customerUID ;;
    label: "customer UID retention"
    hidden: yes
  }

  dimension: customer_tyly_flag {
    type: yesno
    label: "Customer Rentention (Branch MTH)"
    sql: ${customerUID} is not null ;;
  }

}
