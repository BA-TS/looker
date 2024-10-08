view: scorecard_testing_loyalty_region_mth {
  sql_table_name:`toolstation-data-storage.tmp.loyalty_mth_region`;;

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
    group_label: "Loyalty Flags"
    label: "Loyalty (Region MTH)"
    sql: ${customerUID} is not null ;;
  }
}
