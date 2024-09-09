view: scorecard_testing_loyalty_division_mth {
  sql_table_name:`toolstation-data-storage.tmp.loyalty_mth_division`;;

  dimension: siteUID {
    type: string
    sql: ${TABLE}.Division ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: customer_flag {
    type: yesno
    label: "Loyalty (Division MTH)"
    sql: ${customerUID} is not null ;;
  }

}
