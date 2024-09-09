view: scorecard_testing_loyalty_region_ytd {
  sql_table_name:`toolstation-data-storage.tmp.loyalty_ytd_region`;;

  dimension: siteUID {
    type: string
    sql: ${TABLE}.regionName ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: customer_flag {
    type: yesno
    label: "Loyalty (Region YTD)"
    sql: ${customerUID} is not null ;;
  }

}
