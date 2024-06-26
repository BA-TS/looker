view: scorecard_testing_branch_YTD {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_branch_YTD`;;

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
    label: "customer UID retention"
    hidden: yes
  }

  dimension: customer_tyly_flag {
    type: yesno
    view_label: "Scorecard testing"
    label: "Customer Rentention (Branch YTD)"
    sql: ${customerUID} is not null ;;
  }

}
