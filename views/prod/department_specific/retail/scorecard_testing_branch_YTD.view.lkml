view: scorecard_testing_branch_YTD {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_branch_YTD`;;

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
    group_label: "Customer Retention Flags"
    label: "Customer Rentention (Branch YTD)"
    sql: ${customerUID} is not null ;;
  }

}
