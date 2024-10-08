view: scorecard_testing_loyalty_branch_mth {
  sql_table_name:`toolstation-data-storage.tmp.loyalty_mth_branch`;;

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

  dimension: customer_flag {
    type: yesno
    group_label: "Loyalty Flags"
    label: "Loyalty (Branch MTH)"
    sql: ${customerUID} is not null ;;
  }

}
