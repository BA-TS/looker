view: scorecard_testing_loyalty_division_ytd {
  sql_table_name:`toolstation-data-storage.tmp.loyalty_ytd_division`;;

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
    label: "Loyalty (Division YTD)"
    sql: ${customerUID} is not null ;;
  }

}
