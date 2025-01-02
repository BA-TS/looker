view: scorecard_testing_region_mth {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_region`;;

  dimension: siteUID {
    type: string
    label: "siteUID"
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
    label: "Customer Rentention (Region MTH)"
    sql: ${customerUID} is not null ;;
  }

}
