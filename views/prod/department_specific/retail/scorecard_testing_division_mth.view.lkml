view: scorecard_testing_division_mth {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_division`;;

  dimension: siteUID {
    type: string
    view_label: "Scorecard testing"
    sql: ${TABLE}.Division ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    view_label: "Scorecard testing"
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: customer_tyly_flag {
    required_access_grants: [retail_testing]
    type: yesno
    view_label: "Scorecard testing"
    label: "CUSTOMER TYLY MTH (DIVISION)"
    sql: ${customerUID} is not null ;;
  }

}
