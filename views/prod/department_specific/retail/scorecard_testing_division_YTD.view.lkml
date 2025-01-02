view: scorecard_testing_division_YTD {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_division_YTD`;;

  dimension: siteUID {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: customer_tyly_flag {
    type: yesno
    group_label: "Customer Retention Flags"
    label: "Customer Rentention (Division YTD)"
    sql: ${customerUID} is not null ;;
  }

}
