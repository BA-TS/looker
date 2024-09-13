view: scorecard_testing_region_11 {
  sql_table_name:`toolstation-data-storage.tmp.scorecard_testing_region_11`;;

  dimension: customerUID {
    type: string
    sql: ${TABLE}.customerUID ;;
    label: "customer UID retention"
    hidden: yes
  }

  dimension: customer_tyly_flag {
    type: yesno
    group_label: "Customer Retention Flags"
    label: "Customer Rentention (Region YTD)"
    sql: ${customerUID} is not null ;;
  }

}
