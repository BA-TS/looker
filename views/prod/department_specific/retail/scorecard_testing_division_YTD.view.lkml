view: scorecard_testing_division_YTD {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_division_YTD`;;

  dimension: siteUID {
    type: string
    view_label: "Scorecard testing"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    view_label: "Scorecard testing"
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: customer_tyly_flag {
    type: yesno
    view_label: "Scorecard testing"
    label: "Customer Rentention (Division YTD)"
    sql: ${customerUID} is not null ;;
  }

}
