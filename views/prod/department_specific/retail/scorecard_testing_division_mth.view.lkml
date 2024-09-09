view: scorecard_testing_division_mth {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_division`;;

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
    label: "Customer Rentention (Division MTH)"
    sql: ${customerUID} is not null ;;
  }

}
